#define _XOPEN_SOURCE
#include <setjmp.h>
#include "postgres.h"
#include "utils/array.h"
#include "catalog/pg_type.h"
#include "catalog/pg_type_d.h"

//AVX
#include <immintrin.h>

PG_MODULE_MAGIC;

PG_FUNCTION_INFO_V1(float4pl_simd);
PG_FUNCTION_INFO_V1(float4sum_simd);

Datum
float4sum_simd(PG_FUNCTION_ARGS)
{
	ArrayType  *transarray = PG_GETARG_ARRAYTYPE_P(0);
    float4	   *transvalues;
    float4      ret = 0;
    int         value_index = 1;
    float4      count = 0;

    transvalues = (float4 *) ARR_DATA_PTR(transarray);
    count = transvalues[0];
    for(value_index = 1; value_index < (9 + count); value_index++){
        ret += transvalues[value_index];        
    }

    return Float4GetDatum(ret);
}

void add_simd(float *v1, const float *v2){
    //A 256-bit vector in AVX
    _mm256_storeu_ps(v1, _mm256_add_ps(_mm256_loadu_ps(v1), _mm256_loadu_ps(v2)));
}

Datum
float4pl_simd(PG_FUNCTION_ARGS)
{
	ArrayType  *transarray = PG_GETARG_ARRAYTYPE_P(0);
    float4	   *transvalues;
	float4		newval = PG_GETARG_FLOAT4(1);
    float4      count;
    int         value_index = 9;

    transvalues = (float4 *) ARR_DATA_PTR(transarray);
    count = transvalues[0];

    value_index = 9 + count;

    transvalues[value_index] = newval;

    count++;
    if(count < 8){
        transvalues[0] = count;
    } else {
        add_simd(&(transvalues[1]), &(transvalues[9]));
        transvalues[0] = 0;
    }

    PG_RETURN_ARRAYTYPE_P(transarray);
}

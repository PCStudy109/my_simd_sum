create database my_sum_simd;
\c my_sum_simd
drop table t;
create table t(dt timestamp, id int4, name text, val float4);

create aggregate my_sum_normal(float4)
(
    sfunc = float4pl,
    stype = float4
);

create function float4pl_simd(float4[], float4) returns float4[] as 'my_sum_simd' language c immutable strict;
create or replace function float4sum_simd(float4[]) returns float4 as 'my_sum_simd' language c immutable strict;

create aggregate my_sum_simd(float4)
(
    sfunc = float4pl_simd,
    stype = float4[],
    finalfunc = float4sum_simd,
    initcond = '{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}'
);


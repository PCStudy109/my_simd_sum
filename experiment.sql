\timing on
truncate table t;
insert into t select timestamp'2020-01-01' + cast(t || ' seconds' as interval) as dt, t % 100 as id,
                     'hoge' || t as name, 0.0000001 as val from generate_series(1, 20000000, 1) t;

select my_sum_normal(val), my_sum_normal(val), my_sum_normal(val), my_sum_normal(val), my_sum_normal(val),
       my_sum_normal(val), my_sum_normal(val), my_sum_normal(val), my_sum_normal(val), my_sum_normal(val),
       my_sum_normal(val), my_sum_normal(val), my_sum_normal(val), my_sum_normal(val), my_sum_normal(val),
       my_sum_normal(val), my_sum_normal(val), my_sum_normal(val), my_sum_normal(val), my_sum_normal(val),
       my_sum_normal(val), my_sum_normal(val), my_sum_normal(val), my_sum_normal(val), my_sum_normal(val),
       my_sum_normal(val), my_sum_normal(val), my_sum_normal(val), my_sum_normal(val), my_sum_normal(val) from t;

select my_sum_simd(val), my_sum_simd(val), my_sum_simd(val), my_sum_simd(val), my_sum_simd(val),
       my_sum_simd(val), my_sum_simd(val), my_sum_simd(val), my_sum_simd(val), my_sum_simd(val),
       my_sum_simd(val), my_sum_simd(val), my_sum_simd(val), my_sum_simd(val), my_sum_simd(val),
       my_sum_simd(val), my_sum_simd(val), my_sum_simd(val), my_sum_simd(val), my_sum_simd(val),
       my_sum_simd(val), my_sum_simd(val), my_sum_simd(val), my_sum_simd(val), my_sum_simd(val),
       my_sum_simd(val), my_sum_simd(val), my_sum_simd(val), my_sum_simd(val), my_sum_simd(val) from t;

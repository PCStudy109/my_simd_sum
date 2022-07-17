1. Overview
This Repository contains an user defined aggregation function of PostgreSQL which calculates summation of 32bit floating points by SIMD(AVX256).

2. Prerequisites
(1) OS is CentOS7
(2) PostgreSQL's version is PostgreSQL13

3. commands for setup and experiment
export PGDIR=/usr/local/pgsql
gcc  -shared -fPIC -I$PGDIR/include/server -mavx -std=c99 ./my_sum_simd.c -o ./my_sum_simd.so
cp ./my_sum_simd.so $PGDIR/lib
$PGDIR/bin/psql -U postgres -f ./create.sql
$PGDIR/bin/psql -U postgres -d my_sum_simd -f ./experiment.sql

4. References
[1] PostgreSQL13 document, 37.12. User-Defined Aggregates
https://www.postgresql.org/docs/13/xaggr.html
[2] Intel®Intrinsics Guide
https://www.intel.com/content/www/us/en/docs/intrinsics-guide/index.html#techs=AVX

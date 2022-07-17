1. Prerequisites
(1) OS is CentOS7
(2) PostgreSQL's version is PostgreSQL13

2. commands for setup and experiment
export PGDIR=/usr/local/pgsql
gcc  -shared -fPIC -I$PGDIR/include/server -mavx -std=c99 ./my_sum_simd.c -o ./my_sum_simd.so
cp ./my_sum_simd.so $PGDIR/lib
$PGDIR/bin/psql -U postgres -f ./create.sql
$PGDIR/bin/psql -U postgres -d my_sum_simd -f ./experiment.sql

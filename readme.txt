export PGDIR=/usr/local/pgsql
gcc  -shared -fPIC -I$PGDIR/include/server -mavx -std=c99 ./my_sum_simd.c -o ./my_sum_simd.so
cp ./my_sum_simd.so $PGDIR/lib
$PGDIR/bin/psql -U postgres -f ./create.sql
$PGDIR/bin/psql -U postgres -d my_sum_simd -f ./experiment.sql

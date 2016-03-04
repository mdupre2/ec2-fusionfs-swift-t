#!/bin/sh

cd ../src/zht
make

cd ../udt
make 

cd ../ffsnet
make

cd ../fusionfs
make

echo =====Compile succeed.========

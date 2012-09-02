#! /bin/sh
# A simple bash script to capture build logs into a file for review later.
LOG=build.out.txt 
make 2>&1 | tee  ${LOG}

#!/bin/bash

alias eoscp=/nfshome0/veverka/bin/eoscp.sh

export year="2015"
export runprefix="243"
export logfile="NoiseToolFiles_CopyLog_P5_to_EOS_${year}_${runprefix}.log"
export targetdir="LS-I"
# export targetdir="Run-II"

# cd /rpctdata/CAF/
for i in `ls -lrth /rpctdata/CAF/ | grep run${runprefix} | grep -v tar.gz | awk '{print $9}'`;
do
 # export runsuffix=`echo ${i} | awk -F "run${runprefix}" ${print $2}`
 echo "- tarring ${i}" >> ${logfile}
 tar -pczf /rpctdata/CAF/${i}.tar.gz /rpctdata/CAF/${i}; 
 echo "- copying ${i}.tar.gz ==> adler32 checksum `xrdadler32 /rpctdata/LBMonitorHistos/${i}`" >> ${logfile}
 eoscp /rpctdata/CAF/${i}.tar.gz /store/group/dpg_rpc/comm_rpc/${targetdir}/Noise/NoiseOutputFiles/${year}/${i}.tar.gz >> ${logfile}                                                                               
 echo "- copied ${i}.tar.gz ==> did errors occur? $?" >> ${logfile}      
 rm -rf /rpctdata/CAF/${i}.tar.gz
 # rm -rf /rpctdata/CAF/${i}
done

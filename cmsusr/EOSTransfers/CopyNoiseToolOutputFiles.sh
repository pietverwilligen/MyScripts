#!/bin/bash

alias eoscp=/nfshome0/veverka/bin/eoscp.sh

export year="2013"
export logfile="NoiseOutputFiles_CopyLog_P5_to_EOS_Barrel_${year}.log"
export targetdir="LS-I"

export home=`pwd`

cd /rpctdata/CAF
for dir in `ls -lrth /rpctdata/CAF | grep drwx | grep run | grep ${year} | grep -v run${year} | awk '{print $9}'`; do
    tar -pczf ${dir}.tar.gz ${dir}
    eoscp ${dir}.tar.gz /store/group/dpg_rpc/comm_rpc/${targetdir}/Noise/NoiseOutputFiles/${year}/${dir}.tar.gz >> ${logfile}
    rm -rf ${dir}.tar.gz
    # rm -rf ${dir}
done;

cd ${home}


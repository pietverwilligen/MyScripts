#!/bin/bash

export year="2010"
export station="RB+2"
export logfilename="xrdadler32_checksum_${year}_P5_${station}.log"

# export logfile="LBHistos_CopyLog_P5_to_EOS_2010_YEN3_part1.log"
# export logfile="LBHistos_CopyLog_P5_to_EOS_2010_YEN3_part2.log"
# export logfile="LBHistos_CopyLog_P5_to_EOS_2010_part3.log"
# export logfile="LBHistos_CopyLog_P5_to_EOS_Barrel_2010_part4.log"
export logfile="LBHistos_CopyLog_P5_to_EOS_Barrel_2010.log"
# export logfile="LBHistos_CopyLog_P5_to_EOS_Barrel_2010_copy.log"

# typical file content:
# - copying Histos_run_0_YEN3_far__2010_4_8__16_36_49.root ==> adler32 checksum 3936b8ac ...
# now will extract adler32 checksum and filename and print it to a file

IFS=$'\n'       # make newlines the only separator
set -f          # disable globbing
for line in `cat ${logfile} | grep ${station} | egrep "adler32 checksum"`; do
    export filename=`echo ${line} | awk '{print $3}'`;
    export checksum=`echo ${line} | awk '{print $7}'`;
    echo -e "${checksum} \t ${filename}" >> ${logfilename};
done

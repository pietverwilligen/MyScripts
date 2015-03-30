#!/bin/bash

export year="2015";
export test="RB-2";
export logfilename_v1="xrdadler32_checksum_${year}_P5_Test_${test}.log"
export logfilename_v2="filename_${year}_P5_Test_${test}.log"
alias  xrdadler32="/nfshome0/veverka/bin/adler32"

### fixed part ###############################################                                                                            
export fulldir="/rpctdata/LBMonitorHistos"
##############################################################                                                                            

echo "Making Adler32 checksum for P5 directory ${fulldir} for year ${year} and tower ${test}"
echo "Making LogFile"
rm -rf ${logfilename_v1}
rm -rf ${logfilename_v2}
touch ${logfilename_v1}
touch ${logfilename_v2}

for i in `ls -lrh ${fulldir} | grep _${year}_ | grep ${test} | awk '{print $9}'`;
do
    export word=`xrdadler32 ${fulldir}/${i}`;
    export checksum=`echo $word | awk '{print $1}'`
    export filename=`echo $word | awk '{print $2}' | awk -F '/' '{print $NF}'`
    echo -e "${checksum} \t ${filename}" >> ${logfilename_v1}
    echo -e "${filename}" >> ${logfilename_v2}
done

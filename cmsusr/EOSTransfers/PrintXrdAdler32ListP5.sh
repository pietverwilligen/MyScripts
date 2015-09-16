#!/bin/bash

export year="2015";
export logfilename="xrdadler32_checksum_${year}_P5.log"
alias  xrdadler32="/nfshome0/veverka/bin/adler32"

### fixed part ###############################################                                                                            
export fulldir="/rpctdata/LBMonitorHistos"
##############################################################                                                                            

echo "Making Adler32 checksum for P5 directory ${fulldir}"
echo "Making LogFile"
rm -rf ${logfilename}
touch ${logfilename}

for i in `ls -lrh ${fulldir} | grep _${year}_ | awk '{print $9}'`;
do
    export word=`xrdadler32 ${fulldir}/${i}`;
    export checksum=`echo $word | awk '{print $1}'`
    export filename=`echo $word | awk '{print $2}' | awk -F '/' '{print $NF}'`
    echo -e "${checksum} \t ${filename}" >> ${logfilename}
done

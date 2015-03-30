!#/bin/bash

export year="2015"
export test="RB-2";
export logfilename_v1="xrdadler32_checksum_${year}_EOS_Test_${test}.log"
export logfilename_v2="filename_${year}_EOS_Test_${test}.log"
export dir="LS-I";

### fixed part ###############################################
export dir_fixed_p1="store/group/dpg_rpc/comm_rpc/";
export dir_fixed_p3="/Noise/LBMonitorHistos";
export fulldir="${dir_fixed_p1}${dir}${dir_fixed_p3}"
##############################################################

echo "Making Adler32 checksum for EOS directory /eos/cms/${fulldir} and year ${year} and tower ${test}"
echo "Making LogFile"
rm -rf ${logfilename_v1}
rm -rf ${logfilename_v2}
touch ${logfilename_v1}
touch ${logfilename_v2}
echo "Mouting EOS directory under my-eos"
eosmount my-eos

for i in `ls -lrh my-eos/cms/${fulldir} | grep _${year}_ | grep ${test}| awk '{print $9}'`; 
do 
    export word=`xrdadler32 my-eos/cms/${fulldir}/${i}`;
    export checksum=`echo $word | awk '{print $1}'`
    export filename=`echo $word | awk '{print $2}' | awk -F '/' '{print $NF}'`
    echo -e "${checksum} \t ${filename}" >> ${logfilename_v1}
    echo -e "${filename}" >> ${logfilename_v2}
done

echo "Unmounting EOS directory under my-eos"
eosumount my-eos

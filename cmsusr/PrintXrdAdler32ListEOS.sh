!#/bin/bash

export year="2009"
export logfilename="xrdadler32_checksum_${year}_EOS.log"
export dir="pre-Run-I";
### fixed part ###############################################
export dir_fixed_p1="store/group/dpg_rpc/comm_rpc/";
export dir_fixed_p3="/Noise/LBMonitorHistos";
export fulldir="${dir_fixed_p1}${dir}${dir_fixed_p3}"
##############################################################

echo "Making Adler32 checksum for EOS directory /eos/cms/${fulldir} and year ${year}"
echo "Making LogFile"
rm -rf ${logfilename}
touch ${logfilename}
echo "Mouting EOS directory under my-eos"
eosmount my-eos

for i in `ls -lrh my-eos/cms/${fulldir} | grep _${year}_ | awk '{print $9}'`; 
do 
    export word=`xrdadler32 my-eos/cms/${fulldir}/${i}`;
    export checksum=`echo $word | awk '{print $1}'`
    export filename=`echo $word | awk '{print $2}' | awk -F '/' '{print $NF}'`
    echo -e "${checksum} \t ${filename}" >> ${logfilename}
done

echo "Unmounting EOS directory under my-eos"
eosumount my-eos

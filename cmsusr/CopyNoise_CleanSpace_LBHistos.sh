#!/bin/bash

alias eoscp=/nfshome0/veverka/bin/eoscp.sh
export SCRAM_ARCH=slc5_amd64_gcc462
source ~cmssw2/cmsset_default.sh
pushd ~veverka/cmssw/CMSSW_5_2_6/src/ && cmsenv && popd

export year=2015
# export stations="YEN3 YEP3 YEN1 YEP1 RB-2 RB-1 RB0 RB+1 RB+2"
export stations="YEP1 RB-1 RB0 RB+1 RB+2"
# export stations="RB+1 RB+2"
# export stations=""
export logfile="LBHistos_CopyLog_P5_to_EOS_${year}.log"
export targetdir="LS-I"

#########################
### Copy one file     ###
### for test purpose  ###
#########################
# eoscp /rpctdata/LBMonitorHistos/Histos_YEP3_near_2009_3_9__13_15_2.root /store/group/dpg_rpc/comm_rpc/pre-Run-I/Noise/LBMonitorHistos/Histos_YEP3_near_2009_3_9__13_15_2.root
# eoscp /rpctdata/LBMonitorHistos/Histos_RB+1_far_run_0_2015_1_28__12_39_43.root /store/group/dpg_rpc/comm_rpc/LS-I/Noise/LBMonitorHistos/Histos_RB+1_far_run_0_2015_1_28__12_39_43.root
#########################


#########################
##    Copy All Files   ##
#########################

for st in $stations; 
do
  echo "- investigating station ${st}" >> ${logfile}
  echo "- making the list and starting the loop" >> ${logfile}
  ls -lrth /rpctdata/LBMonitorHistos/ | grep _${year}_ | grep ${st} | awk '{print $9}' | wc
  for i in `ls -lrth /rpctdata/LBMonitorHistos/ | grep _${year}_ | grep ${st} | awk '{print $9}'`;
    do 
    echo "- copying ${i} ==> adler32 checksum `xrdadler32 /rpctdata/LBMonitorHistos/${i}`" >> ${logfile}
    eoscp /rpctdata/LBMonitorHistos/${i} /store/group/dpg_rpc/comm_rpc/${targetdir}/Noise/LBMonitorHistos/${i} >> ${logfile}
  done
  echo "- end copy :: length of the list `ls -lrth /rpctdata/LBMonitorHistos/ | grep _${year}_ | grep ${st} | awk '{print $9}' | wc`" >> ${logfile}
  #########################
done

#########################
##  Delete All Files   ##
#########################
# export year=2015
# export stations="YEN3 YEP3 YEN1 YEP1 RB-2 RB-1 RB0 RB+1 RB+2"

# echo "Deleting ${year} data in /rpctdata/LBMonitorHistos !!!"
# for st in $stations; 
# do
#   echo "- investigating station ${st}"
#   echo "- making the list and starting the loop"
#   ls -lrth /rpctdata/LBMonitorHistos/ | grep _${year}_ | grep ${st} | awk '{print $9}' | wc
#   for i in `ls -lrth /rpctdata/LBMonitorHistos/ | grep _${year}_ | grep ${st} | awk '{print $9}'`;
#     do 
#     echo /rpctdata/LBMonitorHistos/${i}
#     rm -rf /rpctdata/LBMonitorHistos/${i}
#   done
#########################
# done
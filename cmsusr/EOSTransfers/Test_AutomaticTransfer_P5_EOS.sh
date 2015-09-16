#!/bin/bash

export ROOTSYS=/opt/wbm-support-root
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$ROOTSYS/lib/root
export MANPATH=$MANPATH:$ROOTSYS/man
export PATH=$PATH:$ROOTSYS/bin


export dirname="/rpctdata/LBMonitorHistos";
export testdir="Test_AutomaticTransfer_P5_EOS"
# export dirname="FileDir";
# export testdir="TestDir";
export hostname=`hostname`;

echo "Going into the loop";
###################################
### Run over the number of RUNS ###
###################################
for i in `ls -lrth ${dirname} | grep RB0_near | grep 234772 | awk '{print $9}'`;
do

  echo "In the loop :: i = ${i}";

  # 1) get info
  export runno=`echo ${i} | awk -F "_" '{print $5}'`;
  export year=`echo ${i} | awk -F "_" '{print $6}'`;
  export jsonfile="run${runno}_ls0000_RPCLBMonitorHistos_${hostname}.jsn";
  export runno_123=`expr substr ${runno} 1 3`;
  export runno_456=`expr substr ${runno} 4 3`;

  # 2) in case tar file exist already, exit the loop
  if [ -f ${testdir}/${jsonfile} ];
  then
      echo "File ${testdir}/${jsonfile} exists."
      continue;   # exit will exit the terminal, use continue
  else

      # 3) continue the program:

      # 3A create json file
      echo "File ${testdir}/${jsonfile} will be created."
      touch ${testdir}/${jsonfile}
      echo "{\"data\":" >> ${testdir}/${jsonfile};

      # 3B copy all files to ${testdir}
      cp ${dirname}/Histos_*_${runno}_${year}_*.root ${testdir}/;

      # 3C loop over all files to extract the necessary information to make the .jsn file
      for j in `ls -lrth ${testdir}/Histos_*.root | grep _${runno}_ | grep _${year}_ | awk '{print $9}' | awk -F "/" '{print $NF}'`;
      do
        echo "processing ${testdir}/${j} :: size = `ls -lt ${testdir}/${j} | awk '{print $5}'`";
        # no events :: ==> no of counting intervals
	export nEntries=`root.exe --l -b -q  ${testdir}/${j} ExtractNumberOfCountingIntervals.cxx+ | grep nEntries | awk '{print $3}'`;
	if [ $nEntries -eq 0 ]; then
	    echo "ROOT File corrupt --> Do not include in json file";
	    continue;
	fi
        # filename  :: ${j}
        export filename=${j};
        # filesize  :: 
        export size=`ls -lrt ${testdir}/${j} | awk '{print $5}'`;
        # checksum  ::
	# export sum=`/nfshome0/smpro/adler32.py ${testdir}/${j}` #not working now, put random number
	export sum="Adler32sumPlaceholder"
        # symlink   :: RPCEOS
        export symlink="RPCEOS"
        # location we would like to transfer to
        export location="comm_rpc/Run-II/Noise/LBMonitorHistos/${year}/000/${runno_123}/${runno_456}/"

        # 3D make entry in jsn file
        echo "[0, ${nEntries}, 0, ${filename}, ${size}, ${sum}, 0, 0, 0, ${symlink}, ${location}]," >> ${testdir}/${jsonfile};
     done

     # 3E close json file
     echo "}" >> ${testdir}/${jsonfile};
  fi
done

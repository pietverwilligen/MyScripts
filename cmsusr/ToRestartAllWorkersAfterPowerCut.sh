#!bin/bash

echo "----------------------------------------------------------------------"
echo "-  Only to be done after the pcs (pcrpct01, pcrpct03) were down ...  -"
echo "-  ... or somtimes after problems with the oracle servers            -"  
echo "----------------------------------------------------------------------"
echo "ssh pcrpct01"
echo "sudo -u rpcpro -H /bin/bash -l"
echo "pwd --> you must be in /nfshome0/rpcpro"
echo "opt/tomcat/bin/startup.sh"



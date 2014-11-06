#!bin/bash

export home=`pwd`
echo "you are in $home"

echo "login to pcrpct01 :: ssh piet@pcrpct01"
echo "go to directory /rpctdata/FebConnectivityTest/ :: cd /rpctdata/FebConnectivityTest/"
ssh piet@pcrpct01 'ls -lrth /rpctdata/FebConnectivityTest/'
echo "go to directory /rpctdata/FebConnectivityTest/ :: cd /rpctdata/FebConnectivityTest/"
ssh piet@pcrpct01 'ls -lrth /nfshome0/rpcpro/rpctdata/FebConnectivityTest/'
echo "login to pcrpct03 :: ssh piet@pcrpct03"
echo "go to directory /var/log :: ls -lrth /var/log"
ssh piet@pcrpct03 'ls -lrth /var/log' | egrep "rpct-worker" | egrep ".stderr"

echo ""
echo ""
echo "----- Summary -----------------------------------------------------"
echo "--- Connectivity Test output: -   ---   ---   ---   ---   ---   ---"
echo "- ssh piet@pcrpct01 or ssh piet@pcrpct03                          -"
echo "- old directory :: /rpctdata/FebConnectivityTest/                 -"
echo "- new directory :: /nfshome0/rpcpro/rpctdata/FebConnectivityTest/ -"
echo "--- Log output: ---   ---   ---   ---   ---   ---   ---   ---   ---"
echo "- ssh piet@pcrpct03                                               -"
echo "- ls -lrth /var/log                                               -"
echo "-------------------------------------------------------------------"
echo ""
echo ""

# export pc01=`uname -a`
# cd /rpctdata/FebConnectivityTest/
# export dbdir=`pwd`
# echo "you are now in $dbdir on $pc01"
# echo "connectivity test files:"
# ls -lrth

# ssh piet@pcrpct03
# export pc03=`uname -a`
# cd blabla
# export dbdir=`pwd`
# echo "you are now in $dbdir on $pc01"
# echo "connectivity test files:"


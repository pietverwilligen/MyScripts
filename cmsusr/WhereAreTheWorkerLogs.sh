#!bin/bash

export home=`pwd`

echo ""
echo ""
echo "----- Show me the Log files ---------------------------------------"
echo "--- Connectivity Test output: -   ---   ---   ---   ---   ---   ---"
ssh piet@pcrpct03 'ls -lrth /var/log' | egrep "rpct-worker" | egrep ".stderr"
echo "--- Log output: ---   ---   ---   ---   ---   ---   ---   ---   ---"
echo "- ssh piet@pcrpct03                                               -"
echo "- ls -lrth /var/log                                               -"
echo "-------------------------------------------------------------------"
echo ""
echo ""


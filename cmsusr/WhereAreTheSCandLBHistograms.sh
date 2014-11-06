#!/bin/bash

echo ""
echo ""
echo "-------------------------------------------------------------------"
echo "login to pcrpct03 :: ssh piet@pcrpct03"
echo "go to directory /rpcpacdata/MonitorHistos :: ls -lrth /rpcpacdata/MonitorHistos"
ssh piet@pcrpct03 'ls -lrth /rpcpacdata/MonitorHistos | head -n 15'
echo "..."
ssh piet@pcrpct03 'ls -lrth /rpcpacdata/MonitorHistos | tail -n 15'
echo "-------------------------------------------------------------------"
echo ""
echo ""
echo "----- Summary -----------------------------------------------------"
echo "--- SC Histograms:    ---   ---   ---   ---   ---   ---   ---   ---"
echo "- ssh piet@pcrpct03                                               -"
echo "- ls -lrth /rpcpacdata/MonitorHistos                              -"
echo "-------------------------------------------------------------------"
echo ""
echo "--- LB Histograms:    ---   ---   ---   ---   ---   ---   ---   ---"
echo "- ssh piet@pcrpct03                                               -"
echo "- ls -lrth /rpctdata/LBMonitorHistos/                              -"
echo "-------------------------------------------------------------------"
echo ""
echo ""


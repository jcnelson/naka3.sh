#!/bin/bash

naka3="../../naka3.sh"

"$naka3" end-transfers "/tmp/one-miner/end-transfers"
"$naka3" node 0 stop
"$naka3" -c "./config-signer-0.sh" signer 0 stop
"$naka3" -c "./config-signer-1.sh" signer 1 stop
"$naka3" -c "./config-signer-2.sh" signer 2 stop
"$naka3" bitcoind stop

#!/bin/bash

naka3="../../naka3.sh"

"$naka3" -c "./config-miner-0.sh" node 0 stop
"$naka3" -c "./config-miner-1.sh" node 1 stop
"$naka3" -c "./config-miner-2.sh" node 2 stop
"$naka3" -c "./config-signer-0.sh" signer 0 stop
"$naka3" -c "./config-signer-1.sh" signer 1 stop
"$naka3" -c "./config-signer-2.sh" signer 2 stop
"$naka3" -c "./config-bitcoind-0.sh" bitcoind stop
"$naka3" -c "./config-bitcoind-1.sh" bitcoind stop
"$naka3" -c "./config-bitcoind-2.sh" bitcoind stop

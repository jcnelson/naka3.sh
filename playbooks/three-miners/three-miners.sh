#!/bin/bash

# Topology:
#
#
#            `bitcoind 0` <----------------> `bitcoind 1` <----------------> `bitcoind 2`
#                 |                              |                               |
#                 |                              |                               |
#                 V                              V                               V
#             `stacks 0`  <---------------->  `stacks 1`  <---------------->  `stacks 2`
#             `(miner) `                      `(miner) `                      `(miner) `
#              ^  ^  ^
#    .---------*  |  *---------.
#    |            |            |
#    |            |            |
#`signer 0`   `signer 1`   `signer 2`


set -ueo pipefail

naka3="../../naka3.sh"

rm -rf "/tmp/three-miners"

"$naka3" -c "./config-signer-0.sh" signer 0 config
"$naka3" -c "./config-signer-1.sh" signer 1 config
"$naka3" -c "./config-signer-2.sh" signer 2 config

"$naka3" -c "./config-miner-0.sh" node 0 config-miner-stacker "0,1,2"
"$naka3" -c "./config-miner-1.sh" node 1 config-miner "none"
"$naka3" -c "./config-miner-2.sh" node 2 config-miner "none"

btcaddr_0="$("$naka3" -c "./config-miner-0.sh" node 0 miner-addr | jq -r '.BTC')"
btcaddr_1="$("$naka3" -c "./config-miner-1.sh" node 1 miner-addr | jq -r '.BTC')"
btcaddr_2="$("$naka3" -c "./config-miner-2.sh" node 2 miner-addr | jq -r '.BTC')"

echo "Miner address is $btcaddr_0"
echo "Miner address is $btcaddr_1"
echo "Miner address is $btcaddr_2"

"$naka3" -c "./config-bitcoind-0.sh" bitcoind start
"$naka3" -c "./config-bitcoind-1.sh" bitcoind start
"$naka3" -c "./config-bitcoind-2.sh" bitcoind start

"$naka3" -c "./config-bitcoind-0.sh" bitcoind peer "127.0.0.1" "28332"
"$naka3" -c "./config-bitcoind-0.sh" bitcoind peer "127.0.0.1" "38332"

"$naka3" -c "./config-bitcoind-1.sh" bitcoind peer "127.0.0.1" "18332"
"$naka3" -c "./config-bitcoind-1.sh" bitcoind peer "127.0.0.1" "38332"

"$naka3" -c "./config-bitcoind-2.sh" bitcoind peer "127.0.0.1" "18332"
"$naka3" -c "./config-bitcoind-2.sh" bitcoind peer "127.0.0.1" "28332"

for i in $(seq 0 34); do
    "$naka3" -c "./config-bitcoind-0.sh" bitcoind mine 1 "$btcaddr_0"
    sleep 0.5s
    "$naka3" -c "./config-bitcoind-1.sh" bitcoind mine 1 "$btcaddr_1"
    sleep 0.5s
    "$naka3" -c "./config-bitcoind-2.sh" bitcoind mine 1 "$btcaddr_2"
    sleep 0.5s
done
 
# at 105 bitcoin blocks

# boot signers
"$naka3" -c "./config-signer-0.sh" signer 0 start
"$naka3" -c "./config-signer-1.sh" signer 1 start
"$naka3" -c "./config-signer-2.sh" signer 2 start

# boot miner nodes
"$naka3" -c "./config-miner-0.sh" node 0 start-miner-stacker "0,1,2"
"$naka3" -c "./config-miner-1.sh" node 1 start-miner "none"
"$naka3" -c "./config-miner-2.sh" node 2 start-miner "none"

# advance to epoch 2.5 (starts at 108)
for i in $(seq 0 5); do
   sleep 10
   "$naka3" -c "./config-bitcoind-0.sh" bitcoind mine 1 "$btcaddr_0"
done

echo "stack stackity stack-stack-stack"
for i in $(seq 0 2); do
   tx="$("$naka3" -c "./config-signer-$i.sh" signer "$i" stack-tx 5 9000000000000000 0 1)"
   "$naka3" -c "./config-miner-0.sh" node 0 send-tx "$tx"
done

# mine through Nakamoto activation
for i in $(seq 0 20); do
   "$naka3" -c "./config-bitcoind-0.sh" bitcoind mine 1 "$btcaddr_0"
   sleep 15s
done

while true; do
   "$naka3" -c "./config-bitcoind-0.sh" bitcoind mine 1 "$btcaddr_0"
   sleep 0.75s
   
   "$naka3" -c "./config-bitcoind-0.sh" bitcoind mine 1 "$btcaddr_0"
   sleep 15s
   
   "$naka3" -c "./config-bitcoind-0.sh" bitcoind mine 1 "$btcaddr_0"
   sleep 15s
done
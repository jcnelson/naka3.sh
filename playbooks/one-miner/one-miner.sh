#!/bin/bash

set -ueo pipefail

naka3="../../naka3.sh"

rm -rf "/tmp/one-miner"

"$naka3" -c "./config-signer-0.sh" signer 0 config
"$naka3" -c "./config-signer-1.sh" signer 1 config
"$naka3" -c "./config-signer-2.sh" signer 2 config

"$naka3" node 0 config-miner

btcaddr="$("$naka3" node 0 miner-addr | jq -r '.BTC')"

echo "Miner address is $btcaddr"

"$naka3" bitcoind start
"$naka3" bitcoind mine 101 "$btcaddr"

"$naka3" -c "./config-signer-0.sh" signer 0 start
"$naka3" -c "./config-signer-1.sh" signer 1 start
"$naka3" -c "./config-signer-2.sh" signer 2 start

"$naka3" node 0 start-miner

# advance to epoch 2.5 (starts at 108)
for i in $(seq 0 10); do
   sleep 10
   "$naka3" bitcoind mine 1 "$btcaddr"
done

echo "stack stackity stack-stack-stack"
for i in $(seq 0 2); do
   tx="$("$naka3" -c "./config-signer-$i.sh" signer "$i" stack-tx 5 9000000000000000 0 1)"
   "$naka3" node 0 send-tx "$tx"
done

touch "/tmp/one-miner/mine"

# mine through Nakamoto activation
for i in $(seq 0 20); do
   "$naka3" bitcoind mine 1 "$btcaddr"
   sleep 15s
done

# run forever, but only mine on command
while true; do
   "$naka3" bitcoind mine 1 "$btcaddr"
   sleep 0.75s
   
   "$naka3" bitcoind mine 1 "$btcaddr"
   sleep 15s
   
   "$naka3" bitcoind mine 1 "$btcaddr"
   sleep 15s
done

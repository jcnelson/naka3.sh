#!/bin/bash

_CONF_BASEDIR="/tmp/naka3"

_CONF_BITCOIN_P2P_PORT=18332
_CONF_BITCOIN_RPC_PORT=18333
_CONF_BITCOIN_DATA_DIR="$_CONF_BASEDIR/bitcoin"

_CONF_STACKS_HOST=127.0.0.1
_CONF_STACKS_P2P_PORT=20444
_CONF_STACKS_RPC_PORT=20443
_CONF_STACKS_MINER="true"
_CONF_STACKS_PEER_KEY="6c6620b925a9fe5162a007e86e5d8be66fda66442ed27c89419fa620faf0bb00"
_CONF_STACKS_MINER_KEY="7933b1e99bab1067d7c6c5c243bdc5a60857bb9e8800ff119ca4695f6e50e8c0"
_CONF_STACKS_NODE_DATA_DIR="$_CONF_BASEDIR/nodes"

_CONF_STACKS_SIGNER_DATA_DIR="$_CONF_BASEDIR/signers"
_CONF_STACKS_SIGNER_KEY="569d94c4eec51bffa0478460eedbb05fd97ab0a58d35992259c7b2aac9881450"
_CONF_STACKS_SIGNER_HOST="127.0.0.1"
_CONF_STACKS_SIGNER_PORT="30000"

_CONF_BITCOIN_HOST="192.168.4.45"

# e7632f313c38dcc20a87b189c294094cd4af07ac22369669a2d8a41afbf76adc
_CONF_SEED_NODE_PUBKEY="03c3fadc32ef7a48fe384320542533ed12ea3905f9000f030abf2ab0f08f576169"
_CONF_SEED_NODE_HOST="192.168.4.45"
_CONF_SEED_NODE_P2P_PORT=20444

# PoX address
_CONF_POX_ADDRESS="mkcL5EbpxqYtf1VHtrmBKgJ5aTfMttduUG"

function conf_exit_error() {
   printf "$1" >&2
   exit 1
}

function conf_set_basedir() {
   _CONF_BASEDIR="$1"
   _CONF_BITCOIN_DATA_DIR="$_CONF_BASEDIR/bitcoin"
   _CONF_STACKS_NODE_DATA_DIR="$_CONF_BASEDIR/nodes"
   _CONF_STACKS_SIGNER_DATA_DIR="$_CONF_BASEDIR/signers"
}

function conf_setup() {
   mkdir -p "$_CONF_BASEDIR" || conf_exit_error "Failed to mkdir $_CONF_BASEDIR"
   mkdir -p "$_CONF_BITCOIN_DATA_DIR" || conf_exit_error "Failed to mkdir $_CONF_BITCOIN_DATA_DIR"
   mkdir -p "$_CONF_STACKS_SIGNER_DATA_DIR" || conf_exit_error "Failed to mkdir $_CONF_STACKS_SIGNER_DATA_DIR"
   mkdir -p "$_CONF_STACKS_NODE_DATA_DIR" || conf_exit_error "Failed to mkdir $_CONF_STACKS_NODE_DATA_DIR"
}

function conf_get_bitcoind_host() {
   echo "$_CONF_BITCOIN_HOST"
}

function conf_get_bitcoind_p2p_port() {
   echo "$_CONF_BITCOIN_P2P_PORT"
}

function conf_get_bitcoind_rpc_port() {
   echo "$_CONF_BITCOIN_RPC_PORT"
}

function conf_get_bitcoind_data_dir() {
   echo "$_CONF_BITCOIN_DATA_DIR"
}

function conf_get_basedir() {
   echo "$_CONF_BASEDIR"
}

function conf_get_stacks_host() {
   echo "$_CONF_STACKS_HOST"
}

function conf_get_stacks_p2p_port() {
   echo "$_CONF_STACKS_P2P_PORT"
}

function conf_get_stacks_rpc_port() {
   echo "$_CONF_STACKS_RPC_PORT"
}

function conf_get_stacks_peer_key() {
   echo "$_CONF_STACKS_PEER_KEY"
}

function conf_get_stacks_miner_key() {
   echo "$_CONF_STACKS_MINER_KEY"
}

function conf_get_stacks_signer_data_dir() {
   echo "$_CONF_STACKS_SIGNER_DATA_DIR"
}

function conf_get_stacks_signer_key() {
   echo "$_CONF_STACKS_SIGNER_KEY"
}

function conf_get_stacks_signer_host() {
   echo "$_CONF_STACKS_SIGNER_HOST"
}

function conf_get_stacks_signer_port() {
   echo "$_CONF_STACKS_SIGNER_PORT"
}

function conf_get_stacks_signer_pox_address() {
   echo "$_CONF_POX_ADDRESS"
}

function conf_get_stacks_signer_private_key() {
   echo "$_CONF_STACKS_SIGNER_KEY"
}

function conf_get_stacks_node_data_dir() {
   echo "$_CONF_STACKS_NODE_DATA_DIR"
}

function conf_get_seed_host() {
   echo "$_CONF_SEED_NODE_HOST"
}

function conf_get_seed_p2p_port() {
   echo "$_CONF_SEED_NODE_P2P_PORT"
}

function conf_get_seed_pubkey() {
   echo "$_CONF_SEED_NODE_PUBKEY"
}


# naka3.sh

### Prerequsites

You need the following in your `$PATH`:

* `stacks-node`
* `blockstack-cli`
* `bitcoind` (version 25 or up)
* `bitcoin-cli`
* `stacks-signer`
* `jq`
* `dc`
* `bash` 5.0 or higher
* The usual GNU coreutils (`grep`, `sed`, etc)

### Quick Start

To run a single-miner, three-signer setup, do this:

```bash
$ cd ./playbooks/one-miner
$ ./one-miner.sh
```

To shut it down, run:

```
$ ./shutdown.sh
```

To run a two-miner, three-signer setup, do this:

```bash
$ cd ./playbooks/two-miners
$ ./two-miners.sh
```

To shut it down, run:

```
$ ./shutdown.sh
```


```{eval-rst}
.. meta::
  :title: Dimecoin Solo Mining
  :description: Solo mining is an individual effort to generate blocks, allowing the miner to claim all rewards, resulting in larger but less frequent payments.
```

> ***We put our best effort into covering all topics related to Dimecoin. Each section will cover a different category. Not all documentation may be 100% accurate, if you spot an error, please report it or submit a PR request on GitHub.***
>
> ***REMINDER: This documentation is always evolving. If you have not been here for a while, perhaps check again. Things may have been added or updated since your last visit!***

## Solo Mining

As illustrated below, solo miners typically use `dimecoind` to get new [transactions](../reference/glossary.md#transaction) from the [network](../reference/glossary.md#network). Their mining software periodically polls `dimecoind` for new transactions using the [`getblocktemplate` RPC](../api/rpc-mining.md#getblocktemplate), which provides the list of new transactions plus the [public key](../reference/glossary.md#public-key) to which the [coinbase transaction](../reference/glossary.md#coinbase-transaction) should be sent.

![Solo Dimecoin Mining](../../img/dev/en-solo-mining-overview.svg)

The mining software constructs a block using the template (described below) and creates a [block header](../reference/glossary.md#block-header). It then sends the 80-byte block header to its mining hardware (an ASIC) along with a [target threshold](../reference/glossary.md#target) (difficulty setting). The mining hardware iterates through every possible value for the block header nonce and generates the corresponding hash.

If none of the hashes are below the threshold, the mining hardware gets an updated block header with a new [merkle root](../reference/glossary.md#merkle-root) from the mining software; this new block header is created by adding extra nonce data to the coinbase field of the coinbase transaction.

On the other hand, if a hash is found below the target threshold, the mining hardware returns the block header with the successful nonce to the mining software. The mining software combines the header with the block and sends the completed block to `dimecoind` to be broadcast to the network for addition to the blockchain.

### Solo Mining with GPU (coming soon)

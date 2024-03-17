```{eval-rst}
.. meta::
  :title: Dimecoin Core Blockchain
  :description: Index for the subsections that document core block details.
```

> ***We put our best effort into covering all topics related to Dimecoin. Each section will cover a different category. Not all documentation may be 100% accurate, if you spot an error, please report it or submit a PR request on GitHub.***
>
> ***REMINDER: This documentation is always evolving. If you have not been here for a while, perhaps check again. Things may have been added or updated since your last visit!***

## Blockchain

The following subsections briefly document Dimecoin's blockchain arhitecture.
  
**[Block Headers](blockchain.md#block-headers)**  
This section covers the structure of block headers and their significance in the blockchain. Topics include:

* [Merkle Trees](blockchain.md#merkle-trees): Explore how Merkle trees ensure secure and efficient transaction verification in blockchain technology.
* [Target nBits](blockchain.md#target-nbits): Discover the role of Target nBits in defining the difficulty level for blockchain mining operations.

**[Serialized Blocks](blockchain.md#serialized-blocks)**  
Focuses on the serialization of blocks within the blockchain, a crucial process for block propagation and storage. See:

* [Coinbase](blockchain.md#coinbase): Learn about the coinbase transaction, the first transaction in a block that awards miners & stakers with new Dimecoin.
* [Supply](blockchain.md#supply): Learn about how Dimecoin's supply works.
* [Treasury](blockchain.md#treasury): Check out how Dimecoin's treasury is structured, including a breakdown of block rewards.

```{toctree}
:maxdepth: 2
:titlesonly:

blockchain-block-headers
blockchain-serialized-blocks
```

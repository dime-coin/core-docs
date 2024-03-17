```{eval-rst}
.. meta::
  :title: Dimecoin Mining
  :description: Mining adds new blocks to the blockchain, making transaction history hard to modify. Mining takes on two forms – Solo Mining and Pool Mining. 
```

> ***We put our best effort into covering all topics related to Dimecoin. Each section will cover a different category. Not all documentation may be 100% accurate, if you spot an error, please report it or submit a PR request on GitHub.***
>
> ***REMINDER: This documentation is always evolving. If you have not been here for a while, perhaps check again. Things may have been added or updated since your last visit!***

## Mining

Mining adds new [blocks](../reference/glossary.md#block) to the [blockchain](../reference/glossary.md#blockchain), making transaction history hard to modify.  Mining today takes on two forms:

* Solo mining, where the [miner](../reference/glossary.md#miner) attempts to generate new blocks on his own, with the proceeds from the [block reward](../reference/glossary.md#block-reward) and transaction fees going entirely to himself, allowing him to receive the full block reward with a higher variance (longer time between payments)

* Pooled mining, where the miner pools resources with other miners to find blocks more often, with the proceeds being shared among the pool miners in rough correlation to the amount of hashing power they each contributed, allowing the miner to receive small payments with a lower variance (shorter time between payments).

### Quick Reference

**Dimecoin Mining**

* [Solo Mining](mining-solo-mining.md)

* [Pool Mining](mining-pool-mining.md)

**[Block Prototypes](mining-block-prototypes.md)**  
Focuses on the serialization of blocks within the blockchain, a crucial process for block propagation and storage. See:

* [getblocktemplate RPC](mining-block-prototypes.md#getblocktemplate-rpc): RPC which provides information to mining software.
* [Stratum](mining-block-prototypes.md#stratum): An alternative to `getblocktemplate` focused on giving miners minimal info they need to construct block headers.\
  
```{toctree}
:maxdepth: 2
:titlesonly:
:hidden:

mining-solo-mining
mining-pool-mining
mining-block-prototypes
```

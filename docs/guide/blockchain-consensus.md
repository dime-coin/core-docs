```{eval-rst}
.. meta::
  :title: Proof of Work/ Proof of Stake
  :description: Explore Dimecoin's innovative hybrid consensus mechanism, combining Proof of Work (PoW) and Proof of Stake (PoS) for enhanced security, energy efficiency, and network decentralization. Learn how this unique approach maintains optimal block time while promoting broad participation in the Dimecoin ecosystem
```

> ***We put our best effort into covering all topics related to Dimecoin. Each section will cover a different category. Not all documentation may be 100% accurate, if you spot an error, please report it or submit a PR request on GitHub.***
>
> ***REMINDER: This documentation is always evolving. If you have not been here for a while, perhaps check again. Things may have been added or updated since your last visit!***

## Consensus

Dimecoin's hybrid consensus model employs a dynamic mechanism to maintain a stable target block time of ~50 seconds. It adjusts the difficulty of PoW and the selection criteria for PoS validators in response to changes in network participation and computational power. The network difficulty adjusts dynamically each block to ensure that the time it takes for block creation remains consistent, regardless of the network’s hashing and minting power. As more participants join the network, the difficulty increases. Alternatively, when few participants are on the network, the difficulty decreases.

Chaining blocks together makes it impossible to modify [transactions](../reference/glossary.md#transaction) included in any block without modifying all following blocks. As a result, the cost to modify a particular block increases with every new block added to the blockchain, magnifying the effect of the dual consensus mechanism.

Dimecoin's adoption of a hybrid mechanism underscores a technical innovation in blockchain technology, blending the computational challenge of PoW with the economic validation of PoS. This dual approach enhances network security, reduces energy consumption, and promotes greater decentralization by encouraging widespread participation in the consensus process. Through its implementation, Dimecoin sets a precedent for balancing efficiency, security, and inclusivity in blockchain networks.

## Proof of Work

The Proof of Work (PoW) arm of the Dimecoin [blockchain](../reference/glossary.md#block-chain) is collaboratively maintained by anonymous [peers](../reference/glossary.md#peer) on the [network](../reference/glossary.md#network), so Dimecoin requires that each [block](../reference/glossary.md#block) prove a significant amount of work was invested in its creation to ensure that untrustworthy peers who want to modify past blocks have to work harder than honest peers who only want to add new blocks to the blockchain.

The [proof of work](../reference/glossary.md#proof-of-work) used in Dimecoin takes advantage of the random nature of cryptographic hashes of the Quark hashing algorithm. A good cryptographic hash algorithm converts arbitrary data into a seemingly-random number. If the data is modified in any way and the hash re-run, a new seemingly-random number is produced, so there is no way to modify the data to make the hash number predictable.

To prove you did some extra work to create a block, you must create a hash of the [block header](../reference/glossary.md#block-header) which does not exceed a certain value. For example, if the maximum possible hash value is <span class="math">2<sup>256</sup> − 1</span>, you can prove that you tried up to two combinations by producing a hash value less than <span class="math">2<sup>255</sup></span>.

In the example given above, you will produce a successful hash on average every other try. You can even estimate the probability that a given hash attempt will generate a number below the [target threshold](../reference/glossary.md#target). Dimecoin assumes a linear probability that the lower it makes the target threshold, the more hash attempts (on average) will need to be tried.

New PoW blocks in Dimecoin's blockchain are added only when their hash meets or surpasses a [difficulty](../reference/glossary.md#difficulty) threshold as defined by the consensus rules. Unlike other systems that may use different algorithms for adjusting difficulty, Dimecoin employs the Linear Weighted Moving Average (LWMA-3) algorithm to calculate and adjust difficulty.

The LWMA-3 algorithm adjusts the mining difficulty after each block, rather than relying on a fixed set of previous blocks like some other systems. This approach allows for a more granular and responsive adaptation to changes in the network's hashrate. The primary goal is to maintain an optimal block time, ensuring steady and predictable block generation. This is crucial for transaction processing efficiency and network security.

* When block production is too rapid, suggesting an increase in the network's hashrate, the LWMA-3 algorithm raises the difficulty for the subsequent block. This increment aims to temper the pace of block generation, aligning it more closely with the target block time.
* Conversely, when block production slows down, indicating a possible decrease in hashrate, the difficulty level is adjusted downward for the following block. This reduction helps to accelerate block generation, aiming to adhere to the predetermined block interval.

This method of calculating difficulty (LWMA-3) was authored by zawy12 to fix exploits possible with the previously used LWMA difficulty readjustment algorithms. For additional detail, reference this [Official LWMA GitHub](https://github.com/zawy12/difficulty-algorithms).

Because each block header must hash to a value below the target threshold, and because each block is linked to the block that preceded it, it requires (on average) as much hashing power to propagate a modified block as the entire Dimecoin network expended between the time the original block was created and the present time. Only if you acquired a majority of the network's hashing power could you reliably execute such a [51 percent attack](../reference/glossary.md#51-percent-attack) against transaction history (although, it should be noted, that even less than 50% of the hashing power still has a good chance of performing such attacks).

The block header provides several easy-to-modify fields, such as a dedicated nonce field, so obtaining new hashes doesn't require waiting for new transactions. Also, only the 80-byte block header is hashed for proof-of-work, so including a large volume of transaction data in a block does not slow down hashing with extra I/O, and adding additional transaction data only requires the recalculation of the ancestor hashes in the [merkle tree](../reference/glossary.md#merkle-tree).

## Proof of Stake

The [Proof of Stake (PoS)](../reference/glossary.md#Proof-of-Stake-(PoS)) arm of the Dimecoin blockchain is maintained by anonymous stakeholders who hold and "mint" new blocks to the network. Unlike Proof of Work (PoW) that requires computational work to mine blocks, PoS ensures the integrity and progression of the blockchain by having stakeholders validate and forge new blocks based on the quantity of coins they hold and are willing to "lock up" as stake.

In PoS, the right to validate and add new blocks to the blockchain is influenced by the amount and age of the cryptocurrency [inputs](../reference/glossary.md#input) a node stakes. Thus, instead of miners competing to solve complex cryptographic puzzles, stakeholders with more significant investments in the network have a higher chance of being chosen to validate new transactions and forge the next block. This method significantly reduces the energy consumption associated with traditional PoW systems. Since minting blocks requires significantly less computational power, PoS enables more participants to engage in the validation process, potentially leading to greater network decentralization.

### Staking Logic

In the context of cryptocurrency wallets, each transaction of coins create inputs and outputs. Inputs essentially refer to the origins of the coins that you have available to spend. Each input provides record of a previous transaction that sent coins to your wallet address, which serves as proof that you “own” those funds. Depending on the amount you are sending, these inputs are combined and referenced in new transactions to validate and send cryptocurrency from one address to another. When it comes to staking, each individual input the wallet contains, is eligible for minting as long as it meets the minimum threshold.

### Minimum Thresholds

Outline below are the rules and minimums required for inputs to stake Dimecoin:

* Participants are required to hold their coins within their wallet for 450 confirmations. The time it takes to reach maturity is approximately 6–8 hours.
* Each input needs to be a minimum of 100,000 to be eligible for staking.

### Coin Age and Days Explained

Time and weight determine each inputs ability to be chosen for minting and creating a new block within the network. The chances of an input being selected to mint a new block and receive a staking reward increase with the number of coins it holds and as it ages.

For instance, if you have 100,000 dimecoins that have reached maturity (at least 450 confirmations), they will start to accumulate what is called “Coin Day”. As “Coin Day” accumulates, the likelihood of producing a new block on the chain increases.

After approximately 30 days, individual inputs will hit their maximum minting power, and coin day accumulation will end. Coin Day will no longer increase after this period passes as a limit is imposed on an input’s coin age to discourage periodic staking.

**Additional Staking Parameters**

* Blocks created through PoS can become orphaned, similar to PoW blocks, if multiple participants mint a PoS block within the same timeframe. The core wallet will automatically clean up your orphaned inputs.
* Coins that have minted a block will automatically have their coinage reset. The coins will also be locked for 450 confirmations (~ 8 hours).
* Staking rewards are directly added to your transaction record where the stake occurs.
* Spending coins, combining inputs, will reset an inputs coinage to zero.

By incentivizing stakeholders to act honestly and maintain their investment in the network, Proof of Stake ensures a secure, efficient, and more environmentally friendly approach to achieving consensus on the blockchain. This method demonstrates a mature evolution in blockchain technology, aiming to sustain the network's long-term growth and security.

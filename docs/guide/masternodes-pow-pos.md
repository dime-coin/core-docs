```{eval-rst}
.. _masternodes:
.. meta::
  :title: Dimecoin Masternodes
  :description: Explanation of difference between block validators (miners or stakers) and masternodes
  :keywords: dimecoin, masternodes, hosting, linux, payments, instantsend, governance, quorum, mining, staking, consensus, PoSe
```

> ***We put our best effort into covering all topics related to Dimecoin. Each section will cover a different category. Not all documentation may be 100% accurate, if you spot an error, please report it or submit a PR request on GitHub.***
>
> ***REMINDER: This documentation is always evolving. If you have not been here for a while, perhaps check again. Things may have been added or updated since your last visit!***

## POW/POS vs Masternodes

Dimecoin, like Bitcoin and most other cryptocurrencies, is based on a decentralized ledger of all transactions, known as a blockchain. This blockchain is secured through a consensus mechanism; in the case of Dimecoin, the consensus mechanism is a hybrid Proof of Work (PoW) / Proof of Stake (PoS) system. Miners attempt to solve complex problems with specialized computers, and when they solve the problem, they receive the right to add a new block to the blockchain. If all the other people running the software agree that the problem was solved correctly, the block is added to the blockchain, and the miner is rewarded. Conversely, staking validators attempt to mint new blocks to the network based on the coins they hold. See the Core guide [consensus](../guide/blockchain-consensus.md) section for more detailed information.

Dimecoin works a little differently when compared to Bitcoin because it has a two-tier network, similar to Dash. The second tier is powered by masternodes [Full Nodes](../resources/glossary.md#full-node), enabling additional network functionality. Since this second tier is essential, masternodes are rewarded when miners or stakers create new blocks. The breakdown is as follows:

* 45% of the block reward goes to the miner.
* 45% goes to masternodes.
* 10% is reserved for the foundation (development, exchange listings, marketing, etc)

The masternode system is referred to as Proof of Service (PoSe) since the masternodes provide crucial services to the network. The entire network is overseen by the masternodes, which can reject improperly formed blocks from validators. If a miner or staker tries to take the whole block reward for themselves or tries to run an old version of the Dimecoin software, the masternode network would orphan that block and not add it to the blockchain.

In short, miners and stakers power the first tier, the basic sending and receiving of funds, and the prevention of double spending. Masternodes power the second tier, which provides the added features that make Dimecoin different from other cryptocurrencies. Masternodes do not mine/stake, and mining/staking computers cannot serve as masternodes. Additionally, each masternode is “secured” by 500 000 000 DIME. Those DIME remain under the sole control of their owner at all times and can still be used. The funds are not locked in any way. However, if the funds are moved or spent, the associated masternode will go offline and stop receiving rewards.

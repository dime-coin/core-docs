```{eval-rst}
.. meta::
  :title: Dimecoin Masternodes
  :description: Explanation of how Dimecoin masternodes work in theory and in practice
```

> ***We put our best effort into covering all topics related to Dimecoin. Each section will cover a different category. Not all documentation may be 100% accurate, if you spot an error, please report it or submit a PR request on GitHub.***
>
> ***REMINDER: This documentation is always evolving. If you have not been here for a while, perhaps check again. Things may have been added or updated since your last visit!***

## Masternodes

### Overview

A [masternode](../resources/glossary.md#masternode) is a server with a full copy of the Dimecoin [blockchain](../resources/glossary.md#blockchain), which guarantees a certain minimum level of performance and functionality to perform specific tasks related to block validation and various other tasks. Masternodes are paid for this
service using a concept known as Proof of Service, which works alongside Dimecoin's hybrid Proof-of-Work/Proof-of-Stake mechanism to secure the blockchain.

Masternodes are open for anyone to operate with the aim of achieving sufficient decentralization. To discourage the network from being overwhelmed by surplus masternodes or careless operators, there's a prerequisite. A user must prove ownership of 500,000,000 DIME. It's not mandatory for these coins to be stored within the masternode itself, but they must be maintained in a manner that is visible and verifiable by the entire network. Should the owner relocate or spend these coins, the associated masternode will cease to function, and its payments will be halted.

Masternodes, [miners](../resources/glossary.md#miner)/[stakers](../resources/glossary.md#staker), and the foundation share the block reward in the following proportions: 45% for masternodes, 45% for miners/stakers, and 10% for the foundation. Payments to masternodes are made on a quasi-random basis, rouglhy every 50 seconds, selected from the top 10% in the masternode list. Once a masternode receives payment, it moves to the end of the queue.

As the network grows with more masternodes, the interval between payments for each masternode increases. While the selection process contains an element of chance, over time, all masternode operators can expect to receive comparable rewards. Masternodes that spend their collateral or fail to serve the network for over an hour are temporarily removed from the selection pool until they are operational again. This system ensures masternodes are motivated to maintain high levels of performance and reliability for the network.

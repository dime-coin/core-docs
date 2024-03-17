```{eval-rst}
.. meta::
  :title: Serialized Blocks
  :description: Describes the structure of serialized Dimecoin blocks and how the block reward is divided among miners, stakers and masternodes.
```

> ***We put our best effort into covering all topics related to Dimecoin. Each section will cover a different category. Not all documentation may be 100% accurate, if you spot an error, please report it or submit a PR request on GitHub.***
>
> ***REMINDER: This documentation is always evolving. If you have not been here for a while, perhaps check again. Things may have been added or updated since your last visit!***

## Serialized Blocks

Under current [consensus rules](../reference/glossary.md#consensus-rules), a
[block](../reference/glossary.md#block) is not valid unless its serialized size is less than or
equal to 1 MB. All fields described below are counted towards the serialized size.

| Bytes    | Name         | Data Type        | Description
| - | - | - | -
| 80       | block header | block_header     | The [block header](../reference/glossary.md#block-header) in the format described in the [block header section](blockchain.md#block-headers).
| *Varies* | txn_count    | [compactSize uint](../reference/glossary.md#compactsize) | The total number of transactions in this block, including the coinbase transaction.
| *Varies* | txns         | [raw transaction](../reference/glossary.md#raw-transaction)  | Every transaction in this block, one after another, in raw transaction format.  Transactions must appear in the data stream in the same order their TXIDs appeared in the first row of the merkle tree.  See the [merkle tree section](blockchain.md#merkle-trees) for details.

### Coinbase

The first transaction in a block must be a [coinbase
transaction](../reference/glossary.md#coinbase-transaction) which should collect and spend any
[transaction fee](../reference/glossary.md#transaction-fee) paid by transactions included in this
block.

### Supply

Dimecoin's supply is inflationary until about the year 2346. As of the consensus updates in October 2023, the rate is set at about 1.4% for the first year, and transitioning to a daily decay that results in an effective annual reduction of 8% in block rewards. By 2348, the supply will approximately cap, adding an estimated 104,709,968,124.82 coins from December 2024 to 2346. These estimates may fluctuate due to changes in mining difficulty, daily block averages, and other variables.

#### Treasury

In October of 2023, a hybrid consensus mechanism was implemented successfully. Here is a breakdown of block subsidy allocation.

| Subsidy allocation | Purpose
|-|-
| 45% | Mining / Staking Reward
| 45% | Masternode Reward
| 10% | Foundation Pay

### Block Reward

Together, the transaction fees and block subsidy are called the [block
reward](../reference/glossary.md#block-reward). A coinbase transaction is invalid if it tries to
spend more value than is available from the block reward.

The block reward is divided into three main parts: [miner/staker](../reference/glossary.md#miner),
[masternode](../reference/glossary.md#masternode), and
[foundation](../reference/glossary.md#superblock). The miner/staker and masternode portions add up to 90%
of the block subsidy with the remainder allocated to the Dimecoin Foundation.

The following table details how the block subsidy and fees are allocated between miners/stakers, masternodes, and the foundation pays.

| Payee        | Block subsidy | Transaction fees | Description
| -----        | :-----:       | :-------: | -----
| Foundation   | 10% |-        | Payment for growth of the network (core dev, marketing, integration, etc.)
| Miner/Staker | 45% |-        | Payment for creating new blocks
| Masternode   | 45% |-        | Payment for masternode services
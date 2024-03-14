```{eval-rst}
.. meta::
  :title: Transaction Broadcasting
  :description: Transaction broadcasting is the process where a transaction is sent to peer nodes in the Dimecoin network for validation and further propagation.
```

> ***We put our best effort into covering all topics related to Dimecoin. Each section will cover a different category. Not all documentation may be 100% accurate, if you spot an error, please report it or submit a PR request on GitHub.***
>
> ***REMINDER: This documentation is always evolving. If you have not been here for a while, perhaps check again. Things may have been added or updated since your last visit!***

## Transaction Broadcasting

In order to send a [transaction](../resources/glossary.md#transaction) to a [peer](../resources/glossary.md#peer), an [`inv` message](../reference/p2p-network-data-messages.md#inv) is sent. If a [`getdata` message](../reference/p2p-network-data-messages.md#getdata) is received in reply, the transaction is sent using a [`tx` message](../reference/p2p-network-data-messages.md#tx). If it is a valid transaction, the peer receiving the transaction also forwards the transaction to its peers.

### Memory Pool

Full peers may track unconfirmed transactions that are eligible to be included in the next [block](../resources/glossary.md#block). This is essential for miners or stakers who will produce some or all of those transactions. Still, it's also useful for any peer who wants to keep track of unconfirmed transactions, such as peers serving unconfirmed transaction information to SPV clients.

Since unconfirmed transactions have no permanent status in Dimecoin, Dimecoin Core stores them in non-persistent memory, calling them a memory pool or mempool. When a peer shuts down, its memory pool is lost except for any transactions stored by its wallet. This means that the never-validated and unconfirmed transactions tend to slowly disappear from the network as peers restart or as they purge some transactions to make room in memory for others.

Transactions included in blocks that subsequently become [stale blocks](../resources/glossary.md#stale-block) can be returned to the memory pool of unconfirmed transactions. In Dimecoin Core, if these transactions become present in more recent blocks, the protocol will quickly remove them from the memory pool again. The process operates sequentially: starting from the latest block, known as the tip, Dimecoin Core removes stale blocks one at a time from the blockchain. With the removal of each stale block, its transactions are placed back into the memory pool. Once all stale blocks have been cleared, the new blocks meant to replace them are added to the blockchain in order, concluding with establishing a new tip. As new blocks are integrated, they check the memory pool for their transactions, confirming and thus removing any that they contain.

SPV clients don't have a memory pool, and for the same reason, they don't relay transactions. They can only independently verify that a transaction has yet to be included in a block and that it only spends UTXOs, so they can't know which transactions are eligible to be included in the next block.

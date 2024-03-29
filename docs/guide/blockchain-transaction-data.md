```{eval-rst}
.. meta::
  :title: Transaction Data
  :description: Every block must include one or more transactions. The first one of these transactions must be a coinbase transaction which should collect and spend the block reward.
```
> ***We put our best effort into covering all topics related to Dimecoin. Each section will cover a different category. Not all documentation may be 100% accurate, if you spot an error, please report it or submit a PR request on GitHub.***
>
> ***REMINDER: This documentation is always evolving. If you have not been here for a while, perhaps check again. Things may have been added or updated since your last visit!***

## Transaction Data

Every [block](../reference/glossary.md#block) must include one or more [transactions](../reference/glossary.md#transaction). The first one of these transactions must be a [coinbase transaction](../reference/glossary.md#coinbase-transaction), also called a generation transaction. This transaction should collect and spend the [block reward](../reference/glossary.md#block-reward) (comprised of a block subsidy and any transaction fees paid by transactions included in this block).

The UTXO of a coinbase transaction has the special condition that it cannot be spent (used as an input) for at least 100 blocks. This temporarily prevents a [miner](../reference/glossary.md#miner) from spending the transaction fees and block reward from a block that may later be determined to be stale (and therefore the coinbase transaction destroyed) after a blockchain [fork](../reference/glossary.md#fork).

Blocks are not required to include any non-coinbase transactions, but validators almost always do include additional transactions in order to collect their transaction fees.

All transactions, including the coinbase transaction, are encoded into blocks in binary [raw transaction](../reference/glossary.md#raw-transaction) format.

The rawtransaction format is hashed to create the transaction identifier ([TXID](../reference/glossary.md#transaction-identifiers)). From these txids, the [merkle tree](../reference/glossary.md#merkle-tree) is constructed by pairing each txid with one other txid and then hashing them together. If there are an odd number of txids, the txid without a partner is hashed with a copy of itself.

The resulting hashes themselves are each paired with one other hash and hashed together. Any hash without a partner is hashed with itself. The process repeats until only one hash remains, the [merkle root](../reference/glossary.md#merkle-root).

For example, if transactions were merely joined (not hashed), a five-transaction merkle tree would look like the following text diagram:

```
       ABCDEEEE .......Merkle root
      /        \
   ABCD        EEEE
  /    \      /
 AB    CD    EE .......E is paired with itself
/  \  /  \  /
A  B  C  D  E .........Transactions
```

As discussed in the [Simplified Payment Verification](../reference/glossary.md#simplified-payment-verification) (SPV) subsection, the merkle tree allows clients to verify for themselves that a transaction was included in a block by obtaining the merkle root from a [block header](../reference/glossary.md#block-header) and a list of the intermediate hashes from a full [peer](../reference/glossary.md#peer). The full peer does not need to be trusted: it is expensive to fake block headers and the intermediate hashes cannot be faked or the verification will fail.

For example, to verify transaction D was added to the block, an SPV client only needs a copy of the C, AB, and EEEE hashes in addition to the merkle root; the client doesn't need to know anything about any of the other transactions. If the block's five transactions were of maximum size, obtaining the entire block would necessitate over 500,000 bytes. However, acquiring three hashes and the block header demands merely 140 bytes.

```{note}
If identical txids are found within the same block, there is a possibility that the merkle tree may collide with a block with some or all duplicates removed due to how unbalanced merkle trees are implemented (duplicating the lone hash). Since it is impractical to have separate transactions with identical txids, this does not impose a burden on honest software, but must be checked if the invalid status of a block is to be cached; otherwise, a valid block with the duplicates eliminated could have the same merkle root and block hash, but be rejected by the cached invalid outcome, resulting in security bugs such as [CVE-2012-2459](https://en.bitcoin.it/wiki/CVEs#CVE-2012-2459).
```

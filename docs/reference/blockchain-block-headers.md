```{eval-rst}
.. meta::
  :title: Dimecoin Block Headers
  :description: Describes the structure of Dimecoin block headers and provides related details on block versions, merkle trees, and mining difficulty.
```

> ***We put our best effort into covering all topics related to Dimecoin. Each section will cover a different category. Not all documentation may be 100% accurate, if you spot an error, please report it or submit a PR request on GitHub.***
>
> ***REMINDER: This documentation is always evolving. If you have not been here for a while, perhaps check again. Things may have been added or updated since your last visit!***

## Block Headers

[Block headers](../reference/glossary.md#block-header) are serialized in the 80-byte format described below and then hashed as part of the proof-of-work algorithm, making the serialized header format part of the [consensus rules](../reference/glossary.md#consensus-rules).

| Bytes | Name                | Data Type | Description
|-------|---------------------|-----------|----------------
| 4     | version             |  int32_t  | The [block](../reference/glossary.md#block) version number indicates which set of block validation rules to follow. See the list of block versions below.
| 32    | previous block header hash | char[32]  | An X11() hash in internal byte order of the previous block's header.  This ensures no previous block can be changed without also changing this block's header.
| 32    | merkle root hash    | char[32]  | A SHA256(SHA256()) hash in internal byte order. The merkle root is derived from the hashes of all transactions included in this block, ensuring that none of those transactions can be modified without modifying the header.  See the [merkle trees section](#merkle-trees) below.
| 4     | time                | uint32_t  | The block time is a Unix epoch time when the miner started hashing the header (according to the miner).  Must be strictly greater than the median time of the previous 11 blocks.  Full nodes will not accept blocks with headers more than two hours in the future according to their clock.
| 4     | nBits               | uint32_t  | An encoded version of the target threshold this block's header hash must be less than or equal to.  See the nBits format described below.
| 4     | nonce               | uint32_t  | An arbitrary number miners change to modify the header hash in order to produce a hash less than or equal to the target threshold.  If all 32-bit values are tested, the time can be updated or the coinbase transaction can be changed and the merkle root updated.

The hashes are in [internal byte order](../reference/glossary.md#internal-byte-order); the other values are all in little-endian order.

An example [header](../reference/glossary.md#header) in hex:

``` text
01000000 ........................... Block version: 1

7f3e8b1a2b9e5a3c4d6f7a8b9cb2a1f4
e6d5c4b3a2f19876e5d4c3b2a1f0e9d8 ... Hash of previous block's header
3c2d1e0f1a2b3c4d5e6f7a8b9cb2a1f4
e6d5c4b3a2f19876e5d4c3b2a1f0e9d8 ... Merkle root

5a3c2d1e ........................... Unix time: 1609459200
18b1a2c3 ........................... Target: 0x1a2b3c * 256**(0x1e-3)
87654321 ........................... Nonce
```

### Merkle Trees

The [merkle root](../reference/glossary.md#merkle-root) is constructed using all the [TXIDs](../reference/glossary.md#transaction-identifiers) of transactions in this block, but first the TXIDs are placed in order as required by the [consensus rules](../reference/glossary.md#consensus-rules):

* The [coinbase transaction](../reference/glossary.md#coinbase-transaction)'s [TXID](../reference/glossary.md#transaction-identifiers) is always placed first.

* Any [input](../reference/glossary.md#input) within this block can spend an [output](../reference/glossary.md#output) which also appears in this block (assuming the spend is otherwise valid). However, the TXID corresponding to the output must be placed at some point before the TXID corresponding to the input. This ensures that any program parsing blockchain transactions linearly will encounter each output before it is used as an input.

If a [block](../reference/glossary.md#block) only has a coinbase transaction, the coinbase TXID is used as the merkle root hash.

If a block only has a coinbase transaction and one other transaction, the TXIDs of those two transactions are placed in order, concatenated as 64 raw bytes, and then SHA256(SHA256()) hashed together to form the merkle root.

If a block has three or more transactions, intermediate [merkle tree](../reference/glossary.md#merkle-tree) rows are formed. The TXIDs are placed in order and paired, starting with the coinbase transaction's TXID. Each pair is concatenated together as 64 raw bytes and SHA256(SHA256()) hashed to form a second row of hashes. If there are an odd (non-even) number of TXIDs, the last TXID is concatenated with a copy of itself and hashed. If there are more than two hashes in the second row, the process is repeated to create a third row (and, if necessary, repeated further to create additional rows). Once a row is obtained with only two hashes, those hashes are concatenated and hashed to produce the merkle root.

![Example Merkle Tree Construction](../../img/dev/en-merkle-tree-construction.svg)

TXIDs and intermediate hashes are always in [internal byte order](../reference/glossary.md#internal-byte-order) when they're concatenated, and the resulting merkle root is also in internal byte order when it's placed in the [block header](../reference/glossary.md#block-header).

### Target nBits

The [target threshold](../reference/glossary.md#target) is a 256-bit unsigned integer which a [header](../reference/glossary.md#header) hash must be equal to or below in order for that header to be a valid part of the [blockchain](../reference/glossary.md#blockchain). However, the header field *[nBits](../reference/glossary.md#nbits)* provides only 32 bits of space, so the [target](../reference/glossary.md#target) number uses a less precise format called "compact" which works like a base-256 version of scientific notation:

![Converting nBits Into A Target Threshold](../../img/dev/en-nbits-overview.svg)

As a base-256 number, nBits can be quickly parsed as bytes the same way you might parse a decimal number in base-10 scientific notation:

![Quickly Converting nBits](../../img/dev/en-nbits-quick-parse.svg)

The target threshold was initially intended to be an unsigned integer, yet the original nBits implementation derived characteristics from a signed data class. This peculiarity permits the target threshold to assume negative values if the high bit of the significand is activated. However, this scenario is impractical as the header hash operates as an unsigned number, making it impossible to match or fall below a negative target threshold. Dimecoin Core addresses this inconsistency through two approaches:

* In processing nBits, Dimecoin Core transforms any negative target threshold into a zero target, theoretically allowing the header hash to achieve equality with it..

* When generating a value for nBits, Dimecoin Core evaluates whether it will result in an nBits perceived as negative. If this is the case, it adjusts by dividing the significand by 256 and incrementing the exponent by one, thereby encoding the same number differently.

Some examples taken from the Dimecoin Core test cases:

|nBits      |  Target          | Notes
|-----------|------------------|----------------
|0x01003456 | &nbsp;0x00       |N/A
|0x01123456 | &nbsp;0x12       |N/A
|0x02008000 | &nbsp;0x80       |N/A
|0x05009234 | &nbsp;0x92340000 |N/A
|0x04923456 | &nbsp;0x12345600 | High bit set (0x80 in 0x92).
|0x04123456 | &nbsp;0x12345600 | Inverse of above; no high bit.

Difficulty 1, the minimum allowed [difficulty](../reference/glossary.md#difficulty), is represented on [mainnet](../reference/glossary.md#mainnet) and the current [testnet](../reference/glossary.md#testnet) by the nBits value 0x1e0ffff0. Regtest mode uses a different difficulty 1 value---0x207fffff, the highest possible value below uint32_max which can be encoded; this allows near-instant building of blocks in [regression test mode](../reference/glossary.md#regression-test-mode).
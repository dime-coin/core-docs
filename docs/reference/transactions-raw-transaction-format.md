```{eval-rst}
.. meta::
  :title: Raw Transaction Format
  :description: Dimecoin transactions are broadcast in a serialized raw format, which is hashed to create the TXID and merkle root, complying with the consensus rules.
```

> ***We put our best effort into covering all topics related to Dimecoin. Each section will cover a different category. Not all documentation may be 100% accurate, if you spot an error, please report it or submit a PR request on GitHub.***
>
> ***REMINDER: This documentation is always evolving. If you have not been here for a while, perhaps check again. Things may have been added or updated since your last visit!***

### Raw Transaction Format

Dimecoin transactions are broadcast between [peers](../reference/glossary.md#peer) in a serialized byte format, called [raw format](../reference/glossary.md#raw-format). It is this form of a transaction which is SHA256(SHA256()) hashed to create the [TXID](../reference/glossary.md#transaction-identifiers) and, ultimately, the [merkle root](../reference/glossary.md#merkle-root) of a [block](../reference/glossary.md#block) containing the transaction---making the transaction format part of the [consensus rules](../reference/glossary.md#consensus-rules).

Dimecoin Core and many other tools print and accept [raw transactions](../reference/glossary.md#raw-transaction) encoded as hex.

A raw transaction has the following top-level format:

| Bytes    | Name         | Data Type           | Description
|----------|--------------|---------------------|-------------
| 2        | version      | int32_t            | Transaction version number; currently version 1 or 2.  Programs creating transactions using newer consensus rules may use higher version numbers.
| *Varies* | tx_in count  | compactSize uint    | Number of inputs in this transaction.
| *Varies* | tx_in        | txIn                | Transaction inputs.  See description of txIn below.
| *Varies* | tx_out count | compactSize uint    | Number of outputs in this transaction.
| *Varies* | tx_out       | txOut               | Transaction outputs.  See description of txOut below.
| 4        | lock_time    | uint32_t            | A time (Unix epoch time) or block number.  See the [locktime parsing rules](../guide/transactions-locktime-and-sequence-number.md).

A transaction may have multiple [inputs](../reference/glossary.md#input) and [outputs](../reference/glossary.md#output), so the txIn and txOut structures may recur within a transaction. [CompactSize unsigned integers](../reference/glossary.md#compactsize) are a form of variable-length integers; they are described in the [CompactSize section](../reference/transactions-compactsize-unsigned-integers.md).

#### JSON-RPC Responses

When retrieving transaction data via Dimecoin Core RPCs (e.g. the [`getrawtransaction` RPC](../api/rpc-raw-transactions.md#getrawtransaction)), the transaction data is returned in the following format.

Transaction Structure

``` json
{
  "txid": "<string>",
  "size": "<int>",
  "version": 2,
  "locktime": 0,
  "vin": [ ],
  "vout": [ ]
}
```

**<span id="txin"></span>**

#### TxIn: A Transaction Input (Non-Coinbase)

Each non- [coinbase](../reference/glossary.md#coinbase) [input](../reference/glossary.md#input) spends an outpoint from a previous transaction. (Coinbase inputs are described separately after the example section below.)

| Bytes    | Name             | Data Type            | Description
|----------|------------------|----------------------|--------------
| 36       | previous_output  | [outpoint](../reference/glossary.md#outpoint)             | The previous outpoint being spent.  See description of outpoint below.
| *Varies* | script bytes     | compactSize uint     | The number of bytes in the signature script.  Maximum is 10,000 bytes.
| *Varies* | signature script | char[]               | A script-language script which satisfies the conditions placed in the outpoint's pubkey script.  Should only contain data pushes; see the [signature script modification warning](transactionsmd#signature-script-modification).
| 4        | sequence         | uint32_t             | Sequence number.  Default for Dimecoin Core and almost all other programs is 0xffffffff.

**<span id="outpoint"></span>**

#### Outpoint: The Specific Part Of A Specific Output

Because a single transaction can include multiple [outputs](../reference/glossary.md#output), the [outpoint](../reference/glossary.md#outpoint) structure includes both a [TXID](../reference/glossary.md#transaction-identifiers) and an output index number to refer to specific output.

| Bytes | Name  | Data Type | Description
|-------|-------|-----------|--------------
| 32    | hash  | char[32]  | The TXID of the transaction holding the output to spend.  The TXID is a hash provided here in internal byte order.
| 4     | index | uint32_t  | The output index number of the specific output to spend from the transaction. The first output is 0x00000000.

**<span id="txout"></span>**

#### TxOut: A Transaction Output

Each [output](../reference/glossary.md#output) spends a certain number of dimecoins, placing them under control of anyone who can satisfy the provided [pubkey script](../reference/glossary.md#pubkey-script).

| Bytes    | Name            | Data Type        | Description
|----------|-----------------|------------------|--------------
| 8        | value           | int64_t          | Number of dimecoins to spend.  May be zero; the sum of all outputs may not exceed the sum of dimecoins previously spent to the outpoints provided in the input section.  (Exception: coinbase transactions spend the block subsidy and collected transaction fees.)
| 1+       | pk_script bytes | compactSize uint | Number of bytes in the pubkey script.  Maximum is 10,000 bytes.
| *Varies* | pk_script       | char[]           | Defines the conditions which must be satisfied to spend this output.

**Example**

The sample raw transaction itemized below is the one created in the [Simple Raw Transaction section](../examples/transaction-tutorial-simple-raw-transaction.md) of the Developer Examples. It spends a previous pay-to-pubkey output by paying to a new pay-to-pubkey-hash (P2PKH) output.

``` text
01000000 ................................... Version

01 ......................................... Number of inputs
|
| 7b1eabe0209b1fe794124575ef807057
| c77ada2138ae4fa8d6c4de0398a14f3f ......... Outpoint TXID
| 00000000 ................................. Outpoint index number: 0
|
| 49 ....................................... Bytes in sig. script: 73
| | 48 ..................................... Push 72 bytes as data
| | | 30450221008949f0cb400094ad2b5eb3
| | | 99d59d01c14d73d8fe6e96df1a7150de
| | | b388ab8935022079656090d7f6bac4c9
| | | a94e0aad311a4268e082a725f8aeae05
| | | 73fb12ff866a5f01 ..................... Secp256k1 signature
|
| ffffffff ................................. Sequence number: UINT32_MAX

01 ......................................... Number of outputs
| f0ca052a01000000 ......................... Dimecoins (49.99990000 DIME)
|
| 19 ....................................... Bytes in pubkey script: 25
| | 76 ..................................... OP_DUP
| | a9 ..................................... OP_HASH160
| | 14 ..................................... Push 20 bytes as data
| | | cbc20a7664f2f69e5355aa427045bc15
| | | e7c6c772 ............................. PubKey hash
| | 88 ..................................... OP_EQUALVERIFY
| | ac ..................................... OP_CHECKSIG

00000000 ................................... locktime: 0 (a block height)
```

**<span id="coinbase"></span>**

#### Coinbase Input: The Input Of The First Transaction In A Block

The first transaction in a [block](../reference/glossary.md#block), called the [coinbase transaction](../reference/glossary.md#coinbase-transaction), must have exactly one input, called a [coinbase](../reference/glossary.md#coinbase). The coinbase [input](../reference/glossary.md#input) currently has the following format.

| Bytes    | Name               | Data Type            | Description
|----------|--------------------|----------------------|--------------
| 32       | hash (null)        | char[32]             | A 32-byte null, as a coinbase has no previous outpoint.
| 4        | index (UINT32_MAX) | uint32_t             | 0xffffffff, as a coinbase has no previous outpoint.
| *Varies* | script bytes       | compactSize uint     | The number of bytes in the coinbase script, up to a maximum of 100 bytes.
| *Varies* (4) | height         | script               | The [block height](../reference/glossary.md#block-height) of this block as required by BIP34.  Uses script language: starts with a data-pushing opcode that indicates how many bytes to push to the stack followed by the block height as a little-endian unsigned integer.  This script must be as short as possible, otherwise it may be rejected.<br><br>  The data-pushing opcode will be 0x03 and the total size four bytes until block 16,777,216 about 300 years from now.
| *Varies* | coinbase script    | *None*               | The [coinbase field](../reference/glossary.md#coinbase): Arbitrary data not exceeding 100 bytes minus the (4) height bytes.  Miners commonly place an extra nonce in this field to update the block header merkle root during hashing.
| 4        | sequence           | uint32_t             | Sequence number.

Although the coinbase script is arbitrary data, if it includes the bytes used by any signature-checking operations such as [`OP_CHECKSIG`](transactions.md#opcodes), those signature checks will be counted as signature operations (sigops) towards the block's sigop limit.  To avoid this, you can prefix all data with the appropriate push operation.

An itemized [coinbase transaction](../reference/glossary.md#coinbase-transaction):

``` text
01000000 .............................. Version

01 .................................... Number of inputs
| 00000000000000000000000000000000
| 00000000000000000000000000000000 ...  Previous outpoint TXID
| ffffffff ............................ Previous outpoint index
|
| 18 .................................. Bytes in coinbase: 24
| |
| | 03 ................................ Bytes in height
| | | b8240b .......................... Height: 730296
| |
| | 03b8240b049d29aa59080400077efa95
| | 0000052f6d70682f .................. Arbitrary data
| 00000000 ............................ Sequence

02 .................................... Output count
| Transaction Output 1
| | f20cbe0a00000000 .................... Dimecoins (1.80227314 DIME)
| | 1976a9142cd46be3ceeacca983e0fea3
| | b88f26b08a26c29b88ac ................ P2PKH script
|
| Transaction Output 2
| | eb0cbe0a00000000 .................... Dimecoins (1.80227307 DIME)
| | 1976a914868180414905937a68fadeb0
| | f33e64d102c9591a88ac ................ P2PKH script
|
| 00000000 ............................ Locktime
```

> ***We put our best effort into covering all topics related to Dimecoin. Each section will cover a different category. Not all documentation may be 100% accurate, if you spot an error, please report it or submit a PR request on GitHub.***
>
> ***REMINDER: This documentation is always evolving. If you have not been here for a while, perhaps check again. Things may have been added or updated since your last visit!***

## Transactions

The following section briefly documents Dimecoin core's transaction details.

```{eval-rst}
.. meta::
  :title: Transactions, OpCodes, Raw Transaction Format
  :description: A breakdown of Dimecoin transaction structure
```

### OpCodes

The [opcodes](../resources/glossary.md#opcode) used in the pubkey scripts of standard [transactions](../resources/glossary.md#transaction) are:

* Various data pushing opcodes from 0x00 to 0x4e (1--78). These aren't typically shown in examples, but they must be used to push [signatures](../resources/glossary.md#signature) and [public keys](../resources/glossary.md#public-key) onto the stack. See the link below this list for a description.

* `OP_TRUE`/`OP_1` (0x51) and `OP_2` through `OP_16` (0x52--0x60), which push the values 1 through 16 to the stack.

* `OP_VERIFY` (0x69) consumes the topmost item on the stack. If that item is zero (false) it terminates the script in failure.

* `OP_RETURN` (0x6a) terminates the script in failure when executed.

* `OP_DUP` (0x76) pushes a copy of the topmost stack item on to the stack.

* `OP_EQUAL` (0x87) consumes the top two items on the stack, compares them, and pushes true onto the stack if they are the same, false if not.

* `OP_EQUALVERIFY` (0x88) runs `OP_EQUAL` and then `OP_VERIFY` in sequence.

* `OP_HASH160` (0xa9) consumes the topmost item on the stack, computes the RIPEMD160(SHA256()) hash of that item, and pushes that hash onto the stack.

**<span id="op_checksig"></span>**

* `OP_CHECKSIG` (0xac) consumes a signature and a full public key, and pushes true onto the stack if the transaction data specified by the [SIGHASH flag](../resources/glossary.md#sighash-flag) was converted into the signature using the same [ECDSA private key](../resources/glossary.md#ecdsa-private-key) that generated the public key. Otherwise, it pushes false onto the stack.

* `OP_CHECKMULTISIG` (0xae) consumes the value (n) at the top of the stack, consumes that many of the next stack levels (public keys), consumes the value (m) now at the top of the stack, and consumes that many of the next values (signatures) plus one extra value.

    The "one extra value" it consumes is the result of an off-by-one error in the Bitcoin Core implementation. This value is not used, so signature scripts prefix the list of [secp256k1 signatures](../resources/glossary.md#secp256k1-signatures) with a single OP_0 (0x00).

    `OP_CHECKMULTISIG` compares the first signature against each public key until it finds an [ECDSA](https://en.wikipedia.org/wiki/Elliptic_Curve_Digital_Signature_Algorithm) match. Starting with the subsequent public key, it compares the second signature against each remaining public key until it finds an ECDSA match. The process is repeated until all signatures have been checked or not enough public keys remain to produce a successful result.

    Because public keys are not checked again if they fail any signature comparison, signatures must be placed in the signature script using the same order as their corresponding public keys were placed in the [pubkey script](../resources/glossary.md#pubkey-script) or [redeem script](../resources/glossary.md#redeem-script). See the `OP_CHECKMULTISIG` warning below for more details.

A complete list of Bitcoin opcodes can be found on the Bitcoin Wiki [Script Page](https://en.bitcoin.it/wiki/Script), with an authoritative list in the `opcodetype` enum of the Dimecoin Core [script header file](https://github.com/dime-coin/dimecoin/blob/master/src/script/script.h).

### Signature Scripts

#### Signature Script Modification

**<span id="signature_script_modification_warning">Warning: Signature Script Modification -</span>:** [Signature scripts](../resources/glossary.md#signature-script) are not signed, so anyone can modify them. This means signature scripts should only contain data and [data-pushing opcode](../resources/glossary.md#data-pushing-opcode) which can't be modified without causing the pubkey script to fail. Placing non-data-pushing opcodes in the signature script currently makes a transaction non-standard, and future consensus rules may forbid such transactions altogether. (Non-data-pushing opcodes are already forbidden in signature scripts when spending a [P2SH pubkey script](../resources/glossary.md#p2sh-pubkey-script).)

#### Multisig Signature Order

**`OP_CHECKMULTISIG` Warning:** The [multisig](../resources/glossary.md#multisig) verification process described above requires that signatures in the signature script be provided in the same order as their corresponding public keys in the pubkey script or redeem script. For example, the following combined signature and pubkey script will produce the stack and comparisons shown:

``` text
OP_0 <A sig> <B sig> OP_2 <A pubkey> <B pubkey> <C pubkey> OP_3

Sig Stack       Pubkey Stack  (Actually a single stack)
---------       ------------
B sig           C pubkey
A sig           B pubkey
OP_0            A pubkey

1. B sig compared to C pubkey (no match)
2. B sig compared to B pubkey (match #1)
3. A sig compared to A pubkey (match #2)

Success: two matches found
```

But reversing the order of the signatures with everything else the same will fail, as shown below:

``` text
OP_0 <B sig> <A sig> OP_2 <A pubkey> <B pubkey> <C pubkey> OP_3

Sig Stack       Pubkey Stack  (Actually a single stack)
---------       ------------
A sig           C pubkey
B sig           B pubkey
OP_0            A pubkey

1. A sig compared to C pubkey (no match)
2. A sig compared to B pubkey (no match)

Failure, aborted: two signature matches required but none found so
                  far, and there's only one pubkey remaining
```

### Address Conversion

The hashes used in P2PKH and [P2SH outputs](../resources/glossary.md#p2sh-output) are commonly encoded as Dimecoin [addresses](../resources/glossary.md#address).  This is the procedure to encode those hashes and decode the addresses.

#### Conversion Process

First, get your hash.  For P2PKH, you RIPEMD-160(SHA256()) hash a ECDSA [public key](../resources/glossary.md#public-key) derived from your 256-bit ECDSA [private key](../resources/glossary.md#private-key) (random data). For P2SH, you RIPEMD-160(SHA256()) hash a [redeem script](../resources/glossary.md#redeem-script) serialized in the format used in [raw transactions](../resources/glossary.md#raw-transaction) (described in a [following sub-section](../reference/transactions-raw-transaction-format.md)).  Taking the resulting hash:

1. Add an [address](../resources/glossary.md#address) version byte in front of the hash.  Version bytes commonly used by Dimecoin are:

    * 0x4c for [P2PKH addresses](../resources/glossary.md#p2pkh-address) on the main Dimecoin network ([mainnet](../resources/glossary.md#mainnet))

    * 0x8c for [P2PKH addresses](../resources/glossary.md#p2pkh-address) on the Dimecoin testing network ([testnet](../resources/glossary.md#testnet))

    * 0x10 for [P2SH addresses](../resources/glossary.md#p2sh-address) on [mainnet](../resources/glossary.md#mainnet)

    * 0x13 for [P2SH addresses](../resources/glossary.md#p2sh-address) on [testnet](../resources/glossary.md#testnet)

2. Create a copy of the version and hash; then hash that twice with SHA256: `SHA256(SHA256(version . hash))`

3. Extract the first four bytes from the double-hashed copy. These are used as a checksum to ensure the base hash gets transmitted correctly.

4. Append the checksum to the version and hash, and encode it as a [base58](../resources/glossary.md#base58) string: `BASE58(version . hash . checksum)`

#### Example Code

Dimecoin's base58 encoding, called [Base58Check](../resources/glossary.md#base58check) may not match other implementations. Tier Nolan provided the following example encoding algorithm to the Bitcoin Wiki [Base58Check encoding](https://en.bitcoin.it/wiki/Base58Check_encoding) page under the [Creative Commons Attribution 3.0 license](https://creativecommons.org/licenses/by/3.0/):

``` c
code_string = "123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz"
x = convert_bytes_to_big_integer(hash_result)

output_string = ""

while(x > 0)
   {
       (x, remainder) = divide(x, 58)
       output_string.append(code_string[remainder])
   }

repeat(number_of_leading_zero_bytes_in_hash)
   {
   output_string.append(code_string[0]);
   }

output_string.reverse();
```

Dimecoin's own code can be traced using the [base58 header file](https://github.com/dimec-coin/dimecoin/blob/master/src/base58.h).

To convert addresses back into hashes, reverse the base58 encoding, extract the checksum, repeat the steps to create the checksum and compare it against the extracted checksum, and then remove the version byte.

### Raw Transaction Format

Dimecoin transactions are broadcast between [peers](../resources/glossary.md#peer) in a serialized byte format, called [raw format](../resources/glossary.md#raw-format). It is this form of a transaction which is SHA256(SHA256()) hashed to create the [TXID](../resources/glossary.md#transaction-identifiers) and, ultimately, the [merkle root](../resources/glossary.md#merkle-root) of a [block](../resources/glossary.md#block) containing the transaction---making the transaction format part of the [consensus rules](../resources/glossary.md#consensus-rules).

Dimecoin Core and many other tools print and accept [raw transactions](../resources/glossary.md#raw-transaction) encoded as hex.

A raw transaction has the following top-level format:

| Bytes    | Name         | Data Type           | Description
|----------|--------------|---------------------|-------------
| 2        | version      | int32_t            | Transaction version number; currently version 1 or 2.  Programs creating transactions using newer consensus rules may use higher version numbers.
| *Varies* | tx_in count  | compactSize uint    | Number of inputs in this transaction.
| *Varies* | tx_in        | txIn                | Transaction inputs.  See description of txIn below.
| *Varies* | tx_out count | compactSize uint    | Number of outputs in this transaction.
| *Varies* | tx_out       | txOut               | Transaction outputs.  See description of txOut below.
| 4        | lock_time    | uint32_t            | A time (Unix epoch time) or block number.  See the [locktime parsing rules](../guide/transactions-locktime-and-sequence-number.md).

A transaction may have multiple [inputs](../resources/glossary.md#input) and [outputs](../resources/glossary.md#output), so the txIn and txOut structures may recur within a transaction. [CompactSize unsigned integers](../resources/glossary.md#compactsize) are a form of variable-length integers; they are described in the [CompactSize section](../reference/transactions-compactsize-unsigned-integers.md).

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

Each non- [coinbase](../resources/glossary.md#coinbase) [input](../resources/glossary.md#input) spends an outpoint from a previous transaction. (Coinbase inputs are described separately after the example section below.)

| Bytes    | Name             | Data Type            | Description
|----------|------------------|----------------------|--------------
| 36       | previous_output  | [outpoint](../resources/glossary.md#outpoint)             | The previous outpoint being spent.  See description of outpoint below.
| *Varies* | script bytes     | compactSize uint     | The number of bytes in the signature script.  Maximum is 10,000 bytes.
| *Varies* | signature script | char[]               | A script-language script which satisfies the conditions placed in the outpoint's pubkey script.  Should only contain data pushes; see the [signature script modification warning](transactionsmd#signature-script-modification).
| 4        | sequence         | uint32_t             | Sequence number.  Default for Dimecoin Core and almost all other programs is 0xffffffff.

**<span id="outpoint"></span>**

#### Outpoint: The Specific Part Of A Specific Output

Because a single transaction can include multiple [outputs](../resources/glossary.md#output), the [outpoint](../resources/glossary.md#outpoint) structure includes both a [TXID](../resources/glossary.md#transaction-identifiers) and an output index number to refer to specific output.

| Bytes | Name  | Data Type | Description
|-------|-------|-----------|--------------
| 32    | hash  | char[32]  | The TXID of the transaction holding the output to spend.  The TXID is a hash provided here in internal byte order.
| 4     | index | uint32_t  | The output index number of the specific output to spend from the transaction. The first output is 0x00000000.

**<span id="txout"></span>**

#### TxOut: A Transaction Output

Each [output](../resources/glossary.md#output) spends a certain number of dimecoins, placing them under control of anyone who can satisfy the provided [pubkey script](../resources/glossary.md#pubkey-script).

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

The first transaction in a [block](../resources/glossary.md#block), called the [coinbase transaction](../resources/glossary.md#coinbase-transaction), must have exactly one input, called a [coinbase](../resources/glossary.md#coinbase). The coinbase [input](../resources/glossary.md#input) currently has the following format.

| Bytes    | Name               | Data Type            | Description
|----------|--------------------|----------------------|--------------
| 32       | hash (null)        | char[32]             | A 32-byte null, as a coinbase has no previous outpoint.
| 4        | index (UINT32_MAX) | uint32_t             | 0xffffffff, as a coinbase has no previous outpoint.
| *Varies* | script bytes       | compactSize uint     | The number of bytes in the coinbase script, up to a maximum of 100 bytes.
| *Varies* (4) | height         | script               | The [block height](../resources/glossary.md#block-height) of this block as required by BIP34.  Uses script language: starts with a data-pushing opcode that indicates how many bytes to push to the stack followed by the block height as a little-endian unsigned integer.  This script must be as short as possible, otherwise it may be rejected.<br><br>  The data-pushing opcode will be 0x03 and the total size four bytes until block 16,777,216 about 300 years from now.
| *Varies* | coinbase script    | *None*               | The [coinbase field](../resources/glossary.md#coinbase): Arbitrary data not exceeding 100 bytes minus the (4) height bytes.  Miners commonly place an extra nonce in this field to update the block header merkle root during hashing.
| 4        | sequence           | uint32_t             | Sequence number.

Although the coinbase script is arbitrary data, if it includes the bytes used by any signature-checking operations such as [`OP_CHECKSIG`](transactions.md#opcodes), those signature checks will be counted as signature operations (sigops) towards the block's sigop limit.  To avoid this, you can prefix all data with the appropriate push operation.

An itemized [coinbase transaction](../resources/glossary.md#coinbase-transaction):

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

### CompactSize Unsigned Integers

The [raw transaction](../resources/glossary.md#raw-transaction) format and several peer-to-peer network messages use a type of variable-length integer to indicate the number of bytes in a following piece of data.

Dimecoin Core code and this document refers to these variable length integers as compactSize. Many other documents refer to them as var_int or varInt, but this risks conflation with other variable-length integer encodings---such as the CVarInt class used in Dimecoin Core for serializing data to disk.  Because it's used in the transaction format, the format of compactSize unsigned integers is part of the [consensus rules](../resources/glossary.md#consensus-rules).

For numbers from 0 to 252 (0xfc), compactSize unsigned integers look like regular unsigned integers. For other numbers up to 0xffffffffffffffff, a byte is prefixed to the number to indicate its length---but otherwise the numbers look like regular unsigned integers in little-endian order.

| Value                                   | Bytes Used | Format
|-----------------------------------------|------------|-----------------------------------------
| >= 0 && <= 0xfc (252)                   | 1          | uint8_t
| >= 0xfd (253) && <= 0xffff              | 3          | 0xfd followed by the number as uint16_t
| >= 0x10000 && <= 0xffffffff             | 5          | 0xfe followed by the number as uint32_t
| >= 0x100000000 && <= 0xffffffffffffffff | 9          | 0xff followed by the number as uint64_t

For example, the number 515 is encoded as 0xfd0302.

> ***We put our best effort into covering all topics related to Dimecoin. Each section will cover a different category. Not all documentation may be 100% accurate, if you spot an error, please report it or submit a PR request on GitHub***
>
> ***REMINDER: This documentation is always evolving. If you have not been here for a while, perhaps check again. Things may have been added or updated since your last visit!***

# Transactions

The following section briefly documents Dimecoin core's transaction details.

```{eval-rst}
.. meta::
  :title: Transactions, OpCodes, Raw Transaction Format
  :description: A breakdown of Dimecoin transaction structure
```
## OpCodes

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

## Signature Scripts

### Signature Script Modification

**<span id="signature_script_modification_warning">Warning: Signature Script Modification -</span>:** [Signature scripts](../resources/glossary.md#signature-script) are not signed, so anyone can modify them. This means signature scripts should only contain data and [data-pushing opcode](../resources/glossary.md#data-pushing-opcode) which can't be modified without causing the pubkey script to fail. Placing non-data-pushing opcodes in the signature script currently makes a transaction non-standard, and future consensus rules may forbid such transactions altogether. (Non-data-pushing opcodes are already forbidden in signature scripts when spending a [P2SH pubkey script](../resources/glossary.md#p2sh-pubkey-script).)

### Multisig Signature Order

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
## Address Conversion

The hashes used in P2PKH and [P2SH outputs](../resources/glossary.md#p2sh-output) are commonly encoded as Dimecoin [addresses](../resources/glossary.md#address).  This is the procedure to encode those hashes and decode the addresses.

### Conversion Process

First, get your hash.  For P2PKH, you RIPEMD-160(SHA256()) hash a ECDSA [public key](../resources/glossary.md#public-key) derived from your 256-bit ECDSA [private key](../resources/glossary.md#private-key) (random data). For P2SH, you RIPEMD-160(SHA256()) hash a [redeem script](../resources/glossary.md#redeem-script) serialized in the format used in [raw transactions](../resources/glossary.md#raw-transaction) (described in a [following sub-section](../reference/transactions-raw-transaction-format.md)).  Taking the resulting hash:

1. Add an [address](../resources/glossary.md#address) version byte in front of the hash.  Version bytes commonly used by Dimecoin are:

    * 0x4c for [P2PKH addresses](../resources/glossary.md#p2pkh-address) on the main Dimecoin network ([mainnet](../resources/glossary.md#mainnet))

    * 0x8c for [P2PKH addresses](../resources/glossary.md#p2pkh-address) on the Dimecoin testing network ([testnet](../resources/glossary.md#testnet))

    * 0x10 for [P2SH addresses](../resources/glossary.md#p2sh-address) on [mainnet](../resources/glossary.md#mainnet)

    * 0x13 for [P2SH addresses](../resources/glossary.md#p2sh-address) on [testnet](../resources/glossary.md#testnet)

2. Create a copy of the version and hash; then hash that twice with SHA256: `SHA256(SHA256(version . hash))`

3. Extract the first four bytes from the double-hashed copy. These are used as a checksum to ensure the base hash gets transmitted correctly.

4. Append the checksum to the version and hash, and encode it as a [base58](../resources/glossary.md#base58) string: `BASE58(version . hash . checksum)`

### Example Code

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

## Raw Transaction Format

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

### JSON-RPC Responses

When retrieving transaction data via Dimecoin Core RPCs (e.g. the [`getrawtransaction` RPC](../api/remote-procedure-calls-raw-transactions.md#getrawtransaction)), the transaction data is returned in the following format.

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

### TxIn: A Transaction Input (Non-Coinbase)

Each non- [coinbase](../resources/glossary.md#coinbase) [input](../resources/glossary.md#input) spends an outpoint from a previous transaction. (Coinbase inputs are described separately after the example section below.)

| Bytes    | Name             | Data Type            | Description
|----------|------------------|----------------------|--------------
| 36       | previous_output  | [outpoint](../resources/glossary.md#outpoint)             | The previous outpoint being spent.  See description of outpoint below.
| *Varies* | script bytes     | compactSize uint     | The number of bytes in the signature script.  Maximum is 10,000 bytes.
| *Varies* | signature script | char[]               | A script-language script which satisfies the conditions placed in the outpoint's pubkey script.  Should only contain data pushes; see the [signature script modification warning](transactionsmd#signature-script-modification).
| 4        | sequence         | uint32_t             | Sequence number.  Default for Dimecoin Core and almost all other programs is 0xffffffff.

**<span id="outpoint"></span>**

### Outpoint: The Specific Part Of A Specific Output

Because a single transaction can include multiple [outputs](../resources/glossary.md#output), the [outpoint](../resources/glossary.md#outpoint) structure includes both a [TXID](../resources/glossary.md#transaction-identifiers) and an output index number to refer to specific output.

| Bytes | Name  | Data Type | Description
|-------|-------|-----------|--------------
| 32    | hash  | char[32]  | The TXID of the transaction holding the output to spend.  The TXID is a hash provided here in internal byte order.
| 4     | index | uint32_t  | The output index number of the specific output to spend from the transaction. The first output is 0x00000000.

**<span id="txout"></span>**

### TxOut: A Transaction Output

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

### Coinbase Input: The Input Of The First Transaction In A Block

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
## Special Transactions

The [Special Transactions](../resources/glossary.md#special-transactions) framework established by [DIP2](https://github.com/dashpay/dips/blob/master/dip-0002.md) enabled the implementation of new on-chain features and [consensus](../resources/glossary.md#consensus) mechanisms. These transactions provide the flexibility to expand beyond the financial uses of classical transactions. DIP2 transactions modified classical transactions by:

1. Splitting the 32 bit `version` field into two 16 bit fields (`version` and `type`)
2. Adding support for a generic extra payload following the `lock_time` field. The maximum allowed size for a transaction version 3 extra payload is 10000 bytes (`MAX_TX_EXTRA_PAYLOAD`).

Classical (financial) transactions have a `type` of 0 while special transactions have a `type` defined in the DIP describing them. A list of current special transaction types is maintained in the [DIP repository](https://github.com/dashpay/dips/blob/master/dip-0002/special-transactions.md).

**Implemented Special Transactions**

| Release | Tx Version | Tx Type | Payload JSON                | Tx Purpose                               | Payload | Payload Size     |
| ------- | ---------- | ------- | --------------------------- | ---------------------------------------- | ------- | ---------------- |
| 0.12.3  | 2          | -       | n/a                         | n/a                                      | n/a     |                  |
| 0.13.0  | 3          | 0       | n/a                         | Standard (Classical) Transaction         | n/a     | n/a              |
| 0.13.0  | 3          | 1       | [ProRegTx](#proregtx)       | Masternode Registration                  | hex     | compactSize uint |
| 0.13.0  | 3          | 2       | [ProUpServTx](#proupservtx) | Update Masternode Service                | hex     | compactSize uint |
| 0.13.0  | 3          | 3       | [ProUpRegTx](#proupregtx)   | Update Masternode Operator               | hex     | compactSize uint |
| 0.13.0  | 3          | 4       | [ProUpRevTx](#prouprevtx)   | Masternode Operator Revocation           | hex     | compactSize uint |
| 0.13.0  | 3          | 5       | [CbTx](#cbtx)               | Masternode List Merkle Proof             | hex     | compactSize uint |
| 0.13.0  | 3          | 6       | [QcTx](#qctx)               | Long-Living Masternode Quorum Commitment | hex     | compactSize uint |

```{eval-rst}
.. _ref-txs-proregtx:
```

### ProRegTx

*Adopted from Dash Core which was added in protocol version 70213 of Dash Core as described by [DIP3](https://github.com/dashpay/dips/blob/master/dip-0003.md)*

The [masternode](../resources/glossary.md#masternode) Registration (ProRegTx) special transaction is used to join the masternode list by proving ownership of the 500 000 000 DIME necessary to create a masternode.

A ProRegTx is created and sent using the [`protx` RPC](../api/remote-procedure-calls-evo.md#protx). The ProRegTx must either include an [output](../resources/glossary.md#output) with 500 000 000 DIME (`protx register`) or refer to an existing unspent output holding 500 000 000 DIME (`protx fund_register`). If the 500 000 000 DIME is an output of the ProRegTx, the collateralOutpoint hash field should be null.

The special transaction type is 1 and the extra payload consists of the following data:

| Bytes | Name | Data type |  Description |
| ---------- | ----------- | -------- | -------- |
| 2 | version | uint_16 | Provider transaction version number. Currently set to 1.  Updated to 2 after v19 hard fork.
| 2 | type | uint_16 | Masternode type. Default set to 0.
| 2 | mode | uint_16 | Masternode mode. Default set to 0.
| 36 | collateralOutpoint | COutpoint | The collateral outpoint.<br>**Note:** The hash will be null if the collateral is part of this transaction, otherwise it will reference an existing collateral.
| 16 | ipAddress | byte[] | IPv6 address in network byte order. Only IPv4 mapped addresses are allowed (to be extended in the future)
| 2 | port | uint_16 | Port (network byte order)
| 20 | KeyIdOwner | CKeyID | The public key hash used for owner related signing (ProTx updates, governance voting)
| 48 | PubKeyOperator | CBLSPublicKey | The BLS public key used for operational related signing (network messages, ProTx updates).<br>**Note**: serialization varies based on `version`:<br> - Version 1 - legacy BLS scheme<br> - Version 2 - basic BLS scheme
| 20 | KeyIdVoting | CKeyID | The public key hash used for voting.
| 2 | operatorReward | uint_16 | A value from 0 to 10000.
| 1-9 | scriptPayoutSize | compactSize uint | Size of the Payee Script.
| Variable | scriptPayout | Script | Payee script (p2pkh/p2sh)
| 32 | inputsHash | uint256 | Hash of all the outpoints of the transaction inputs
| 1-9 | payloadSigSize |compactSize uint | Size of the Signature
| Variable | payloadSig | vector | Signature of the hash of the ProTx fields. Signed with the key corresponding to the collateral outpoint in case the collateral is not part of the ProRegTx itself, empty otherwise.

The following annotated hexdump shows a ProRegTx transaction referencing an existing collateral. (Parts of the classical transaction section have been omitted.)

``` text Version 1 ProRegTx (existing collateral)
0300 ....................................... Version (3)
0100 ....................................... Type (1 - ProRegTx)

[...] ...................................... Transaction inputs omitted
[...] ...................................... Transaction outputs omitted

00000000 ................................... locktime: 0 (a block height)

fd1201 ..................................... Extra payload size (274)

ProRegTx Payload
| 0100 ..................................... Version (1)
| 0000 ..................................... Type (0)
| 0000 ..................................... Mode (0)
|
| 4859747b0eb19bb2dae5a12ef7b6a69b
| 03712bfeded1174de0b6ab1334ab2e8b ......... Outpoint TXID
| 01000000 ................................. Outpoint index number: 1
|
| 00000000000000000000ffffc0000233 ......... IP Address: ::ffff:192.0.2.51
| 270f ..................................... Port: 9999
|
|
| 1636e84d02310b0b458f3eb51d8ea8b2e684b7ce . Owner pubkey hash (ECDSA)
| 88d719278eef605d9c19037366910b59bc28d437
| de4a8db4d76fda6d6985dbdf10404fb9bb5cd0e8
| c22f4a914a6c5566 ......................... Operator public key (BLS)
| 1636e84d02310b0b458f3eb51d8ea8b2e684b7ce . Voting pubkey hash (ECDSA)
|
| f401 ..................................... Operator reward (500 -> 5%)
|
| Payout script
| 19 ....................................... Bytes in pubkey script: 25
| | 76 ..................................... OP_DUP
| | a9 ..................................... OP_HASH160
| | 14 ..................................... Push 20 bytes as data
| | | fc136008111fcc7a05be6cec66f97568
| | | 727a9e51 ............................. PubKey hash
| | 88 ..................................... OP_EQUALVERIFY
| | ac ..................................... OP_CHECKSIG
|
| 0fcfb7d939078ba6a6b81ecf1dc2e05d
| e2776f49f7b503ac254798be6a672699 ......... Inputs hash
|
| Payload signature
| 41 ....................................... Signature Size (65)
| 200476f193b465764093014ba44bd4ff
| de2b3fc92794c4acda9cad6305ca172e
| 9e3d6b1cd6e30f86678dae8e6595e53d
| 2b30bc32141b6c0151eb58479121b3e6a4 ....... Signature
```

The following annotated hexdump shows a ProRegTx transaction creating a new collateral.

**Note the presence of the output, a null Outpoint TXID and the absence of a signature (since it isn't referring to an existing collateral).** (Parts of the classical transaction section have been omitted.)

``` text Version 1 ProRegTx
0300 ....................................... Version (3)
0100 ....................................... Type (1 - ProRegTx)

[...] ...................................... Transaction inputs omitted

02 ......................................... Number of outputs
| [...] .................................... 1 output omitted
|
| Masternode collateral output
| | 00e8764817000000 ....................... Dimecoins (500000000 DIME)
| | 1976a9149e648c7e4b61482aa3
| | 9bd10e0bf0b5268768005f88ac ............. Script

00000000 ................................... locktime: 0 (a block height)

d1 ......................................... Extra payload size (209)

ProRegTx Payload
| 0100 ..................................... Version (1)
| 0000 ..................................... Type (0)
| 0000 ..................................... Mode (0)
|
| 00000000000000000000000000000000
| 00000000000000000000000000000000 ......... Outpoint TXID
| 01000000 ................................. Outpoint index number: 1
|
| 00000000000000000000ffffc0000233 ......... IP Address: ::ffff:192.0.2.51
| 270f ..................................... Port: 9999
|
| 757a2171bbf92517e358249f20c37a8ad2d7a5bc . Owner pubkey hash (ECDSA)
| 0e02146e9c34cfbcb3f3037574a1abb35525e2ca
| 0c3c6901dbf82ac591e30218d1711223b7ca956e
| df39f3d984d06d51 ......................... Operator public key (BLS)
| 757a2171bbf92517e358249f20c37a8ad2d7a5bc . Voting pubkey hash (ECDSA)
|
| f401 ..................................... Operator reward (500 -> 5%)
|
| Payout script
| 19 ....................................... Bytes in pubkey script: 25
| | 76 ..................................... OP_DUP
| | a9 ..................................... OP_HASH160
| | 14 ..................................... Push 20 bytes as data
| | | 9e648c7e4b61482aa39bd10e0bf0b526
| | | 8768005f ............................. PubKey hash
| | 88 ..................................... OP_EQUALVERIFY
| | ac ..................................... OP_CHECKSIG
|
| 57b115d681b9aff82824ff7e22af99d4
| ac4b39ad7be7cb70b662e9011827d589 ......... Inputs hash
|
| Payload signature
| 00 ....................................... Signature Size (0)
| .......................................... Signature (Empty)
```

### Example ProRegTx

```Text Raw Transaction hex
03000100013ea08d68bd3038b8ea3d92d43fa38047522896724b04f246827d74b703bd3f2801000000
6a47304402201fe458e3dc2c6072848418fedd48fe79081be3c818301ce0a97de4c1dd5ee2da02206f
601d0de9540ac53ef7f9c59c92ef594237f8b23dad3b04b1005ff85fb61a5d0121022dce9621ff449f
e1a12648da526b93e0c2f8e43d14f8c1650f95272569d932a6feffffff011ec89a3b000000001976a9
14955410003527bf2b360a7a390b9ff14b9106c63288ac00000000fd12010100000000005c71e5f46d
35196e33b45c5d59d3fd2dc84381942064cae21744fb717412c1ac0100000000000000000000000000
ffff2f6fb5cf4e2199e9dff4cd5a0abc61b5287a0ba48c0553d6358890c0e9ec9dc5f08b1d4d021192
0fe5d96a225c555a4ba7dd7f6cb14e271c925f2fc72316a01282973f9ad9cf1e39e03829dcf16f7a66
b832d3b84dbab400a1e9eb7f30ac00001976a914955410003527bf2b360a7a390b9ff14b9106c63288
ac835b69acdba709707c5cccdfcc342eacc87d6db0cc676896a01fe433a0620ae4411f5da2e5444c6a
1556c3d45798b9f95567b1625b3f0cbe69936a70e35ca76b381f0a5506de07274e5e24db8be77234ad
8fa023938f750a283b39b1bff17b2ad11f
```

The JSON representation of a raw transaction can be obtained with the [`getrawtransaction` RPC](../api/remote-procedure-calls-raw-transactions.md#getrawtransaction) or the [`decoderawtransaction` RPC](../api/remote-procedure-calls-raw-transactions.md#decoderawtransaction).

```json JSON Representation
{
  "txid": "b43dadbd485e4d1e1d202ea5180f0ad4e8e7f05e97a7e566a764ed714356bd1f",
  "version": 3,
  "type": 1,
  "size": 468,
  "locktime": 0,
  "vin": [
    {
      "txid": "283fbd03b7747d8246f2044b729628524780a33fd4923deab83830bd688da03e",
      "vout": 1,
      "scriptSig": {
        "asm": "304402201fe458e3dc2c6072848418fedd48fe79081be3c818301ce0a97de4c1dd5ee2da02206f601d0de9540ac53ef7f9c59c92ef594237f8b23dad3b04b1005ff85fb61a5d[ALL] 022dce9621ff449fe1a12648da526b93e0c2f8e43d14f8c1650f95272569d932a6",
        "hex": "47304402201fe458e3dc2c6072848418fedd48fe79081be3c818301ce0a97de4c1dd5ee2da02206f601d0de9540ac53ef7f9c59c92ef594237f8b23dad3b04b1005ff85fb61a5d0121022dce9621ff449fe1a12648da526b93e0c2f8e43d14f8c1650f95272569d932a6"
      },
      "sequence": 4294967294
    }
  ],
  "vout": [
    {
      "value": 9.99999518,
      "valueSat": 999999518,
      "n": 0,
      "scriptPubKey": {
        "asm": "OP_DUP OP_HASH160 955410003527bf2b360a7a390b9ff14b9106c632 OP_EQUALVERIFY OP_CHECKSIG",
        "hex": "76a914955410003527bf2b360a7a390b9ff14b9106c63288ac",
        "reqSigs": 1,
        "type": "pubkeyhash",
        "addresses": [
          "yZw2EYuVkTNUzUqd7mfXRNhCMReonL99tu"
        ]
      }
    }
  ],
  "extraPayloadSize": 274,
  "extraPayload": "0100000000005c71e5f46d35196e33b45c5d59d3fd2dc84381942064cae21744fb717412c1ac0100000000000000000000000000ffff2f6fb5cf4e2199e9dff4cd5a0abc61b5287a0ba48c0553d6358890c0e9ec9dc5f08b1d4d0211920fe5d96a225c555a4ba7dd7f6cb14e271c925f2fc72316a01282973f9ad9cf1e39e03829dcf16f7a66b832d3b84dbab400a1e9eb7f30ac00001976a914955410003527bf2b360a7a390b9ff14b9106c63288ac835b69acdba709707c5cccdfcc342eacc87d6db0cc676896a01fe433a0620ae4411f5da2e5444c6a1556c3d45798b9f95567b1625b3f0cbe69936a70e35ca76b381f0a5506de07274e5e24db8be77234ad8fa023938f750a283b39b1bff17b2ad11f",
  "proRegTx": {
    "version": 1,
    "type": 0,
    "collateralHash": "acc1127471fb4417e2ca6420948143c82dfdd3595d5cb4336e19356df4e5715c",
    "collateralIndex": 1,
    "service": "47.111.181.207:20001",
    "ownerAddress": "yaMGQThTVPUf1LBqVqa1jMTtLW7ByVbN78",
    "votingAddress": "yQ8oETtF1pRQfBP4iake2e5zyCCm85CAET",
    "payoutAddress": "yZw2EYuVkTNUzUqd7mfXRNhCMReonL99tu",
    "pubKeyOperator": "90c0e9ec9dc5f08b1d4d0211920fe5d96a225c555a4ba7dd7f6cb14e271c925f2fc72316a01282973f9ad9cf1e39e038",
    "operatorReward": 0,
    "inputsHash": "e40a62a033e41fa0966867ccb06d7dc8ac2e34ccdfcc5c7c7009a7dbac695b83"
  },
  "hex": "03000100013ea08d68bd3038b8ea3d92d43fa38047522896724b04f246827d74b703bd3f28010000006a47304402201fe458e3dc2c6072848418fedd48fe79081be3c818301ce0a97de4c1dd5ee2da02206f601d0de9540ac53ef7f9c59c92ef594237f8b23dad3b04b1005ff85fb61a5d0121022dce9621ff449fe1a12648da526b93e0c2f8e43d14f8c1650f95272569d932a6feffffff011ec89a3b000000001976a914955410003527bf2b360a7a390b9ff14b9106c63288ac00000000fd12010100000000005c71e5f46d35196e33b45c5d59d3fd2dc84381942064cae21744fb717412c1ac0100000000000000000000000000ffff2f6fb5cf4e2199e9dff4cd5a0abc61b5287a0ba48c0553d6358890c0e9ec9dc5f08b1d4d0211920fe5d96a225c555a4ba7dd7f6cb14e271c925f2fc72316a01282973f9ad9cf1e39e03829dcf16f7a66b832d3b84dbab400a1e9eb7f30ac00001976a914955410003527bf2b360a7a390b9ff14b9106c63288ac835b69acdba709707c5cccdfcc342eacc87d6db0cc676896a01fe433a0620ae4411f5da2e5444c6a1556c3d45798b9f95567b1625b3f0cbe69936a70e35ca76b381f0a5506de07274e5e24db8be77234ad8fa023938f750a283b39b1bff17b2ad11f",
  "blockhash": "0000000016e9bd30f97d98be7abc7934e24a064b1c8e7fefcb641694fe53e5d4",
  "height": 247288,
  "confirmations": 611337,
  "time": 1578970980,
  "blocktime": 1578970980,
  "instantlock": true,
  "instantlock_internal": false,
  "chainlock": true
}

```

```{eval-rst}
.. _ref-txs-proupservtx:
```

## ProUpServTx

*Adopted from Dash Core which was added in protocol version 70213 of Dash Core as described by [DIP3](https://github.com/dashpay/dips/blob/master/dip-0003.md)*

The [masternode](../resources/glossary.md#masternode) Provider Update Service (ProUpServTx) special transaction is used to update the IP Address and port of a masternode. If a non-zero operatorReward was set in the initial [ProRegTx](#proregtx), the operator may also set the scriptOperatorPayout field in the ProUpServTx.

A ProUpServTx is only valid for masternodes in the registered masternodes subset. When processed, it updates the metadata of the masternode entry and revives the masternode if it was previously marked as PoSe-banned.

A ProUpServTx is created and sent using the [`protx update_service` RPC](../api/remote-procedure-calls-evo.md#protx-update-service).

The special transaction type used for ProUpServTx Transactions is 2 and the extra payload consists of the following data:

| Bytes | Name | Data type |  Description |
| ---------- | ----------- | -------- | -------- |
| 2 | version | uint_16 | ProUpServTx version number. Currently set to 1.
| 32 | proTXHash | uint256 | The hash of the initial ProRegTx
| 16 | ipAddress | byte[] | IPv6 address in network byte order. Only IPv4 mapped addresses are allowed (to be extended in the future)
| 2 | port | uint_16 | Port (network byte order)
| 1-9 | scriptOperator<br>PayoutSize | compactSize uint | Size of the Operator Payee Script.
| Variable | scriptOperator<br>Payout | Script | Operator Payee script (p2pkh/p2sh)
| 32 | inputsHash | uint256 | Hash of all the outpoints of the transaction inputs
| 0 or 20 | platformNodeID | byte[] | Dash Platform P2P node ID, derived from P2P public key. Only present for masternode type 1.
| 0 or 2 | platformP2PPort | uint_16 | TCP port of DIME Platform peer-to-peer communication between nodes (network byte order). Only present for masternode type 1.
| 0 or 2 | platformHTTPPort | uint_16 |TCP port of Platform HTTP/API interface (network byte order). Only present for masternode type 1.
| 1-9 | payloadSigSize |compactSize uint | Size of the Signature<br>**Note:** not present in BLS implementation
| 96 | payloadSig | vector | BLS Signature of the hash of the ProUpServTx fields. Signed by the Operator.<br>**Note**:  serialization varies based on `version`:<br> - Version 1 - legacy BLS scheme<br> - Version 2 - basic BLS scheme

The following annotated hexdump shows a ProUpServTx transaction. (Parts of the
classical transaction section have been omitted.)

``` text Version 1 ProUpServTx
0300 ....................................... Version (3)
0200 ....................................... Type (2 - ProUpServTx)

[...] ...................................... Transaction inputs omitted
[...] ...................................... Transaction outputs omitted

00000000 ................................... locktime: 0 (a block height)

b5 ......................................... Extra payload size (181)

ProUpServTx Payload
| 0100 ..................................... Version (1)
|
| db60b8cecae691a3d078a2341d460b06
| b2914f6b092f1906b5c815589399b0ff ......... ProRegTx Hash
|
| 00000000000000000000ffffc0000233 ......... IP Address: ::ffff:192.0.2.51
| 270f ..................................... Port: 9999
|
| 00 ....................................... Operator payout script size (0)
| .......................................... Operator payout script (Empty)
|
| a9569d037b0eacc8bca05c5829c95283
| 4ac27d1c7e7df610500b7ba70fd46507 ......... Inputs hash
|
| Payload signature (BLS)
| 0267702ef85d186ef7fa32dc40c65f2f
| eca0a7465715eb7c30f81beb69e35ee4
| 1f6ff7f292b82a9caebb5aa961b0f915
| 02501becf629e93c0a01c76162d56a6c
| 65a9675c3ca9d5297f053e68f91393dd
| 789beed8ef7e8839695a334c2e1bd37c ......... BLS Signature (96 bytes)
```

### Example ProUpServTx

```Text Raw Transaction hex
0300020001f88750ccc24410679d87ee63df5c8dfd901329aa1fe60a74c183d560eee5218d01000000
6a473044022029090e49ba2e387e7b39df51fdd6ec1becdd568cdd0de79f5dca6084bee67738022058
3bb62418aa986d927b4487d6a7f0469c4bc54a0e7baa0c484e8c140c37b3d301210345184cc81d6cd9
8eef548206f23a1467c27fea65582d519daa0f7a88a6c45666feffffff01e7edd23b000000001976a9
147f95c0f808aff27883260bfaf9cfe2b84519a6b288ac00000000b702000000ff92ce2d64657cc3d4
d9d82547efca2206ec1d9f5dcf2776624bc0a58b12ed3b00000000000000000000ffffae22e9734e1f
0026ad5ada35511fc5b9d762b14b22510325ef8b82d21d59567f8e1c3c9e0c955ab99a62829e6317b1
943d97f66191b1c6714146540788e2d26a1007498dce455603f55aebacf1a38131048abf7d5a05d00e
9e93c1e91cc8cad239b4301b328f5fe1bcbae829ccd6a3f461e712873a188224829fc4b5fc01fa0fb2
9014b947d8f7
```

The JSON representation of a raw transaction can be obtained with the [`getrawtransaction` RPC](../api/remote-procedure-calls-raw-transactions.md#getrawtransaction) or the [`decoderawtransaction` RPC](../api/remote-procedure-calls-raw-transactions.md#decoderawtransaction).

```json
{
  "txid": "f1d23a149955d48ef7bf81ce0a58d4f47ae28399ed3e4ef3c1f90a55a6a9e082",
  "version": 3,
  "type": 2,
  "size": 375,
  "locktime": 0,
  "vin": [
    {
      "txid": "8d21e5ee60d583c1740ae61faa291390fd8d5cdf63ee879d671044c2cc5087f8",
      "vout": 1,
      "scriptSig": {
        "asm": "3044022029090e49ba2e387e7b39df51fdd6ec1becdd568cdd0de79f5dca6084bee677380220583bb62418aa986d927b4487d6a7f0469c4bc54a0e7baa0c484e8c140c37b3d3[ALL] 0345184cc81d6cd98eef548206f23a1467c27fea65582d519daa0f7a88a6c45666",
        "hex": "473044022029090e49ba2e387e7b39df51fdd6ec1becdd568cdd0de79f5dca6084bee677380220583bb62418aa986d927b4487d6a7f0469c4bc54a0e7baa0c484e8c140c37b3d301210345184cc81d6cd98eef548206f23a1467c27fea65582d519daa0f7a88a6c45666"
      },
      "sequence": 4294967294
    }
  ],
  "vout": [
    {
      "value": 10.03679207,
      "valueSat": 1003679207,
      "n": 0,
      "scriptPubKey": {
        "asm": "OP_DUP OP_HASH160 7f95c0f808aff27883260bfaf9cfe2b84519a6b2 OP_EQUALVERIFY OP_CHECKSIG",
        "hex": "76a9147f95c0f808aff27883260bfaf9cfe2b84519a6b288ac",
        "reqSigs": 1,
        "type": "pubkeyhash",
        "addresses": [
          "yXx44e8DiK4rCaYmJUMHSp3zGTFFvFaWLg"
        ]
      }
    }
  ],
  "extraPayloadSize": 183,
  "extraPayload": "02000000ff92ce2d64657cc3d4d9d82547efca2206ec1d9f5dcf2776624bc0a58b12ed3b00000000000000000000ffffae22e9734e1f0026ad5ada35511fc5b9d762b14b22510325ef8b82d21d59567f8e1c3c9e0c955ab99a62829e6317b1943d97f66191b1c6714146540788e2d26a1007498dce455603f55aebacf1a38131048abf7d5a05d00e9e93c1e91cc8cad239b4301b328f5fe1bcbae829ccd6a3f461e712873a188224829fc4b5fc01fa0fb29014b947d8f7",
  "proUpServTx": {
    "version": 2,
    "type": 0,
    "proTxHash": "3bed128ba5c04b627627cf5d9f1dec0622caef4725d8d9d4c37c65642dce92ff",
    "service": "174.34.233.115:19999",
    "inputsHash": "5a950c9e3c1c8e7f56591dd2828bef250351224bb162d7b9c51f5135da5aad26"
  },
  "hex": "0300020001f88750ccc24410679d87ee63df5c8dfd901329aa1fe60a74c183d560eee5218d010000006a473044022029090e49ba2e387e7b39df51fdd6ec1becdd568cdd0de79f5dca6084bee677380220583bb62418aa986d927b4487d6a7f0469c4bc54a0e7baa0c484e8c140c37b3d301210345184cc81d6cd98eef548206f23a1467c27fea65582d519daa0f7a88a6c45666feffffff01e7edd23b000000001976a9147f95c0f808aff27883260bfaf9cfe2b84519a6b288ac00000000b702000000ff92ce2d64657cc3d4d9d82547efca2206ec1d9f5dcf2776624bc0a58b12ed3b00000000000000000000ffffae22e9734e1f0026ad5ada35511fc5b9d762b14b22510325ef8b82d21d59567f8e1c3c9e0c955ab99a62829e6317b1943d97f66191b1c6714146540788e2d26a1007498dce455603f55aebacf1a38131048abf7d5a05d00e9e93c1e91cc8cad239b4301b328f5fe1bcbae829ccd6a3f461e712873a188224829fc4b5fc01fa0fb29014b947d8f7",
  "blockhash": "0000024ea047afdb72b301d3a6501e1027b101c7bc047e1377da0efbe7495bcf",
  "height": 854855,
  "confirmations": 3772,
  "time": 1679598509,
  "blocktime": 1679598509,
  "instantlock": true,
  "instantlock_internal": false,
  "chainlock": true
}
```

```{eval-rst}
.. _ref-txs-proupregtx:
```

## ProUpRegTx

*Adopted from Dash Core which was added in protocol version 70213 of Dash Core as described by [DIP3](https://github.com/dashpay/dips/blob/master/dip-0003.md)*

The [masternode](../resources/glossary.md#masternode) Provider Update Registrar (ProUpRegTx) special transaction is used by a masternode owner to update masternode metadata (e.g. operator/voting key details or the payout script).

A ProUpRegTx is created and sent using the [`protx update_registrar` RPC](../api/remote-procedure-calls-evo.md#protx-update-registrar).

The special transaction type is 3 and the extra payload consists of the following data:

| Bytes | Name | Data type |  Description |
| ---------- | ----------- | -------- | -------- |
| 2 | version | uint_16 | Provider update registrar transaction version number. Currently set to 1.
| 32 | proTXHash | uint256 | The hash of the initial ProRegTx
| 2 | mode | uint_16 | Masternode mode. Default set to 0.
| 48 | PubKeyOperator | CBLSPublicKey | The BLS public key used for operational related signing (network messages, ProTx updates).<br>**Note**: serialization varies based on `version`:<br> - Version 1 - legacy BLS scheme<br> - Version 2 - basic BLS scheme
| 20 | KeyIdVoting | CKeyID | The public key hash used for voting.
| 1-9 | scriptPayoutSize | compactSize uint | Size of the Payee Script.
| Variable | scriptPayout | Script | Payee script (p2pkh/p2sh)
| 32 | inputsHash | uint256 | Hash of all the outpoints of the transaction inputs
| 1-9 | payloadSigSize |compactSize uint | Size of the Signature
| Variable | payloadSig | vector | Signature of the hash of the ProTx fields. Signed with the key corresponding to the collateral outpoint in case the collateral is not part of the ProRegTx itself, empty otherwise.

The following annotated hexdump shows a ProUpRegTx transaction referencing an
existing collateral. (Parts of the classical transaction section have been omitted.)

``` text Version 1 ProUpRegTx
0300 ....................................... Version (3)
0300 ....................................... Type (3 - ProUpRegTx)

[...] ...................................... Transaction inputs omitted
[...] ...................................... Transaction outputs omitted

00000000 ................................... locktime: 0 (a block height)

e4 ......................................... Extra payload size (228)

ProRegTx Payload
| 0100 ..................................... Version (1)
|
| ddaf13bf1b02de39711de911e646c63e
| f089b6cee786a1b776086ae130331bba ......... ProRegTx Hash
|
| 0000 ..................................... Mode (0)
|
| 0e02146e9c34cfbcb3f3037574a1abb35525e2ca
| 0c3c6901dbf82ac591e30218d1711223b7ca956e
| df39f3d984d06d51 ......................... Operator public key (BLS)
| 757a2171bbf92517e358249f20c37a8ad2d7a5bc . Voting pubkey hash (ECDSA)
|
| Payout script
| 19 ....................................... Bytes in pubkey script: 25
| | 76 ..................................... OP_DUP
| | a9 ..................................... OP_HASH160
| | 14 ..................................... Push 20 bytes as data
| | | 9e648c7e4b61482aa39bd10e0bf0b526
| | | 8768005f ............................. PubKey hash
| | 88 ..................................... OP_EQUALVERIFY
| | ac ..................................... OP_CHECKSIG
|
| 50b50b24193b2b16f0383125c1f4426e
| 883d256eeadee96d500f8c08b0e0f9e4 ......... Inputs hash
|
| Payload signature
| 41 ....................................... Signature Size (65)
| 1ffa8a27ae0301e414176d4c876cff2e
| 20b810683a68ab7dcea95de1f8f36441
| 4c56368f189a3ef7a59b83bd77f22431
| a73d347841a58768b94c771819dc2bbce3 ....... Signature
```

### Example ProUpRegTx

```Text Raw Transaction hex
0300030001f9485c88c87c282dc4de6b826afbba91c49aaa5bc75a0c0110465988573b5fd501000000
6a4730440220085ea9929647b789429fa07bc83cf2a1c457628bc686be1e3014fdc5c2f9cc22022037
47c39ad3a09a58a4b6f4ab6e8a08529cc9bdca86fe74689b1013b72ec6f92f012102ea1bcf94f4a787
a3a94f15ce0a954ea4131be49d0f545531c7df1720045b85fffeffffff0133edd23b000000001976a9
14dc82946c9cee9ab3e8fef5a5d641a57bdf1523c088ac00000000e4020099bf316f8cb867be68dc9b
d89bf2b8b984eae2fa9fa6ac19e862459cb7cf79390000a73d8c1e640d29e2257042a39bbbac8d867f
69ae252e146884816b98ab0d0526ed4992d9cff22ef04878423f66583382f00e43355184a124cf6a37
1433e3fb1d792bd5421976a914dc82946c9cee9ab3e8fef5a5d641a57bdf1523c088acbe428d911be8
7c670640d3cf73f1490b327be4b33a4fac8bcb70ca934199b4774120dc2d1ce8ea4188f04953528e11
2fd1402ab7434cdc5cc9f245468d952e1fa6d83701f90fc8e74c10bc32fec5c7e2beda675ce8a3cb85
9d25d8aa2cff5962ece6
```

The JSON representation of a raw transaction can be obtained with the [`getrawtransaction` RPC](../api/remote-procedure-calls-raw-transactions.md#getrawtransaction) or the [`decoderawtransaction` RPC](../api/remote-procedure-calls-raw-transactions.md#decoderawtransaction).

```json JSON Representation
{
  "txid": "ff5782f5537ef18b919b5ad0a2c605a72d83b4092434dcc8273e2d53ac0d0113",
  "version": 3,
  "type": 3,
  "size": 420,
  "locktime": 0,
  "vin": [
    {
      "txid": "d55f3b5788594610010c5ac75baa9ac491bafb6a826bdec42d287cc8885c48f9",
      "vout": 1,
      "scriptSig": {
        "asm": "30440220085ea9929647b789429fa07bc83cf2a1c457628bc686be1e3014fdc5c2f9cc2202203747c39ad3a09a58a4b6f4ab6e8a08529cc9bdca86fe74689b1013b72ec6f92f[ALL] 02ea1bcf94f4a787a3a94f15ce0a954ea4131be49d0f545531c7df1720045b85ff",
        "hex": "4730440220085ea9929647b789429fa07bc83cf2a1c457628bc686be1e3014fdc5c2f9cc2202203747c39ad3a09a58a4b6f4ab6e8a08529cc9bdca86fe74689b1013b72ec6f92f012102ea1bcf94f4a787a3a94f15ce0a954ea4131be49d0f545531c7df1720045b85ff"
      },
      "sequence": 4294967294
    }
  ],
  "vout": [
    {
      "value": 10.03679027,
      "valueSat": 1003679027,
      "n": 0,
      "scriptPubKey": {
        "asm": "OP_DUP OP_HASH160 dc82946c9cee9ab3e8fef5a5d641a57bdf1523c0 OP_EQUALVERIFY OP_CHECKSIG",
        "hex": "76a914dc82946c9cee9ab3e8fef5a5d641a57bdf1523c088ac",
        "reqSigs": 1,
        "type": "pubkeyhash",
        "addresses": [
          "ygRPwFLoC8WeW3ujqrskqHZiQvKpTHF6qv"
        ]
      }
    }
  ],
  "extraPayloadSize": 228,
  "extraPayload": "020099bf316f8cb867be68dc9bd89bf2b8b984eae2fa9fa6ac19e862459cb7cf79390000a73d8c1e640d29e2257042a39bbbac8d867f69ae252e146884816b98ab0d0526ed4992d9cff22ef04878423f66583382f00e43355184a124cf6a371433e3fb1d792bd5421976a914dc82946c9cee9ab3e8fef5a5d641a57bdf1523c088acbe428d911be87c670640d3cf73f1490b327be4b33a4fac8bcb70ca934199b4774120dc2d1ce8ea4188f04953528e112fd1402ab7434cdc5cc9f245468d952e1fa6d83701f90fc8e74c10bc32fec5c7e2beda675ce8a3cb859d25d8aa2cff5962ece6",
  "proUpRegTx": {
    "version": 2,
    "proTxHash": "3979cfb79c4562e819aca69ffae2ea84b9b8f29bd89bdc68be67b88c6f31bf99",
    "votingAddress": "yiCk7DjwBbUGJuJofTA7eXU4hyybu123pD",
    "payoutAddress": "ygRPwFLoC8WeW3ujqrskqHZiQvKpTHF6qv",
    "pubKeyOperator": "a73d8c1e640d29e2257042a39bbbac8d867f69ae252e146884816b98ab0d0526ed4992d9cff22ef04878423f66583382",
    "inputsHash": "77b4994193ca70cb8bac4f3ab3e47b320b49f173cfd34006677ce81b918d42be"
  },
  "hex": "0300030001f9485c88c87c282dc4de6b826afbba91c49aaa5bc75a0c0110465988573b5fd5010000006a4730440220085ea9929647b789429fa07bc83cf2a1c457628bc686be1e3014fdc5c2f9cc2202203747c39ad3a09a58a4b6f4ab6e8a08529cc9bdca86fe74689b1013b72ec6f92f012102ea1bcf94f4a787a3a94f15ce0a954ea4131be49d0f545531c7df1720045b85fffeffffff0133edd23b000000001976a914dc82946c9cee9ab3e8fef5a5d641a57bdf1523c088ac00000000e4020099bf316f8cb867be68dc9bd89bf2b8b984eae2fa9fa6ac19e862459cb7cf79390000a73d8c1e640d29e2257042a39bbbac8d867f69ae252e146884816b98ab0d0526ed4992d9cff22ef04878423f66583382f00e43355184a124cf6a371433e3fb1d792bd5421976a914dc82946c9cee9ab3e8fef5a5d641a57bdf1523c088acbe428d911be87c670640d3cf73f1490b327be4b33a4fac8bcb70ca934199b4774120dc2d1ce8ea4188f04953528e112fd1402ab7434cdc5cc9f245468d952e1fa6d83701f90fc8e74c10bc32fec5c7e2beda675ce8a3cb859d25d8aa2cff5962ece6",
  "instantlock": true,
  "instantlock_internal": true,
  "chainlock": false
}

```

```{eval-rst}
.. _ref-txs-prouprevtx:
```

## ProUpRevTx

*Adopted from Dash Core which was added in protocol version 70213 of Dash Core as described by [DIP3](https://github.com/dashpay/dips/blob/master/dip-0003.md)*

The [masternode](../resources/glossary.md#masternode) Operator Revocation (ProUpRevTx) special transaction allows an operator to revoke their key in case of compromise or if they wish to terminate service. If a masternode's operator key is revoked, the masternode becomes ineligible for payment until the owner provides a new operator key (via a ProUpRegTx).

A ProUpRevTx is created and sent using the [`protx revoke` RPC](../api/remote-procedure-calls-evo.md#protx-revoke).

The special transaction type used for ProUpServTx Transactions is 4 and the extra payload consists of the following data:

| Bytes | Name | Data type |  Description |
| ---------- | ----------- | -------- | -------- |
| 2 | version | uint_16 | ProUpRevTx version number. Currently set to 1.  
| 32 | proTXHash | uint256 | The hash of the initial ProRegTx
| 2 | reason | uint_16 | The reason for revoking the key.<br>`0` - Not specified<br>`1` - Termination of Service<br>`2` - Compromised Key<br>`3` - Change of key
| 32 | inputsHash | uint256 | Hash of all the outpoints of the transaction inputs
| 1-9 | payloadSigSize |compactSize uint | Size of the Signature<br>**Note:** not present in BLS implementation
| 96 | payloadSig | vector | BLS Signature of the hash of the ProUpServTx fields. Signed by the Operator.<br>**Note**:  serialization varies based on `version`:<br> - Version 1 - legacy BLS scheme<br> - Version 2 - basic BLS scheme

The following annotated hexdump shows a ProUpRevTx transaction. (Parts of the classical transaction section have been omitted.)

``` text Version 1 ProUpRevTx
0300 ....................................... Version (3)
0400 ....................................... Type (4 - ProUpRevTx)

[...] ...................................... Transaction inputs omitted
[...] ...................................... Transaction outputs omitted

00000000 ................................... locktime: 0 (a block height)

a4 ......................................... Extra payload size (164)

ProUpRevTx Payload
| 0100 ..................................... Version (1)
|
| ddaf13bf1b02de39711de911e646c63e
| f089b6cee786a1b776086ae130331bba ......... ProRegTx Hash
|
| 0000 ..................................... Reason: 0 (Not specified)
|
| cb0dfe113c87f8e9cde2c5d18aae12fc
| 8d0617c42c34ca5c2f2f6ab4b1dae164 ......... Inputs hash
|
| Payload signature (BLS)
| 0adaef4bf1a904308f1b0efbdfaffc93
| 864f9e047fd83415c831589180303711
| 0f0d8adb312ab43ddd7f8086042d3f5b
| 09029a6a16c341c9d2a62789b495fef4
| e068da711dac28106ff354db7249ae88
| 05877d82ff7d1af00ae2d303dea5eb3b ......... BLS Signature (96 bytes)
```

### Example ProUpRevTx

```text Raw transaction hex
03000400016f8a813df204873df003d6efc44e1906eaf6180a762513b1c91252826ce05916000000006b483045022100
9b50474beacd48b37340eb5715a5ebd92239e54595147b5c55018bc29f26bde302203f312cdd8009f3f03b9bb9a00074
361974a40f5f5fafaf16ba4378cb72adcc4201210250a5b41488dec3d4116ae5733d18d03326050aebc3958118d64773
9ad1a5de24feffffff01b974ed6d000000001976a914f0ae84a7ea8a0efd48c155eeeaaed6eb64c2812188ac00000000a4
01006f8a813df204873df003d6efc44e1906eaf6180a762513b1c91252826ce05916010082cf248cf6b8ac6a3cdc826eda
e582ead20421659ed891f9d4953a540616fb4f05279584b3339ed2ba95711ad28b18ee2878c4a904f76ea4d103e1d739
f22ff7e3b9b3db7d0c4a7e120abb4952c3574a18de34fa29828f9fe3f52bd0b1fac17acd04f7751967d782045ab6550536
53438f1dd1e14ba6adeb8351b78c9eb59bf4
```

The JSON representation of a raw transaction can be obtained with the [`getrawtransaction` RPC](../api/remote-procedure-calls-raw-transactions.md#getrawtransaction) or the [`decoderawtransaction` RPC](../api/remote-procedure-calls-raw-transactions.md#decoderawtransaction).

```json JSON Representation
{
  "txid": "6926d964bccfd4418e373f08cf41d3302f9616ee5d9bc40b18aa99fc18a3d4ea",
  "version": 3,
  "type": 4,
  "size": 357,
  "locktime": 0,
  "vin": [
    {
      "txid": "1659e06c825212c9b11325760a18f6ea06194ec4efd603f03d8704f23d818a6f",
      "vout": 0,
      "scriptSig": {
        "asm": "30450221009b50474beacd48b37340eb5715a5ebd92239e54595147b5c55018bc29f26bde302203f312cdd8009f3f03b9bb9a00074361974a40f5f5fafaf16ba4378cb72adcc42[ALL] 0250a5b41488dec3d4116ae5733d18d03326050aebc3958118d647739ad1a5de24",
        "hex": "4830450221009b50474beacd48b37340eb5715a5ebd92239e54595147b5c55018bc29f26bde302203f312cdd8009f3f03b9bb9a00074361974a40f5f5fafaf16ba4378cb72adcc4201210250a5b41488dec3d4116ae5733d18d03326050aebc3958118d647739ad1a5de24"
      },
      "sequence": 4294967294
    }
  ],
  "vout": [
    {
      "value": 18.44278457,
      "valueSat": 1844278457,
      "n": 0,
      "scriptPubKey": {
        "asm": "OP_DUP OP_HASH160 f0ae84a7ea8a0efd48c155eeeaaed6eb64c28121 OP_EQUALVERIFY OP_CHECKSIG",
        "hex": "76a914f0ae84a7ea8a0efd48c155eeeaaed6eb64c2812188ac",
        "reqSigs": 1,
        "type": "pubkeyhash",
        "addresses": [
          "yiG45yiCksvpd1iLU5o3Dsj8GYRsWvGchu"
        ]
      }
    }
  ],
  "extraPayloadSize": 164,
  "extraPayload": "01006f8a813df204873df003d6efc44e1906eaf6180a762513b1c91252826ce05916010082cf248cf6b8ac6a3cdc826edae582ead20421659ed891f9d4953a540616fb4f05279584b3339ed2ba95711ad28b18ee2878c4a904f76ea4d103e1d739f22ff7e3b9b3db7d0c4a7e120abb4952c3574a18de34fa29828f9fe3f52bd0b1fac17acd04f7751967d782045ab655053653438f1dd1e14ba6adeb8351b78c9eb59bf4",
  "proUpRevTx": {
    "version": 1,
    "proTxHash": "1659e06c825212c9b11325760a18f6ea06194ec4efd603f03d8704f23d818a6f",
    "reason": 1,
    "inputsHash": "4ffb1606543a95d4f991d89e652104d2ea82e5da6e82dc3c6aacb8f68c24cf82"
  },
  "hex": "03000400016f8a813df204873df003d6efc44e1906eaf6180a762513b1c91252826ce05916000000006b4830450221009b50474beacd48b37340eb5715a5ebd92239e54595147b5c55018bc29f26bde302203f312cdd8009f3f03b9bb9a00074361974a40f5f5fafaf16ba4378cb72adcc4201210250a5b41488dec3d4116ae5733d18d03326050aebc3958118d647739ad1a5de24feffffff01b974ed6d000000001976a914f0ae84a7ea8a0efd48c155eeeaaed6eb64c2812188ac00000000a401006f8a813df204873df003d6efc44e1906eaf6180a762513b1c91252826ce05916010082cf248cf6b8ac6a3cdc826edae582ead20421659ed891f9d4953a540616fb4f05279584b3339ed2ba95711ad28b18ee2878c4a904f76ea4d103e1d739f22ff7e3b9b3db7d0c4a7e120abb4952c3574a18de34fa29828f9fe3f52bd0b1fac17acd04f7751967d782045ab655053653438f1dd1e14ba6adeb8351b78c9eb59bf4",
  "blockhash": "00000000052bba30e878367092bd76c287c184cf1ae48053860e2a8150b031a2",
  "height": 13899,
  "confirmations": 844713,
  "time": 1546027092,
  "blocktime": 1546027092,
  "instantlock": false,
  "instantlock_internal": false,
  "chainlock": false
}
```

```{eval-rst}
.. _ref-txs-cbtx:
```

## CbTx

*Adopted from Dash Core which was added in protocol version 70213 of Dash Core as described by [DIP4](https://github.com/dashpay/dips/blob/master/dip-0004.md)*

The Coinbase (CbTx) special transaction adds information to the [block](../resources/glossary.md#block) [coinbase transaction](../resources/glossary.md#coinbase-transaction) that enables verification of the deterministic masternode list without the full chain (e.g. from [SPV](../resources/glossary.md#simplified-payment-verification) clients). This allows light-clients to properly verify [InstantSend](../resources/glossary.md#instantsend) transactions (not yet enabled for Dimecoin) and support additional deterministic masternode list functionality in the future.

The special transaction type used for CbTx Transactions is 5 and the extra payload consists of the following data:

| Bytes | Name | Data type |  Description |
| ---------- | ----------- | -------- | -------- |
| 2 | version | uint_16 | CbTx version number. Currently set to 2.
| 4 | height | uint32_t | Height of the block
| 32 | merkleRootMNList | uint256 | Merkle root of the masternode list
| 32 | merkleRootQuorums | uint256 | *Added by CbTx version 2 in v0.14.0*<br><br>Merkle root of currently active LLMQs

Version History

| CbTx<br>Version | First Supported<br>Protocol Version | Dimecoin Core<br>Version |  Notes |
| ---------- | ----------- | -------- | -------- |
| 1 | 70006 | 2.0.0.0 | Enabled by [Hardfork @ Block 5000000](https://github.com/dime-coin/dimecoin/releases/tag/2.0.0.0) activation

The following annotated hexdump shows a CbTx transaction (v3).

An itemized coinbase transaction:

``` text
0300 ....................................... Version (3)
0500 ....................................... Type (5 - Coinbase)

01 ......................................... Number of inputs
| 00000000000000000000000000000000
| 00000000000000000000000000000000 ......... Previous outpoint TXID
| ffffffff ................................. Previous outpoint index
|
| 27 ....................................... Bytes in coinbase: 39
| |
| | 03 ..................................... Bytes in height
| | | da5c1e ............................... Height: 1989850
| |
| | 04d04580650800007588782d01000fe4
| | b883e5bda9e7a59ee4bb99e9b1bc04f09f909f . Arbitrary data
| 88f581b8 ................................. Sequence

02 ......................................... Output count
| Transaction Output
| | 53640f0300000000 ....................... Dimecoins (0.51340371 DIME)
| | 1976a9147c086eada12bdb10a265c16c
| | 08a7ae87366bd48188ac ................... Script
|
| Transaction Output 2
| | f82c2e0900000000 ....................... Dimecoins (1.54021112 DIME)
| | 1976a91453dc8bffae84a3851ab9fe29
| | 6417da85d5e7185888ac ................... P2PKH script

a0f04c20 ................................... Locktime

af ......................................... Extra payload size (175)

Coinbase Transaction Payload
| 0300 ..................................... Version (3)
|
| da5c1e00 ................................. Block height: 1989850
|
| 54e04067fa61cef61f1e91b0d52c21b2
| 8cdc69cc9d0383f0bb88ba0129b973e2 ......... MN List merkle root
|
| f67e47d5580e70c7e77af8b1a6670669
| c7424b896ab3d44d349a4988e9a8328d ......... Active LLMQ merkle root
|
| 00 ....................................... Best ChainLock height diff
|
| b22fef542f5c630e4f2a67ad56d30cf2
| a3dac55848abcd2bac30bf780318792b
| cdf32f7729443846c9fdc57050a131cd
| 12c0e54a16f6265e900f459e3b9dd434
| 21a0bc3f61efd49ce752e440e5131a8d
| 2758a280ad883b8eb902c49ee5b878b3 ......... ChainLock BLS signature
|
| 0000000000000000 ......................... Credit pool balance (0.0 DIME)
```

### Example CbTx

```Text Raw Transaction hex
03000500010000000000000000000000000000000000000000000000000000000000000000ffffffff
03000500010000000000000000000000000000000000000000000000000000000000000000ffffffff
2703da5c1e04d04580650800007588782d01000fe4b883e5bda9e7a59ee4bb99e9b1bc04f09f909f88
f581b80253640f03000000001976a9147c086eada12bdb10a265c16c08a7ae87366bd48188acf82c2e
09000000001976a91453dc8bffae84a3851ab9fe296417da85d5e7185888aca0f04c20af0300da5c1e
0054e04067fa61cef61f1e91b0d52c21b28cdc69cc9d0383f0bb88ba0129b973e2f67e47d5580e70c7
e77af8b1a6670669c7424b896ab3d44d349a4988e9a8328d00b22fef542f5c630e4f2a67ad56d30cf2
a3dac55848abcd2bac30bf780318792bcdf32f7729443846c9fdc57050a131cd12c0e54a16f6265e90
0f459e3b9dd43421a0bc3f61efd49ce752e440e5131a8d2758a280ad883b8eb902c49ee5b878b30000
000000000000
```

The JSON representation of a raw transaction can be obtained with the [`getrawtransaction` RPC](../api/remote-procedure-calls-raw-transactions.md#getrawtransaction) or the [`decoderawtransaction` RPC](../api/remote-procedure-calls-raw-transactions.md#decoderawtransaction).

```json JSON Representation
{
  "txid": "c550cae3f65d396a2f517a7220c7851cc3dc065e20141dadf9f19676348730f2",
  "version": 3,
  "type": 5,
  "size": 334,
  "locktime": 541913248,
  "vin": [
    {
      "coinbase": "03da5c1e04d04580650800007588782d01000fe4b883e5bda9e7a59ee4bb99e9b1bc04f09f909f",
      "sequence": 3095524744
    }
  ],
  "vout": [
    {
      "value": 0.51340371,
      "valueSat": 51340371,
      "n": 0,
      "scriptPubKey": {
        "asm": "OP_DUP OP_HASH160 7c086eada12bdb10a265c16c08a7ae87366bd481 OP_EQUALVERIFY OP_CHECKSIG",
        "hex": "76a9147c086eada12bdb10a265c16c08a7ae87366bd48188ac",
        "reqSigs": 1,
        "type": "pubkeyhash",
        "addresses": [
          "XmzfivrzYQ7B7oBMZKwPRdhjB1iNvX71XZ"
        ]
      }
    },
    {
      "value": 1.54021112,
      "valueSat": 154021112,
      "n": 1,
      "scriptPubKey": {
        "asm": "OP_DUP OP_HASH160 53dc8bffae84a3851ab9fe296417da85d5e71858 OP_EQUALVERIFY OP_CHECKSIG",
        "hex": "76a91453dc8bffae84a3851ab9fe296417da85d5e7185888ac",
        "reqSigs": 1,
        "type": "pubkeyhash",
        "addresses": [
          "XiLG83Jj8reHt7YH4H4JQ16q7c2q78KCSz"
        ]
      }
    }
  ],
  "extraPayloadSize": 175,
  "extraPayload": "0300da5c1e0054e04067fa61cef61f1e91b0d52c21b28cdc69cc9d0383f0bb88ba0129b973e2f67e47d5580e70c7e77af8b1a6670669c7424b896ab3d44d349a4988e9a8328d00b22fef542f5c630e4f2a67ad56d30cf2a3dac55848abcd2bac30bf780318792bcdf32f7729443846c9fdc57050a131cd12c0e54a16f6265e900f459e3b9dd43421a0bc3f61efd49ce752e440e5131a8d2758a280ad883b8eb902c49ee5b878b30000000000000000",
  "cbTx": {
    "version": 3,
    "height": 1989850,
    "merkleRootMNList": "e273b92901ba88bbf083039dcc69dc8cb2212cd5b0911e1ff6ce61fa6740e054",
    "merkleRootQuorums": "8d32a8e988499a344dd4b36a894b42c7690667a6b1f87ae7c7700e58d5477ef6",
    "bestCLHeightDiff": 0,
    "bestCLSignature": "b22fef542f5c630e4f2a67ad56d30cf2a3dac55848abcd2bac30bf780318792bcdf32f7729443846c9fdc57050a131cd12c0e54a16f6265e900f459e3b9dd43421a0bc3f61efd49ce752e440e5131a8d2758a280ad883b8eb902c49ee5b878b3",
    "creditPoolBalance": 0.00000000
  },
  "hex": "03000500010000000000000000000000000000000000000000000000000000000000000000ffffffff2703da5c1e04d04580650800007588782d01000fe4b883e5bda9e7a59ee4bb99e9b1bc04f09f909f88f581b80253640f03000000001976a9147c086eada12bdb10a265c16c08a7ae87366bd48188acf82c2e09000000001976a91453dc8bffae84a3851ab9fe296417da85d5e7185888aca0f04c20af0300da5c1e0054e04067fa61cef61f1e91b0d52c21b28cdc69cc9d0383f0bb88ba0129b973e2f67e47d5580e70c7e77af8b1a6670669c7424b896ab3d44d349a4988e9a8328d00b22fef542f5c630e4f2a67ad56d30cf2a3dac55848abcd2bac30bf780318792bcdf32f7729443846c9fdc57050a131cd12c0e54a16f6265e900f459e3b9dd43421a0bc3f61efd49ce752e440e5131a8d2758a280ad883b8eb902c49ee5b878b30000000000000000",
  "blockhash": "0000000000000025033c275e59b2b6beda724cf5ab49a96e001d080b68d00279",
  "height": 1989850,
  "confirmations": 135,
  "time": 1702905296,
  "blocktime": 1702905296,
  "instantlock": true,
  "instantlock_internal": false,
  "chainlock": true
}
```

```{eval-rst}
.. _ref-txs-qctx:
```

## QcTx

*Adopted from Dash Core which was added in protocol version 70213 of Dash Core as described by [DIP6](https://github.com/dashpay/dips/blob/master/dip-0006.md)*

> 🚧 Note
>
> This special transaction has no inputs and no outputs and thus also pays no fee.

The Quorum Commitment (QcTx) special transaction adds the best final commitment from a [Long-Living Masternode Quorum](../resources/glossary.md#long-living-masternode-quorum) (LLMQ) Distributed Key Generation (DKG) session to the chain.

Since this special transaction pays no fees, it is mandatory by [consensus rules](../resources/glossary.md#consensus-rules) to ensure that miners include it. Exactly one quorum commitment transaction MUST be included in every [block](../resources/glossary.md#block) while in the mining phase of the LLMQ process until a valid commitment is present in a block.

If a DKG failed or a [miner](../resources/glossary.md#miner) did not receive a final commitment in-time, a null commitment has to be included in the special transaction payload. A null commitment must have the `signers` and `validMembers` bitsets set to the `quorumSize` and all bits set to zero. All other fields must be set to the null representation of the field’s types.

The special transaction type used for Quorum Commitment Transactions is 6 and the extra payload consists of the following data:

| Bytes | Name | Data type |  Description |
| ---------- | ----------- | -------- | -------- |
| 2 | version | uint_16 | Quorum Commitment version number. Currently set to 1.
| 4 | height | uint32_t | Height of the block
| Variable | commitment | qfcommit | The payload of the [`qfcommit` message](../reference/p2p-network-quorum-messages.md#qfcommit)

The following annotated hexdump shows a QcTx transaction.

An itemized quorum commitment transaction (v1):

``` text
0300 ....................................... Version (3)
0600 ....................................... Type (6 - Quorum Commitment)

00 ......................................... Number of inputs
00 ......................................... Number of outputs

00000000 ................................... Locktime

fd4901 ..................................... Extra payload size (329)

Quorum Commitment Transaction Payload
| 0100 ..................................... Version (1)
|
| 934c0100 ................................. Block height: 85139
|
| Payload from the qfcommit message
| | 0100 ................................... Version (1)
| |
| | 01 ..................................... LLMQ Type (1)
| |
| | 6b2fd2c61cea32d939ee7fe185c7abc5
| | 01aa7001d973379f46b9200500000000 ....... Quorum hash
| |
| | 32 ..................................... Number of signers (50)
| | bfffffffffff03 ......................... Aggregrated signers bitvector
| |
| | 32 ..................................... Number of valid members (50)
| | bfffffffffff03 ......................... Valid members bitvector
| |
| | 9450e90f61a24a4205c92572666ed068
| | 40f617ac11a26d650c88769675e81197
| | 993858d8b695f120f0af7dd38c17a67e ....... Quorum public key (BLS)
| |
| | 912507814fe204c59e14720bc961c09f
| | f88a4fd1f15e9c2efd4e4f112720967d ....... Quorum verification vector hash
| |
| | Quorum threshold signature (BLS)
| | 0281c321090c2d2e59a0d3754dcfbc11
| | d76c26a152b50885d826915af4d95a73
| | 120d0e1ba7e96d89f40252e24109c323
| | 0971dda1f554d331985ca570c76b9a1a
| | ec699ec132838ae097c767d65d0a51d7
| | 017c62e062270b60b854ae912bc07437 ....... BLS Signatures (96 bytes)
| |
| | Aggregated signatures from all commitments (BLS)
| | 91f878a0ae620e2178bff06c3a3967d7
| | 433d4b82e7879bb927dd5cb605423c84
| | 0641fcddf3731da80d0515a172ff3666
| | 0f4eac88ee8fd7779e32e4f0be704078
| | df31601b87b95374cebb4b304afc543e
| | e0d4f461a2ba0e32a711197ca559dacf ....... BLS Signature (96 bytes)
```

### Example QcTx

```Text Raw Transaction hex
03000600000000000000fd49010100d3710b000100016deffc783c55e385653fe687fb5ec594
46e4c3a2146898ca297e02013300000032ffffffffffff0332ffffffffffff031636185ce736
08e3077536f0621bea1fbc78449f96e40b1f67ca7b50a7638562c716bc9d4fdaa7002be06e6e
54c49369d91c78768678912d3ec71d2d11d92e42488772bd3cdcaa2ce15a016e9eb998048af4
e3ce1100e5188d30c2769e811691f75e94b20fe4c3867b918483319b7f4c7b924599a621b876
fbfa943cd38017bb1226e55beb1df752ddc74470e04f38e8e644d5a74c2783f939b72728bcc6
c5b22b21ed8caf3bcfb90212a8ee6517afeb04ec5a9af7064c7df1f92b01b7cc71e7f76f6dbc
8e53cdd5d5f274566eece977e9431cc9bedf76a241ac95faea018e160bdf89270808acef4f63
1fcd8a551d896581455a37a33f8ef6202145bc1561a404798dffd339b105b5716937e4086f04
```

The JSON representation of a raw transaction can be obtained with the [`getrawtransaction` RPC](../api/remote-procedure-calls-raw-transactions.md#getrawtransaction) or the [`decoderawtransaction` RPC](../api/remote-procedure-calls-raw-transactions.md#decoderawtransaction)

```json JSON Representation
{
  "txid": "82600f79f0f58299995775382af1e813bdbe593b270e4e891baec064307f2a54",
  "version": 3,
  "type": 6,
  "size": 342,
  "locktime": 0,
  "vin": [
  ],
  "vout": [
  ],
  "extraPayloadSize": 329,
  "extraPayload": "0100d3710b000100016deffc783c55e385653fe687fb5ec59446e4c3a2146898ca297e02013300000032ffffffffffff0332ffffffffffff031636185ce73608e3077536f0621bea1fbc78449f96e40b1f67ca7b50a7638562c716bc9d4fdaa7002be06e6e54c49369d91c78768678912d3ec71d2d11d92e42488772bd3cdcaa2ce15a016e9eb998048af4e3ce1100e5188d30c2769e811691f75e94b20fe4c3867b918483319b7f4c7b924599a621b876fbfa943cd38017bb1226e55beb1df752ddc74470e04f38e8e644d5a74c2783f939b72728bcc6c5b22b21ed8caf3bcfb90212a8ee6517afeb04ec5a9af7064c7df1f92b01b7cc71e7f76f6dbc8e53cdd5d5f274566eece977e9431cc9bedf76a241ac95faea018e160bdf89270808acef4f631fcd8a551d896581455a37a33f8ef6202145bc1561a404798dffd339b105b5716937e4086f04",
  "qcTx": {
    "version": 1,
    "height": 750035,
    "commitment": {
      "version": 1,
      "llmqType": 1,
      "quorumHash": "0000003301027e29ca986814a2c3e44694c55efb87e63f6585e3553c78fcef6d",
      "quorumIndex": 0,
      "signersCount": 50,
      "signers": "ffffffffffff03",
      "validMembersCount": 50,
      "validMembers": "ffffffffffff03",
      "quorumPublicKey": "1636185ce73608e3077536f0621bea1fbc78449f96e40b1f67ca7b50a7638562c716bc9d4fdaa7002be06e6e54c49369",
      "quorumVvecHash": "0498b99e6e015ae12caadc3cbd728748422ed9112d1dc73e2d91788676781cd9",
      "quorumSig": "8af4e3ce1100e5188d30c2769e811691f75e94b20fe4c3867b918483319b7f4c7b924599a621b876fbfa943cd38017bb1226e55beb1df752ddc74470e04f38e8e644d5a74c2783f939b72728bcc6c5b22b21ed8caf3bcfb90212a8ee6517afeb",
      "membersSig": "04ec5a9af7064c7df1f92b01b7cc71e7f76f6dbc8e53cdd5d5f274566eece977e9431cc9bedf76a241ac95faea018e160bdf89270808acef4f631fcd8a551d896581455a37a33f8ef6202145bc1561a404798dffd339b105b5716937e4086f04"
    }
  },
  "hex": "03000600000000000000fd49010100d3710b000100016deffc783c55e385653fe687fb5ec59446e4c3a2146898ca297e02013300000032ffffffffffff0332ffffffffffff031636185ce73608e3077536f0621bea1fbc78449f96e40b1f67ca7b50a7638562c716bc9d4fdaa7002be06e6e54c49369d91c78768678912d3ec71d2d11d92e42488772bd3cdcaa2ce15a016e9eb998048af4e3ce1100e5188d30c2769e811691f75e94b20fe4c3867b918483319b7f4c7b924599a621b876fbfa943cd38017bb1226e55beb1df752ddc74470e04f38e8e644d5a74c2783f939b72728bcc6c5b22b21ed8caf3bcfb90212a8ee6517afeb04ec5a9af7064c7df1f92b01b7cc71e7f76f6dbc8e53cdd5d5f274566eece977e9431cc9bedf76a241ac95faea018e160bdf89270808acef4f631fcd8a551d896581455a37a33f8ef6202145bc1561a404798dffd339b105b5716937e4086f04",
  "blockhash": "000000adc9d8a9ff83e79d78efb30f70c73c1f22496bb5d86b775f1d79203fbe",
  "height": 750035,
  "confirmations": 108598,
  "time": 1656194626,
  "blocktime": 1656194626,
  "instantlock": true,
  "instantlock_internal": false,
  "chainlock": true
}

```

## CompactSize Unsigned Integers

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

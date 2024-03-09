```{eval-rst}
.. _api-rpc-blockchain:
.. meta::
  :title: Blockchain RPCs
  :description: A list of all the Blockchain RPCs in Dimecoin.
```

> ***We put our best effort into covering all topics related to Dimecoin. Each section will cover a different category. Not all documentation may be 100% accurate, if you spot an error, please report it or submit a PR request on GitHub.***
>
> ***REMINDER: This documentation is always evolving. If you have not been here for a while, perhaps check again. Things may have been added or updated since your last visit!***

## Blockchain RPCs

### GetBestBlockHash

The [`getbestblockhash` RPC](../api/rpc-blockchain.md#getbestblockhash) returns the header hash of the most recent block on the best blockchain.

*Parameters: none*

*Result---hash of the tip from the best blockchain*

Name | Type | Presence | Description 
--- | --- | --- | ---
`result` | string (hex) | Required<br>(exactly 1) | The hash of the block header from the most recent block on the best blockchain, encoded as hex in RPC byte order 

*Example from Dimecoin Core 2.3.0.0*

``` bash
dimecoin-cli -mainnet getbestblockhash
```

Result:

``` text
00000bafbc94add76cb75e2ec92894837288a481e5c005f6563d91623bf8bc2c
```

*See also*

* [GetBlock](../api/rpc-blockchain.md#getblock): gets a block with a particular header hash from the local block database either as a JSON object or as a serialized block.
* [GetBlockHash](../api/rpc-blockchain.md#getblockhash): returns the header hash of a block at the given height in the local best blockchain.

### GetBlock

The [`getblock` RPC](../api/rpc-blockchain.md#getblock) gets a block with a particular header hash from the local block database either as a JSON object or as a serialized block.

*Parameter #1---block hash*

Name | Type | Presence | Description
--- | --- | --- | ---
Block Hash | string (hex) | Required<br>(exactly 1) | The hash of the header of the block to get, encoded as hex in RPC byte order

*Parameter #2---whether to get JSON or hex output*

Name | Type | Presence | Description
--- | --- | --- | ---
Verbosity | numeric | Optional<br>(0 or 1) | Set to one of the following verbosity levels:<br>• `0` - Get the block in serialized block format;<br>• `1` - Get the decoded block as a JSON object (default)<br>• `2` - Get the decoded block as a JSON object with transaction details

*Result (if verbosity was `0`)---a serialized block*

Name | Type | Presence | Description
--- | --- | --- | ---
`result` | string (hex)/null | Required<br>(exactly 1) | The requested block as a serialized block, encoded as hex, or JSON `null` if an error occurred

*Result (if verbosity was `1` or omitted)---a JSON block with transaction hashes*

Name | Type | Presence | Description
--- | --- | --- | ---
`result` | object/null | Required<br>(exactly 1) | An object containing the requested block, or JSON `null` if an error occurred
→<br>`hash` | string (hex) | Required<br>(exactly 1) | The hash of this block's block header encoded as hex in RPC byte order.  This is the same as the hash provided in parameter #1
→<br>`confirmations` | numeric | Required<br>(exactly 1) | The number of confirmations the transactions in this block have, starting at 1 when this block is at the tip of the best blockchain.  This score will be -1 if the the block is not part of the best blockchain
→<br>`size` | numeric | Required<br>(exactly 1) | The size of this block in serialized block format, counted in bytes
→<br>`strippedsize`| numeric | Required<br>(exactly 1) | The block size excluding witness data
→<br>`height` | numeric | Required<br>(exactly 1) | The height of this block on its blockchain
→<br>`version` | numeric | Required<br>(exactly 1) | This block's version number.  See [block version numbers](../reference/block-chain-block-headers.md#block-versions)
→<br>`versionHex` | string (hex) | Required<br>(exactly 1) | The block version formatted in hexadecimal
→<br>`merkleroot` | string (hex) | Required<br>(exactly 1) | The merkle root for this block, encoded as hex in RPC byte order
→<br>`tx` | array | Required<br>(exactly 1) | An array containing the TXIDs of all transactions in this block.  The transactions appear in the array in the same order they appear in the serialized block
→ →<br>TXID | string (hex) | Required<br>(1 or more) | The TXID of a transaction in this block, encoded as hex in RPC byte order
→<br>`cbTx` | object | Required<br>(exactly 1) | Coinbase special transaction details
→ →<br>`version` | numeric | Required<br>(exactly 1) | The version of the Coinbase special transaction (CbTx)
→ →<br>`height` | numeric | Required<br>(exactly 1) | The height of this block on its blockchain
→ →<br>`merkleRootMNList` | string (hex) | Required<br>(exactly 1) | The merkle root for the masternode list
→ →<br>`merkleRootQuorums` | string (hex) | Required<br>(exactly 1) | The merkle root for the quorum list
→<br>`time` | numeric | Required<br>(exactly 1) | The value of the *time* field in the block header, indicating approximately when the block was created
→<br>`mediantime` | numeric | Required<br>(exactly 1) | The median block time in Unix epoch time  
→<br>`nonce` | numeric | Required<br>(exactly 1) | The nonce which was successful at turning this particular block into one that could be added to the best blockchain
→<br>`bits` | string (hex) | Required<br>(exactly 1) | The value of the *nBits* field in the block header, indicating the target threshold this block's header had to pass
→<br>`difficulty` | number (real) | Required<br>(exactly 1) | The estimated amount of work done to find this block relative to the estimated amount of work done to find block 0
→<br>`chainwork` | string (hex) | Required<br>(exactly 1) | The estimated number of block header hashes miners had to check from the genesis block to this block, encoded as big-endian hex
→<br>`nTx` | numeric | Required<br>(exactly 1) | The number of transactions in the block
→<br>`previousblockhash` | string (hex) | Optional<br>(0 or 1) | The hash of the header of the previous block, encoded as hex in RPC byte order.  Not returned for genesis block
→<br>`nextblockhash` | string (hex) | Optional<br>(0 or 1) | The hash of the next block on the best blockchain, if known, encoded as hex in RPC byte order

*Result (if verbosity was `2`---a JSON block with full transaction details*)

Name | Type | Presence | Description
--- | --- | --- | ---
`result` | object/null | Required<br>(exactly 1) | An object containing the requested block, or JSON `null` if an error occurred
→<br>`hash` | string (hex) | Required<br>(exactly 1) | The hash of this block's block header encoded as hex in RPC byte order.  This is the same as the hash provided in parameter #1
→<br>`confirmations` | numeric | Required<br>(exactly 1) | The number of confirmations the transactions in this block have, starting at 1 when this block is at the tip of the best blockchain.  This score will be -1 if the the block is not part of the best blockchain
→<br>`size` | numeric | Required<br>(exactly 1) | The size of this block in serialized block format, counted in bytes
→<br>`weight`| numeric | Required<br>(exactly 1) | THe block weight as defined in [BIP 141](https://github.com/bitcoin/bips/blob/master/bip-0141.mediawiki)
→<br>`height` | numeric | Required<br>(exactly 1) | The height of this block on its blockchain
→<br>`version` | numeric | Required<br>(exactly 1) | This block's version number.  See [block version numbers](../reference/block-chain-block-headers.md#block-versions)
→<br>`versionHex` | string (hex) | Required<br>(exactly 1) | The block version formatted in hexadecimal
→<br>`merkleroot` | string (hex) | Required<br>(exactly 1) | The merkle root for this block, encoded as hex in RPC byte order
→<br>`tx` | array | Required<br>(exactly 1) | An array containing the TXIDs of all transactions in this block.  The transactions appear in the array in the same order they appear in the serialized block
→ →<br>`TXID` | string (hex) | Required<br>(exactly 1) | The transaction's TXID encoded as hex in RPC byte order
→ →<br>`time` | numeric | Required<br>(exactly 1) | The block time in seconds since epoch
→ →<br>`version` | numeric | Required<br>(exactly 1) | The transaction format version number
→ →<br>`type` | numeric | Required<br>(exactly 1) | The transaction format type
→ →<br>`locktime` | numeric | Required<br>(exactly 1) | The transaction's locktime: either a Unix epoch date or block height; see the [locktime parsing rules](../guide/transactions-locktime-and-sequence-number.md#locktime-parsing-rules)
→ →<br>`vin` | array | Required<br>(exactly 1) | An array of objects with each object being an input vector (vin) for this transaction.  Input objects will have the same order within the array as they have in the transaction, so the first input listed will be input 0
→ → →<br>Input | object | Required<br>(1 or more) | An object describing one of this transaction's inputs.  May be a regular input or a coinbase
→ → → →<br>`txid` | string | Optional<br>(0 or 1) | The TXID of the outpoint being spent, encoded as hex in RPC byte order.  Not present if this is a coinbase transaction
→ → → →<br>`vout` | numeric | Optional<br>(0 or 1) | The output index number (vout) of the outpoint being spent.  The first output in a transaction has an index of `0`.  Not present if this is a coinbase transaction
→ → → →<br>`scriptSig` | object | Optional<br>(0 or 1) | An object describing the signature script of this input.  Not present if this is a coinbase transaction
→ → → → →<br>`asm` | string | Required<br>(exactly 1) | The signature script in decoded form with non-data-pushing opcodes listed
→ → → → →<br>`hex` | string (hex) | Required<br>(exactly 1) | The signature script encoded as hex
→ → → →<br>`coinbase` | string (hex) | Optional<br>(0 or 1) | The coinbase (similar to the hex field of a scriptSig) encoded as hex.  Only present if this is a coinbase transaction
→ → → →<br>`value` | number (DIME) | Optional<br>(exactly 1) | The number of Dash paid to this output.  May be `0`.<br><br>Only present if `spentindex` enabled
→ → → →<br>`valueSat` | number (dimecoins) | Optional<br>(exactly 1) | The number of dimecoins paid to this output.  May be `0`.<br><br>Only present if `spentindex` enabled
→ → → → →<br>`addresses` | string : array | Optional<br>(0 or 1) | The P2PKH or P2SH addresses used in this transaction, or the computed P2PKH address of any pubkeys in this transaction.  This array will not be returned for `nulldata` or `nonstandard` script types.<br><br>Only present if `spentindex` enabled
→ → → → → →<br>`Address` | string | Required<br>(1 or more) | A P2PKH or P2SH address
→ → → →<br>`sequence` | numeric | Required<br>(exactly 1) | The input sequence number
→ →<br>`vout` | array | Required<br>(exactly 1) | An array of objects each describing an output vector (vout) for this transaction.  Output objects will have the same order within the array as they have in the transaction, so the first output listed will be output 0
→ → →<br>`Output` | object | Required<br>(1 or more) | An object describing one of this transaction's outputs
→ → → →<br>`value` | number (DIME) | Required<br>(exactly 1) | The number of Dash paid to this output.  May be `0`
→ → → →<br>`valueSat` | number (dimecoins) | Required<br>(exactly 1) | The number of dimecoins paid to this output.  May be `0`
→ → → →<br>`n` | numeric | Required<br>(exactly 1) | The output index number of this output within this transaction
→ → → →<br>`scriptPubKey` | object | Required<br>(exactly 1) | An object describing the pubkey script
→ → → → →<br>`asm` | string | Required<br>(exactly 1) | The pubkey script in decoded form with non-data-pushing opcodes listed
→ → → → →<br>`hex` | string (hex) | Required<br>(exactly 1) | The pubkey script encoded as hex
→ → → → →<br>`reqSigs` | numeric | Optional<br>(0 or 1) | The number of signatures required; this is always `1` for P2PK, P2PKH, and P2SH (including P2SH multisig because the redeem script is not available in the pubkey script).  It may be greater than 1 for bare multisig.  This value will not be returned for `nulldata` or `nonstandard` script types (see the `type` key below)
→ → → → →<br>`type` | string | Optional<br>(0 or 1) | The type of script.  This will be one of the following:<br>• `pubkey` for a P2PK script<br>• `pubkeyhash` for a P2PKH script<br>• `scripthash` for a P2SH script<br>• `multisig` for a bare multisig script<br>• `nulldata` for nulldata scripts<br>• `nonstandard` for unknown scripts
→ → → → →<br>`addresses` | string : array | Optional<br>(0 or 1) | The P2PKH or P2SH addresses used in this transaction, or the computed P2PKH address of any pubkeys in this transaction.  This array will not be returned for `nulldata` or `nonstandard` script types
→ → → → → →<br>Address | string | Required<br>(1 or more) | A P2PKH or P2SH address
→ →<br>`version` | numeric | Required<br>(exactly 1) | The version of the Coinbase special transaction (CbTx)
→ →<br>`height` | numeric | Required<br>(exactly 1) | The height of this block on its blockchain
→<br>`time` | numeric | Required<br>(exactly 1) | The value of the *time* field in the block header, indicating approximately when the block was created
→<br>`mediantime` | numeric | Required<br>(exactly 1) | The median block time in Unix epoch time  
→<br>`nonce` | numeric | Required<br>(exactly 1) | The nonce which was successful at turning this particular block into one that could be added to the best blockchain
→<br>`bits` | string (hex) | Required<br>(exactly 1) | The value of the *nBits* field in the block header, indicating the target threshold this block's header had to pass
→<br>`difficulty` | number (real) | Required<br>(exactly 1) | The estimated amount of work done to find this block relative to the estimated amount of work done to find block 0
→<br>`chainwork` | string (hex) | Required<br>(exactly 1) | The estimated number of block header hashes miners had to check from the genesis block to this block, encoded as big-endian hex
→<br>`nTx` | numeric | Required<br>(exactly 1) | The number of transactions in the block
→<br>`previousblockhash` | string (hex) | Optional<br>(0 or 1) | The hash of the header of the previous block, encoded as hex in RPC byte order.  Not returned for genesis block
→<br>`nextblockhash` | string (hex) | Optional<br>(0 or 1) | The hash of the next block on the best blockchain, if known, encoded as hex in RPC byte order

*Example from Dimecoin Core 2.3.0.0*

Get a block in raw hex:

``` bash
dimecoin-cli -mainnet getblock \
            00000000002490fad52485862dddb08f3fa31812b6c3b44136dd481ad7014d91 \
            0
```

Result (wrapped):

``` text
0100000001000000000000000000000000000000000000000000000000000000\
0000000000ffffffff21032851560421d290650881022f9cea04000054686542\
6565506f6f6c2e636f6d000000000002b026d300000000001976a914b153550d\
d81025c3542d95d0a744ccb2408d809488ac10f6a751000000001976a914743f\
864ff6c44d47340a1eaf10f26ad783bd5fef88ac00000000
```

Get the same block in JSON:

``` bash
dimecoin-cli -mainnet getblock \
            00000000002490fad52485862dddb08f3fa31812b6c3b44136dd481ad7014d91
```

Result:

``` json
{
  "hash": "00000000002490fad52485862dddb08f3fa31812b6c3b44136dd481ad7014d91",
  "confirmations": 124201,
  "strippedsize": 233,
  "size": 233,
  "height": 917286,
  "weight": 932,
  "version": 536870912,
  "versionHex": "20000000",
  "merkleroot": "88f6bfb0042a6f7ed14499f24d3995350b829ac1aab9f45194882ec61cc407f6",
  "tx": [
    "88f6bfb0042a6f7ed14499f24d3995350b829ac1aab9f45194882ec61cc407f6"
  ],
  "time": 1703989793,
  "mediantime": 1703989562,
  "nonce": 3858403250,
  "bits": "1b280b17",
  "difficulty": 1636.602571601571,
  "chainwork": "0000000000000000000000000000000000000000000002224d830b6af3fff024",
  "nTx": 1,
  "previousblockhash": "0000000000090fdd82a1735409a7f8c2e8c9abc1dd566234f337d6162a1832f4",
  "nextblockhash": "000000000000b30ef27147bcc0829c540d0bd01076f9727d9a3a3c4c2e1f0d1d"
}
```

Get the same block in JSON with transaction details:

``` bash
dimecoin-cli -mainnet getblock \
            00000000002490fad52485862dddb08f3fa31812b6c3b44136dd481ad7014d91 2
```

Result:

``` json
{
  "hash": "00000000002490fad52485862dddb08f3fa31812b6c3b44136dd481ad7014d91",
  "confirmations": 124218,
  "strippedsize": 233,
  "size": 233,
  "weight": 932,
  "height": 5656872,
  "version": 536870912,
  "versionHex": "20000000",
  "merkleroot": "88f6bfb0042a6f7ed14499f24d3995350b829ac1aab9f45194882ec61cc407f6",
  "tx": [
    {
      "txid": "88f6bfb0042a6f7ed14499f24d3995350b829ac1aab9f45194882ec61cc407f6",
      "hash": "88f6bfb0042a6f7ed14499f24d3995350b829ac1aab9f45194882ec61cc407f6",
      "version": 1,
      "size": 152,
      "vsize": 152,
      "weight": 608,
      "locktime": 0,
      "vin": [
        {
          "coinbase": "032851560421d290650881022f9cea040000546865426565506f6f6c2e636f6d00",
          "sequence": 0
        }
      ],
      "vout": [
        {
          "value": 138.38000,
          "n": 0,
          "scriptPubKey": {
            "asm": "OP_DUP OP_HASH160 b153550dd81025c3542d95d0a744ccb2408d8094 OP_EQUALVERIFY OP_CHECKSIG",
            "hex": "76a914b153550dd81025c3542d95d0a744ccb2408d809488ac",
            "reqSigs": 1,
            "type": "pubkeyhash",
            "addresses": [
              "7KEfCcJ2cMkSb25xpJP8bVUXd8xffoWWb2"
            ]
          }
        },
        {
          "value": 13699.62000,
          "n": 1,
          "scriptPubKey": {
            "asm": "OP_DUP OP_HASH160 743f864ff6c44d47340a1eaf10f26ad783bd5fef OP_EQUALVERIFY OP_CHECKSIG",
            "hex": "76a914743f864ff6c44d47340a1eaf10f26ad783bd5fef88ac",
            "reqSigs": 1,
            "type": "pubkeyhash",
            "addresses": [
              "7DfiFeoRozWQCsNhWFy59g1a62BY75FSwS"
            ]
          }
        }
      ],
      "hex": "01000000010000000000000000000000000000000000000000000000000000000000000000ffffffff21032851560421d290650881022f9cea040000546865426565506f6f6c2e636f6d000000000002b026d300000000001976a914b153550dd81025c3542d95d0a744ccb2408d809488ac10f6a751000000001976a914743f864ff6c44d47340a1eaf10f26ad783bd5fef88ac00000000"
    }
  ],
  "time": 1703989793,
  "mediantime": 1703989562,
  "nonce": 3858403250,
  "bits": "1b280b17",
  "difficulty": 1636.602571601571,
  "chainwork": "0000000000000000000000000000000000000000000002224d830b6af3fff024",
  "nTx": 1,
  "previousblockhash": "0000000000090fdd82a1735409a7f8c2e8c9abc1dd566234f337d6162a1832f4",
  "nextblockhash": "000000000000b30ef27147bcc0829c540d0bd01076f9727d9a3a3c4c2e1f0d1d"
}
```

*See also*

* [GetBlockHash](../api/rpc-blockchain.md#getblockhash): returns the header hash of a block at the given height in the local best blockchain.
* [GetBestBlockHash](../api/rpc-blockchain.md#getbestblockhash): returns the header hash of the most recent block on the best blockchain.

### GetBlockChainInfo

The [`getblockchaininfo` RPC](../api/rpc-blockchain.md#getblockchaininfo) provides information about the current state of the blockchain.

*Parameters: none*

*Result---A JSON object providing information about the blockchain*

Name | Type | Presence | Description
--- | --- | --- | ---
`result` | object | Required<br>(exactly 1) | Information about the current state of the local blockchain
→<br>`chain` | string | Required<br>(exactly 1) | The name of the blockchain. Either `main` for mainnet, `test` for testnet, `regtest` for regtest, or `devnet-<name>` for devnets
→<br>`blocks` | numeric | Required<br>(exactly 1) | The number of validated blocks in the local best blockchain.  For a new node with just the hardcoded genesis block, this will be 0
→<br>`headers` | numeric | Required<br>(exactly 1) | The number of validated headers in the local best headers chain.  For a new node with just the hardcoded genesis block, this will be zero.  This number may be higher than the number of *blocks*
→<br>`bestblockhash` | string (hex) | Required<br>(exactly 1) | The hash of the header of the highest validated block in the best blockchain, encoded as hex in RPC byte order.  This is identical to the string returned by the [`getbestblockhash` RPC](../api/rpc-blockchain.md#getbestblockhash)
→<br>`difficulty` | number (real) | Required<br>(exactly 1) | The difficulty of the highest-height block in the best blockchain for both proof-of-work & proof-of-stake
→<br>`mediantime` | numeric | Required<br>(exactly 1) | The median time of the 11 blocks before the most recent block on the blockchain.  Used for validating transaction locktime under BIP113
→<br>`verificationprogress` | number (real) | Required<br>(exactly 1) | Estimate of what percentage of the blockchain transactions have been verified so far, starting at 0.0 and increasing to 1.0 for fully verified.  May slightly exceed 1.0 when fully synced to account for transactions in the memory pool which have been verified before being included in a block
→<br>`initialblockdownload` | boolean | Required<br>(exactly 1) | An estimate of whether this node is in [Initial Block Download](../guide/p2p-network-initial-block-download.md) mode (*debug information*)
→<br>`chainwork` | string (hex) | Required<br>(exactly 1) | The estimated number of block header hashes checked from the genesis block to this block, encoded as big-endian hex
→<br>`size_on_disk` | numeric | Required<br>(exactly 1) | The estimated size of the block and undo files on disk
→<br>`softforks` | object | Required<br>(exactly 1) | An object with each key describing a current or previous soft fork
→ →<br>Softfork | object | Required<br>(0 or more) | The name of a specific softfork
→ → →<br>`type`          | string  | Required | One of "buried", "bip9"
→ → →<br>`bip9`          | object  | Optional | Status of bip9 softforks (only for "bip9" type)
→ → → →<br>`status`       | string  | Required | One of "defined", "started", "locked_in", "active", "failed"
→ → → →<br>`bit`          | numeric | Optional | The bit (0-28) in the block version field used to signal this softfork (only for "started" status)
→ → → →<br>`start_time`   | numeric | Required | The minimum median time past of a block at which the bit gains its meaning
→ → → →<br>`timeout`      | numeric | Required | The median time past of a block at which the deployment is considered failed if not yet locked in
→ → → →<br>`since`        | numeric | Required | Height of the first block to which the status applies
→ → → →<br>`activation_height` | numeric | Optional | Expected activation height for this softfork (only for "locked_in" `status`)
→ → → →<br>`ehf`          | bool | Required | `true` for EHF activated hard forks
→ → → →<br>`ehf_height`   | numeric | Optional | The minimum height at which miner's signals for the deployment matter. Below this height miner signaling cannot trigger hard fork lock-in. Not returned if `ehf` is `false` or if the minimum height is not known yet.
→ → → →<br>`statistics` | string : object | Required<br>(exactly 1) | Numeric statistics about BIP9 signaling for a softfork (only for \started\" status)"
→ → → → →<br>`period` | numeric<br>(int) | Optional<br>(0 or 1) | The length in blocks of the BIP9 signaling period.  Field is only shown when status is `started`
→ → → → →<br>`threshold` | numeric<br>(int) | Optional<br>(0 or 1) | The number of blocks with the version bit set required to activate the feature.  Field is only shown when status is `started`
→ → → → →<br>`elapsed` | numeric<br>(int) | Optional<br>(0 or 1) | The number of blocks elapsed since the beginning of the current period.  Field is only shown when status is `started`
→ → → → →<br>`count` | numeric<br>(int) | Optional<br>(0 or 1) | The number of blocks with the version bit set in the current period.  Field is only shown when status is `started`
→ → → → →<br>`possible` | bool | Optional<br>(0 or 1) | Returns false if there are not enough blocks left in this period to pass activation threshold.  Field is only shown when status is `started`
→ → →<br>`height` | numeric | Optional | Height of the first block at which the rules are or will be enforced (only for "buried" type, or "bip9" type with "active" status)
→ → →<br>`active` | boolean | Required | True if the rules are enforced for the mempool and the next block
→<br>`warnings` | string | Optional<br>(0 or 1) | Returns any network and blockchain warnings

*Example from Dimecoin Core 2.3.0.0*

``` bash
dimecoin-cli -mainnet getblockchaininfo
```

Result:

``` json
{
  "chain": "main",
  "blocks": 5781103,
  "headers": 5781103,
  "bestblockhash": "000000000001a5f6fad5f8c6ead5c6580d87ee85014807bb49ad1c49ea289ba3",
  "difficulty": {
    "proof-of-work": 42790.26571420032,
    "proof-of-stake": 49148933.24239863
  },
  "mediantime": 1709848934,
  "verificationprogress": 0.9999988101850906,
  "initialblockdownload": false,
  "chainwork": "00000000000000000000000000000000000000000000035676abb8d31975b701",
  "size_on_disk": 4267677214,
  "softforks": [
    {
      "id": "bip34",
      "version": 2,
      "reject": {
        "status": true
      }
    },
    {
      "id": "bip66",
      "version": 3,
      "reject": {
        "status": true
      }
    },
    {
      "id": "bip65",
      "version": 4,
      "reject": {
        "status": true
      }
    }
  ],
  "bip9_softforks": {
    "csv": {
      "status": "failed",
      "startTime": 1462060800,
      "timeout": 1493596800,
      "since": 2102400
    },
    "segwit": {
      "status": "failed",
      "startTime": 1479168000,
      "timeout": 1510704000,
      "since": 2507040
    }
  },
  "warnings": ""
}
```

*See also*

* [GetMiningInfo](../api/rpc-mining.md#getmininginfo): returns various mining-related information.
* [GetNetworkInfo](../api/rpc-network.md#getnetworkinfo): returns information about the node's connection to the network.
* [GetWalletInfo](../api/rpc-wallet.md#getwalletinfo): provides information about the wallet.

### GetBlockCount

The [`getblockcount` RPC](../api/rpc-blockchain.md#getblockcount) returns the number of blocks in the local best blockchain.

*Parameters: none*

*Result---the number of blocks in the local best blockchain*

Name | Type | Presence | Description
--- | --- | --- | ---
`result` | numeric | Required<br>(exactly 1) | The number of blocks in the local best blockchain.  For a new node with only the hardcoded genesis block, this number will be 0

*Example from Dimecoin Core 2.3.0.0*

``` bash
dimecoin-cli -mainnet getblockcount
```

Result:

``` text
5781103
```

*See also*

* [GetBlockHash](../api/rpc-blockchain.md#getblockhash): returns the header hash of a block at the given height in the local best blockchain.
* [GetBlock](../api/rpc-blockchain.md#getblock): gets a block with a particular header hash from the local block database either as a JSON object or as a serialized block.

### GetBlockHash

The [`getblockhash` RPC](../api/rpc-blockchain.md#getblockhash) returns the header hash of a block at the given height in the local best blockchain.

*Parameter---a block height*

Name | Type | Presence | Description
--- | --- | --- | ---
Block Height | numeric | Required<br>(exactly 1) | Returns hash of block in best-block-chain at height provided.  The height of the hardcoded genesis block is 0

*Result---the block header hash*

Name | Type | Presence | Description
--- | --- | --- | ---
`result` | string (hex)/null | Required<br>(exactly 1) | The hash of the block at the requested height, encoded as hex in RPC byte order, or JSON `null` if an error occurred

*Example from Dimecoin Core 2.3.0.0*

``` bash
dimecoin-cli -mainnet getblockhash 100000
```

Result:

``` text
00000000539760ef8dd9d933743b6281e8337359ecfa35917f924e52156c7566
```

*See also*

* [GetBlock](../api/rpc-blockchain.md#getblock): gets a block with a particular header hash from the local block database either as a JSON object or as a serialized block.
* [GetBestBlockHash](../api/rpc-blockchain.md#getbestblockhash): returns the header hash of the most recent block on the best blockchain.

### GetBlockHeader

The [`getblockheader` RPC](../api/rpc-blockchain.md#getblockheader) gets a block header with a particular header hash from the local block database either as a JSON object or as a serialized block header.

*Parameter #1---header hash*

Name | Type | Presence | Description
--- | --- | --- | ---
Header Hash | string (hex) | Required<br>(exactly 1) | The hash of the block header to get, encoded as hex in RPC byte order

*Parameter #2---JSON or hex output*

Name | Type | Presence | Description
--- | --- | --- | ---
Format | bool | Optional<br>(0 or 1) | Set to `false` to get the block header in serialized block format; set to `true` (the default) to get the decoded block header as a JSON object

*Result (if format was `false`)---a serialized block header*

Name | Type | Presence | Description
--- | --- | --- | ---
`result` | string (hex)/null | Required<br>(exactly 1) | The requested block header as a serialized block, encoded as hex, or JSON `null` if an error occurred

*Result (if format was `true` or omitted)---a JSON block header*

Name | Type | Presence | Description
--- | --- | --- | ---
`result` | object/null | Required<br>(exactly 1) | An object containing the requested block, or JSON `null` if an error occurred
→<br>`hash` | string (hex) | Required<br>(exactly 1) | The hash of this block's block header encoded as hex in RPC byte order.  This is the same as the hash provided in parameter #1
→<br>`confirmations` | numeric | Required<br>(exactly 1) | The number of confirmations the transactions in this block have, starting at 1 when this block is at the tip of the best blockchain.  This score will be -1 if the the block is not part of the best blockchain
→<br>`height` | numeric | Required<br>(exactly 1) | The height of this block on its blockchain
→<br>`version` | numeric | Required<br>(exactly 1) | This block's version number.  See [block version numbers](../reference/block-chain-block-headers.md#block-versions)
→<br>`merkleroot` | string (hex) | Required<br>(exactly 1) | The merkle root for this block, encoded as hex in RPC byte order
→<br>`time` | numeric | Required<br>(exactly 1) | The time of the block  
→<br>`mediantime` | numeric | Required<br>(exactly 1) | The computed median time of the previous 11 blocks.  Used for validating transaction locktime under BIP113
→<br>`nonce` | numeric | Required<br>(exactly 1) | The nonce which was successful at turning this particular block into one that could be added to the best blockchain
→<br>`bits` | string (hex) | Required<br>(exactly 1) | The value of the *nBits* field in the block header, indicating the target threshold this block's header had to pass
→<br>`difficulty` | number (real) | Required<br>(exactly 1) | The estimated amount of work done to find this block relative to the estimated amount of work done to find block 0
→<br>`chainwork` | string (hex) | Required<br>(exactly 1) | The estimated number of block header hashes miners had to check from the genesis block to this block, encoded as big-endian hex
→<br>`nTx` | numeric | Required<br>(exactly 1) | The number of transactions in the block
→<br>`previousblockhash` | string (hex) | Optional<br>(0 or 1) | The hash of the header of the previous block, encoded as hex in RPC byte order.  Not returned for genesis block
→<br>`nextblockhash` | string (hex) | Optional<br>(0 or 1) | The hash of the next block on the best blockchain, if known, encoded as hex in RPC byte order

*Example from Dimecoin Core 2.3.0.0*

Get a block header in raw hex:

``` bash
dimecoin-cli -mainnet getblockheader \
            00000000002490fad52485862dddb08f3fa31812b6c3b44136dd481ad7014d91 \
            false
```

Result (wrapped):

``` text
00000000002490fad52485862dddb08f3fa31812b6c3b44136dd481ad7014d91\

```

Get the same block in JSON:

``` bash
dimecoin-cli -mainnet getblockheader \
            00000000002490fad52485862dddb08f3fa31812b6c3b44136dd481ad7014d91
```

Result:

``` json
{
  "hash": "00000000002490fad52485862dddb08f3fa31812b6c3b44136dd481ad7014d91",
  "confirmations": 124240,
  "height": 5656872,
  "version": 536870912,
  "versionHex": "20000000",
  "merkleroot": "88f6bfb0042a6f7ed14499f24d3995350b829ac1aab9f45194882ec61cc407f6",
  "time": 1703989793,
  "mediantime": 1703989562,
  "nonce": 3858403250,
  "bits": "1b280b17",
  "difficulty": 1636.602571601571,
  "chainwork": "0000000000000000000000000000000000000000000002224d830b6af3fff024",
  "nTx": 1,
  "previousblockhash": "0000000000090fdd82a1735409a7f8c2e8c9abc1dd566234f337d6162a1832f4",
  "nextblockhash": "000000000000b30ef27147bcc0829c540d0bd01076f9727d9a3a3c4c2e1f0d1d"
}
```

*See also*

* [GetBlock](../api/rpc-blockchain.md#getblock): gets a block with a particular header hash from the local block database either as a JSON object or as a serialized block.
* [GetBlockHash](../api/rpc-blockchain.md#getblockhash): returns the header hash of a block at the given height in the local best blockchain.
* [GetBlockHashes](../api/rpc-blockchain.md#getblockhashes): returns array of hashes of blocks within the timestamp range provided (requires `timestampindex` to be enabled).
* [GetBlockHeaders](../api/rpc-blockchain.md#getblockheaders): returns an array of items with information about the requested number of blockheaders starting from the requested hash.
* [GetBestBlockHash](../api/rpc-blockchain.md#getbestblockhash): returns the header hash of the most recent block on the best blockchain.

```{eval-rst}
.. _api-rpc-blockchain-getblockheaders:
```

### GetChainTips

The [`getchaintips` RPC](../api/remote-procedure-calls-blockchain.md#getchaintips) returns information about the highest-height block (tip) of each local block chain.

*Parameters: none*

*Result---an array of block chain tips*

Name | Type | Presence | Description
--- | --- | --- | ---
`result` | array | Required<br>(exactly 1) | An array of JSON objects, with each object describing a chain tip.  At least one tip---the local best block chain---will always be present
→<br>Tip | object | Required<br>(1 or more) | An object describing a particular chain tip.  The first object will always describe the active chain (the local best block chain)
→ →<br>`height` | number (int) | Required<br>(exactly 1) | The height of the highest block in the chain.  A new node with only the genesis block will have a single tip with height of 0
→ →<br>`hash` | string (hex) | Required<br>(exactly 1) | The hash of the highest block in the chain, encoded as hex in RPC byte order
→<br>`difficulty` | number (real) | Required<br>(exactly 1) | The difficulty of the highest-height block in the best block chain (Added in Dash Core 0.12.1)
→<br>`chainwork` | string (hex) | Required<br>(exactly 1) | The estimated number of block header hashes checked from the genesis block to this block, encoded as big-endian hex
→ →<br>`branchlen` | number (int) | Required<br>(exactly 1) | The number of blocks that are on this chain but not on the main chain.  For the local best block chain, this will be `0`; for all other chains, it will be at least `1`
→ →<br>`forkpoint` | string (hex) | Required<br>(exactly 1) | Block hash of the last common block between this tip and the main chain
→ →<br>`status` | string | Required<br>(exactly 1) | The status of this chain.  Valid values are:<br>• `active` for the local best block chain<br>• `invalid` for a chain that contains one or more invalid blocks<br>• `headers-only` for a chain with valid headers whose corresponding blocks both haven't been validated and aren't stored locally<br>• `valid-headers` for a chain with valid headers whose corresponding blocks are stored locally, but which haven't been fully validated<br>• `valid-fork` for a chain which is fully validated but which isn't part of the local best block chain (it was probably the local best block chain at some point)<br>• `unknown` for a chain whose reason for not being the active chain is unknown

*Example from Dimecoin Core 2.3.0.0*

``` bash
dash-cli -testnet getchaintips
```

``` json
[
  {
    "height": 5453791,
    "hash": "000000000014ec3bd78b98648f3106518a65680062286999f7719cdaa0d1c290",
    "difficulty": 661.7647844639035,
    "chainwork": "0000000000000000000000000000000000000000000000b2b86bd4abe952da1e",
    "branchlen": 0,
    "forkpoint": "00000000001e30dcbae4c748c79b773ee769766a6fcc12a63f4be67277377c25",
    "status": "active"
  }
]
```

*See also*

* [GetBestBlockHash](../api/remote-procedure-calls-blockchain.md#getbestblockhash): returns the header hash of the most recent block on the best block chain.
* [GetBlock](../api/remote-procedure-calls-blockchain.md#getblock): gets a block with a particular header hash from the local block database either as a JSON object or as a serialized block.
* [GetBlockChainInfo](../api/remote-procedure-calls-blockchain.md#getblockchaininfo): provides information about the current state of the block chain.

### GetChainTxStats

The [`getchaintxstats` RPC](../api/rpc-blockchain.md#getchaintxstats) compute statistics about the total number and rate of transactions in the chain.

*Parameter #1---nblocks*

Name | Type | Presence | Description
--- | --- | --- | ---
nblocks | numeric | Optional | Size of the window in number of blocks (default: one month).

*Parameter #2---blockhash*

Name | Type | Presence | Description
--- | --- | --- | ---
blockhash | string | Optional | The hash of the block that ends the window.

*Result--statistics about transactions*

Name | Type | Presence | Description
--- | --- | --- | ---
`result` | object | Required<br>(exactly 1) | Object containing transaction statistics
→<br>`time` | numeric | Required<br>(exactly 1) | The timestamp for the statistics in UNIX format
→<br>`txcount` | numeric | Required<br>(exactly 1) | The total number of transactions in the chain up to that point
→<br>`window_final_block_hash` | string (hex) | Required<br>(exactly 1) | The hash of the final block in the window
→<br>`window_block_count` | numeric | Required<br>(exactly 1) | Size of the window in number of blocks
→<br>`window_final_block_height` | numeric | Required<br>(exactly 1) | Height of the final block in window
→<br>`window_tx_count` | numeric | Optional<br>(0 or 1) | The number of transactions in the window. Only returned if `window_block_count` is > 0
→<br>`window_interval` | numeric | Optional<br>(0 or 1) | The elapsed time in the window in seconds. Only returned if `window_block_count` is > 0
→<br>`txrate` | numeric | Optional<br>(0 or 1) | The average rate of transactions per second in the window. Only returned if `window_interval` is > 0

*Example from Dimecoin Core 2.3.0.0*

``` bash
dimecoin-cli -mainnet getchaintxstats
```

Result:

``` json
{
  "time": 1709850029,
  "txcount": 7286862,
  "window_final_block_hash": "5ff07ab9ae8dc45e52261e4b1382a3ced2b45846232d2f9c6499459c00f4b047",
  "window_block_count": 40500,
  "window_tx_count": 63673,
  "window_interval": 1945561,
  "txrate": 0.03272732132274444
}
```

*See also: none*

### GetCheckPoint

The `getcheckpoint` RPC returns info of latest syncronized checkpoint.

*Parameters: none*

*Example from Dimecoin Core 2.3.0.0*

``` bash
dimecoin-cli -mainnet getcheckpoint
```

Result:

``` text
{
  "synccheckpoint": "fdcf17b964c7ba5b8f80a55cac69931df06a2848339340d20a58900827856c63",
  "height": 5781227,
  "timestamp": 1709854037
}
```

### GetDifficulty

The [`getdifficulty` RPC](../api/rpc-blockchain.md#getdifficulty) returns the proof-of-work difficulty as a multiple of the minimum difficulty.

*Parameters: none*

*Result---the current difficulty*

Name | Type | Presence | Description
--- | --- | --- | ---
`result` | number (real) | Required<br>(exactly 1) | Returns the proof-of-work and proof-of-stake difficulties as a multiple of the minimum difficulty.

*Example from Dimecoin Core 2.3.0.0*

``` bash
dimecoin-cli -mainnet getdifficulty
```

Result:

``` text
  "proof-of-work": 7000.711921042552,
  "proof-of-stake": 13105918.85568522
```

*See also*

* [GetNetworkHashPS](../api/rpc-mining.md#getnetworkhashps): returns the estimated network hashes per second based on the last n blocks.
* [GetMiningInfo](../api/rpc-mining.md#getmininginfo): returns various mining-related information.

```{eval-rst}
.. _api-rpc-blockchain-getmempoolancestors:
```

### GetMemPoolAncestors

The [`getmempoolancestors` RPC](../api/rpc-blockchain.md#getmempoolancestors) returns all in-mempool ancestors for a transaction in the mempool.

*Parameter #1---a transaction identifier (TXID)*

Name | Type | Presence | Description
--- | --- | --- | ---
TXID | string (hex) | Required<br>(exactly 1) | The TXID of a transaction in the memory pool, encoded as hex in RPC byte order

*Parameter #2---desired output format*

Name | Type | Presence | Description
--- | --- | --- | ---
Format | bool | Optional<br>(0 or 1) | Set to `true` to get json objects describing each transaction in the memory pool; set to `false` (the default) to only get an array of TXIDs

*Result---list of ancestor transactions*

Name | Type | Presence | Description
--- | --- | --- | ---
`result` | array | Required<br>(exactly 1) | An array of TXIDs belonging to transactions in the memory pool.  The array may be empty if there are no transactions in the memory pool
→<br>TXID | string | Optional<br>(0 or more) | The TXID of a transaction in the memory pool, encoded as hex in RPC byte order

*Result (format: `true`)---a JSON object describing each transaction*

Name | Type | Presence | Description
--- | --- | --- | ---
`result` | object | Required<br>(exactly 1) | A object containing transactions currently in the memory pool.  May be empty
→<br>TXID | string : object | Optional<br>(0 or more) | The TXID of a transaction in the memory pool, encoded as hex in RPC byte order
→ →<br>`size` | numeric | Required<br>(exactly 1) | The size of the serialized transaction in bytes
→ →<br>`fee` | number (dimecoins) | Required<br>(exactly 1) | The transaction fee paid by the transaction in decimal dimecoins
→ →<br>`modifiedfee` | number (dimecoins) | Required<br>(exactly 1) | The transaction fee with fee deltas used for mining priority in decimal dimecoins
→ →<br>`time` | numeric | Required<br>(exactly 1) | The time the transaction entered the memory pool, Unix epoch time format
→ →<br>`height` | numeric | Required<br>(exactly 1) | The block height when the transaction entered the memory pool
→ →<br>`descendantcount` | numeric | Required<br>(exactly 1) | The number of in-mempool descendant transactions (including this one)
→ →<br>`descendantsize` | numeric | Required<br>(exactly 1) | The size of in-mempool descendants (including this one)
→ →<br>`descendantfees` | numeric | Required<br>(exactly 1) | The modified fees (see `modifiedfee` above) of in-mempool descendants (including this one)
→ →<br>`ancestorcount` | numeric | Required<br>(exactly 1) | The number of in-mempool ancestor transactions (including this one)
→ →<br>`ancestorsize` | numeric | Required<br>(exactly 1) | The size of in-mempool ancestors (including this one)
→ →<br>`ancestorfees` | numeric | Required<br>(exactly 1) | The modified fees (see `modifiedfee` above) of in-mempool ancestors (including this one)
→ →<br>`fees` | object | Optional<br>(0 or 1) | Object containing fee information
→→→<br>`base` | number | Optional<br>(0 or 1) | Transaction fee in DASH
→→→<br>`modified` | number | Optional<br>(0 or 1) | Transaction fee with fee deltas used for mining priority in DASH
→→→<br>`ancestor` | number | Optional<br>(0 or 1) | Modified fees (see above) of in-mempool ancestors (including this one) in DASH
→→→<br>`descendent` | number | Optional<br>(0 or 1) | Modified fees (see above) of in-mempool descendants (including this one) in DASH
→ →<br>`depends` | array | Required<br>(exactly 1) | An array holding TXIDs of unconfirmed transactions this transaction depends upon (parent transactions).  Those transactions must be part of a block before this transaction can be added to a block, although all transactions may be included in the same block.  The array may be empty
→ → →<br>Depends TXID | string | Optional (0 or more) | The TXIDs of any unconfirmed transactions this transaction depends upon, encoded as hex in RPC byte order
→ →<br>`spentby` | array | Required<br>(exactly 1) |  An array of unconfirmed transactions spending outputs from this transaction
→ → →<br>TXID | string | Optional (0 or more) | The TXIDs of any unconfirmed transactions spending from this transaction

*See also*

* [GetMemPoolDescendants](../api/rpc-blockchain.md#getmempooldescendants): returns all in-mempool descendants for a transaction in the mempool.
* [GetRawMemPool](../api/rpc-blockchain.md#getrawmempool): returns all transaction identifiers (TXIDs) in the memory pool as a JSON array, or detailed information about each transaction in the memory pool as a JSON object.

```{eval-rst}
.. _api-rpc-blockchain-getmempooldescendants:
```

### GetMemPoolDescendants

The [`getmempooldescendants` RPC](../api/rpc-blockchain.md#getmempooldescendants) returns all in-mempool descendants for a transaction in the mempool.

*Parameter #1---a transaction identifier (TXID)*

Name | Type | Presence | Description
--- | --- | --- | ---
TXID | string (hex) | Required<br>(exactly 1) | The TXID of a transaction in the memory pool, encoded as hex in RPC byte order

*Parameter #2---desired output format*

Name | Type | Presence | Description
--- | --- | --- | ---
Format | bool | Optional<br>(0 or 1) | Set to `true` to get json objects describing each transaction in the memory pool; set to `false` (the default) to only get an array of TXIDs

*Result---list of descendant transactions*

Name | Type | Presence | Description
--- | --- | --- | ---
`result` | array | Required<br>(exactly 1) | An array of TXIDs belonging to transactions in the memory pool.  The array may be empty if there are no transactions in the memory pool
→<br>TXID | string | Optional<br>(0 or more) | The TXID of a transaction in the memory pool, encoded as hex in RPC byte order

*Result (format: `true`)---a JSON object describing each transaction*

Name | Type | Presence | Description
--- | --- | --- | ---
`result` | object | Required<br>(exactly 1) | A object containing transactions currently in the memory pool.  May be empty
→<br>TXID | string : object | Optional<br>(0 or more) | The TXID of a transaction in the memory pool, encoded as hex in RPC byte order
→ →<br>`size` | numeric | Required<br>(exactly 1) | The size of the serialized transaction in bytes
→ →<br>`fee` | number (dimecoins) | Required<br>(exactly 1) | The transaction fee paid by the transaction in decimal dimecoins
→ →<br>`modifiedfee` | number (dimecoins) | Required<br>(exactly 1) | The transaction fee with fee deltas used for mining priority in decimal dimecoins
→ →<br>`time` | numeric | Required<br>(exactly 1) | The time the transaction entered the memory pool, Unix epoch time format
→ →<br>`height` | numeric | Required<br>(exactly 1) | The block height when the transaction entered the memory pool
→ →<br>`descendantcount` | numeric | Required<br>(exactly 1) | The number of in-mempool descendant transactions (including this one)
→ →<br>`descendantsize` | numeric | Required<br>(exactly 1) | The size of in-mempool descendants (including this one)
→ →<br>`descendantfees` | numeric | Required<br>(exactly 1) | The modified fees (see `modifiedfee` above) of in-mempool descendants (including this one)
→ →<br>`ancestorcount` | numeric | Required<br>(exactly 1) | The number of in-mempool ancestor transactions (including this one)
→ →<br>`ancestorsize` | numeric | Required<br>(exactly 1) | The size of in-mempool ancestors (including this one)
→ →<br>`ancestorfees` | numeric | Required<br>(exactly 1) | The modified fees (see `modifiedfee` above) of in-mempool ancestors (including this one)
→ →<br>`fees` | object | Optional<br>(0 or 1) | Object containing fee information
→→→<br>`base` | number | Optional<br>(0 or 1) | Transaction fee in DASH
→→→<br>`modified` | number | Optional<br>(0 or 1) | Transaction fee with fee deltas used for mining priority in DASH
→→→<br>`ancestor` | number | Optional<br>(0 or 1) | Modified fees (see above) of in-mempool ancestors (including this one) in DASH
→→→<br>`descendent` | number | Optional<br>(0 or 1) | Modified fees (see above) of in-mempool descendants (including this one) in DASH
→ →<br>`depends` | array | Required<br>(exactly 1) | An array holding TXIDs of unconfirmed transactions this transaction depends upon (parent transactions).  Those transactions must be part of a block before this transaction can be added to a block, although all transactions may be included in the same block.  The array may be empty
→ → →<br>Depends TXID | string | Optional (0 or more) | The TXIDs of any unconfirmed transactions this transaction depends upon, encoded as hex in RPC byte order
→ →<br>`spentby` | array | Required<br>(exactly 1) |  An array of unconfirmed transactions spending outputs from this transaction
→ → →<br>TXID | string | Optional (0 or more) | The TXIDs of any unconfirmed transactions spending from this transaction
→ →<br>`unbroadcast` | bool | Required<br>(exactly 1) | True if this transaction  is currently unbroadcast (initial broadcast not yet acknowledged by any peers)
→ →<br>`instantlock` | bool | Required<br>(exactly 1) | Set to `true` if this transaction was locked via InstantSend

*See also*

* [GetMemPoolAncestors](../api/rpc-blockchain.md#getmempoolancestors): returns all in-mempool ancestors for a transaction in the mempool.
* [GetRawMemPool](../api/rpc-blockchain.md#getrawmempool): returns all transaction identifiers (TXIDs) in the memory pool as a JSON array, or detailed information about each transaction in the memory pool as a JSON object.

```{eval-rst}
.. _api-rpc-blockchain-getmempoolentry:
```

### GetMemPoolEntry

The [`getmempoolentry` RPC](../api/rpc-blockchain.md#getmempoolentry) returns mempool data for given transaction (must be in mempool).

*Parameter #1---a transaction identifier (TXID)*

Name | Type | Presence | Description
--- | --- | --- | ---
TXID | string (hex) | Required<br>(exactly 1) | The TXID of a transaction in the memory pool, encoded as hex in RPC byte order

*Result ---a JSON object describing the transaction*

Name | Type | Presence | Description
--- | --- | --- | ---
`result` | object | Required<br>(exactly 1) | A object containing transactions currently in the memory pool.  May be empty
→<br>`vsize` | numeric | Required<br>(exactly 1) | The virtual transaction size. This can be different from actual serialized size for high-sigop transactions.
→<br>`fee` | number (dimecoins) | Required<br>(exactly 1) | The transaction fee paid by the transaction in decimal dimecoins
→<br>`modifiedfee` | number (dimecoins) | Required<br>(exactly 1) | <br><br>The transaction fee with fee deltas used for mining priority in decimal dimecoins
→<br>`time` | numeric | Required<br>(exactly 1) | The time the transaction entered the memory pool, Unix epoch time format
→<br>`height` | numeric | Required<br>(exactly 1) | The block height when the transaction entered the memory pool
→<br>`descendantcount` | numeric | Required<br>(exactly 1) | The number of in-mempool descendant transactions (including this one)
→<br>`descendantsize` | numeric | Required<br>(exactly 1) | The size of in-mempool descendants (including this one)
→<br>`descendantfees` | numeric | Required<br>(exactly 1) | The modified fees (see `modifiedfee` above) of in-mempool descendants (including this one)
→<br>`ancestorcount` | numeric | Required<br>(exactly 1) | The number of in-mempool ancestor transactions (including this one)
→<br>`ancestorsize` | numeric | Required<br>(exactly 1) | The size of in-mempool ancestors (including this one)
→<br>`ancestorfees` | numeric | Required<br>(exactly 1) | The modified fees (see `modifiedfee` above) of in-mempool ancestors (including this one)
→ →<br>`fees` | object | Optional<br>(0 or 1) | Object containing fee information
→→→<br>`base` | number | Optional<br>(0 or 1) | Transaction fee in DASH
→→→<br>`modified` | number | Optional<br>(0 or 1) | Transaction fee with fee deltas used for mining priority in DASH
→→→<br>`ancestor` | number | Optional<br>(0 or 1) | Modified fees (see above) of in-mempool ancestors (including this one) in DASH
→→→<br>`descendent` | number | Optional<br>(0 or 1) | Modified fees (see above) of in-mempool descendants (including this one) in DASH
→<br>`depends` | array | Required<br>(exactly 1) | An array holding TXIDs of unconfirmed transactions this transaction depends upon (parent transactions).  Those transactions must be part of a block before this transaction can be added to a block, although all transactions may be included in the same block.  The array may be empty
→ →<br>Depends TXID | string | Optional (0 or more) | The TXIDs of any unconfirmed transactions this transaction depends upon, encoded as hex in RPC byte order
→<br>`spentby` | array | Required<br>(exactly 1) |  An array of unconfirmed transactions spending outputs from this transaction
→ →<br>TXID | string | Optional (0 or more) | The TXIDs of any unconfirmed transactions spending from this transaction

*Example from Dimecoin Core 2.3.0.0*

``` bash
dimecoin-cli getmempoolentry 1c789d3697b0036af0176d0bed968d27dc72733310e406a37e08ec8f48883ff0
```

Result:

``` json
{
  "fees": {
    "base": 0.00229,
    "modified": 0.00229,
    "ancestor": 0.00229,
    "descendant": 0.00229
  },
  "size": 226,
  "fee": 0.00229,
  "modifiedfee": 0.00229,
  "time": 1709851154,
  "height": 5781142,
  "descendantcount": 1,
  "descendantsize": 226,
  "descendantfees": 229,
  "ancestorcount": 1,
  "ancestorsize": 226,
  "ancestorfees": 229,
  "wtxid": "1c789d3697b0036af0176d0bed968d27dc72733310e406a37e08ec8f48883ff0",
  "depends": [
  ],
  "spentby": [
  ]
}
```

*See also*

* [GetMemPoolAncestors](../api/rpc-blockchain.md#getmempoolancestors): returns all in-mempool ancestors for a transaction in the mempool.
* [GetMemPoolDescendants](../api/rpc-blockchain.md#getmempooldescendants): returns all in-mempool descendants for a transaction in the mempool.
* [GetRawMemPool](../api/rpc-blockchain.md#getrawmempool): returns all transaction identifiers (TXIDs) in the memory pool as a JSON array, or detailed information about each transaction in the memory pool as a JSON object.

### GetMemPoolInfo

The [`getmempoolinfo` RPC](../api/rpc-blockchain.md#getmempoolinfo) returns information about the node's current transaction memory pool.

*Parameters: none*

*Result---information about the transaction memory pool*

Name | Type | Presence | Description
--- | --- | --- | ---
`result` | object | Required<br>(exactly 1) | A object containing information about the memory pool
→<br>`size` | numeric | Required<br>(exactly 1) | The number of transactions currently in the memory pool
→<br>`bytes` | numeric | Required<br>(exactly 1) | The total number of bytes in the transactions in the memory pool
→<br>`usage` | numeric | Required<br>(exactly 1) | Total memory usage for the mempool in bytes
→<br>`maxmempool` | numeric | Required<br>(exactly 1) | Maximum memory usage for the mempool in bytes
→<br>`mempoolminfee` | number | Required<br>(exactly 1) | The lowest fee per kilobyte paid by any transaction in the memory pool
→<br>`mempoolminfee` | number | Required<br>(exactly 1) | Minimum fee rate in DASH/kB for tx to be accepted. Is the maximum of minrelaytxfee and minimum mempool fee
→<br>`minrelaytxfee` | numeric | Required<br>(exactly 1) | Current minimum relay fee for transactions

*Example from Dimecoin Core 2.3.0.0*

``` bash
dimecoin-cli -mainnet getmempoolinfo
```

Result:

``` json
{
  "size": 0,
  "bytes": 0,
  "usage": 96,
  "maxmempool": 300000000,
  "mempoolminfee": 0.01000,
  "minrelaytxfee": 0.01000
}
```

*See also*

* [GetBlockChainInfo](../api/rpc-blockchain.md#getblockchaininfo): provides information about the current state of the blockchain.
* [GetRawMemPool](../api/rpc-blockchain.md#getrawmempool): returns all transaction identifiers (TXIDs) in the memory pool as a JSON array, or detailed information about each transaction in the memory pool as a JSON object.
* [GetTxOutSetInfo](../api/rpc-blockchain.md#gettxoutsetinfo): returns statistics about the confirmed unspent transaction output (UTXO) set. Note that this call may take some time and that it only counts outputs from confirmed transactions---it does not count outputs from the memory pool.

```{eval-rst}
.. _api-rpc-blockchain-getrawmempool:
```

### GetRawMemPool

The [`getrawmempool` RPC](../api/rpc-blockchain.md#getrawmempool) returns all transaction identifiers (TXIDs) in the memory pool as a JSON array, or detailed information about each transaction in the memory pool as a JSON object.

*Parameter---desired output format*

Name | Type | Presence | Description
--- | --- | --- | ---
Format | bool | Optional<br>(0 or 1) | Set to `true` to get verbose output describing each transaction in the memory pool; set to `false` (the default) to only get an array of TXIDs for transactions in the memory pool

*Result (format `false`)---an array of TXIDs*

Name | Type | Presence | Description
--- | --- | --- | ---
`result` | array | Required<br>(exactly 1) | An array of TXIDs belonging to transactions in the memory pool.  The array may be empty if there are no transactions in the memory pool
→<br>TXID | string | Optional<br>(0 or more) | The TXID of a transaction in the memory pool, encoded as hex in RPC byte order

*Result (format: `true`)---a JSON object describing each transaction*

Name | Type | Presence | Description
--- | --- | --- | ---
`result` | object | Required<br>(exactly 1) | A object containing transactions currently in the memory pool.  May be empty
→<br>TXID | string : object | Optional<br>(0 or more) | The TXID of a transaction in the memory pool, encoded as hex in RPC byte order
→ →<br>`size` | numeric | Required<br>(exactly 1) | The size of the serialized transaction in bytes
→ →<br>`fee` | amount (DIME) | Required<br>(exactly 1) | The transaction fee paid by the transaction in decimal Dash
→ →<br>`modifiedfee` | amount (DIME) | Required<br>(exactly 1) | The transaction fee with fee deltas used for mining priority in decimal Dash
→ →<br>`time` | numeric | Required<br>(exactly 1) | The time the transaction entered the memory pool, Unix epoch time format
→ →<br>`height` | numeric | Required<br>(exactly 1) | The block height when the transaction entered the memory pool
→ →<br>`descendantcount` | numeric | Required<br>(exactly 1) | The number of in-mempool descendant transactions (including this one)
→ →<br>`descendantsize` | numeric | Required<br>(exactly 1) | The size of in-mempool descendants (including this one)
→ →<br>`descendantfees` | numeric | Required<br>(exactly 1) | The modified fees (see `modifiedfee` above) of in-mempool descendants (including this one)
→ →<br>`ancestorcount` | numeric | Required<br>(exactly 1) | The number of in-mempool ancestor transactions (including this one)
→ →<br>`ancestorsize` | numeric | Required<br>(exactly 1) | The size of in-mempool ancestors (including this one)
→ →<br>`ancestorfees` | numeric | Required<br>(exactly 1) | The modified fees (see `modifiedfee` above) of in-mempool ancestors (including this one)
→ →<br>`fees` | object | Optional<br>(0 or 1) | Object containing fee information
→→→<br>`base` | number | Optional<br>(0 or 1) | Transaction fee in DASH
→→→<br>`modified` | number | Optional<br>(0 or 1) | Transaction fee with fee deltas used for mining priority in DASH
→→→<br>`ancestor` | number | Optional<br>(0 or 1) | Modified fees (see above) of in-mempool ancestors (including this one) in DASH
→→→<br>`descendent` | number | Optional<br>(0 or 1) | Modified fees (see above) of in-mempool descendants (including this one) in DASH
→ →<br>`depends` | array | Required<br>(exactly 1) | An array holding TXIDs of unconfirmed transactions this transaction depends upon (parent transactions).  Those transactions must be part of a block before this transaction can be added to a block, although all transactions may be included in the same block.  The array may be empty
→ → →<br>Depends TXID | string | Optional (0 or more) | The TXIDs of any unconfirmed transactions this transaction depends upon, encoded as hex in RPC byte order
→ →<br>`spentby` | array | Required<br>(exactly 1) | An array of unconfirmed transactions spending outputs from this transaction
→ → →<br>TXID | string | Optional (0 or more) | The TXIDs of any unconfirmed transactions spending from this transaction

*Examples from Dimecoin Core 2.3.0.0*

The default (`false`):

``` bash
dimecoin-cli getrawmempool
```

Result:

``` json
[
  "84e0bb9b5efecb46dec47d7e22d91f7bab6c4231acdbe165f8bc85d74d526067"
]
```

Verbose output (`true`):

``` bash
dimecoin-cli getrawmempool true
```

Result:

``` json
{
  "84e0bb9b5efecb46dec47d7e22d91f7bab6c4231acdbe165f8bc85d74d526067": {
    "fees": {
      "base": 0.00229,
      "modified": 0.00229,
      "ancestor": 0.00229,
      "descendant": 0.00229
    },
    "size": 227,
    "fee": 0.00229,
    "modifiedfee": 0.00229,
    "time": 1709851395,
    "height": 5781148,
    "descendantcount": 1,
    "descendantsize": 227,
    "descendantfees": 229,
    "ancestorcount": 1,
    "ancestorsize": 227,
    "ancestorfees": 229,
    "wtxid": "84e0bb9b5efecb46dec47d7e22d91f7bab6c4231acdbe165f8bc85d74d526067",
    "depends": [
    ],
    "spentby": [
    ]
  }
}
```

*See also*

* [GetMemPoolInfo](../api/rpc-blockchain.md#getmempoolinfo): returns information about the node's current transaction memory pool.
* [GetMemPoolEntry](../api/rpc-blockchain.md#getmempoolentry): returns mempool data for given transaction (must be in mempool).
* [GetTxOutSetInfo](../api/rpc-blockchain.md#gettxoutsetinfo): returns statistics about the confirmed unspent transaction output (UTXO) set. Note that this call may take some time and that it only counts outputs from confirmed transactions---it does not count outputs from the memory pool.

### GetTxOut

The [`gettxout` RPC](../api/rpc-blockchain.md#gettxout) returns details about an unspent transaction output (UTXO).

*Parameter #1---the TXID of the output to get*

Name | Type | Presence | Description
--- | --- | --- | ---
TXID | string (hex) | Required<br>(exactly 1) | The TXID of the transaction containing the output to get, encoded as hex in RPC byte order

*Parameter #2---the output index number (vout) of the output to get*

Name | Type | Presence | Description
--- | --- | --- | ---
Vout | numeric | Required<br>(exactly 1) | The output index number (vout) of the output within the transaction; the first output in a transaction is vout 0

*Parameter #3---whether to display unconfirmed outputs from the memory pool*

Name | Type | Presence | Description
--- | --- | --- | ---
Unconfirmed | bool | Optional<br>(0 or 1) | Set to `true` to display unconfirmed outputs from the memory pool; set to `false` (the default) to only display outputs from confirmed transactions

*Result---a description of the output*

Name | Type | Presence | Description
--- | --- | --- | ---
`result` | object/null | Required<br>(exactly 1) | Information about the output.  If output wasn't found, if it was spent, or if an error occurred, this will be JSON `null`
→<br>`bestblock` | string (hex) | Required<br>(exactly 1) | The hash of the header of the block on the local best blockchain which includes this transaction.  The hash will encoded as hex in RPC byte order.  If the transaction is not part of a block, the string will be empty
→<br>`confirmations` | numeric | Required<br>(exactly 1) | The number of confirmations received for the transaction containing this output or `0` if the transaction hasn't been confirmed yet
→<br>`value` | number (DIME) | Required<br>(exactly 1) | The amount of Dash spent to this output.  May be `0`
→<br>`scriptPubKey` | string : object | Optional<br>(0 or 1) | An object with information about the pubkey script.  This may be `null` if there was no pubkey script
→ →<br>`asm` | string | Required<br>(exactly 1) | The pubkey script in decoded form with non-data-pushing opcodes listed
→ →<br>`hex` | string (hex) | Required<br>(exactly 1) | The pubkey script encoded as hex
→ →<br>`reqSigs` | numeric | Optional<br>(0 or 1) | The number of signatures required; this is always `1` for P2PK, P2PKH, and P2SH (including P2SH multisig because the redeem script is not available in the pubkey script).  It may be greater than 1 for bare multisig.  This value will not be returned for `nulldata` or `nonstandard` script types (see the `type` key below)
→ →<br>`type` | string | Optional<br>(0 or 1) | The type of script.  This will be one of the following:<br>• `pubkey` for a P2PK script<br>• `pubkeyhash` for a P2PKH script<br>• `scripthash` for a P2SH script<br>• `multisig` for a bare multisig script<br>• `nulldata` for nulldata scripts<br>• `nonstandard` for unknown scripts
→ →<br>`addresses` | string : array | Optional<br>(0 or 1) | The P2PKH or P2SH addresses used in this transaction, or the computed P2PKH address of any pubkeys in this transaction.  This array will not be returned for `nulldata` or `nonstandard` script types
→ → →<br>Address | string | Required<br>(1 or more) | A P2PKH or P2SH address
→<br>`coinbase` | bool | Required<br>(exactly 1) | Set to `true` if the transaction output belonged to a coinbase transaction; set to `false` for all other transactions.  Coinbase transactions need to have 101 confirmations before their outputs can be spent

*Example from Dimecoin Core 2.3.0.0*

Get the UTXO from the following transaction from the first output index ("0"),
searching the memory pool if necessary.

``` bash
dimecoin-cli -mainnet gettxout \
  84e0bb9b5efecb46dec47d7e22d91f7bab6c4231acdbe165f8bc85d74d526067 \
  0 true
```

Result:

``` json
{
  "bestblock": "000000000006301e8b1988fe5b4f58a6e1cc12122d12c4a9cadfdb8651d83972",
  "confirmations": 13,
  "value": 1.00000,
  "scriptPubKey": {
    "asm": "OP_DUP OP_HASH160 b5e9ccdf17eb279fbb44394894ce43eced5af051 OP_EQUALVERIFY OP_CHECKSIG",
    "hex": "76a914b5e9ccdf17eb279fbb44394894ce43eced5af05188ac",
    "reqSigs": 1,
    "type": "pubkeyhash",
    "addresses": [
      "7KevA5YQSyWMAykzFWPuPEXJk1bxUwXxaY"
    ]
  },
  "coinbase": false
}
```

*See also*

* [GetRawTransaction](../api/rpc-raw-transactions.md#getrawtransaction): gets a hex-encoded serialized transaction or a JSON object describing the transaction. By default, Dimecoin Core only stores complete transaction data for UTXOs and your own transactions, so the RPC may fail on historic transactions unless you use the non-default `txindex=1` in your Dimecoin Core startup settings.
* [GetTransaction](../api/rpc-wallet.md#gettransaction): gets detailed information about an in-wallet transaction.

### GetTxOutProof

The [`gettxoutproof` RPC](../api/rpc-blockchain.md#gettxoutproof) returns a hex-encoded proof that one or more specified transactions were included in a block.

**NOTE:**
By default this function only works when there is an
unspent output in the UTXO set for this transaction. To make it always work,
you need to maintain a transaction index, using the `-txindex` command line option, or specify the block in which the transaction is included in manually (by block header hash).

*Parameter #1---the transaction hashes to prove*

Name | Type | Presence | Description
--- | --- | --- | ---
TXIDs | array | Required<br>(exactly 1) | A JSON array of txids to filter
→<br>`txid` | string | Required<br>(1 or more) | TXIDs of the transactions to generate proof for.  All transactions must be in the same block

*Parameter #2---the block to look for txids in*

Name | Type | Presence | Description
--- | --- | --- | ---
Header hash | string | Optional<br>(0 or 1) | If specified, looks for txid in the block with this hash

*Result---serialized, hex-encoded data for the proof*

Name | Type | Presence | Description
--- | --- | --- | ---
`result` | string | Required<br>(exactly 1) | A string that is a serialized, hex-encoded data for the proof

*See also*

* [VerifyTxOutProof](../api/rpc-blockchain.md#verifytxoutproof): verifies that a proof points to one or more transactions in a block, returning the transactions the proof commits to and throwing an RPC error if the block is not in our best blockchain.
* [`merkleblock` message](../reference/p2p-network-data-messages.md#merkleblock): A description of the
  format used for the proof.

### GetTxOutSetInfo

The [`gettxoutsetinfo` RPC](../api/rpc-blockchain.md#gettxoutsetinfo) returns statistics about the confirmed unspent transaction output (UTXO) set. Note that this call may take some time and that it only counts outputs from confirmed transactions---it does not count outputs from the memory pool.

*Parameter #1---Selecting UTXO set hash*

Name | Type | Presence | Description
--- | --- | --- | ---
hash_type | string | Optional<br>(0 or 1) | Which UTXO set hash should be calculated. Options: 'hash_serialized_2' (the legacy algorithm), 'muhash', 'none'.

*Result---statistics about the UTXO set*

Name | Type | Presence | Description
--- | --- | --- | ---
`result` | object | Required<br>(exactly 1) | Information about the UTXO set
→<br>`height` | numeric | Required<br>(exactly 1) | The height of the local best blockchain.  A new node with only the hardcoded genesis block will have a height of 0
→<br>`bestblock` | string (hex) | Required<br>(exactly 1) | The hash of the header of the highest block on the local best blockchain, encoded as hex in RPC byte order
→<br>`transactions` | numeric | Required<br>(exactly 1) | The number of transactions with unspent outputs
→<br>`txouts` | numeric | Required<br>(exactly 1) | The number of unspent transaction outputs
→<br>`bogosize` | numeric | Required<br>(exactly 1) | A meaningless metric for UTXO set size
→<br>`hash_serialized_2` | string (hex) | Optional<br>(exactly 1) |  The serialized hash (only present if 'hash_serialized_2' hash_type is chosen)
→<br>`muhash` | string (hex) | Optional<br>(exactly 1) | A SHA256(SHA256()) The serialized hash (only present if 'muhash' hash_type is chosen).
→<br>`disk_size` | numeric | Required<br>(exactly 1) | The estimated size of the chainstate on disk
→<br>`total_amount` | number (DIME) | Required<br>(exactly 1) | The total amount of Dash in the UTXO set

*Example from Dimecoin Core 2.3.0.0*

``` bash
dimecoin-cli -mainnet gettxoutsetinfo
```

Result:

``` json
{
  "height": 5781164,
  "bestblock": "aa7bdea3fe13f67cbba62aba234e67546616388016c814b16126a936b3769c89",
  "transactions": 1531789,
  "txouts": 4276648,
  "bogosize": 331329636,
  "hash_serialized_2": "4f053895de62e311f7e296fced27697650030307432c0b1b48276729213defda",
  "disk_size": 236850664,
  "total_amount": 3117947018953.76811
}
```

*See also*

* [GetBlockChainInfo](../api/rpc-blockchain.md#getblockchaininfo): provides information about the current state of the blockchain.
* [GetMemPoolInfo](../api/rpc-blockchain.md#getmempoolinfo): returns information about the node's current transaction memory pool.

### PreciousBlock

The [`preciousblock` RPC](../api/rpc-blockchain.md#preciousblock) treats a block as if it were received before others with the same work. A later `preciousblock` call can override the effect of an earlier one. The effects of `preciousblock` are not retained across restarts.

*Parameter #1---the block hash*

Name | Type | Presence | Description
--- | --- | --- | ---
Header Hash | string (hex) | Required<br>(exactly 1) | The hash of the block to mark as precious

*Result---`null` or error on failure*

Name | Type | Presence | Description
--- | --- | --- | ---
`result` | null | Required<br>(exactly 1) | JSON `null`.  The JSON-RPC error field will be set only if you entered an invalid block hash

### SaveMemPool

The [`savemempool` RPC](../api/rpc-blockchain.md#savemempool) dumps the mempool to disk.

*Parameters: none*

*Example from Dimecoin Core 2.3.0.0*

``` bash
dimecoin-cli savemempool
```

Result (no output from dimecoin-cli, returns `null`).

### VerifyChain

The [`verifychain` RPC](../api/rpc-blockchain.md#verifychain) verifies each entry in the local blockchain database.

*Parameter #1---how thoroughly to check each block*

Name | Type | Presence | Description
--- | --- | --- | ---
Check Level | numeric | Optional<br>(0 or 1) | How thoroughly to check each block, from 0 to 4.  Default is the level set with the `-checklevel` command line argument; if that isn't set, the default is `3`.  Each higher level includes the tests from the lower levels<br><br>Levels are:<br>**0.** Read from disk to ensure the files are accessible<br>**1.**  Ensure each block is valid<br>**2.** Make sure undo files can be read from disk and are in a valid format<br>**3.** Test each block undo to ensure it results in correct state<br>**4.** After undoing blocks, reconnect them to ensure they reconnect correctly

*Parameter #2---the number of blocks to check*

Name | Type | Presence | Description
--- | --- | --- | ---
Number Of Blocks | numeric | Optional<br>(0 or 1) | The number of blocks to verify.  Set to `0` to check all blocks.  Defaults to the value of the `-checkblocks` command-line argument; if that isn't set, the default is `288`

*Result---verification results*

Name | Type | Presence | Description
--- | --- | --- | ---
`result` | bool | Required<br>(exactly 1) | Set to `true` if verified; set to `false` if verification failed for any reason

*Example from Dimecoin Core 2.3.0.0*

Verify the most recent 1000 blocks using the most detailed check:

``` bash
dimecoin-cli -mainnet verifychain 4 1000
```

A window will pop up as it scans the blocks. When done the result should display as follows:

Result ():

``` json
true
```

*See also*

* [GetBlockChainInfo](../api/rpc-blockchain.md#getblockchaininfo): provides information about the current state of the blockchain.
* [GetTxOutSetInfo](../api/rpc-blockchain.md#gettxoutsetinfo): returns statistics about the confirmed unspent transaction output (UTXO) set. Note that this call may take some time and that it only counts outputs from confirmed transactions---it does not count outputs from the memory pool.

### VerifyTxOutProof

The [`verifytxoutproof` RPC](../api/rpc-blockchain.md#verifytxoutproof) confirms if a proof corresponds to one or more transactions within a block, detailing the transactions tied to the proof. An RPC error is raised if the block isn't part of the main blockchain.

*Parameter #1---The hex-encoded proof generated by gettxoutproof*

Name | Type | Presence | Description
--- | --- | --- | ---
`proof` | string | Required | A hex-encoded proof

*Result---txid(s) which the proof commits to*

Name | Type | Presence | Description
--- | --- | --- | ---
`result` | string | Required<br>(exactly 1) | The txid(s) which the proof commits to, or empty array if the proof cannot be validated

*Example from Dimecoin Core 2.3.0.0*

Verify a proof:

``` bash
dimecoin-cli verifytxoutproof \                                         
01000020789ace9b0a2b3c4d5e6f70819293a4b5c6d7e8f9000112233445566778899aab\
bccddeeff00112233445566778899aabbccddeeff00112233445566778899aa00000000
```

Result:

``` json
[
"243ceb732dae2a027d94b046bf7e9861295863bf575d7e2f482fbd122a719e9c"
]
```

*See also*

* [GetTxOutProof](../api/rpc-blockchain.md#gettxoutproof): returns a hex-encoded proof that one or more specified transactions were included in a block.
* [`merkleblock` message](../reference/p2p-network-data-messages.md#merkleblock): A description of the format used for the proof.

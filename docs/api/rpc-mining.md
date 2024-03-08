```{eval-rst}
.. _api-rpc-mining:
.. meta::
  :title: Mining RPCs
  :description: A list of remote procedure calls for mining in Dimecoin.
```
> ***We put our best effort into covering all topics related to Dimecoin. Each section will cover a different category. Not all documentation may be 100% accurate, if you spot an error, please report it or submit a PR request on GitHub.***
>
> ***REMINDER: This documentation is always evolving. If you have not been here for a while, perhaps check again. Things may have been added or updated since your last visit!***

### Mining RPCs

#### GetBlockTemplate

The [`getblocktemplate` RPC](../api/rpc-mining.md##getblocktemplate) gets a block template or proposal for use with mining software. For more
information, please see the following resources:

* [Bitcoin Wiki GetBlockTemplate](https://en.bitcoin.it/wiki/Getblocktemplate)
* [BIP22](https://github.com/bitcoin/bips/blob/master/bip-0022.mediawiki)
* [BIP23](https://github.com/bitcoin/bips/blob/master/bip-0023.mediawiki)

*Parameter #1---a JSON request object*

Name | Type | Presence | Description
--- | --- | --- | ---
Request | object | Optional<br>(exactly 1) | A JSON request object
→<br>`mode` | string | Optional<br>(exactly 1) | This must be set to \template\" or omitted"
→<br>`capabilities` | array (string) | Optional<br>(0 or more) | A list of strings
→ →<br>Capability | string | Optional<br>(exactly 1) | Client side supported feature, `longpoll`, `coinbasetxn`, `coinbasevalue`, `proposal`, `serverlist`, `workid`
→<br>`rules` | array (string) | Optional<br>(0 or more) | A list of strings
→ →<br>Rules | string | Optional<br>(exactly 1) | Client side supported softfork deployment, `csv`, `dip0001`, etc.

*Result---block template*

Name | Type | Presence | Description
--- | --- | --- | ---
`result` | object | Required<br>(exactly 1) | A object containing a block template
→<br>`capabilities` | array (string) | Required<br>(1 or more) | The client side supported features
→ →<br>Capability | string | Optional<br>(0 or more) | A client side supported feature
→<br>`version` | number (int) | Required<br>(exactly 1) | The block version
→<br>`rules` | array (string) | Required<br>(1 or more) | The specific block rules that are to be enforced
→ →<br>Block Rule | string | Optional<br>(0 or more) | A specific block rule to be enforced
→<br>`vbavailable` | object | Required<br>(exactly 1) | Contains the set of pending, supported versionbit (BIP 9) softfork deployments
→ →<br>Bit Number | number | Required<br>(0 or more) | The bit number the named softfork rule
→<br>`vbrequired` | number | Required<br>(exactly 1) | The bit mask of versionbits the server requires set in submissions
→<br>`previousblockhash` | string (hex) | Required<br>(exactly 1) | The hash of current highest block
→<br>`transactions` | array (objects) | Optional<br>(0 or more) | Non-coinbase transactions to be included in the next block
→ →<br>Transaction | object | Optional<br>(0 or more) | Non-coinbase transaction
→ → →<br>`data` | string (hex) | Optional<br>(0 or more) | Transaction data encoded in hex (byte-for-byte)
→ → →<br>`hash` | string (hex) | Optional<br>(0 or more) | The hash/id encoded in little-endian hex
→ → →<br>`depends` | array (numbers) | Required<br>(0 or more) | An array holding TXIDs of unconfirmed transactions this TX depends upon (parent transactions).
→ → → →<br>Transaction number | number | Optional<br>(1 or more) | Transactions before this one (by 1-based index in `transactions` list) that must be present in the final block if this one is
→ → →<br>`fee` | number | Required<br>(exactly 1) | The difference in value between transaction inputs and outputs (in dimecoins). For coinbase transactions, this is a negative number of the total collected block fees (ie., not including the block subsidy); if key is not present, fee is unknown and clients MUST NOT assume there isn't one
→ → →<br>`sigops` | number | Required<br>(exactly 1) | Total SigOps. If not present, the count is unknown (clients MUST NOT assume there aren't any)
→<br>`coinbaseaux` | object | Required<br>(exactly 1) | A object containing data that should be included in the coinbase scriptSig content
→<br>`coinbasevalue` | number | Required<br>(exactly 1) | The maximum allowable input to coinbase transaction, including the generation award and transaction fees (in dimecoins)
→<br>`coinbasetxn` | object | Required<br>(exactly 1) |
→<br>`target` | string | Required<br>(exactly 1) | The hash target
→<br>`mintime` | number | Required<br>(exactly 1) | The minimum timestamp appropriate for next block time in seconds since epoch
→<br>`mutable` | array (string) | Required<br>(exactly 1) | The list of ways the block template may be changed
→ →<br>Value | string | Required<br>(0 or more) | A way the block template may be changed, e.g. 'time', 'transactions', 'prevblock'
→<br>`noncerange` | string | Required<br>(exactly 1) | A range of valid nonces
→<br>`sigoplimit` | number | Required<br>(exactly 1) | The limit of sigops in blocks
→<br>`sizelimit` | number | Required<br>(exactly 1) | The limit of block size
→<br>`curtime` | number | Required<br>(exactly 1) | The current timestamp in seconds since epoch
→<br>`bits` | string | Required<br>(exactly 1) | The compressed target of next block
→<br>`previousbits` | string | Required<br>(exactly 1) | The compressed target of  the current highest block
→<br>`height` | number | Required<br>(exactly 1) | The height of the next block
→<br>`masternode` | array (objects) | Required<br>(0 or more) | Required masternode payments that must be included in the next block
→ →<br>Masternode Payee | object | Optional<br>(0 or more) | Object containing a masternode payee's information  
→ → →<br>`payee` | string | Required<br>(exactly 1) | Payee address
→ → →<br>`script` | string | Required<br>(exactly 1) | Payee scriptPubKey
→ → →<br>`amount` | number | Required<br>(exactly 1) | Required amount to pay
→<br>`masternode_payments_started` | boolean | Required<br>(exactly 1) | True if masternode payments started
→<br>`masternode_payments_enforced` | boolean | Required<br>(exactly 1) | True if masternode payments enforced

*Example from Dimecoin Core 2.3.0.0*

```bash
dimecoin-cli -mainnet getblocktemplate
```
Result:

```json
{
  "capabilities": [
    "proposal"
  ],
  "version": 536870912,
  "rules": [
  ],
  "vbavailable": {
  },
  "vbrequired": 0,
  "previousblockhash": "00000000000a042c4806b6cae473b2c07afcf572b5906b2911c9deb6ae95fb3c",
  "transactions": [
  ],
  "coinbaseaux": {
    "flags": ""
  },
  "coinbasevalue": 1355700000,
  "longpollid": "00000000000a042c4806b6cae473b2c07afcf572b5906b2911c9deb6ae95fb3c5782997",
  "target": "00000000000f3f86000000000000000000000000000000000000000000000000",
  "mintime": 1709932218,
  "mutable": [
    "time",
    "transactions",
    "prevblock"
  ],
  "noncerange": "00000000ffffffff",
  "sigoplimit": 20000,
  "sizelimit": 1000000,
  "curtime": 1709932679,
  "bits": "1b0f3f86",
  "height": 5782847,
  "masternode": [
    {
      "payee": "7BBVpSS7roduwe2ruiRLS1MGHG51ePikpu",
      "script": "76a91458f93f060d23eca36d8a5b30a3961d7262fc16e088ac",
      "amount": 610065000
    }
  ],
  "masternode_payments_started": false,
  "masternode_payments_enforced": false
}
```
*See also*

* [GetMiningInfo](../api/rpc-mining.md##getmininginfo): returns various mining-related information.
* [SubmitBlock](../api/rpc-mining.md##submitblock): accepts a block, verifies it is a valid addition to the blockchain, and broadcasts it to the network. Extra parameters are ignored by Dimecoin Core but may be used by mining pools or other programs.
* [PrioritiseTransaction](../api/rpc-mining.md##prioritisetransaction): adds virtual priority or fee to a transaction, allowing it to be accepted into blocks mined by this node (or miners which use this node) with a lower priority or fee. (It can also remove virtual priority or fee, requiring the transaction have a higher priority or fee to be accepted into a locally-mined block.)

#### GetMiningInfo

The [`getmininginfo` RPC](../api/rpc-mining.md##getmininginfo) returns various mining-related information.

*Parameters: none*

*Result---various mining-related information*

Name | Type | Presence | Description
--- | --- | --- | ---
`result` | object | Required<br>(exactly 1) | Various mining-related information
→<br>`blocks` | number (int) | Required<br>(exactly 1) | The height of the highest block on the local best blockchain
→<br>`currentblocksize` | number (int) | Optional<br>(0 or 1) | If generation was enabled since the last time this node was restarted, this is the size in bytes of the last block built by this node for header hash checking.
→<br>`currentblocktx` | number (int) | Optional<br>(0 or 1) | If generation was enabled since the last time this node was restarted, this is the number of transactions in the last block built by this node for header hash checking.
→<br>`difficulty` | number (real) | Required<br>(exactly 1) | If generation was enabled since the last time this node was restarted, this is the difficulty of the highest-height block in the local best blockchain.  Otherwise, this is the value `0`
→<br>`networkhashps` | number (int) | Required<br>(exactly 1) | An estimate of the number of hashes per second the network is generating to maintain the current difficulty.  See the [`getnetworkhashps` RPC](../api/rpc-mining.md##getnetworkhashps) for configurable access to this data
→<br>`pooledtx` | number (int) | Required<br>(exactly 1) | The number of transactions in the memory pool
→<br>`chain` | string | Required<br>(exactly 1) | Set to `main` for mainnet, `test` for testnet, and `regtest` for regtest
→<br>`warnings` | string | Required<br>(exactly 1) | Any network or blockchain warnings
→<br>`errors` | string | Optional<br>(0 or 1) | Only shown when dimecoind is started with `getmininginfo`

*Example from Dimecoin Core 2.3.0.0*

```bash
dimecoin-cli getmininginfo
```
Result:

```json
{
  "blocks": 5782848,
  "currentblockweight": 4000,
  "currentblocktx": 0,
  "difficulty": {
    "proof-of-work": 3234.210187053827,
    "proof-of-stake": 201952203.5483864
  },
  "networkhashps": 435726190377064.9,
  "pooledtx": 0,
  "chain": "main",
  "warnings": ""
}
```
*See also*

* [GetMemPoolInfo](../api/rpc-blockchain.md##getmempoolinfo): returns information about the node's current transaction memory pool.
* [GetRawMemPool](../api/rpc-blockchain.md##getrawmempool): returns all transaction identifiers (TXIDs) in the memory pool as a JSON array, or detailed information about each transaction in the memory pool as a JSON object.
* [GetBlockTemplate](../api/rpc-mining.md##getblocktemplate): gets a block template or proposal for use with mining software.

#### GetNetworkHashPS

The [`getnetworkhashps` RPC](../api/rpc-mining.md##getnetworkhashps) returns the estimated network hashes per second based on the last n blocks.

*Parameter #1---number of blocks to average*

Name | Type | Presence | Description
--- | --- | --- | ---
`blocks` | number (int) | Optional<br>(0 or 1) | The number of blocks to average together for calculating the estimated hashes per second.  Default is `120`.  Use `-1` to average all blocks produced since the last difficulty change

*Parameter #2---block height*

Name | Type | Presence | Description
--- | --- | --- | ---
`height` | number (int) | Optional<br>(0 or 1) | The height of the last block to use for calculating the average.  Defaults to `-1` for the highest-height block on the local best blockchain.  If the specified height is higher than the highest block on the local best blockchain, it will be interpreted the same as `-1`

*Result---estimated hashes per second*

Name | Type | Presence | Description
--- | --- | --- | ---
`result` | number (int) | Required<br>(exactly 1) | The estimated number of hashes per second based on the parameters provided.  May be 0 (for Height=`0`, the genesis block) or a negative value if the highest-height block averaged has a block header time earlier than the lowest-height block averaged

*Example from Dimecoin Core 2.3.0.0*

Get the average hashes per second for all the blocks since the last
difficulty change before block 4000.

```bash
dimecoin-cli -mainnet getnetworkhashps -1 4000
```
Result:

```text
938189.1678726483
```
*See also*

* [GetDifficulty](../api/rpc-blockchain.md##getdifficulty): returns the proof-of-work and proof-of-stake difficulties as a multiple of the minimum difficulty.
* [GetBlock](../api/rpc-blockchain.md##getblock): gets a block with a particular header hash from the local block database either as a JSON object or as a serialized block.

#### PrioritiseTransaction

The [`prioritisetransaction` RPC](../api/rpc-mining.md##prioritisetransaction) adds virtual priority or fee to a transaction, allowing it to be accepted into blocks mined by this node (or miners which use this node) with a lower priority or fee. (It can also remove virtual priority or fee, requiring the transaction have a higher priority or fee to be accepted into a locally-mined block.)

*Parameter #1---the TXID of the transaction to modify*

Name | Type | Presence | Description
--- | --- | --- | ---
TXID | string | Required<br>(exactly 1) | The TXID of the transaction whose virtual priority or fee you want to modify, encoded as hex in RPC byte order

*Parameter #2---the change to make to the virtual fee*

Name | Type | Presence | Description
--- | --- | --- | ---
Fee | number (int) | Required<br>(exactly 1) | **Warning:** this value is in mDIME, not DIME<br><br>If positive, the virtual fee to add to the actual fee paid by the transaction; if negative, the virtual fee to subtract from the actual fee paid by the transaction.  No change is made to the actual fee paid by the transaction

*Result---`true` if the priority is changed*

Name | Type | Presence | Description
--- | --- | --- | ---
`result` | bool (true only) | Required<br>(exactly 1) | Always set to `true` if all three parameters are provided.  Will not return an error if the TXID is not in the memory pool.  If fewer or more than three arguments are provided, or if something goes wrong, will be set to `null`

*See also*

* [GetRawMemPool](../api/rpc-blockchain.md##getrawmempool): returns all transaction identifiers (TXIDs) in the memory pool as a JSON array, or detailed information about each transaction in the memory pool as a JSON object.
* [GetBlockTemplate](../api/rpc-mining.md##getblocktemplate): gets a block template or proposal for use with mining software.

#### SubmitBlock

The [`submitblock` RPC](../api/rpc-mining.md##submitblock) accepts a block, verifies it is a valid addition to the blockchain, and broadcasts it to the network. Extra parameters are ignored by Dimecoin Core but may be used by mining pools or other programs.

*Parameter #1---the new block in serialized block format as hex*

Name | Type | Presence | Description
--- | --- | --- | ---
Block | string (hex) | Required<br>(exactly 1) | The full block to submit in serialized block format as hex

*Parameter #2---dummy value*

Name | Type | Presence | Description
--- | --- | --- | ---
`dummy` | object | Optional<br>(0 or 1) | A dummy value for compatibility with BIP22. This value is ignored.

*Result---`null` or error string*

Name | Type | Presence | Description
--- | --- | --- | ---
`result` | null/string | Required<br>(exactly 1) | If the block submission succeeded, set to JSON `null`.  If submission failed, set to one of the following strings: `duplicate`, `duplicate-invalid`, `inconclusive`, or `rejected`.  The JSON-RPC `error` field will still be set to `null` if submission failed for one of these reasons

*Example from Dimecoin Core 2.3.0.0*

Submit the following block with the a dummy value, "test".

```bash                                                                         
dimecoin-cli -mainnet submitblock 01000000010000000000000000000000000000000000000\
000000000000000000000000000ffffffff2103423d58047a81eb650881008e81806400005468\
65426565506f6f6c2e636f6d00000000000208ddce00000000001976a914b153550dd81025c35\
42d95d0a744ccb2408d809488ac187aff4f000000001976a91446cb8dd813962ea615d115a445\
5d23179fe7c80688ac00000000\
  "test"
```

Result (the block above was already on a copy of the local chain):

```text
duplicate
```
*See also*

* [GetBlockTemplate](../api/rpc-mining.md##getblocktemplate): gets a block template or proposal for use with mining software.
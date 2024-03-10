> ***We put our best effort into covering all topics related to Dimecoin. Each section will cover a different category. Not all documentation may be 100% accurate, if you spot an error, please report it or submit a PR request on GitHub.***
>
> ***REMINDER: This documentation is always evolving. If you have not been here for a while, perhaps check again. Things may have been added or updated since your last visit!***

## Quick Reference

* [GET Block](../api/http-rest-requests.md#get-block) gets a block with a particular header hash from the local block database either as a JSON object or as a serialized block.
* [GET Block/NoTxDetails](../api/http-rest-requests.md#get-blocknotxdetails) gets a block with a particular header hash from the local block database either as a JSON object or as a serialized block.  The JSON object includes TXIDs for transactions within the block rather than the complete transactions [GET block](../api/http-rest-requests.md#get-block) returns.
* [GET ChainInfo](../api/http-rest-requests.md#get-chaininfo) returns information about the current state of the blockchain.
* [GET GetUtxos](../api/http-rest-requests.md#get-getutxos) returns an UTXO set given a set of outpoints.
* [GET Headers](../api/http-rest-requests.md#get-headers) returns a specified amount of block headers in upward direction.
* [GET MemPool/Contents](../api/http-rest-requests.md#get-mempoolcontents) returns all transaction in the memory pool with detailed information.
* [GET MemPool/Info](../api/http-rest-requests.md#get-mempoolinfo) returns information about the node's current transaction memory pool
* [GET Tx](../api/http-rest-requests.md#get-tx) gets a hex-encoded serialized transaction or a JSON object describing the transaction. By default, Dimecoin Core only stores complete transaction data for UTXOs and your own transactions, so this method may fail on historic transactions unless you use the non-default `txindex=1` in your Dimecoin Core startup settings.

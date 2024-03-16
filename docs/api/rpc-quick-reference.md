```{eval-rst}
.. _api-rpc-quick-reference:
.. meta::
  :title: RPC API Quick Reference
  :description: A quick reference guide for all the RPCs in Dimecoin.
```

> ***We put our best effort into covering all topics related to Dimecoin. Each section will cover a different category. Not all documentation may be 100% accurate, if you spot an error, please report it or submit a PR request on GitHub.***
>
> ***REMINDER: This documentation is always evolving. If you have not been here for a while, perhaps check again. Things may have been added or updated since your last visit!***

## Quick Reference

### [Blockchain RPCs](../api/rpc-blockchain.md)

* [GetBestBlockHash](../api/rpc-blockchain.md#getbestblockhash): returns the header hash of the most recent block on the best blockchain.
* [GetBlock](../api/rpc-blockchain.md#getblock): gets a block with a particular header hash from the local block database either as a JSON object or as a serialized block.
* [GetBlockChainInfo](../api/rpc-blockchain.md#getblockchaininfo): provides information about the current state of the blockchain.
* [GetBlockCount](../api/rpc-blockchain.md#getblockcount): returns the number of blocks in the local best blockchain.
* [GetBlockHash](../api/rpc-blockchain.md#getblockhash): returns the header hash of a block at the given height in the local best blockchain.
* [GetBlockHeader](../api/rpc-blockchain.md#getblockheader): gets a block header with a particular header hash from the local block database either as a JSON object or as a serialized block header.
* [GetChainTips](../api/rpc-blockchain.md#getchaintips): returns information about the highest-height block (tip) of each local blockchain.
* [GetDifficulty](../api/rpc-blockchain.md#getdifficulty): returns the proof-of-work difficulty as a multiple of the minimum difficulty.
* [GetMemPoolAncestors](../api/rpc-blockchain.md#getmempoolancestors): returns all in-mempool ancestors for a transaction in the mempool.
* [GetMemPoolDescendants](../api/rpc-blockchain.md#getmempooldescendants): returns all in-mempool descendants for a transaction in the mempool.
* [GetMemPoolEntry](../api/rpc-blockchain.md#getmempoolentry): returns mempool data for given transaction (must be in mempool).
* [GetMemPoolInfo](../api/rpc-blockchain.md#getmempoolinfo): returns information about the node's current transaction memory pool.
* [GetRawMemPool](../api/rpc-blockchain.md#getrawmempool): returns all transaction identifiers (TXIDs) in the memory pool as a JSON array, or detailed information about each transaction in the memory pool as a JSON object.
* [GetTxOut](../api/rpc-blockchain.md#gettxout): returns details about an unspent transaction output (UTXO).
* [GetTxOutProof](../api/rpc-blockchain.md#gettxoutproof): returns a hex-encoded proof that one or more specified transactions were included in a block.
* [GetTxOutSetInfo](../api/rpc-blockchain.md#gettxoutsetinfo): returns statistics about the confirmed unspent transaction output (UTXO) set. Note that this call may take some time and that it only counts outputs from confirmed transactions---it does not count outputs from the memory pool.
* [PreciousBlock](../api/rpc-blockchain.md#preciousblock): treats a block as if it were received before others with the same work.
* [SaveMemPool](../api/rpc-blockchain.md#savemempool): dumps the mempool to disk.
* [SendCheckPoint](../api/rpc-blockchain.md#sendcheckpoint): sends a synchronized checkpoint. used for ACP implementation
* [VerifyChain](../api/rpc-blockchain.md#verifychain): verifies each entry in the local blockchain database.
* [VerifyTxOutProof](../api/rpc-blockchain.md#verifytxoutproof): verifies that a proof points to one or more transactions in a block, returning the transactions the proof commits to and throwing an RPC error if the block is not in our best blockchain.

### [Control RPCs](../api/rpc-control.md)

* [GetMemoryInfo](../api/rpc-control.md#getmemoryinfo): returns information about memory usage.
* [Help](../api/rpc-control.md#help): lists all available public RPC commands, or gets help for the specified RPC.  Commands which are unavailable will not be listed, such as wallet RPCs if wallet support is disabled.
* [Logging](../api/rpc-control.md#logging): gets and sets the logging configuration
* [Stop](../api/rpc-control.md#stop): safely shuts down the Dimecoin Core server.
* [Uptime](../api/rpc-control.md#uptime): returns the total uptime of the server.

### [Dimecoin RPCs](../api/remote-procedure-calls-dime.md)

* [GetGovernanceInfo](../api/remote-procedure-calls-dime.md#getgovernanceinfo): returns an object containing governance parameters.
* [GetSuperblockBudget](../api/remote-procedure-calls-dime.md#getsuperblockbudget): returns the absolute maximum sum of superblock payments allowed. (superblock not used)
* [GObject](../api/remote-procedure-calls-dime.md#gobject): provides a set of commands for managing governance objects and displaying information about them.
* [Masternode](../api/remote-procedure-calls-dime.md#masternode): provides a set of commands for managing masternodes and displaying information about them.
* [MasternodeList](../api/remote-procedure-calls-dime.md#masternodelist): returns a list of masternodes in different modes.
* [MnSync](../api/remote-procedure-calls-dime.md#mnsync): returns the sync status, updates to the next step or resets it entirely.
* [SentinelPing](../api/remote-procedure-calls-dime#sentinelping): returns version of sentinel and its state.
* [Spork](../api/remote-procedure-calls-dime.md#spork): shows information about the current state of sporks.
* [SporkUpdate](../api/remote-procedure-calls-dime.md#sporkupdate): updates the value of the provided spork.
* [VoteRaw](../api/remote-procedure-calls-dime.md#voteraw): compiles and relays a governance vote with provided external signature instead of signing vote internally

### [Generating RPCs](../api/rpc-generating.md)

* [GenerateBlock](../api/rpc-generating.md#generateblock): mines a block with a set of ordered transactions immediately to a specified address or descriptor (before the RPC call returns).

### [Mining RPCs](../api/rpc-mining.md)

* [GetBlockTemplate](../api/rpc-mining.md#getblocktemplate): gets a block template or proposal for use with mining software.
* [GetMiningInfo](../api/rpc-mining.md#getmininginfo): returns various mining-related information.
* [GetNetworkHashPS](../api/rpc-mining.md#getnetworkhashps): returns the estimated network hashes per second based on the last n blocks.
* [PrioritiseTransaction](../api/rpc-mining.md#prioritisetransaction): adds virtual priority or fee to a transaction, allowing it to be accepted into blocks mined by this node (or miners which use this node) with a lower priority or fee. (It can also remove virtual priority or fee, requiring the transaction have a higher priority or fee to be accepted into a locally-mined block.)
* [SetGenerate] (../api/rpc-mining.md#setgenerate): enables cpu mining. only applicable for testnet
* [SubmitBlock](../api/rpc-mining.md#submitblock): accepts a block, verifies it is a valid addition to the blockchain, and broadcasts it to the network. Extra parameters are ignored by Dimecoin Core but may be used by mining pools or other programs.

### [Network RPCs](../api/rpc-network.md)

* [AddNode](../api/rpc-network.md#addnode): attempts to add or remove a node from the addnode list, or to try a connection to a node once.
* [ClearBanned](../api/rpc-network.md#clearbanned): clears list of banned nodes.
* [DisconnectNode](../api/rpc-network.md#disconnectnode): immediately disconnects from a specified node.
* [GetAddedNodeInfo](../api/rpc-network.md#getaddednodeinfo): returns information about the given added node, or all added nodes (except onetry nodes). Only nodes which have been manually added using the [`addnode` RPC](../api/rpc-network.md#addnode) will have their information displayed.
* [GetConnectionCount](../api/rpc-network.md#getconnectioncount): returns the number of connections to other nodes.
* [GetNetTotals](../api/rpc-network.md#getnettotals): returns information about network traffic, including bytes in, bytes out, and the current time.
* [GetNetworkInfo](../api/rpc-network.md#getnetworkinfo): returns information about the node's connection to the network.
* [GetPeerInfo](../api/rpc-network.md#getpeerinfo): returns data about each connected network node.
* [ListBanned](../api/rpc-network.md#listbanned): lists all banned IPs/Subnets.
* [Ping](../api/rpc-network.md#ping): sends a P2P ping message to all connected nodes to measure ping time. Results are provided by the [`getpeerinfo` RPC](../api/rpc-network.md#getpeerinfo) pingtime and pingwait fields as decimal seconds. The P2P [`ping` message](../reference/p2p-network-control-messages.md#ping) is handled in a queue with all other commands, so it measures processing backlog, not just network ping.
* [SetBan](../api/rpc-network.md#setban): attempts add or remove a IP/Subnet from the banned list.
* [SetNetworkActive](../api/rpc-network.md#setnetworkactive): disables/enables all P2P network activity.

### [Raw Transaction RPCs](../api/rpc-raw-transactions.md)

* [CombinePSBT](../api/rpc-raw-transactions.md#combinepsbt): combines multiple partially-signed dimecoin transactions into one transaction.
* [CombineRawTransaction](../api/rpc-raw-transactions.md#combinerawtransaction): combine multiple partially signed transactions into one transaction.
* [ConvertToPSBT](../api/rpc-raw-transactions.md#converttopsbt): converts a network serialized transaction to a PSBT.
* [CreatePSBT](../api/rpc-raw-transactions.md#createpsbt): creates a transaction in the Partially Signed Transaction (PST) format.
* [CreateRawTransaction](../api/rpc-raw-transactions.md#createrawtransaction): creates an unsigned serialized transaction that spends a previous output to a new output with a P2PKH or P2SH address. The transaction is not stored in the wallet or transmitted to the network.
* [DecodePSBT](../api/rpc-raw-transactions.md#decodepsbt): returns a JSON object representing the serialized, base64-encoded partially signed dimecoin transaction.
* [DecodeRawTransaction](../api/rpc-raw-transactions.md#decoderawtransaction): decodes a serialized transaction hex string into a JSON object describing the transaction.
* [DecodeScript](../api/rpc-raw-transactions.md#decodescript): decodes a hex-encoded P2SH redeem script.
* [FinalizePSBT](../api/rpc-raw-transactions.md#finalizepsbt): finalizes the inputs of a PSBT. The PSBT produces a network serialized transaction if the transaction is fully signed.
* [FundRawTransaction](../api/rpc-raw-transactions.md#fundrawtransaction): adds inputs to a transaction until it has enough in value to meet its out value.
* [GetRawTransaction](../api/rpc-raw-transactions.md#getrawtransaction): gets a hex-encoded serialized transaction or a JSON object describing the transaction. By default, Dimecoin Core only stores complete transaction data for UTXOs and your own transactions, so the RPC may fail on historic transactions unless you use the non-default `txindex=1` in your Dimecoin Core startup settings.
* [SendRawTransaction](../api/rpc-raw-transactions.md#sendrawtransaction): validates a transaction and broadcasts it to the peer-to-peer network.
* [SignRawTransactionWithKey](../api/rpc-raw-transactions.md#signrawtransactionwithkey): signs a transaction in the serialized transaction format using private keys provided in the call.
* [TestMempoolAccept](../api/rpc-raw-transactions.md#testmempoolaccept): returns the results of mempool acceptance tests indicating if raw transaction (serialized, hex-encoded) would be accepted by mempool.

### [Utility RPCs](../api/rpc-utility.md)

* [CreateMultiSig](../api/rpc-utility.md#createmultisig): creates a P2SH multi-signature address.
* [EstimateSmartFee](../api/rpc-utility.md#estimatesmartfee): estimates the transaction fee per kilobyte that needs to be paid for a transaction to begin confirmation within a certain number of blocks and returns the number of blocks for which the estimate is valid.
* [GetStakingStatus](../api/rpc-utility#getstakingstatus): returns various staking information
* [SignMessageWithPrivKey](../api/rpc-utility.md#signmessagewithprivkey): signs a message with a given private key.
* [ValidateAddress](../api/rpc-utility.md#validateaddress): returns information about the given dimecoin address.
* [VerifyMessage](../api/rpc-utility.md#verifymessage): verifies a signed message.

### [Wallet RPCs](../api/rpc-wallet.md)

**Note:** the wallet RPCs are only available if Dimecoin Core was built with [wallet support](../reference/glossary.md#wallet-support), which is the default.

* [AbandonTransaction](../api/rpc-wallet.md#abandontransaction): marks an in-wallet transaction and all its in-wallet descendants as abandoned. This allows their inputs to be respent.
* [AbortRescan](../api/rpc-wallet.md#abortrescan): stops current wallet rescan.
* [AddMultiSigAddress](../api/rpc-wallet.md#addmultisigaddress): adds a P2SH multisig address to the wallet.
* [BackupWallet](../api/rpc-wallet.md#backupwallet): safely copies `wallet.dat` to the specified file, which can be a directory or a path with filename.
* [DumpPrivKey](../api/rpc-wallet.md#dumpprivkey): returns the wallet-import-format (WIP) private key corresponding to an address. (But does not remove it from the wallet.)
* [DumpWallet](../api/rpc-wallet.md#dumpwallet): creates or overwrites a file with all wallet keys in a human-readable format.
* [EncryptWallet](../api/rpc-wallet.md#encryptwallet): encrypts the wallet with a passphrase.  This is only to enable encryption for the first time. After encryption is enabled, you will need to enter the passphrase to use private keys.
* [GetAddressInfo](../api/rpc-wallet.md#getaddressinfo): returns information about the given dimecoin address.
* [GetAddressesByLabel](../api/rpc-wallet.md#getaddressesbylabel): returns a list of every address assigned to a particular label.
* [GetBalance](../api/rpc-wallet.md#getbalance): gets the balance in decimal dime across all accounts or for a particular account.
* [GetBalances](../api/rpc-wallet.md#getbalances): returns an object with all balances denominated in DIME.
* [GetNewAddress](../api/rpc-wallet.md#getnewaddress): returns a new dimecoin address for receiving payments. If an account is specified, payments received with the address will be credited to that account.
* [GetRawChangeAddress](../api/rpc-wallet.md#getrawchangeaddress): returns a new dimecoin address for receiving change. This is for use with raw transactions, not normal use.
* [GetReceivedByAddress](../api/rpc-wallet.md#getreceivedbyaddress): returns the total amount received by the specified address in transactions with the specified number of confirmations. It does not count coinbase transactions.
* [GetReceivedByLabel](../api/rpc-wallet.md#getreceivedbylabel): returns the list of addresses assigned the specified label.
* [GetTransaction](../api/rpc-wallet.md#gettransaction): gets detailed information about an in-wallet transaction.
* [GetUnconfirmedBalance](../api/rpc-wallet.md#getunconfirmedbalance): returns the wallet's total unconfirmed balance.
* [GetWalletInfo](../api/rpc-wallet.md#getwalletinfo): provides information about the wallet.
* [ImportAddress](../api/rpc-wallet.md#importaddress): adds an address or pubkey script to the wallet without the associated private key, allowing you to watch for transactions affecting that address or pubkey script without being able to spend any of its outputs.
* [ImportMulti](../api/rpc-wallet.md#importmulti): imports addresses or scripts (with private keys, public keys, or P2SH redeem scripts) and optionally performs the minimum necessary rescan for all imports.
* [ImportPrivKey](../api/rpc-wallet.md#importprivkey): adds a private key to your wallet. The key should be formatted in the wallet import format created by the [`dumpprivkey` RPC](../api/rpc-wallet.md#dumpprivkey).
* [ImportPrunedFunds](../api/rpc-wallet.md#importprunedfunds): imports funds without the need of a rescan. Meant for use with pruned wallets.
* [ImportPubKey](../api/rpc-wallet.md#importpubkey): imports a public key (in hex) that can be watched as if it were in your wallet but cannot be used to spend
* [ImportWallet](../api/rpc-wallet.md#importwallet): imports private keys from a file in wallet dump file format. These keys will be added to the keys currently in the wallet.  This call may need to rescan all or parts of the blockchain for transactions affecting the newly-added keys, which may take several minutes.
* [KeyPoolRefill](../api/rpc-wallet.md#keypoolrefill): fills the cache of unused pre-generated keys (the keypool).
* [ListAddressGroupings](../api/rpc-wallet.md#listaddressgroupings): lists groups of addresses that may have had their common ownership made public by common use as inputs in the same transaction or from being used as change from a previous transaction.
* [ListLabels](../api/rpc-wallet.md#listlabels): returns the list of all labels, or labels that are assigned to addresses with a specific purpose.
* [ListLockUnspent](../api/rpc-wallet.md#listlockunspent): returns a list of temporarily unspendable (locked) outputs.
* [ListReceivedByAddress](../api/rpc-wallet.md#listreceivedbyaddress): lists the total number of dimecoin received by each address.
* [ListReceivedByLabel](../api/rpc-wallet.md#listreceivedbylabel): lists the total number of dimecoin received by each label.
* [ListSinceBlock](../api/rpc-wallet.md#listsinceblock): gets all transactions affecting the wallet which have occurred since a particular block, plus the header hash of a block at a particular depth.
* [ListTransactions](../api/rpc-wallet.md#listtransactions): returns the most recent transactions that affect the wallet.
* [ListUnspent](../api/rpc-wallet.md#listunspent): returns an array of unspent transaction outputs belonging to this wallet.
* [ListWallets](../api/rpc-wallet.md#listwallets): returns a list of currently loaded wallets.
* [LockUnspent](../api/rpc-wallet.md#lockunspent): temporarily locks or unlocks specified transaction outputs. A locked transaction output will not be chosen by automatic coin selection when spending dimecoin. Locks are stored in memory only, so nodes start with zero locked outputs and the locked output list is always cleared when a node stops or fails.
* [RemovePrunedFunds](../api/rpc-wallet.md#removeprunedfunds): deletes the specified transaction from the wallet. Meant for use with pruned wallets and as a companion to importprunedfunds.
* [RescanBlockChain](../api/rpc-wallet.md#rescanblockchain): rescans the local blockchain for wallet related transactions.
* [ScanTxOutset](../api/rpc-wallet.md#scantxoutset): scans the unspent transaction output set for entries that match certain output descriptors.
* [SendMany](../api/rpc-wallet.md#sendmany): creates and broadcasts a transaction which sends outputs to multiple addresses.
* [SendToAddress](../api/rpc-wallet.md#sendtoaddress): spends an amount to a given address.
* [SetTxFee](../api/rpc-wallet.md#settxfee): sets the transaction fee per kilobyte paid by transactions created by this wallet.
* [SignMessage](../api/rpc-wallet.md#signmessage): signs a message with the private key of an address.
* [SignRawTransactionWithWallet](../api/rpc-wallet.md#signrawtransactionwithwallet): signs a transaction in the serialized transaction format using private keys found in the wallet.
* [WalletLock](../api/rpc-wallet.md#walletlock): removes the wallet encryption key from memory, locking the wallet. After calling this method, you will need to call `walletpassphrase` again before being able to call any methods which require the wallet to be unlocked.
* [WalletPassphrase](../api/rpc-wallet.md#walletpassphrase): stores the wallet decryption key in memory for the indicated number of seconds. Issuing the `walletpassphrase` command while the wallet is already unlocked will set a new unlock time that overrides the old one.
* [WalletPassphraseChange](../api/rpc-wallet.md#walletpassphrasechange): changes the wallet passphrase from 'old passphrase' to 'new passphrase'.

### [Wallet RPCs (Deprecated)](../api/rpc-wallet-deprecated.md)

**Note:** the wallet RPCs are only available if Dimecoin Core was built with [wallet support](../reference/glossary.md#wallet-support), which is the default.

* [GetAccount](../api/rpc-wallet-deprecated.md#getaccount): returns the name of the account associated with the given address. ***Deprecated_**
* [GetAccountAddress](../api/rpc-wallet-deprecated.md#getaccountaddress): returns the current dimecoin address for receiving payments to this account. If the account doesn't exist, it creates both the account and a new address for receiving payment.  Once a payment has been received to an address, future calls to this RPC for the same account will return a different address. ***Deprecated_**
* [GetAddressesByAccount](../api/rpc-wallet-deprecated.md#getaddressesbyaccount): returns a list of every address assigned to a particular account. ***Deprecated_**
* [SetAccount](../api/rpc-wallet-deprecated.md#setaccount): puts the specified address in the given account. ***Deprecated_**

### [ZeroMQ (ZMQ) RPCs](../api/rpc-zmq.md)

* [GetZmqNotifications](../api/rpc-zmq.md#getzmqnotifications): returns information about the active ZeroMQ notifications.

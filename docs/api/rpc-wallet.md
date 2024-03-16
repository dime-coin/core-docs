```{eval-rst}
.. _api-rpc-wallet:
.. meta::
  :title: Wallet RPCs
  :description: A list of remote procedure calls in Dimecoin that are used to perform wallet operations such as sending, creating and categorizing addresses, etc. 
```

> ***We put our best effort into covering all topics related to Dimecoin. Each section will cover a different category. Not all documentation may be 100% accurate, if you spot an error, please report it or submit a PR request on GitHub.***
>
> ***REMINDER: This documentation is always evolving. If you have not been here for a while, perhaps check again. Things may have been added or updated since your last visit!***

## Wallet RPCs

```{admonition} Wallet Support
RPCs that require wallet support are **not available on masternodes** for security reasons. Such RPCs are designated with a "*Requires wallet support*" message.
```

### AbandonTransaction

The [`abandontransaction` RPC](../api/rpc-wallet.md#abandontransaction) marks an in-wallet transaction and all its in-wallet descendants as abandoned. This allows their inputs to be respent.

*Parameter #1---a transaction identifier (TXID)*

| Name | Type         | Presence                | Description                                                                                              |
| ---- | ------------ | ----------------------- | -------------------------------------------------------------------------------------------------------- |
| TXID | string (hex) | Required<br>(exactly 1) | The TXID of the transaction that you want to abandon.  The TXID must be encoded as hex in RPC byte order |

*Result---`null` on success*

| Name     | Type | Presence                | Description                                                         |
| -------- | ---- | ----------------------- | ------------------------------------------------------------------- |
| `result` | null | Required<br>(exactly 1) | JSON `null` when the transaction and all descendants were abandoned |

*Example from Dimecoin Core 2.3.0.0*

Abandons the transaction on your node.

```bash
dimecoin-cli abandontransaction fa3970c341c9f5de6ab13f128cbfec58d732e736a505fe32137ad551c799ecc4
```

Result (no output from `dimecoin-cli` because result is set to `null`).

```{seealso}
* [SendRawTransaction](../api/rpc-raw-transactions.md#sendrawtransaction): validates a transaction and broadcasts it to the peer-to-peer network.
```

### AbortRescan

The [`abortrescan` RPC](../api/rpc-wallet.md#abortrescan) stops current wallet rescan

Stops current wallet rescan triggered e.g. by an [`importprivkey` RPC](../api/rpc-wallet.md#importprivkey) call.

*Parameters: none*

*Result---`true` on success*

| Name     | Type | Presence                | Description                                                          |
| -------- | ---- | ----------------------- | -------------------------------------------------------------------- |
| `result` | null | Required<br>(exactly 1) | `true` when the command was successful or `false` if not successful. |

*Example from Dimecoin Core 2.3.0.0*

Abort the running wallet rescan

```bash
dimecoin-cli -mainnet abortrescan
```

Result:

```text
true
```

```{seealso}
*none*
```

### AddMultiSigAddress

```{note}
Requires [wallet](../reference/glossary.md#wallet) support (**unavailable on masternodes**)
```

The [`addmultisigaddress` RPC](../api/rpc-wallet.md#addmultisigaddress) adds a P2SH multisig address to the wallet. Each key is a Dimecoin address or hex-encoded public key. This functionality is only intended for use with non-watchonly addresses. See [`importaddress` RPC](../api/rpc-wallet.md#importaddress) for watchonly p2sh address support. If 'label' is specified, assign address to that label.

*Parameter #1---the number of signatures required*

| Name     | Type         | Presence                | Description                                                                          |
| -------- | ------------ | ----------------------- | ------------------------------------------------------------------------------------ |
| Required | number (int) | Required<br>(exactly 1) | The minimum (*m*) number of signatures required to spend this m-of-n multisig script |

*Parameter #2---the full public keys, or addresses for known public keys*

| Name                | Type   | Presence                | Description                                                                                                                                                                                                                                                                            |
| ------------------- | ------ | ----------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Keys Or Addresses   | array  | Required<br>(exactly 1) | An array of strings with each string being a public key or address                                                                                                                                                                                                                     |
| →<br>Key Or Address | string | Required<br>(1 or more) | A public key against which signatures will be checked.  Alternatively, this may be a P2PKH address belonging to the wallet---the corresponding public key will be substituted.  There must be at least as many keys as specified by the Required parameter, and there may be more keys |

*Parameter #3---label*

| Name  | Type   | Presence             | Description                         |
| ----- | ------ | -------------------- | ----------------------------------- |
| Label | string | Optional<br>(0 or 1) | A label to assign the addresses to. |

*Result---P2SH address and hex-encoded redeem script*

| Name                | Type            | Presence                | Description                                      |
| ------------------- | --------------- | ----------------------- | ------------------------------------------------ |
| `result`            | object          | Required<br>(exactly 1) | An object describing the multisig address        |
| →<br>`address`      | string (base58) | Required<br>(exactly 1) | The P2SH address for this multisig redeem script |
| →<br>`redeemScript` | string (hex)    | Required<br>(exactly 1) | The multisig redeem script encoded as hex        |

*Example from Dimecoin Core 2.3.0.0*

Adding a 1-of-2 P2SH multisig address with the label "test label" by combining one P2PKH address and one full public key:

```bash
dimecoin-cli -mainnet -rpcwallet="" addmultisigaddress 1 '''
  [
    "7SxkBWzPwMrZLAY9ZPitMnSwf4NSUBPbiH",
    "02594523b004e82849a66b3da096b1e680bf2ed5f7d03a3443c027aa5777bb6223"
  ]
'''  'test label'
```

Result:

```json
{
  "address": "8jYUv8hJcbSUPbwYmzp1XMPU6SXoic3hwi",
  "redeemScript": "512103283a224c2c014d1d0ef82b00470b6b277d71e227c0e2394f9baade5d666e57d32102594523b004e82849a66b3da096b1e680bf2ed5f7d03a3443c027aa5777bb622352ae",
  "descriptor": "sh(multi(1,[48de9d39]03283a224c2c014d1d0ef82b00470b6b277d71e227c0e2394f9baade5d666e57d3,[dec361f1]02594523b004e82849a66b3da096b1e680bf2ed5f7d03a3443c027aa5777bb6223))#vtc5zmh2"
}
```

(New P2SH multisig address also stored in wallet.)

```{seealso}
* [CreateMultiSig](../api/rpc-utility.md#createmultisig): creates a P2SH multi-signature address.
* [DecodeScript](../api/rpc-raw-transactions.md#decodescript): decodes a hex-encoded P2SH redeem script.
```

### BackupWallet

```{note}
Requires [wallet](../reference/glossary.md#wallet) support (**unavailable on masternodes**)
```

The [`backupwallet` RPC](../api/rpc-wallet.md#backupwallet) safely copies `wallet.dat` to the specified file, which can be a directory or a path with filename.

*Parameter #1---destination directory or filename*

| Name        | Type   | Presence                | Description                                                                                                                                                                       |
| ----------- | ------ | ----------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Destination | string | Required<br>(exactly 1) | A filename or directory name.  If a filename, it will be created or overwritten.  If a directory name, the file `wallet.dat` will be created or overwritten within that directory |

*Result---`null` or error*

| Name     | Type | Presence                | Description                                                                                                        |
| -------- | ---- | ----------------------- | ------------------------------------------------------------------------------------------------------------------ |
| `result` | null | Required<br>(exactly 1) | Always `null` whether success or failure.  The JSON-RPC error and message fields will be set if a failure occurred |

*Example from Dimecoin Core 2.3.0.0*

```bash
dimecoin-cli -mainnet backupwallet /tmp/backup.dat
```

```{seealso}
* [ImportWallet](../api/rpc-wallet.md#importwallet): imports private keys from a file in wallet dump file format. These keys will be added to the keys currently in the wallet. This call may need to rescan all or parts of the blockchain for transactions affecting the newly-added keys, which may take several minutes.
```
  
## CreateWallet

```{note}
Requires [wallet](../reference/glossary.md#wallet) support (**unavailable on masternodes**)
```

The [`createwallet` RPC](../api/remote-procedure-calls-wallet.md#createwallet) creates and loads a new wallet.

*Parameter #1---wallet name*

| Name          | Type   | Presence                | Description                                                                                      |
| ------------- | ------ | ----------------------- | ------------------------------------------------------------------------------------------------ |
| `wallet_name` | string | Required<br>(exactly 1) | The name for the new wallet. If this is a path, the wallet will be created at the path location. |

*Parameter #2---disable private keys_

| Name                   | Type | Presence             | Description                                                                         |
| ---------------------- | ---- | -------------------- | ----------------------------------------------------------------------------------- |
| `disable_private_keys` | bool | Optional<br>(0 or 1) | Disable the possibility of private keys. Only watchonlys are possible in this mode. |

*Parameter #3---passphrase*

| Name         | Type   | Presence             | Description                              |
| ------------ | ------ | -------------------- | ---------------------------------------- |
| `passphrase` | string | Optional<br>(0 or 1) | Encrypt the wallet with this passphrase. |

*Result---wallet name and any warnings*

| Name           | Type   | Presence                | Description                                                                                                                   |
| -------------- | ------ | ----------------------- | ----------------------------------------------------------------------------------------------------------------------------- |
| `result`       | object | Required<br>(exactly 1) | An object containing information about wallet creation                                                                        |
| →<br>`name`    | string | Required<br>(exactly 1) | The wallet name if created successfully. If the wallet was created using a full path, the `wallet_name` will be the full path |
| →<br>`warning` | string | Required<br>(exactly 1) | Warning message if wallet was not loaded cleanly.                                                                             |

*Example from Dimecoin Core 2.3.0.0*

```bash
dimecoin-cli -mainnet createwallet new-wallet
```

Result:

```json
{
  "name": "new-wallet",
  "warning": ""
}
```

```{note}
In the example above, a new directory named `new-wallet` was created in the current data directory (`~/.dimecoincore/testnet3/`). This new directory contains the wallet.dat file and other related wallet files for the new wallet.
```

```{seealso}
* [LoadWallet](../api/remote-procedure-calls-wallet.md#loadwallet): loads a wallet from a wallet file or directory.
```

### DumpPrivKey

```{note}
Requires [wallet](../reference/glossary.md#wallet) support (**unavailable on masternodes**). Requires an unlocked wallet or an unencrypted wallet.
```

The [`dumpprivkey` RPC](../api/rpc-wallet.md#dumpprivkey) returns the wallet-import-format (WIP) private key corresponding to an address. (But does not remove it from the wallet.)

*Parameter #1---the address corresponding to the private key to get*

| Name          | Type            | Presence                | Description                                                                                                                              |
| ------------- | --------------- | ----------------------- | ---------------------------------------------------------------------------------------------------------------------------------------- |
| P2PKH Address | string (base58) | Required<br>(exactly 1) | The P2PKH address corresponding to the private key you want returned.  Must be the address corresponding to a private key in this wallet |

*Result---the private key*

| Name     | Type            | Presence                | Description                                                       |
| -------- | --------------- | ----------------------- | ----------------------------------------------------------------- |
| `result` | string (base58) | Required<br>(exactly 1) | The private key encoded as base58check using wallet import format |

*Example from Dimecoin Core 2.3.0.0*

```bash
dimecoin-cli -mainnet dumpprivkey 7cBuREgSskHHkWLxDa9A5WppCki6PfFycL
```

Result:

```text
dQZZ4awQvcDHyFS3CmURqSgeTobQm9t9nyUr337kvUtsWsnvvQyw
```

```seealso
* [ImportPrivKey](../api/rpc-wallet.md#importprivkey): adds a private key to your wallet. The key should be formatted in the wallet import format created by the [`dumpprivkey` RPC](../api/rpc-wallet.md#dumpprivkey).
* [DumpWallet](../api/rpc-wallet.md#dumpwallet): creates or overwrites a file with all wallet keys in a human-readable format.
```

## DumpWallet

```{note}
Requires [wallet](../reference/glossary.md#wallet) support (**unavailable on masternodes**). Requires an unlocked wallet or an unencrypted wallet.
```

The [`dumpwallet` RPC](../api/remote-procedure-calls-wallet.md#dumpwallet) creates or overwrites a file with all wallet keys in a human-readable format.

*Parameter #1---a filename*

| Name     | Type   | Presence                | Description                                                                                                                                                        |
| -------- | ------ | ----------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| Filename | string | Required<br>(exactly 1) | The filename with path (either absolute or relative to Dimecoin Core) into which the wallet dump will be placed.  An existing file with that name will be overwritten. |

*Result---information about exported wallet*

| Name                   | Type         | Presence                | Description                                                         |
| ---------------------- | ------------ | ----------------------- | ------------------------------------------------------------------- |
| `result`               | object       | Required<br>(exactly 1) | An object describing dumped wallet file                             |
| →<br>`version` | string       | Required<br>(exactly 1) | Dimecoin Core build details                                                 |
| →<br>`lastblockheight` | int          | Required<br>(exactly 1) | Height of the most recent block received                            |
| →<br>`lastblockhash`   | string (hex) | Required<br>(exactly 1) | Hash of the most recent block received                              |
| →<br>`lastblocktime`   | string       | Required<br>(exactly 1) | Timestamp of the most recent block received                         |
| →<br>`keys`            | int          | Required<br>(exactly 1) | Number of keys dumped                                               |
| →<br>`filename`        | string       | Required<br>(exactly 1) | Name of the file the wallet was dumped to                           |
| →<br>`warning`         | string       | Required<br>(exactly 1) | Warning to not share the file due to it containing the private keys |

*Example from Dimecoin Core 2.3.0.0*

Create a wallet dump and then print its first 10 lines.

```bash
dimecoin-cli -mainnet dumpwallet /tmp/dump.txt
head /tmp/dump.txt
```

Results:

```json
{
  "version": "v2.3.0.0",
  "lastblockheight": 250186,
  "lastblockhash": "0000000000a82fb1890de5da4740d0671910a436fe6fc4503a3e553adef073b4",
  "lastblocktime": "2018-10-23T12:50:44Z",
  "keys": 8135,
  "file": "/tmp/dump.txt",
  "warning": "/tmp/dump.txt file contains all private keys from this wallet. Do not share it with anyone!"
}
```

Sample Results (the first 10 lines of the file):

```bash
>>>>>>>># Wallet dump created by Dimecoin Core
>>>>>>>># * Created on 2020-12-09T18:40:52Z
>>>>>>>># * Best block at time of backup was 56750034 (000000b2304f57eefd42cdd943e7736d479468beb08049b8f88d11ebc7cf6f02),
>>>>>>>>#   mined on 2020-12-09T18:40:23Z

cQZZ4awQvcXXyES3CmUJqSgeTobQm9t9nyUr337kvUtsWsnvvMyw 2018-12-14T17:24:37Z change=1 # addr=ycBuREgSskHHkWLxDa9A5WppCki6PfFycL
cTBRPnJoPjEMh67v1zes437v8Po5bFLDWKgEudTJMhVaLs1ZVGJe 2018-12-14T17:24:37Z change=1 # addr=yNsWkgPLN1u7p5dfWYnasYdgirU2J3tjUj
cRkkwrFnQUrih3QiT87sNy1AxyfjzqVYSyVYuL3qnJcSiQfE4QJa 2018-12-14T17:24:37Z change=1 # addr=yRkHzRbRKn8gBp5826mbaBvxLuBBNDVQg3
cQM7KoqQjHCCTrDhnfBEY1vpW9W65zRvaQeTb41UbFb6WX8Q8UkQ 2018-12-14T17:24:37Z change=1 # addr=yVEdefApUYiDLHApvvWCK5afTtJeQada8Y
cTGSKYaQTQabnjNSwCqpjYXiucVujTXiwp9dzmJV9cNAiayAJusi 2018-12-14T17:24:37Z change=1 # addr=ybQYgp21ZyZK8JuMLb2CVwG4TaWrXVXD5M
```

```{seealso}
* [BackupWallet](../api/remote-procedure-calls-wallet.md#backupwallet): safely copies `wallet.dat` to the specified file, which can be a directory or a path with filename.
* [ImportWallet](../api/remote-procedure-calls-wallet.md#importwallet): imports private keys from a file in wallet dump file format (see the [`dumpwallet` RPC](../api/remote-procedure-calls-wallet.md#dumpwallet)). These keys will be added to the keys currently in the wallet.  This call may need to rescan all or parts of the blockchain for transactions affecting the newly-added keys, which may take several minutes.
```

### EncryptWallet

```{note}
Requires [wallet](../reference/glossary.md#wallet) support (**unavailable on masternodes**).
```

The [`encryptwallet` RPC](../api/rpc-wallet.md#encryptwallet) encrypts the wallet with a passphrase.  This is only to enable encryption for the first time. After encryption is enabled, you will need to enter the passphrase to use private keys.

```{warning}
If using this RPC on the command line, remember that your shell probably saves your command lines (including the value of the passphrase parameter). In addition, there is no RPC to completely disable encryption. If you want to return to an unencrypted wallet, you must create a new wallet and restore your data from a backup made with the [`dumpwallet` RPC](../api/rpc-wallet.md#dumpwallet).
```

*Parameter #1---a passphrase*

| Name       | Type   | Presence                | Description                                                                     |
| ---------- | ------ | ----------------------- | ------------------------------------------------------------------------------- |
| Passphrase | string | Required<br>(exactly 1) | The passphrase to use for the encrypted wallet.  Must be at least one character |

*Result---a notice (with program shutdown)*

| Name     | Type   | Presence                | Description                                                                                               |
| -------- | ------ | ----------------------- | --------------------------------------------------------------------------------------------------------- |
| `result` | string | Required<br>(exactly 1) | A notice that the server is stopping and that you need to make a new backup.  The wallet is now encrypted |

*Example from Dimecoin Core 2.3.0.0*

```bash
dimecoin-cli -mainnet encryptwallet "test"
```

Result:

```text
Wallet encrypted; Dimecoin Core server stopping, restart to run with encrypted wallet.
The keypool has been flushed and a new HD seed was generated (if you are using
HD). You need to make a new backup.

```

```{seealso}
* [WalletPassphrase](../api/rpc-wallet.md#walletpassphrase): stores the wallet decryption key in memory for the indicated number of seconds. Issuing the `walletpassphrase` command while the wallet is already unlocked will set a new unlock time that overrides the old one.
* [WalletLock](../api/rpc-wallet.md#walletlock): removes the wallet encryption key from memory, locking the wallet. After calling this method, you will need to call `walletpassphrase` again before being able to call any methods which require the wallet to be unlocked.
* [WalletPassphraseChange](../api/rpc-wallet.md#walletpassphrasechange): changes the wallet passphrase from 'old passphrase' to 'new passphrase'.
```

### GetAddressInfo

```{note}
Requires [wallet](../reference/glossary.md#wallet) support (**unavailable on masternodes**).
```

The [`getaddressinfo` RPC](../api/rpc-wallet.md#getaddressinfo) returns information about the given Dimecoin address.

```{important}
Some information requires the address to be in the wallet.
```

*Parameter #1---a P2PKH or P2SH address*

| Name    | Type            | Presence                | Description |
| ------- | --------------- | ----------------------- | ----------- |
| Address | string (base58) | Required<br>(exactly 1) | The P2PKH or P2SH address encoded in base58check format |

*Result---returns information about the address*

| Name                       | Type             | Presence                | Description |
| -------------------------- | ---------------- | ----------------------- | ----------- |
| `result`                   | object           | Required<br>(exactly 1) | Information about the address |
| →<br>`address`             | string (base58)  | Required<br>(exactly 1) | The Dimecoin address given as parameter |
| →<br>`scriptPubKey`        | string (hex)     | Required<br>(exactly 1) | The hex encoded scriptPubKey generated by the address |
| →<br>`ismine`              | bool             | Required<br>(exactly 1) | Set to `true` if the address belongs to the wallet; set to false if it does not.  Only returned if wallet support enabled |
| →<br>`iswatchonly`         | bool             | Required<br>(exactly 1) | Set to `true` if the address is watch-only.  Otherwise set to `false`.  Only returned if address is in the wallet |
| →<br>`isscript`            | bool             | Required<br>(exactly 1) | Whether or not the key is a script |
| →<br>`desc`                | string           | Optional<br>(0 or 1)    | A descriptor for spending coins sent to this address (only present when `solvable` is `true`) |
| →<br>`isscript`            | bool             | Required<br>(exactly 1) | Set to `true` if a P2SH address; otherwise set to `false`.  Only returned if the address is in the wallet |
| →<br>`witness_version`     | numeric          | Optional                | Version number of the witness program |
| →<br>`witness_program`     | string           | Optional                | Hex vcale of the witness program      |
| →<br>`ischange`            | bool             | Required<br>(exactly 1) | Set to `true` if the address was used for change output. |
| →<br>`script`              | string           | Optional<br>(0 or 1)    | Only returned for P2SH addresses belonging to this wallet. This is the type of script:<br>• `pubkey` for a P2PK script inside P2SH<br>• `pubkeyhash` for a P2PKH script inside P2SH<br>• `multisig` for a multisig script inside P2SH<br>• `nonstandard` for unknown scripts |
| →<br>`hex`                 | string (hex)     | Optional<br>(0 or 1)    | Only returned for P2SH addresses belonging to this wallet.  This is the redeem script encoded as hex |
| →<br>`pubkeys`             | array            | Optional<br>(0 or 1)    | Array of pubkeys associated with the known redeemscript (only if `script` is "multisig") |
| → →<br>Pubkey              | string           | Optional<br>(0 or more) | A public key |
| →<br>`addresses`           | array            | Optional<br>(0 or 1)    | Array of addresses associated with the known redeemscript (only if "script" is "multisig"). |
| → →<br>Address             | string           | Optional<br>(0 or more) | An address. |
| →<br>`sigsrequired`        | number (int)     | Optional<br>(0 or 1)    | Only returned for multisig P2SH addresses belonging to the wallet.  The number of signatures required by this script |
| →<br>`pubkey`              | string (hex)     | Optional<br>(0 or 1)    | The public key corresponding to this address.  Only returned if the address is a P2PKH address in the wallet |
| →<br>`iscompressed`        | bool             | Optional<br>(0 or 1)    | Set to `true` if a compressed public key or set to `false` if an uncompressed public key.  Only returned if the address is a P2PKH address in the wallet |
| →<br>`label`               | string           | Optional<br>(0 or 1)    | The label associated with the address. Defaults to "". Replaced by the labels array below. |
| →<br>`timestamp`           | number (int)     | Optional<br>(0 or 1)    | The creation time of the key if available in seconds since epoch (Jan 1 1970 GMT) |
| →<br>`hdkeypath`           | string           | Optional<br>(0 or 1)    | The HD keypath if the key is HD and available |
| →<br>`hdmasterkeyid`       | string           | Optional<br>(0 or 1)    | Hash160 of the HD master pubkey |
| →<br>`labels`              | array            | Optional<br>(0 or 1)    | Array of labels associated with the address. |
| →→<br>Label Data           | object           | Optional<br>(0 or 1)    | JSON object containing label data |
| →→→<br>`name`              | string           | Optional<br>(0 or 1)    | The label |
| →→→<br>`purpose`           | string           | Optional<br>(0 or 1)    | Purpose of address (`send` for sending address, `receive` for receiving address) |

*Example from Dimecoin Core 2.3.0.0*

Get info for the following P2PKH address from the wallet:

```bash
dimecoin-cli getaddressinfo "7S9BMYB3QQwARC3UpnTKFQcGBsoZWpwWA7"
```

Result:

```json
{
  "address": "7S9BMYB3QQwARC3UpnTKFQcGBsoZWpwWA7",
  "scriptPubKey": "76a914fd12e36177dd3a0a5736be7aa319ab02ebab2c0888ac",
  "ismine": true,
  "iswatchonly": false,
  "isscript": false,
  "iswitness": false,
  "pubkey": "0283fe2d0a3f1fdf5fd228d8c97a0e5b020c26ae0ae021a71ba6ff719198661680",
  "iscompressed": true,
  "label": "",
  "timestamp": 1695663614,
  "hdkeypath": "m/0'/0'/5'",
  "hdmasterkeyid": "de16ce029a24193c206b136d62300c1777b9ed63",
  "labels": [
    {
      "name": "",
      "purpose": "receive"
    }
  ]
}
```

Get info for the following P2SH multisig address from the wallet:

```bash
dimecoin-cli -mainnet getaddressinfo 8uJLxDxk2gEMbidF5vT8XLS2UCgQmVcroW
```

Result:

```json
{
  "address": "8uJLxDxk2gEMbidF5vT8XLS2UCgQmVcroW",
  "scriptPubKey": "a914a33155e490d146e656a9bac2cbee9c625ef42f0a87",
  "ismine": false,
  "solvable": false,
  "iswatchonly": false,
  "isscript": true,
  "ischange": false,
  "labels": [
  ]
}
```

```{seealso}
* [ImportAddress](../api/rpc-wallet.md#importaddress): adds an address or pubkey script to the wallet without the associated private key, allowing you to watch for transactions affecting that address or pubkey script without being able to spend any of its outputs.
* [GetNewAddress](../api/rpc-wallet.md#getnewaddress): returns a new DIME address for receiving payments. If an account is specified, payments received with the address will be credited to that account.
* [ValidateAddress](../api/rpc-utility.md#validateaddress): returns information about the given DIME address.
```

### GetAddressesByLabel

```{note}
Requires [wallet](../reference/glossary.md#wallet) support (**unavailable on masternodes**)
```

The [`getaddressesbylabel` RPC](../api/rpc-wallet.md#getaddressesbylabel) returns a list of every address assigned to a particular label.

*Parameter #1---the label name*

| Name  | Type   | Presence                | Description                                                                                                                          |
| ----- | ------ | ----------------------- | ------------------------------------------------------------------------------------------------------------------------------------ |
| Label | string | Required<br>(exactly 1) | The name of the label associated with the addresses to get.  To get addresses from the default account, pass an empty string (`""`). |

*Result---a list of addresses*

| Name        | Type   | Presence                | Description                                                                         |
| ----------- | ------ | ----------------------- | ----------------------------------------------------------------------------------- |
| `result`    | object | Required<br>(exactly 1) | A JSON object containing all addresses belonging to the specified label as keys.    |
| →Address    | object | Optional<br>(1 or more) | A JSON object with information about a P2PKH or P2SH address belonging to the label |
| →→`purpose` | string | Optional<br>(1 or more) | Purpose of address (`send` for sending address, `receive` for receiving address)    |

*Example from Dimecoin Core 2.3.0.0*

Get the addresses assigned to the label "test":

```bash
dimecoin-cli -mainnet getaddressesbylabel "test"
```

Result:

```json
{
  "7DAUpYSaWUFvP7PJbYoWb9gJg9xEmMiPYU": {
    "purpose": "receive"
  }
}
```

```{seealso}
* [GetAccount](../api/rpc-wallet-deprecated.md#getaccount): returns the name of the account associated with the given address.
* [GetBalance](../api/rpc-wallet.md#getbalance): gets the balance in decimal DIME across all accounts or for a particular account.
```

### GetBalance

```{note}
Requires [wallet](../reference/glossary.md#wallet) support (**unavailable on masternodes**)
```

The [`getbalance` RPC](../api/rpc-wallet.md#getbalance) gets the total *available balance* in DIME. The *available balance* is what the wallet considers currently spendable, and is thus affected by options which limit spendability such as `-spendzeroconfchange`.

*Parameter #1---unused parameter*

| Name   | Type   | Presence             | Description                                                                                                                                                       |
| ------ | ------ | -------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Unused | string | Optional<br>(0 or 1) | **Deprecated: (previously account) will be removed in a later version of Dimecoin Core**<br><br>Remains for backward compatibility. Must be excluded or set to `"*"`. |

*Parameter #2---the minimum number of confirmations*

| Name          | Type         | Presence             | Description                                                                                                                                                                                                                                                                                                                                                                                            |
| ------------- | ------------ | -------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| Confirmations | number (int) | Optional<br>(0 or 1) | The minimum number of confirmations an externally-generated transaction must have before it is counted towards the balance.  Transactions generated by this node are counted immediately.  Typically, externally-generated transactions are payments to this wallet and transactions generated by this node are payments to other wallets.  Use `0` to count unconfirmed transactions.  Default is `1` |

*Parameter #3---whether to add the balance from transactions locked via InstantSend*

| Name      | Type | Presence                | Description                                          |
| --------- | ---- | ----------------------- | ---------------------------------------------------- |
| addlocked | bool | Optional<br>(exactly 1) | Add the balance from InstantSend locked transactions |

*Parameter #4---whether to include watch-only addresses*

| Name               | Type | Presence             | Description                                                                                                                                                                                                                                                                                                                                                 |
| ------------------ | ---- | -------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Include Watch-Only | bool | Optional<br>(0 or 1) | If set to `true`, include watch-only addresses in details and calculations as if they were regular addresses belonging to the wallet.  If set to `false` (the default for non-watching only wallets), treat watch-only addresses as if they didn't belong to this wallet.<br>As of Dimecoin Core 18.1, `true` is used as the default for watching-only wallets. |

*Parameter #5---avoids partial respends*

| Name        | Type | Presence             | Description                                                                                                                 |
| ----------- | ---- | -------------------- | --------------------------------------------------------------------------------------------------------------------------- |
| avoid_reuse | bool | Optional<br>(0 or 1) | Do not include balance in dirty outputs; addresses are considered dirty if they have previously been used in a transaction. |

*Result---the balance in DIME*

| Name     | Type          | Presence                | Description                                          |
| -------- | ------------- | ----------------------- | ---------------------------------------------------- |
| `result` | number (DIME) | Required<br>(exactly 1) | The balance of the account (or all accounts) in DIME |

*Examples from Dimecoin Core 2.3.0.0*

Get the balance, including transactions with at least three confirmations and those spent to watch-only addresses. Do not include InstantSend locked transactions.

```bash
dimecoin-cli -mainnet getbalance "*" 3 false true
```

Result:

```json
0.00000
```

Get the balance, including transactions with at least three confirmations and those spent to watch-only addresses. Include the balance from InstantSend locked transactions.

```bash
dimecoin-cli -mainnet getbalance "" 3 true true
```

Result:

```json
1.00000
```

```{seealso}
* [ListAccounts](../api/rpc-removed.md#listaccounts): lists accounts and their balances.
* [GetReceivedByAccount](../api/rpc-removed.md#getreceivedbyaccount): returns the total amount received by addresses in a particular account from transactions with the specified number of confirmations.  It does not count coinbase transactions.
* [GetReceivedByAddress](../api/rpc-wallet.md#getreceivedbyaddress): returns the total amount received by the specified address in transactions with the specified number of confirmations. It does not count coinbase transactions.
```

### GetNewAddress

>
> Requires [wallet](../reference/glossary.md#wallet) support (**unavailable on masternodes**)

The [`getnewaddress` RPC](../api/rpc-wallet.md#getnewaddress) returns a new DIME address for receiving payments. If `label` is specified, the address is added to the address book so payments received with the address will be associated with `label`.

*Parameter #1---an account name*

| Name    | Type   | Presence             | Description                                                                                                                                                                                                                                                               |
| ------- | ------ | -------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `label` | string | Optional<br>(0 or 1) | The label name for the address to be linked to. If not provided, the default label `""` is used. It can also be set to the empty string `""` to represent the default label. The label does not need to exist, it will be created if there is no label by the given name. |

*Result---a DIME address never previously returned*

| Name     | Type            | Presence                | Description           |
| -------- | --------------- | ----------------------- | --------------------- |
| `result` | string (base58) | Required<br>(exactly 1) | The new DIME address. |

*Example from Dimecoin Core 2.3.0.0*

Create a new address in the "test" account:

```bash
dimecoin-cli -mainnet getnewaddress "test"
```

Result:

```text
7DAUpYSaWUFvP7PJbYoWb9gJg9xEmMiPYU
```

```{seealso}
* [GetAccountAddress](../api/rpc-wallet-deprecated.md#getaccountaddress): returns the current Dimecoin address for receiving payments to this account. If the account doesn't exist, it creates both the account and a new address for receiving payment.  Once a payment has been received to an address, future calls to this RPC for the same account will return a different address.
* [GetRawChangeAddress](../api/rpc-wallet.md#getrawchangeaddress): returns a new Dimecoin address for receiving change. This is for use with raw transactions, not normal use.
* [GetBalance](../api/rpc-wallet.md#getbalance): gets the balance in decimal DIME across all accounts or for a particular account.
```

### GetRawChangeAddress

```{note}
Requires [wallet](../reference/glossary.md#wallet) support (**unavailable on masternodes**)
```

The [`getrawchangeaddress` RPC](../api/rpc-wallet.md#getrawchangeaddress) returns a new DIME address for receiving change. This is for use with raw transactions, not normal use.

*Parameters: none*

*Result---a P2PKH address which can be used in raw transactions*

| Name     | Type            | Presence                | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| -------- | --------------- | ----------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `result` | string (base58) | Required<br>(exactly 1) | A P2PKH address which has not previously been returned by this RPC.  The address will be removed from the keypool but not marked as a receiving address, so RPCs such as the [`dumpwallet` RPC](../api/rpc-wallet.md#dumpwallet) will show it as a change address.  The address may already have been part of the keypool, so other RPCs such as the [`dumpwallet` RPC](../api/rpc-wallet.md#dumpwallet) may have disclosed it previously.  If the wallet is unlocked, its keypool will also be filled to its max (by default, 100 unused keys).  If the wallet is locked and its keypool is empty, this RPC will fail |

*Example from Dimecoin Core 2.3.0.0*

```bash
dimecoin-cli -mainnet getrawchangeaddress
```

Result:

```text
7E6mZQV4Yv31vgAjncwS6aarecgXf8gsKw
```

```{seealso}
* [GetNewAddress](../api/rpc-wallet.md#getnewaddress): returns a new DIME address for receiving payments. If an account is specified, payments received with the address will be credited to that account.
* [GetAccountAddress](../api/rpc-wallet-deprecated.md#getaccountaddress): returns the current Dimecoin address for receiving payments to this account. If the account doesn't exist, it creates both the account and a new address for receiving payment.  Once a payment has been received to an address, future calls to this RPC for the same account will return a different address.
```

### GetReceivedByAddress

```{note}
Requires [wallet](../reference/glossary.md#wallet) support (**unavailable on masternodes**)

*This RPC only returns a balance for addresses contained in the local wallet.*
```

The [`getreceivedbyaddress` RPC](../api/rpc-wallet.md#getreceivedbyaddress) returns the total amount received by the specified address in transactions with the specified number of confirmations. It does not count coinbase transactions.

*Parameter #1---the address*

| Name    | Type   | Presence                | Description                                                                                                        |
| ------- | ------ | ----------------------- | ------------------------------------------------------------------------------------------------------------------ |
| Address | string | Required<br>(exactly 1) | **Only works for addresses contained in the local wallet**<br><br>The address whose transactions should be tallied |

*Parameter #2---the minimum number of confirmations*

| Name          | Type         | Presence             | Description                                                                                                                                                                                                                                                                                                                                                                                            |
| ------------- | ------------ | -------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| Confirmations | number (int) | Optional<br>(0 or 1) | The minimum number of confirmations an externally-generated transaction must have before it is counted towards the balance.  Transactions generated by this node are counted immediately.  Typically, externally-generated transactions are payments to this wallet and transactions generated by this node are payments to other wallets.  Use `0` to count unconfirmed transactions.  Default is `1` |

*Parameter #3---whether to include transactions locked via InstantSend* *Not currently available in Dimecoin Core*

| Name      | Type | Presence                | Description                                          |
| --------- | ---- | ----------------------- | ---------------------------------------------------- |
| addlocked | bool | Optional<br>(exactly 1) | Add the balance from InstantSend locked transactions |

*Result---the amount of DIME received*

| Name     | Type          | Presence                | Description                                                                              |
| -------- | ------------- | ----------------------- | ---------------------------------------------------------------------------------------- |
| `result` | number (DIME) | Required<br>(exactly 1) | The amount of DIME received by the address, excluding coinbase transactions.  May be `0` |

*Example from Dimecoin Core 2.3.0.0*

Get the DIME received for a particular address, only counting  
transactions with six or more confirmations (ignore InstantSend locked transactions):

```bash
dimecoin-cli -mainnet getreceivedbyaddress 7E6mZQV4Yv31vgAjncwS6aarecgXf8gsKw 6
```

Result:

```json
125.00000
```

Get the DIME received for a particular address, only counting  
transactions with six or more confirmations (include InstantSend locked transactions):

```bash
dimecoin-cli -mainnet getreceivedbyaddress 7E6mZQV4Yv31vgAjncwS6aarecgXf8gsKw 6 true
```

Result:

```json
0.30000
```

```{seealso}
* [GetReceivedByAccount](../api/rpc-removed.md#getreceivedbyaccount): returns the total amount received by addresses in a particular account from transactions with the specified number of confirmations.  It does not count coinbase transactions.
* [GetAddressesByAccount](../api/rpc-wallet-deprecated.md#getaddressesbyaccount): returns a list of every address assigned to a particular account.
* [ListAccounts](../api/rpc-removed.md#listaccounts): lists accounts and their balances.
```

### GetReceivedByLabel

```{note}
Requires [wallet](../reference/glossary.md#wallet) support (**unavailable on masternodes**)
```

The [`getreceivedbylabel` RPC](../api/rpc-wallet.md#getreceivedbylabel) returns the total amount received by addresses with <label> in transactions with specified minimum number of confirmations.

*Parameter #1---the label name*

| Name  | Type   | Presence                | Description                                              |
| ----- | ------ | ----------------------- | -------------------------------------------------------- |
| Label | string | Required<br>(exactly 1) | The selected label, may be the default label using `""`. |

*Parameter #2---the minimum number of confirmations*

| Name          | Type         | Presence             | Description                                                                                                                                                      |
| ------------- | ------------ | -------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Confirmations | number (int) | Optional<br>(0 or 1) | The minimum number of confirmations a transaction must have before it is counted towards the balance. Use `0` to count unconfirmed transactions.  Default is `1` |

*Parameter #3---whether to include transactions locked via InstantSend*

| Name      | Type | Presence                | Description                                                          |
| --------- | ---- | ----------------------- | -------------------------------------------------------------------- |
| addlocked | bool | Optional<br>(exactly 1) | Add the balance from InstantSend locked transactions (default=false) |

*Result---the number of DIME received*

| Name     | Type          | Presence                | Description                                                   |
| -------- | ------------- | ----------------------- | ------------------------------------------------------------- |
| `result` | number (DIME) | Required<br>(exactly 1) | The total amount of DIME received for this label.  May be `0` |

*Example from Dimecoin Core 2.3.0.0*

Get the DIME received by the "test" label with six or more confirmations:

```bash
dimecoin-cli -mainnet getreceivedbylabel "test" 6
```

Result:

```json
0.30000
```

```{seealso}
* [GetReceivedByAddress](../api/rpc-wallet.md#getreceivedbyaddress): returns the total amount received by the specified address in transactions with the specified number of confirmations. It does not count coinbase transactions.
* [GetAddressesByLabel](../api/rpc-wallet.md#getaddressesbylabel): returns a list of every address assigned to a particular label.
* [ListLabels](../api/rpc-wallet.md#listlabels): lists labels.
```

```{eval-rst}
.. _api-rpc-wallet-gettransaction:
```

### GetTransaction

```{note}
Requires [wallet](../reference/glossary.md#wallet) support (**unavailable on masternodes**)
```

The [`gettransaction` RPC](../api/rpc-wallet.md#gettransaction) gets detailed information about an in-wallet transaction.

*Parameter #1---a transaction identifier (TXID)*

| Name | Type         | Presence                | Description                                                                                          |
| ---- | ------------ | ----------------------- | ---------------------------------------------------------------------------------------------------- |
| TXID | string (hex) | Required<br>(exactly 1) | The TXID of the transaction to get details about.  The TXID must be encoded as hex in RPC byte order |

*Parameter #2---whether to include watch-only addresses in details and calculations*

| Name               | Type | Presence             | Description                                                                                                                                                                                                                                                                                                                                         |
| ------------------ | ---- | -------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Include Watch-Only | bool | Optional<br>(0 or 1) | If set to `true`, include watch-only addresses in details and calculations as if they were regular addresses belonging to the wallet.  If set to `false` (the default for non-watching only wallets), treat watch-only addresses as if they didn't belong to this wallet. |

*Parameter #3---whether or not to include the decoded transaction*

| Name    | Type | Presence                | Description                                                                                                      |
| ------- | ---- | ----------------------- | ---------------------------------------------------------------------------------------------------------------  |
| verbose | bool | Optional<br>(exactly 1) | Whether to include a `decoded` field containing the decoded transaction (equivalent to RPC [`decoderawtransaction`](../api/rpc-raw-transactions.md#decoderawtransaction)) |

*Result---a description of the transaction*

| Name                         | Type            | Presence                    | Description                                                                                                                                                                                                                                                                                                                                                                                   |
| ---------------------------- | --------------- | --------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `result`                     | object          | Required<br>(exactly 1)     | An object describing how the transaction affects the wallet                                                                                                                                                                                                                                                                                                                                   |
| →<br>`amount`                | number (DIME)   | Required<br>(exactly 1)     | A positive number of DIME if this transaction increased the total wallet balance; a negative number of DIME if this transaction decreased the total wallet balance, or `0` if the transaction had no net effect on wallet balance                                                                                                                                                             |
| →<br>`fee`                   | number (DIME)   | Optional<br>(0 or 1)        | If an outgoing transaction, this is the fee paid by the transaction reported as negative DIME                                                                                                                                                                                                                                                                                                 |
| → <br>`confirmations`        | number (int)    | Required<br>(exactly 1)     | The number of confirmations the transaction has received.  Will be `0` for unconfirmed and `-1` for conflicted                                                                                                                                                                                                                                                                                |
| → <br>`blockhash`            | string (hex)    | Optional<br>(0 or 1)        | The hash of the block on the local best blockchain which includes this transaction, encoded as hex in RPC byte order.  Only returned for confirmed transactions |
| → <br>`blockindex`           | number (int)    | Optional<br>(0 or 1)        | The index of the transaction in the block that includes it.  Only returned for confirmed transactions |
| → <br>`blocktime`            | number (int)    | Optional<br>(0 or 1)        | The block header time (Unix epoch time) of the block on the local best blockchain which includes this transaction.  Only returned for confirmed transactions |
| → <br>`trusted`              | bool            | Optional<br>(0 or 1)        | Whether we consider the outputs of this unconfirmed transaction safe to spend. Only returned for unconfirmed transactions |
| → <br>`txid`                 | string (hex)    | Required<br>(exactly 1)     | The TXID of the transaction, encoded as hex in RPC byte order                                                                                                                                                                                                                                                                                                                                 |
| → <br>`walletconflicts`      | array           | Required<br>(exactly 1)     | An array containing the TXIDs of other transactions that spend the same inputs (UTXOs) as this transaction.  Array may be empty                                                                                                                                                                                                                                                               |
| → →<br>TXID                  | string (hex)    | Optional<br>(0 or more)     | The TXID of a conflicting transaction, encoded as hex in RPC byte order                                                                                                                                                                                                                                                                                                                       |
| → <br>`time`                 | number (int)    | Required<br>(exactly 1)     | A Unix epoch time when the transaction was added to the wallet                                                                                                                                                                                                                                                                                                                                |
| → <br>`timereceived`         | number (int)    | Required<br>(exactly 1)     | A Unix epoch time when the transaction was detected by the local node, or the time of the block on the local best blockchain that included the transaction                                                                                                                                                                                                                                   |
| → <br>`abandoned`            | bool            | Optional<br>(0 or 1)        | `true` if the transaction has been abandoned (inputs are respendable). Only available for the 'send' category of transactions.                                                                                                                                                                                                                                                                |
| → <br>`comment`              | string          | Optional<br>(0 or 1)        | For transaction originating with this wallet, a locally-stored comment added to the transaction.  Only returned if a comment was added                                                                                                                                                                                                                                                        |
| → <br>`to`                   | string          | Optional<br>(0 or 1)        | For transaction originating with this wallet, a locally-stored comment added to the transaction identifying who the transaction was sent to.  Only returned if a comment-to was added                                                                                                                                                                                                         |
| →<br>`details`               | array           | Required<br>(exactly 1)     | An array containing one object for each input or output in the transaction which affected the wallet                                                                                                                                                                                                                                                                                          |
| → →<br>`address`             | string (base58) | Optional<br>(0 or 1)        | If an output, the address paid (may be someone else's address not belonging to this wallet).  If an input, the address paid in the previous output.  May be empty if the address is unknown, such as when paying to a non-standard pubkey script                                                                                                                                              |
| → →<br>`category`            | string          | Required<br>(exactly 1)     | Set to one of the following values:<br>• `send` if sending payment normally<br>• `coinjoin` if sending CoinJoin payment<br>• `receive` if this wallet received payment in a regular transaction<br>• `generate` if a matured and spendable coinbase<br>• `immature` if a coinbase that is not spendable yet<br>• `orphan` if a coinbase from a block that's not in the local best blockchain |
| → →<br>`amount`              | number (DIME)   | Required<br>(exactly 1)     | A negative DIME amount if sending payment; a positive DIME amount if receiving payment (including coinbases)                                                                                                                                                                                                                                                                                  |
| → →<br>`label`               | string          | Optional<br>(0 or 1)        | An optional comment for the address/transaction                                                                                                                                                                                                                                                                                                                                               |
| → →<br>`vout`                | number (int)    | Required<br>(exactly 1)     | For an output, the output index (vout) for this output in this transaction.  For an input, the output index for the output being spent in its transaction.  Because inputs list the output indexes from previous transactions, more than one entry in the details array may have the same output index                                                                                        |
| → →<br>`fee`                 | number (DIME)   | Optional<br>(0 or 1)        | If sending payment, the fee paid as a negative DIME value.  May be `0`.  Not returned if receiving payment                                                                                                                                                                                                                                                                                    |
| → →<br>`abandoned`           | bool            | Optional<br>(0 or 1)        | Indicates if a transaction is was abandoned:<br>• `true` if it was abandoned (inputs are respendable)<br>• `false`  if it was not abandoned<br>Only returned by *send* category payments                                                                                                                                                                |
| →<br>`hex`                   | string (hex)    | Required<br>(exactly 1)     | The transaction in serialized transaction format                                                                                                                                                                                                                                                                                                                                              |
| →<br>`data`               | object          | Optional<br>(0 or 1)        | The decoded transaction (only present when `verbose` is passed), equivalent to the RPC [`decoderawtransaction` method](../api/rpc-raw-transactions.md#decoderawtransaction), or the RPC [`getrawtransaction` method](../api/rpc-raw-transactions.md#getrawtransaction) when `verbose` is passed.                                                                                                                                                                                                                  |

*Example from Dimecoin Core 2.3.0.0*

```bash
dimecoin-cli -mainnet gettransaction \
  c099c882745ad150e9b2a55ef5818683c7ef597e1e5fc20856c67eabc3778ccc
```

Result:

```json
{
  "amount": -5750.00000000,
  "fee": -0.01000000,
  "confirmations": 276000,
  "instantlock": true,
  "instantlock_internal": false,
  "chainlock": true,
  "blockhash": "00000a01007be2912c3123085534b58d341cb5e5980b967e8dcc021089487a1e",
  "blockheight": 65859,
  "blockindex": 1,
  "blocktime": 1553290594,
  "txid": "c099c882745ad150e9b2a55ef5818683c7ef597e1e5fc20856c67eabc3778ccc",
  "walletconflicts": [
  ],
  "time": 1553290594,
  "timereceived": 1688046610,
  "details": [
    {
      "address": "7E6mZQV4Yv31vgAjncwS6aarecgXf8gsKw",
      "category": "send",
      "amount": -50.00000000,
      "label": "test",
      "vout": 1,
      "fee": -0.00030000,
      "abandoned": false
    }
  ],
  "hex": "0200000003aac865dba0e98fe32533df6bc3eaac160d04bb02966584fb61fc8d7788e09537010000006a47304402202d537257f23ab42b3e14f2ab533f39bb4586aa1b29a1f833f718a59493c8a601022019c6c156c20e66ef256519592b3c977b64d417c94aea4dca20cf18522a138993012103c67d86944315838aea7ec80d390b5d09b91b62483370d4979da5ccf7a7df77a9feffffff47833a270d2e2bac47bc5dc0df576c3a68b01bedbc89692060ac4113a6f9cb67010000006a4730440220442c19a913b10edc533bf63310f5294d6d91eec0eb9c510a3c6b0f33333f27320220501d5093ecdf603b8af9734e21d5de4710c8500309bfa4acdda243a294442b2c012103c67d86944315838aea7ec80d390b5d09b91b62483370d4979da5ccf7a7df77a9feffffffdcfd2d0fb30d79ffeadab8832e65be2310b67043ff3d74deac9a9cb825acda67000000006b483045022100cae8c025d3bec82903f356a5ec38d78a141447b6562e3aceac901f5fcc6f8567022076407835937514d6690c81c0c3b97f92d2b0ae9749249affaf539ead825692f4012102d6be44ab930ff67f084fbaf47a38b539b8d5da65c010952a972c9e524b6009dffeffffff0204fe2b00000000001976a914e3b0093477c2f629430d0a7b5813fe8b0153b0fd88ac00f2052a010000001976a914ae4365dedb1836ba215b9149602e0787a23376d288ac42010100"
}
```

```{seealso}
* [GetRawTransaction](../api/rpc-raw-transactions.md#getrawtransaction): gets a hex-encoded serialized transaction or a JSON object describing the transaction. By default, Dimecoin Core only stores complete transaction data for UTXOs and your own transactions, so the RPC may fail on historic transactions unless you use the non-default `txindex=1` in your Dimecoin Core startup settings.
```

### GetUnconfirmedBalance

```{note}
Requires [wallet](../reference/glossary.md#wallet) support (**unavailable on masternodes**)
```

The [`getunconfirmedbalance` RPC](../api/rpc-wallet.md#getunconfirmedbalance) returns the wallet's total unconfirmed balance.

*Parameters: none*

*Result---the balance of unconfirmed transactions paying this wallet*

| Name     | Type          | Presence                | Description                                                              |
| -------- | ------------- | ----------------------- | ------------------------------------------------------------------------ |
| `result` | number (DIME) | Required<br>(exactly 1) | The total number of DIME paid to this wallet in unconfirmed transactions |

*Example from Dimecoin Core 2.3.0.0*

```bash
dimecoin-cli -mainnet getunconfirmedbalance
```

Result (no unconfirmed incoming payments):

```json
0.00000
```

```{seealso}
* [GetBalance](../api/rpc-wallet.md#getbalance): gets the balance in decimal DIME across all accounts or for a particular account.
```

### GetWalletInfo

```{note}
Requires [wallet](../reference/glossary.md#wallet) support (**unavailable on masternodes**)
```

The [`getwalletinfo` RPC](../api/rpc-wallet.md#getwalletinfo) provides information about the wallet.

*Parameters: none*

*Result---information about the wallet*

| Name                           | Type             | Presence                | Description |
| ------------------------------ | ---------------- | ----------------------- | ----------- |
| `result`                       | object           | Required<br>(exactly 1) | An object describing the wallet |
| →<br>`walletname`              | string           | Required<br>(exactly 1) | The name of the wallet |
| →<br>`walletversion`           | number (int)     | Required<br>(exactly 1) | The version  |
| →<br>`balance`                 | number (DIME)    | Required<br>(exactly 1) | The total confirmed balance of the wallet.  The same as returned by the [`getbalance` RPC](../api/rpc-wallet.md#getbalance) with default parameters |
| →<br>`unconfirmed_balance`     | number (DIME)    | Required<br>(exactly 1) | The total unconfirmed balance of the wallet.  The same as returned by the [`getunconfirmedbalance` RPC](../api/rpc-wallet.md#getunconfirmedbalance) with default parameters. Identical to `getbalances().mine.untrusted_pending`. |
| →<br>`immature_balance`        | number (DIME)    | Required<br>(exactly 1) | The total immature balance of the wallet.  This includes mining/masternode rewards that cannot be spent yet. Identical to `getbalances().mine.immature`. |
| →<br>`txcount`                 | number (int)     | Required<br>(exactly 1) | The total number of transactions in the wallet (both spends and receives) |
| →<br>`keypoololdest`           | number (int)     | Required<br>(exactly 1) | The date as Unix epoch time when the oldest key in the wallet key pool was created; useful for only scanning blocks created since this date for transactions |
| →<br>`keypoolsize`             | number (int)     | Required<br>(exactly 1) | The number of keys in the wallet keypool |
| →<br>`keypoolsize_hd_internal` | number (int)     | Optional<br>(0 or 1)    | How many new keys are pre-generated for internal use (used for change outputs, only appears if the wallet is using this feature, otherwise external keys are used) |
| →<br>`unlocked_until`          | number (int)     | Optional<br>(0 or 1)    | Only returned if the wallet was encrypted with the [`encryptwallet` RPC](../api/rpc-wallet.md#encryptwallet). A Unix epoch date when the wallet will be locked, or `0` if the wallet is currently locked |
| →<br>`paytxfee`                | number (float)   | Required<br>(exactly 1) | The transaction fee configuration, set in DIME/kB |
| →<br>`hdmasterkeyid`           | string (hash)    | Optional<br>(0 or 1)    | The Hash160 of the HD master pubkey (only present when HD is enabled) |

*Example from Dimecoin Core 2.3.0.0*

```bash
dimecoin-cli -mainnet getwalletinfo
```

Result:

```json
{
  "walletname": "",
  "walletversion": 159900,
  "balance": 3750252.25594,
  "unconfirmed_balance": 0.00000,
  "immature_balance": 0.00000,
  "txcount": 20,
  "keypoololdest": 1695663615,
  "keypoolsize": 997,
  "keypoolsize_hd_internal": 999,
  "unlocked_until": 0,
  "paytxfee": 1.00000,
  "hdmasterkeyid": "XXXXXXa24193cZzzzzzz06b136XXXXXXX0c1777b9675345"
}
```

```{seealso}
* [ListTransactions](../api/rpc-wallet.md#listtransactions): returns the most recent transactions that affect the wallet.
```

### ImportAddress

```{note}
Requires [wallet](../reference/glossary.md#wallet) support (**unavailable on masternodes**)
```

The [`importaddress` RPC](../api/rpc-wallet.md#importaddress) adds an address or pubkey script to the wallet without the associated private key, allowing you to watch for transactions affecting that address or pubkey script without being able to spend any of its outputs.

*Parameter #1---the address or pubkey script to watch*

| Name              | Type                   | Presence                | Description                                                                              |
| ----------------- | ---------------------- | ----------------------- | ---------------------------------------------------------------------------------------- |
| Address or Script | string (base58 or hex) | Required<br>(exactly 1) | Either a P2PKH or P2SH address encoded in base58check, or a pubkey script encoded as hex |

*Parameter #2---The account into which to place the address or pubkey script*

| Name  | Type   | Presence             | Description                                          |
| ----- | ------ | -------------------- | ---------------------------------------------------- |
| Label | string | Optional<br>(0 or 1) | An optional label.  Default is an empty string(\\")" |

*Parameter #3---whether to rescan the blockchain*

| Name   | Type | Presence             | Description                                                                                                                                                                                                                                                                                                                                                                                                                |
| ------ | ---- | -------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Rescan | bool | Optional<br>(0 or 1) | Set to `true` (the default) to rescan the entire local block database for transactions affecting any address or pubkey script in the wallet (including transaction affecting the newly-added address or pubkey script).  Set to `false` to not rescan the block database (rescanning can be performed at any time by restarting Dimecoin Core with the `-rescan` command-line argument).  Rescanning may take several minutes. |

*Parameter #4---whether to rescan the blockchain*

| Name | Type | Presence             | Description                                |
| ---- | ---- | -------------------- | ------------------------------------------ |
| P2SH | bool | Optional<br>(0 or 1) | Add the P2SH version of the script as well |

*Result---`null` on success*

| Name     | Type | Presence                | Description                                                                                                             |
| -------- | ---- | ----------------------- | ----------------------------------------------------------------------------------------------------------------------- |
| `result` | null | Required<br>(exactly 1) | If the address or pubkey script is added to the wallet (or is already part of the wallet), JSON `null` will be returned |

*Example from Dimecoin Core 2.3.0.0*

Add an address, rescanning the local block database for any transactions  
matching it.

```bash
dimecoin-cli -mainnet importaddress \
  7DAUpYSaWUFvP7PJbYoWb9gJg9xEmMiPYU "watch-only test" true
```

Result:

(No output; success.)

Show that the address has been added:

```bash
dimecoin-cli -mainnet getaccount 7DAUpYSaWUFvP7PJbYoWb9gJg9xEmMiPYU
```

Result:

```text
watch-only test
```

```{seealso}
* [ImportPrivKey](../api/rpc-wallet.md#importprivkey): adds a private key to your wallet. The key should be formatted in the wallet import format created by the [`dumpprivkey` RPC](../api/rpc-wallet.md#dumpprivkey).
* [ListReceivedByAddress](../api/rpc-wallet.md#listreceivedbyaddress): lists the total number of DIME received by each address.
```

### ImportMulti

```{note}
Requires [wallet](../reference/glossary.md#wallet) support (**unavailable on masternodes**). Wallet must be unlocked.
```

The [`importmulti` RPC](../api/rpc-wallet.md#importmulti) imports addresses or scripts (with private keys, public keys, or P2SH redeem scripts) and optionally performs the minimum necessary rescan for all imports.

*Parameter #1---the addresses/scripts to import*

| Name                  | Type                  | Presence                | Description                                                                                                                                                                                                                                                                                                                                                                                                                      |
| --------------------- | --------------------- | ----------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Imports               | array                 | Required<br>(exactly 1) | An array of JSON objects, each one being an address or script to be imported                                                                                                                                                                                                                                                                                                                                                     |
| → Import              | object                | Required<br>(1 or more) | A JSON object describing a particular import                                                                                                                                                                                                                                                                                                                                                                                     |
| → →<br>`scriptPubKey` | string (hex)          | Optional<br>(0 or 1)    | The script (string) to be imported.  Must have either this field or `address` below                                                                                                                                                                                                                                                                                                                                              |
| → →<br>`address`      | string (base58)       | Optional<br>(0 or 1)    | The P2PKH or P2SH address to be imported.  Must have either this field or `scriptPubKey` above                                                                                                                                                                                                                                                                                                                                   |
| → →<br>`timestamp`    | number (int) / string | Required<br>(exactly 1) | The creation time of the key in Unix epoch time or the string “now” to substitute the current synced blockchain time. The timestamp of the oldest key will determine how far back blockchain rescans need to begin. Specify `now` to bypass scanning for keys which are known to never have been used.  Specify `0` to scan the entire blockchain. Blocks up to 2 hours before the earliest key creation time will be scanned |
| → →<br>`redeemscript` | string                | Optional<br>(0 or 1)    | A redeem script. Only allowed if either the `address` field is a P2SH address or the `scriptPubKey` field is a P2SH scriptPubKey                                                                                                                                                                                                                                                                                                 |
| → →<br>`pubkeys`      | array                 | Optional<br>(0 or 1)    | Array of strings giving pubkeys that must occur in the scriptPubKey or redeemscript                                                                                                                                                                                                                                                                                                                                              |
| → →<br>`keys`         | array                 | Optional<br>(0 or 1)    | Array of strings giving private keys whose corresponding public keys must occur in the scriptPubKey or redeemscript                                                                                                                                                                                                                                                                                                              |
| → →<br>`internal`     | bool                  | Optional<br>(0 or 1)    | Stating whether matching outputs should be treated as change rather than incoming payments. The default is `false`                                                                                                                                                                                                                                                                                                               |
| → →<br>`watchonly`    | bool                  | Optional<br>(0 or 1)    | Stating whether matching outputs should be considered watched even when they're not spendable. This is only allowed if keys are empty. The default is `false`                                                                                                                                                                                                                                                                    |
| → →<br>`label`        | string                | Optional<br>(0 or 1)    | Label to assign to the address, only allowed with `internal` set to `false`. The default is an empty string (“”)                                                                                                                                                                                                                                                                                                                 |

*Parameter #2---options regarding the import*

| Name           | Type   | Presence             | Description                                                                                                                                                                                                                                                                                       |
| -------------- | ------ | -------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Option         | object | Optional<br>(0 or 1) | JSON object with options regarding the import                                                                                                                                                                                                                                                     |
| → <br>`rescan` | bool   | Optional<br>(0 or 1) | Set to `true` (the default) to rescan the entire local blockchain for transactions affecting any imported address or script. Set to `false` to not rescan after the import. Rescanning may take a considerable amount of time and may require re-downloading blocks if using blockchain pruning |

*Result---execution result*

| Name                | Type            | Presence                | Description                                                                               |
| ------------------- | --------------- | ----------------------- | ----------------------------------------------------------------------------------------- |
| `result`            | array           | Required<br>(exactly 1) | An array of JSON objects, with each object describing the execution result of each import |
| → Result            | object          | Required<br>(1 or more) | A JSON object describing the execution result of an imported address or script            |
| → → <br>`success`   | string          | Required<br>(exactly 1) | Displays `true` if the import has been successful or `false` if it failed                 |
| → → <br>`error`     | string : object | Optional<br>(0 or 1)    | A JSON object containing details about the error. Only displayed if the import fails      |
| → → → <br>`code`    | number (int)    | Optional<br>(0 or 1)    | The error code                                                                            |
| → → → <br>`message` | string          | Optional<br>(0 or 1)    | The error message                                                                         |

*Example from Dimecoin Core 2.3.0.0*

Import the address `7DAUpYSaWUFvP7PJbYoWb9gJg9xEmMiPYU` (giving it a label and scanning the entire blockchain) and the scriptPubKey `76a9146cf5870411edc31ba5630d61c7cddff55b884fda88ac` (giving a specific timestamp and label):

```bash
dimecoin-cli importmulti '
  [
    {
      "scriptPubKey" : { "address": "7DAUpYSaWUFvP7PJbYoWb9gJg9xEmMiPYU" },
      "timestamp" : 0,
      "label" : "Test"
    },
    {
      "scriptPubKey" : "76a9146cf5870411edc31ba5630d61c7cddff55b884fda88ac",
      "timestamp" : 1493912405,
      "label" : "TestFailure"
    }
  ]' '{ "rescan": true }'
```

Result (scriptPubKey import failed because `internal` was not set to `true`):

```json
[
  {
    "success": true
  },
  {
    "success": false,
    "error": {
      "code": -8,
      "message": "Internal must be set for hex scriptPubKey"
    }
  }
]
```

```{seealso}
* [ImportPrivKey](../api/rpc-wallet.md#importprivkey): adds a private key to your wallet. The key should be formatted in the wallet import format created by the [`dumpprivkey` RPC](../api/rpc-wallet.md#dumpprivkey).
* [ImportAddress](../api/rpc-wallet.md#importaddress): adds an address or pubkey script to the wallet without the associated private key, allowing you to watch for transactions affecting that address or pubkey script without being able to spend any of its outputs.
* [ImportWallet](../api/rpc-wallet.md#importwallet): imports private keys from a file in wallet dump file format (see the [`dumpwallet` RPC](../api/rpc-wallet.md#dumpwallet)). These keys will be added to the keys currently in the wallet.  This call may need to rescan all or parts of the blockchain for transactions affecting the newly-added keys, which may take several minutes.
```

### ImportPrivKey

```{note}
Requires [wallet](../reference/glossary.md#wallet) support (**unavailable on masternodes**). Wallet must be unlocked.
```

The [`importprivkey` RPC](../api/rpc-wallet.md#importprivkey) adds a private key to your wallet. The key should be formatted in the wallet import format created by the [`dumpprivkey` RPC](../api/rpc-wallet.md#dumpprivkey).

*Parameter #1---the private key to import*

| Name        | Type            | Presence                | Description                                                                                       |
| ----------- | --------------- | ----------------------- | ------------------------------------------------------------------------------------------------- |
| Private Key | string (base58) | Required<br>(exactly 1) | The private key to import into the wallet encoded in base58check using wallet import format (WIF) |

*Parameter #2---the account into which the key should be placed*

| Name    | Type   | Presence             | Description                                                                                                                                    |
| ------- | ------ | -------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------- |
| Account | string | Optional<br>(0 or 1) | The name of an account to which transactions involving the key should be assigned.  The default is the default account, an empty string (\\")" |

*Parameter #3---whether to rescan the blockchain*

| Name   | Type | Presence             | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| ------ | ---- | -------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Rescan | bool | Optional<br>(0 or 1) | Set to `true` (the default) to rescan the entire local block database for transactions affecting any address or pubkey script in the wallet (including transaction affecting the newly-added address for this private key).  Set to `false` to not rescan the block database (rescanning can be performed at any time by restarting Dimecoin Core with the `-rescan` command-line argument).  Rescanning may take several minutes.  NOTE: if the address for this key is already in the wallet, the block database will not be rescanned even if this parameter is set |

*Result---`null` on success*

| Name     | Type | Presence                | Description                                                                                                |
| -------- | ---- | ----------------------- | ---------------------------------------------------------------------------------------------------------- |
| `result` | null | Required<br>(exactly 1) | If the private key is added to the wallet (or is already part of the wallet), JSON `null` will be returned |

*Example from Dimecoin Core 2.3.0.0*

Import the private key for the address  
7DAUpYSaWUFvP7PJbYoWb9gJg9xEmMiPYU, giving it a label and scanning the  
entire blockchain:

```bash
dimecoin-cli -mainnet importprivkey \
              7DAUpYSaWUFvP7PJbYoWb9gJg9xEmMiPYU \
              "test" \
              true
```

(Success: no result displayed.)

```{seealso}
* [DumpPrivKey](../api/rpc-wallet.md#dumpprivkey): returns the wallet-import-format (WIP) private key corresponding to an address. (But does not remove it from the wallet.)
* [ImportAddress](../api/rpc-wallet.md#importaddress): adds an address or pubkey script to the wallet without the associated private key, allowing you to watch for transactions affecting that address or pubkey script without being able to spend any of its outputs.
* [ImportPubKey](../api/rpc-wallet.md#importpubkey): imports a public key (in hex) that can be watched as if it were in your wallet but cannot be used to spend
* [ImportWallet](../api/rpc-wallet.md#importwallet): imports private keys from a file in wallet dump file format (see the [`dumpwallet` RPC](../api/rpc-wallet.md#dumpwallet)). These keys will be added to the keys currently in the wallet.  This call may need to rescan all or parts of the blockchain for transactions affecting the newly-added keys, which may take several minutes.
```

### ImportPrunedFunds

```{note}
Requires [wallet](../reference/glossary.md#wallet) support (**unavailable on masternodes**).
*As of Dimecoin Core 2.0.0.0 pruned wallets are not supported*
```

The [`importprunedfunds` RPC](../api/rpc-wallet.md#importprunedfunds) imports funds without the need of a rescan. Meant for use with pruned wallets. Corresponding address or script must previously be included in wallet.  
The end-user is responsible to import additional transactions that subsequently spend the imported  
outputs or rescan after the point in the blockchain the transaction is included.

*Parameter #1---the raw transaction to import*

| Name            | Type            | Presence                | Description                                                            |
| --------------- | --------------- | ----------------------- | ---------------------------------------------------------------------- |
| Raw Transaction | string<br>(hex) | Required<br>(exactly 1) | A raw transaction in hex funding an already-existing address in wallet |

*Parameter #2---the tx out proof that cointains the transaction*

| Name         | Type            | Presence                | Description                                                     |
| ------------ | --------------- | ----------------------- | --------------------------------------------------------------- |
| TX Out Proof | string<br>(hex) | Required<br>(exactly 1) | The hex output from gettxoutproof that contains the transaction |

*Result---`null` on success*

| Name     | Type | Presence                | Description                                                    |
| -------- | ---- | ----------------------- | -------------------------------------------------------------- |
| `result` | null | Required<br>(exactly 1) | If the funds are added to wallet, JSON `null` will be returned |

*Example from Dimecoin Core 1.10.01*

```bash
dimecoin-cli importprunedfunds "txhex" "txoutproof"
```

(Success: no result displayed.)

```{seeealso}
* [ImportPrivKey](../api/rpc-wallet.md#importprivkey): adds a private key to your wallet. The key should be formatted in the wallet import format created by the [`dumpprivkey` RPC](../api/rpc-wallet.md#dumpprivkey).
* [RemovePrunedFunds](../api/rpc-wallet.md#removeprunedfunds): deletes the specified transaction from the wallet. Meant for use with pruned wallets and as a companion to importprunedfunds.
```

### ImportPubKey

The [`importpubkey` RPC](../api/rpc-wallet.md#importpubkey) imports a public key (in hex) that can be watched as if it were in your wallet but cannot be used to spend

*Parameter #1---the public key to import*

| Name       | Type         | Presence                | Description              |
| ---------- | ------------ | ----------------------- | ------------------------ |
| Public Key | string (hex) | Required<br>(exactly 1) | The public key to import |

*Parameter #2---the account into which the key should be placed*

| Name  | Type   | Presence             | Description                          |
| ----- | ------ | -------------------- | ------------------------------------ |
| Label | string | Optional<br>(0 or 1) | The label the key should be assigned |

*Parameter #3---whether to rescan the blockchain*

| Name   | Type | Presence             | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| ------ | ---- | -------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| Rescan | bool | Optional<br>(0 or 1) | Set to `true` (the default) to rescan the entire local block database for transactions affecting any address or pubkey script in the wallet.  Set to `false` to not rescan the block database (rescanning can be performed at any time by restarting Dimecoin Core with the `-rescan` command-line argument).  Rescanning may take several minutes.  NOTE: if the address for this key is already in the wallet, the block database will not be rescanned even if this parameter is set |

*Result---`null` on success*

| Name     | Type | Presence                | Description                                                                                               |
| -------- | ---- | ----------------------- | --------------------------------------------------------------------------------------------------------- |
| `result` | null | Required<br>(exactly 1) | If the public key is added to the wallet (or is already part of the wallet), JSON `null` will be returned |

*Example from Dimecoin Core 2.3.0.0*

Import the public key for the address, giving it a label and scanning the  
entire blockchain:

```bash
dimecoin-cli -mainnet importpubkey \
    623222c61dbc12abfd3a029ae8a6f789c340390c83f1765f99e5e8de98b469fa \
    "test" \
    true
```

(Success: no result displayed.)

```{seealso}
* [ImportAddress](../api/rpc-wallet.md#importaddress): adds an address or pubkey script to the wallet without the associated private key, allowing you to watch for transactions affecting that address or pubkey script without being able to spend any of its outputs.
* [ImportPrivKey](../api/rpc-wallet.md#importprivkey): adds a private key to your wallet. The key should be formatted in the wallet import format created by the [`dumpprivkey` RPC](../api/rpc-wallet.md#dumpprivkey).
* [ImportWallet](../api/rpc-wallet.md#importwallet): imports private keys from a file in wallet dump file format (see the [`dumpwallet` RPC](../api/rpc-wallet.md#dumpwallet)). These keys will be added to the keys currently in the wallet.  This call may need to rescan all or parts of the blockchain for transactions affecting the newly-added keys, which may take several minutes.
```

### ImportWallet

```{note}
Requires [wallet](../reference/glossary.md#wallet) support (**unavailable on masternodes**). Requires an unlocked wallet or an unencrypted wallet.
```

The [`importwallet` RPC](../api/rpc-wallet.md#importwallet) imports private keys from a file in wallet dump file format (see the [`dumpwallet` RPC](../api/rpc-wallet.md#dumpwallet)). These keys will be added to the keys currently in the wallet.  This call may need to rescan all or parts of the blockchain for transactions affecting the newly-added keys, which may take several minutes.

*Parameter #1---the file to import*

| Name     | Type   | Presence                | Description                                                                |
| -------- | ------ | ----------------------- | -------------------------------------------------------------------------- |
| Filename | string | Required<br>(exactly 1) | The file to import.  The path is relative to Dimecoin Core's working directory |

*Result---`null` on success*

| Name     | Type | Presence                | Description                                                                                                           |
| -------- | ---- | ----------------------- | --------------------------------------------------------------------------------------------------------------------- |
| `result` | null | Required<br>(exactly 1) | If all the keys in the file are added to the wallet (or are already part of the wallet), JSON `null` will be returned |

*Example from Dimecoin Core 2.3.0.0*

Import the file shown in the example subsection of the [`dumpwallet` RPC](../api/rpc-wallet.md#dumpwallet).

```bash
dimecoin-cli -mainnet importwallet /tmp/dump.txt
```

(Success: no result displayed.)

```{seealso}
* [DumpWallet](../api/rpc-wallet.md#dumpwallet): creates or overwrites a file with all wallet keys in a human-readable format.
* [ImportPrivKey](../api/rpc-wallet.md#importprivkey): adds a private key to your wallet. The key should be formatted in the wallet import format created by the [`dumpprivkey` RPC](../api/rpc-wallet.md#dumpprivkey).
```

### KeyPoolRefill

```{note}
Requires [wallet](../reference/glossary.md#wallet) support (**unavailable on masternodes**). Requires an unlocked wallet or an unencrypted wallet.
```

The [`keypoolrefill` RPC](../api/rpc-wallet.md#keypoolrefill) fills the cache of unused pre-generated keys (the keypool).

*Parameter #1---the new keypool size*

| Name          | Type         | Presence             | Description                                                                                                                                                                                                                                                              |
| ------------- | ------------ | -------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| Key Pool Size | number (int) | Optional<br>(0 or 1) | The new size of the keypool; if the number of keys in the keypool is less than this number, new keys will be generated.  Default is `1000`.  The value `0` also equals the default.  The value specified is for this call only---the default keypool size is not changed |

*Result---`null` on success*

| Name     | Type | Presence                | Description                                                         |
| -------- | ---- | ----------------------- | ------------------------------------------------------------------- |
| `result` | null | Required<br>(exactly 1) | If the keypool is successfully filled, JSON `null` will be returned |

*Example from Dimecoin Core 2.3.0.0*

Generate one extra key than the default:

```bash
dimecoin-cli -mainnet keypoolrefill 1001
```

(No result shown: success.)

```{seealso}
* [GetNewAddress](../api/rpc-wallet.md#getnewaddress): returns a new DIME address for receiving payments. If an account is specified, payments received with the address will be credited to that account.
* [GetAccountAddress](../api/rpc-wallet-deprecated.md#getaccountaddress): returns the current DIME address for receiving payments to this account. If the account doesn't exist, it creates both the account and a new address for receiving payment.  Once a payment has been received to an address, future calls to this RPC for the same account will return a different address.
* [GetWalletInfo](../api/rpc-wallet.md#getwalletinfo): provides information about the wallet.
```

### ListAddressGroupings

```{note}
Requires [wallet](../reference/glossary.md#wallet) support (**unavailable on masternodes**).
```

The [`listaddressgroupings` RPC](../api/rpc-wallet.md#listaddressgroupings) lists groups of addresses that may have had their common ownership made public by common use as inputs in the same transaction or from being used as change from a previous transaction.

*Parameters: none*

*Result---an array of arrays describing the groupings*

| Name                   | Type              | Presence                | Description                                                                           |
| ---------------------- | ----------------- | ----------------------- | ------------------------------------------------------------------------------------- |
| `result`               | array             | Required<br>(exactly 1) | An array containing the groupings.  May be empty                                      |
| →<br>Groupings         | array             | Optional<br>(0 or more) | An array containing arrays of addresses which can be associated with each other       |
| → →<br>Address Details | array             | Required<br>(1 or more) | An array containing information about a particular address                            |
| → → →<br>Address       | string (base58)   | Required<br>(exactly 1) | The address in base58check format                                                     |
| → → →<br>Amount        | number (dimecoins) | Required<br>(exactly 1) | The amount in DIME                                                                    |
| → → →<br>Label         | string            | Optional<br>(0 or 1)    | The label the address belongs to, if any.                                             |

*Example from Dimecoin Core 2.3.0.0*

```bash
dimecoin-cli -mainnet listaddressgroupings
```

Result (edited to only three results):

```json
[
  [
    [
      "74QPDKfhMvRrjB73LFesRZ2636VzntkCCN",
      0.00000
    ],
    [
      "76HfKD15N8GtHuFeqVWMsvAifKJgyGXUSD",
      0.00000
    ],
    [
      "7BvixF8U75VrR4jd6Y7sDbDuQ8ERnKyi3J",
      0.00000,
      "test3"
    ],
    [
      "7CUCsDSLQ8rkHE21gacBozX13UmhiPkspH",
      0.00000
    ],
    [
      "7GKyz3zwiuNzgAkVvkLrBXHcbQCE2MSCuH",
      0.00000
    ],
    [
      "7GcxC5B7eToahnKrvixAbLGT4rWN5cTnno",
      24882.97207
    ],
    [
      "7Jdsq8b2SCvDUJphucNMtwG1cNK8c6ZZtf",
      0.00000
    ],
    [
      "7N5EpoBZwsZPMmNpaBUnkzeMNvk8itzxg9",
      0.00000
    ],
    [
      "7QiXzuc334UycnLrG6UmqayyGBqPLRJz92",
      0.00000
    ]
  ],
  [
    [
      "7Pd9uKuKFedPkWbzqrDVhy2BxZTU7SEpP1",
      2.49084
    ],
    [
      "7S9BMYB3QQwARC3UpnTKFQcGBsoZWpwWA7",
      0.00000,
      ""
    ]
  ]
]
```

```{seealso}
* [GetAddressesByAccount](../api/rpc-wallet-deprecated.md#getaddressesbyaccount): returns a list of every address assigned to a particular account.
* [GetTransaction](../api/rpc-wallet.md#gettransaction): gets detailed information about an in-wallet transaction.
* [ListAddressBalances](../api/rpc-wallet.md#listaddressbalances): lists addresses of this wallet and their balances
```

### ListLabels

```{note}
Requires [wallet](../reference/glossary.md#wallet) support (**unavailable on masternodes**).
```

The [`listlabels` RPC](../api/rpc-wallet.md#listlabels) returns the list of all labels, or labels that are assigned to addresses with a specific purpose.

*Parameter #1---purpose*

| Name    | Type   | Presence             | Description                                                                                                         |
| ------- | ------ | -------------------- | ------------------------------------------------------------------------------------------------------------------- |
| Purpose | string | Optional<br>(0 or 1) | Address purpose to list labels for (`send`, `receive`). An empty string is the same as not providing this argument. |

*Result---a list of labels*

| Name       | Type   | Presence                | Description                                                                                        |
| ---------- | ------ | ----------------------- | -------------------------------------------------------------------------------------------------- |
| `result`   | array  | Required<br>(exactly 1) | A JSON array containing label names.  Must include, at the very least, the default account (`""`). |
| →<br>Label | string | Required<br>(1 or more) | The name of a label.                                                                               |

*Example from Dimecoin Core 2.3.0.0*

Display labels used for receiving.

```bash
dimecoin-cli -mainnet listlabels "receive"
```

Result:

```json
[
  "",
  "test",
  "test2",
  "test3"
]
```

```{seealso}
* [GetAddressesByLabel](../api/rpc-wallet.md#getaddressesbylabel): returns the list of addresses assigned the specified label.
* [ListReceivedByLabel](../api/rpc-wallet.md#listreceivedbylabel): lists the total number of DIME received by each label.
```

### ListLockUnspent

```{note}
Requires [wallet](../reference/glossary.md#wallet) support (**unavailable on masternodes**).
```

The [`listlockunspent` RPC](../api/rpc-wallet.md#listlockunspent) returns a list of temporarily unspendable (locked) outputs.

*Parameters: none*

*Result---an array of locked outputs*

| Name          | Type         | Presence                | Description                                                                                                                              |
| ------------- | ------------ | ----------------------- | ---------------------------------------------------------------------------------------------------------------------------------------- |
| `result`      | array        | Required<br>(exactly 1) | An array containing all locked outputs.  May be empty                                                                                    |
| →<br>Output   | object       | Optional<br>(1 or more) | An object describing a particular locked output                                                                                          |
| → →<br>`txid` | string (hex) | Required<br>(exactly 1) | The TXID of the transaction containing the locked output, encoded as hex in RPC byte order                                               |
| → →<br>`vout` | number (int) | Required<br>(exactly 1) | The output index number (vout) of the locked output within the transaction.  Output index `0` is the first output within the transaction |

*Example from Dimecoin Core 2.3.0.0*

```bash
dimecoin-cli -mainnet listlockunspent
```

Result:

```json
[
  {
    "txid": "1fab6fbc3b4b006ea00e29de7d4dff081591344ba16f0de273703deedb439fef",
    "vout": 0
  }
]
```

```{seealso}
* [LockUnspent](../api/rpc-wallet.md#lockunspent): temporarily locks or unlocks specified transaction outputs. A locked transaction output will not be chosen by automatic coin selection when spending DIME. Locks are stored in memory only, so nodes start with zero locked outputs and the locked output list is always cleared when a node stops or fails.
```

### ListReceivedByAddress

```{note}
Requires [wallet](../reference/glossary.md#wallet) support (**unavailable on masternodes**).
```

The [`listreceivedbyaddress` RPC](../api/rpc-wallet.md#listreceivedbyaddress) lists the total number of DIME received by each address.

*Parameter #1---the minimum number of confirmations a transaction must have to be counted*

| Name          | Type         | Presence             | Description                                                                                                                                                                                                                                                                                                                                                                                            |
| ------------- | ------------ | -------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| Confirmations | number (int) | Optional<br>(0 or 1) | The minimum number of confirmations an externally-generated transaction must have before it is counted towards the balance.  Transactions generated by this node are counted immediately.  Typically, externally-generated transactions are payments to this wallet and transactions generated by this node are payments to other wallets.  Use `0` to count unconfirmed transactions.  Default is `1` |

*Parameter #2---whether to include empty accounts*

| Name          | Type | Presence             | Description                                                                                                                                                                                                                                                 |
| ------------- | ---- | -------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Include Empty | bool | Optional<br>(0 or 1) | Set to `true` to display accounts which have never received a payment.  Set to `false` (the default) to only include accounts which have received a payment.  Any account which has received a payment will be displayed even if its current balance is `0` |

*Parameter #3---whether to include watch-only addresses in results*

| Name               | Type | Presence             | Description                                                                                                                                                                                                                                                                                                                                         |
| ------------------ | ---- | -------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Include Watch-Only | bool | Optional<br>(0 or 1) | If set to `true`, include watch-only addresses in details and calculations as if they were regular addresses belonging to the wallet.  If set to `false` (the default for non-watching only wallets), treat watch-only addresses as if they didn't belong to this wallet. |

*Parameter #4---limit returned information to a specific address*

| Name           | Type   | Presence             | Description                                          |
| -------------- | ------ | -------------------- | ---------------------------------------------------- |
| Address Filter | string | Optional<br>(0 or 1) | If present, only return information for this address |

*Result---addresses, account names, balances, and minimum confirmations*

| Name                       | Type            | Presence                | Description                                                                                                                                                                                                                          |
| -------------------------- | --------------- | ----------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `result`                   | array           | Required<br>(exactly 1) | An array containing objects each describing a particular address                                                                                                                                                                     |
| →<br>Address               | object          | Optional<br>(0 or more) | An object describing an address                                                                                                                                                                                                      |
| → →<br>`involvesWatchonly` | bool            | Optional<br>(0 or 1)    | Set to `true` if this address is a watch-only address which has received a spendable payment (that is, a payment with at least the specified number of confirmations and which is not an immature coinbase).  Otherwise not returned |
| → →<br>`address`           | string (base58) | Required<br>(exactly 1) | The address being described encoded in base58check                                                                                                                                                                                   |
| → →<br>`amount`            | number (DIME)   | Required<br>(exactly 1) | The total amount the address has received in DIME                                                                                                                                                                                    |
| → →<br>`confirmations`     | number (int)    | Required<br>(exactly 1) | The number of confirmations of the latest transaction to the address.  May be `0` for unconfirmed                                                                                                                                    |
| → →<br>`label`             | string          | Required<br>(exactly 1) | The account the address belongs to.  May be the default account, an empty string (\\")"                                                                                                                                              |
| → →<br>`txids`             | array           | Required<br>(exactly 1) | An array of TXIDs belonging to transactions that pay the address                                                                                                                                                                     |
| → → →<br>TXID              | string          | Optional<br>(0 or more) | The TXID of a transaction paying the address, encoded as hex in RPC byte order                                                                                                                                                       |

*Example from Dimecoin Core 2.3.0.0*

List addresses with balances confirmed by at least six blocks, including  
watch-only addresses. Also include the balance from InstantSend locked transactions:

```bash
dimecoin-cli -mainnet listreceivedbyaddress 6 true false
```

Result (edit to show only two entries):

```json
[
  {
    "address": "781UNnKeADd5SGJMRKhhUSCgyUiGVkYq2f",
    "account": "",
    "amount": 0.00000,
    "confirmations": 0,
    "label": "",
    "txids": [
    ]
  },
  {
    "address": "7AZqqccQUnjp8Mmnpqs7Dvu6Sw8rHiiPE3",
    "account": "",
    "amount": 0.00000,
    "confirmations": 0,
    "label": "",
    "txids": [
    ]
  },
  {
    "address": "7S9BMYB3QQwARC3UpnTKFQcGBsoZWpwWA7",
    "account": "test",
    "amount": 10.00000,
    "confirmations": 4995,
    "label": "",
    "txids": [
      "1fab6fbc3b4b006ea00e29de7d4dff081591344ba16f0de273703deedb439fef"
    ]
  },
]
```

```{seealso}
* [GetReceivedByAddress](../api/rpc-wallet.md#getreceivedbyaddress): returns the total amount received by the specified address in transactions with the specified number of confirmations. It does not count coinbase transactions.
```

### ListReceivedByLabel

```{note}
Requires [wallet](../reference/glossary.md#wallet) support (**unavailable on masternodes**).
```

The [`listreceivedbylabel` RPC](../api/rpc-wallet.md#listreceivedbylabel) lists the total number of DIME received by each label.

*Parameter #1---the minimum number of confirmations a transaction must have to be counted*

| Name          | Type         | Presence             | Description                                                                                                                                                       |
| ------------- | ------------ | -------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Confirmations | number (int) | Optional<br>(0 or 1) | The minimum number of confirmations a  transaction must have before it is counted towards the balance. Use `0` to count unconfirmed transactions.  Default is `1` |

*Parameter #2---whether to include empty accounts*

| Name          | Type | Presence             | Description                                                                                                                                                                                                                                                 |
| ------------- | ---- | -------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Include Empty | bool | Optional<br>(0 or 1) | Set to `true` to display accounts which have never received a payment.  Set to `false` (the default) to only include accounts which have received a payment.  Any account which has received a payment will be displayed even if its current balance is `0` |

*Parameter #3---whether to include watch-only addresses in results*

| Name               | Type | Presence             | Description                                                                                                                                                                                                                                                                                                                                         |
| ------------------ | ---- | -------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Include Watch-Only | bool | Optional<br>(0 or 1) | If set to `true`, include watch-only addresses in details and calculations as if they were regular addresses belonging to the wallet.  If set to `false` (the default for non-watching only wallets), treat watch-only addresses as if they didn't belong to this wallet. |

*Result---account names, balances, and minimum confirmations*

| Name                       | Type          | Presence                | Description                                                                                                                                                                                                                                               |
| -------------------------- | ------------- | ----------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `result`                   | array         | Required<br>(exactly 1) | An array containing objects each describing an account.  At the very least, the default account (\\") will be included"                                                                                                                                   |
| →<br>Label                 | object        | Required<br>(1 or more) | An object describing a label                                                                                                                                                                                                                              |
| → →<br>`involvesWatchonly` | bool          | Optional<br>(0 or 1)    | Set to `true` if the balance of this account includes a watch-only address which has received a spendable payment (that is, a payment with at least the specified number of confirmations and which is not an immature coinbase).  Otherwise not returned |
| → →<br>`account`           | string        | Required<br>(exactly 1) | *Deprecated*<br>Backwards compatible alias for label                                                                                                                                                                                                      |
| → →<br>`amount`            | number (DIME) | Required<br>(exactly 1) | The total amount received by this account in DIME                                                                                                                                                                                                         |
| → →<br>`confirmations`     | number (int)  | Required<br>(exactly 1) | The number of confirmations received by the last transaction received by this account.  May be `0`                                                                                                                                                        |
| → →<br>`label`             | string        | Optional<br>(0 or 1)    | The label of the receiving address. The default label is `""`.                                                                                                                                                                                            |

*Example from Dimecoin Core 2.3.0.0*

Get the balances for all non-empty accounts, including transactions which have been confirmed at least six times and InstantSend locked transactions:

```bash
dimecoin-cli -mainnet listreceivedbylabel 6 true false
```

Result:

```json
[
  {
    "account": "",
    "amount": 500.00000000,
    "confirmations": 33,
    "label": ""
  },
  {
    "account": "test",
    "amount": 1250.00000000,
    "confirmations": 47,
    "label": "test"
  }
]
```

```{seealso}
* [ListReceivedByAddress](../api/rpc-wallet.md#listreceivedbyaddress): lists the total number of DIME received by each address.
* [GetReceivedByAccount](../api/rpc-removed.md#getreceivedbyaccount): returns the total amount received by addresses in a particular account from transactions with the specified number of confirmations.  It does not count coinbase transactions.
* [GetReceivedByAddress](../api/rpc-wallet.md#getreceivedbyaddress): returns the total amount received by the specified address in transactions with the specified number of confirmations. It does not count coinbase transactions.
```

```{eval-rst}
.. _api-rpc-wallet-listsinceblock:
```

### ListSinceBlock

```{note}
Requires [wallet](../reference/glossary.md#wallet) support (**unavailable on masternodes**).
```

The [`listsinceblock` RPC](../api/rpc-wallet.md#listsinceblock) gets all transactions affecting the wallet which have occurred since a particular block, plus the header hash of a block at a particular depth.

*Parameter #1---a block header hash*

| Name        | Type         | Presence             | Description                                                                                                                                                                                                                                                                                                            |
| ----------- | ------------ | -------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Header Hash | string (hex) | Optional<br>(0 or 1) | The hash of a block header encoded as hex in RPC byte order.  All transactions affecting the wallet which are not in that block or any earlier block will be returned, including unconfirmed transactions.  Default is the hash of the genesis block, so all transactions affecting the wallet are returned by default |

*Parameter #2---the target confirmations for the lastblock field*

| Name                 | Type         | Presence             | Description                                                                                                                                                                                                                                                |
| -------------------- | ------------ | -------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Target Confirmations | number (int) | Optional<br>(0 or 1) | Sets the lastblock field of the results to the header hash of a block with this many confirmations.  This does not affect which transactions are returned.  Default is `1`, so the hash of the most recent block on the local best blockchain is returned |

*Parameter #3---whether to include watch-only addresses in details and calculations*

| Name               | Type | Presence             | Description                                                                                                                                                                                                                                                                                                                                         |
| ------------------ | ---- | -------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Include Watch-Only | bool | Optional<br>(0 or 1) | If set to `true`, include watch-only addresses in details and calculations as if they were regular addresses belonging to the wallet.  If set to `false` (the default for non-watching only wallets), treat watch-only addresses as if they didn't belong to this wallet. |

*Parameter #4---include_removed*

| Name            | Type | Presence                   | Description                                                                                                           |
| --------------- | ---- | -------------------------- | --------------------------------------------------------------------------------------------------------------------- |
| include_removed | bool | Optional<br>Default=`true` | Show transactions that were removed due to a reorg in the \\removed\" array (not guaranteed to work on pruned nodes)" |

**Result**

| Name                         | Type            | Presence                    | Description                                                                                                                                                                                                                                                                                                                                                                                   |
| ---------------------------- | --------------- | --------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `result`                     | object          | Required<br>(exactly 1)     | An object containing an array of transactions and the lastblock field                                                                                                                                                                                                                                                                                                                         |
| →<br>`transactions`          | array           | Required<br>(exactly 1)     | An array of objects each describing a particular **payment** to or from this wallet.  The objects in this array do not describe an actual transactions, so more than one object in this array may come from the same transaction.  This array may be empty                                                                                                                                    |
| → →<br>Payment               | object          | Optional<br>(0 or more)     | An payment which did not appear in the specified block or an earlier block                                                                                                                                                                                                                                                                                                                    |
| → <br>`involvesWatchonly`    | bool            | Optional<br>(0 or 1)        | Set to `true` if the payment involves a watch-only address.  Otherwise not returned                                                                                                                                                                                                                                                                                                           |
| → <br>`address`              | string (base58) | Optional<br>(0 or 1)        | The address paid in this payment, which may be someone else's address not belonging to this wallet.  May be empty if the address is unknown, such as when paying to a non-standard pubkey script                                                                                                                                                                                              |
| → <br>`category`             | string          | Required<br>(exactly 1)     | Set to one of the following values:<br>• `send` if sending payment normally<br>• `coinjoin` if sending CoinJoin payment<br>• `receive` if this wallet received payment in a regular transaction<br>• `generate` if a matured and spendable coinbase<br>• `immature` if a coinbase that is not spendable yet<br>• `orphan` if a coinbase from a block that's not in the local best blockchain |
| → <br>`amount`               | number (DIME)   | Required<br>(exactly 1)     | A negative DIME amount if sending payment; a positive DIME amount if receiving payment (including coinbases)                                                                                                                                                                                                                                                                                  |
| → <br>`vout`                 | number (int)    | Required<br>(exactly 1)     | For an output, the output index (vout) for this output in this transaction.  For an input, the output index for the output being spent in its transaction.  Because inputs list the output indexes from previous transactions, more than one entry in the details array may have the same output index                                                                                        |
| → <br>`fee`                  | number (DIME)   | Optional<br>(0 or 1)        | If sending payment, the fee paid as a negative DIME value.  May be `0`. Not returned if receiving payment                                                                                                                                                                                                                                                                                     |
| → <br>`confirmations`        | number (int)    | Required<br>(exactly 1)     | The number of confirmations the transaction has received.  Will be `0` for unconfirmed and `-1` for conflicted                                                                                                                                                                                                                                                                                |
| → <br>`generated`            | bool            | Optional<br>(0 or 1)        | Set to `true` if the transaction is a coinbase.  Not returned for regular transactions                                                                                                                                                                                                                                                                                                        |
| → <br>`blockhash`            | string (hex)    | Optional<br>(0 or 1)        | The hash of the block on the local best blockchain which includes this transaction, encoded as hex in RPC byte order.  Only returned for confirmed transactions                                                                                                                                                                                                                              |
| → <br>`blockheight`            | string (hex)    | Optional<br>(0 or 1)        | The block height containing the transaction.                                                                                                                                                                                                                              |
| → <br>`blockindex`           | number (int)    | Optional<br>(0 or 1)        | The index of the transaction in the block that includes it.  Only returned for confirmed transactions                                                                                                                                                                                                                                                                                         |
| → <br>`blocktime`            | number (int)    | Optional<br>(0 or 1)        | The block header time (Unix epoch time) of the block on the local best blockchain which includes this transaction.  Only returned for confirmed transactions                                                                                                                                                                                                                                 |
| → <br>`txid`                 | string (hex)    | Required<br>(exactly 1)     | The TXID of the transaction, encoded as hex in RPC byte order                                                                                                                                                                                                                                                                                                                                 |
| → <br>`walletconflicts`      | array           | Required<br>(exactly 1)     | An array containing the TXIDs of other transactions that spend the same inputs (UTXOs) as this transaction.  Array may be empty                                                                                                                                                                                                                                                               |
| → →<br>TXID                  | string (hex)    | Optional<br>(0 or more)     | The TXID of a conflicting transaction, encoded as hex in RPC byte order                                                                                                                                                                                                                                                                                                                       |
| → <br>`time`                 | number (int)    | Required<br>(exactly 1)     | A Unix epoch time when the transaction was added to the wallet                                                                                                                                                                                                                                                                                                                                |
| → <br>`timereceived`         | number (int)    | Required<br>(exactly 1)     | A Unix epoch time when the transaction was detected by the local node, or the time of the block on the local best blockchain that included the transaction                                                                                                                                                                                                                                   |
| → <br>`abandoned`            | bool            | Optional<br>(0 or 1)        | `true` if the transaction has been abandoned (inputs are respendable). Only available for the 'send' category of transactions.                                                                                                                                                                                                                                                                |
| → <br>`comment`              | string          | Optional<br>(0 or 1)        | For transaction originating with this wallet, a locally-stored comment added to the transaction.  Only returned if a comment was added                                                                                                                                                                                                                                                        |
| → <br>`to`                   | string          | Optional<br>(0 or 1)        | For transaction originating with this wallet, a locally-stored comment added to the transaction identifying who the transaction was sent to.  Only returned if a comment-to was added                                                                                                                                                                                                         |
| →<br>`removed`               | array           | Optional<br>(0 or 1)        | Structure is the same as `transactions`. Only present if `include_removed` is `true`.<br>*NOTE:*: transactions that were re-added in the active chain will appear as-is in this array, and may thus have a positive confirmation count.                                                                                                                                                        |

*Example from Dimecoin Core 2.3.0.0*

Get all transactions since a particular block (including watch-only transactions) and the header hash of the sixth most recent block.

```bash
dimecoin-cli -mainnet listsinceblock 0000015fb32d785efb2f792a194a14c11ef04141bb2778c04cea447cdccb4b6e 6 true true
```

Result (edited to show only two payments):

```json
{
  "transactions": [
    {
      "address": "7KevA5YQSyWMAykzFWPuPEXJk1bxUwXxaY",
      "category": "send",
      "amount": -5.00000,
      "label": "test",
      "vout": 0,
      "fee": -0.00229,
      "confirmations": 4998,
      "blockhash": "acd4f8bad5b551faaf28db94f8a05ed75bc1ec5a9141c0ebf40ddfa330587165",
      "blockindex": 2,
      "blocktime": 1709850951,
      "txid": "243ceb732dae2a027d94b046bf7e9861295863bf575d7e2f482fbd122a719e9c",
      "walletconflicts": [
      ],
      "time": 1709850886,
      "timereceived": 1709850886,
      "bip125-replaceable": "no",
      "abandoned": false
    }
  ]
}
```

```{seealso}
* [ListReceivedByAddress](../api/rpc-wallet.md#listreceivedbyaddress): lists the total number of DIME received by each address.
```

```{eval-rst}
.. _api-rpc-wallet-listtransactions:
```

### ListTransactions

```{note}
Requires [wallet](../reference/glossary.md#wallet) support (**unavailable on masternodes**).
```

The [`listtransactions` RPC](../api/rpc-wallet.md#listtransactions) returns the most recent transactions that affect the wallet. If a label name is provided, this will return only incoming transactions paying to addresses with the specified label.

*Parameter #1---a label name*

| Name  | Type   | Presence             | Description                                                                                                                                                    |
| ----- | ------ | -------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Label | string | Optional<br>(0 or 1) | If set, should be a valid label name to return only incoming transactions with the specified label, or `"*"` to disable filtering and return all transactions. |

*Parameter #2---the number of transactions to get*

| Name  | Type         | Presence             | Description                                                          |
| ----- | ------------ | -------------------- | -------------------------------------------------------------------- |
| Count | number (int) | Optional<br>(0 or 1) | The number of the most recent transactions to list.  Default is `10` |

*Parameter #3---the number of transactions to skip*

| Name | Type         | Presence             | Description                                                                                                                 |
| ---- | ------------ | -------------------- | --------------------------------------------------------------------------------------------------------------------------- |
| Skip | number (int) | Optional<br>(0 or 1) | The number of the most recent transactions which should not be returned.  Allows for pagination of results.  Default is `0` |

*Parameter #4---whether to include watch-only addresses in details and calculations*

| Name               | Type | Presence             | Description                                                                                                                                                                                                                                                                                                                                         |
| ------------------ | ---- | -------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Include Watch-Only | bool | Optional<br>(0 or 1) | If set to `true`, include watch-only addresses in details and calculations as if they were regular addresses belonging to the wallet.  If set to `false` (the default for non-watching only wallets), treat watch-only addresses as if they didn't belong to this wallet. |

*Result---payment details*

| Name                        | Type            | Presence                | Description                                                                                                                                                                                                                                                                                                                                                                        |
| --------------------------- | --------------- | ----------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `result`                    | array           | Required<br>(exactly 1) | An array containing objects, with each object describing a **payment** or internal accounting entry (not a transaction).  More than one object in this array may come from a single transaction.  Array may be empty                                                                                                                                                               |
| →<br>Payment                | object          | Optional<br>(0 or more) | A payment or internal accounting entry                                                                                                                                                                                                                                                                                                                                             |
| → →<br>`address`            | string (base58) | Optional<br>(0 or 1)    | The address paid in this payment, which may be someone else's address not belonging to this wallet.  May be empty if the address is unknown, such as when paying to a non-standard pubkey script or if this is in the *move* category                                                                                                                                              |
| → →<br>`category`           | string          | Required<br>(exactly 1) | Set to one of the following values:<br>• `send` if sending payment<br>• `coinjoin` if sending CoinJoin funds<br>• `receive` if this wallet received payment in a regular transaction<br>• `generate` if a matured and spendable coinbase<br>• `immature` if a coinbase that is not spendable yet<br>• `orphan` if a coinbase from a block that's not in the local best blockchain |
| → →<br>`amount`             | number (DIME)   | Required<br>(exactly 1) | A negative DIME amount if sending payment; a positive DIME amount if receiving payment (including coinbases)                                                                                                                                                                                                                                                                       |
| → →<br>`label`              | string          | Optional<br>(0 or 1)    | A comment for the address/transaction                                                                                                                                                                                                                                                                                                                                              |
| → →<br>`vout`               | number (int)    | Optional<br>(0 or 1)    | For an output, the output index (vout) for this output in this transaction.  For an input, the output index for the output being spent in its transaction.  Because inputs list the output indexes from previous transactions, more than one entry in the details array may have the same output index.  Not returned for *move* category payments                                 |
| → →<br>`fee`                | number (DIME)   | Optional<br>(0 or 1)    | If sending payment, the fee paid as a negative DIME value.  May be `0`. Not returned if receiving payment or for *move* category payments                                                                                                                                                                                                                                          |
| → →<br>`confirmations`      | number (int)    | Optional<br>(0 or 1)    | The number of confirmations the transaction has received.  Will be `0` for unconfirmed and `-1` for conflicted.  Not returned for *move* category payments                                                                                                                                                                                                                         |
| → →<br>`generated`          | bool            | Optional<br>(0 or 1)    | Set to `true` if the transaction is a coinbase.  Not returned for regular transactions or *move* category payments                                                                                                                                                                                                                                                                 |
| → →<br>`trusted`            | bool            | Optional<br>(0 or 1)    | Indicates whether we consider the outputs of this unconfirmed transaction safe to spend.  Only returned for unconfirmed transactions                                                                                                                                                                                                                                               |
| → →<br>`blockhash`          | string (hex)    | Optional<br>(0 or 1)    | The hash of the block on the local best blockchain which includes this transaction, encoded as hex in RPC byte order.  Only returned for confirmed transactions                                                                                                                                                                                                                   |
| → →<br>`blockheight`        | string (hex)    | Optional<br>(0 or 1)    | The block height containing the transaction.|

| → →<br>`blockindex`         | number (int)    | Optional<br>(0 or 1)    | The index of the transaction in the block that includes it.  Only returned for confirmed transactions                                                                                                                                                                                                                                                                              |
| → →<br>`blocktime`          | number (int)    | Optional<br>(0 or 1)    | The block header time (Unix epoch time) of the block on the local best blockchain which includes this transaction.  Only returned for confirmed transactions                                                                                                                                                                                                                      |
| → →<br>`txid`               | string (hex)    | Optional<br>(0 or 1)    | The TXID of the transaction, encoded as hex in RPC byte order.  Not returned for *move* category payments                                                                                                                                                                                                                                                                          |
| → →<br>`walletconflicts`    | array           | Optional<br>(0 or 1)    | An array containing the TXIDs of other transactions that spend the same inputs (UTXOs) as this transaction.  Array may be empty.  Not returned for *move* category payments                                                                                                                                                                                                        |
| → → →<br>TXID               | string (hex)    | Optional<br>(0 or more) | The TXID of a conflicting transaction, encoded as hex in RPC byte order                                                                                                                                                                                                                                                                                                            |
| → →<br>`time`               | number (int)    | Required<br>(exactly 1) | A Unix epoch time when the transaction was added to the wallet                                                                                                                                                                                                                                                                                                                     |
| → →<br>`timereceived`       | number (int)    | Optional<br>(0 or 1)    | A Unix epoch time when the transaction was detected by the local node, or the time of the block on the local best blockchain that included the transaction.  Not returned for *move* category payments                                                                                                                                                                            |
| → →<br>`comment`            | string          | Optional<br>(0 or 1)    | For transaction originating with this wallet, a locally-stored comment added to the transaction.  Only returned in regular payments if a comment was added.  Always returned in *move* category payments.  May be an empty string                                                                                                                                                  |
| → →<br>`to`                 | string          | Optional<br>(0 or 1)    | For transaction originating with this wallet, a locally-stored comment added to the transaction identifying who the transaction was sent to.  Only returned if a comment-to was added.  Never returned by *move* category payments.  May be an empty string                                                                                                                        |
| → →<br>`bip125-replaceable` | string          | bool    | Whether transaction is RBF (Replace-by-Fee) eligible.        |
| → →<br>`abandoned`          | bool            | Optional<br>(0 or 1)    | Indicates if a transaction is was abandoned:<br>• `true` if it was abandoned (inputs are respendable)<br>• `false`  if it was not abandoned<br>Only returned by *send* category payments                                                                                                                                                     |

*Example from Dimecoin Core 2.3.0.0*

List the most recent transaction.

```bash
dimecoin-cli listtransactions "*" 1
```

Result:

```json
[
  {
    "address": "7Q1qNyuskRBFpY9WvH2ztv6rJMvQpNaBWi",
    "category": "send",
    "amount": -10.00000,
    "label": "",
    "vout": 1,
    "fee": -0.00229,
    "confirmations": 25,
    "blockhash": "000000000003fab9e9a8aaa9ac6de7862f4f06dc5ba7b0add46c13a3b941656f",
    "blockindex": 1,
    "blocktime": 1710094644,
    "txid": "9e5f8ad76df0c275990a8c713fbe801413b1a17409ebc63b7600c58d08250088",
    "walletconflicts": [
    ],
    "time": 1710094573,
    "timereceived": 1710094573,
    "bip125-replaceable": "no",
    "abandoned": false
  }
]
```

```{seealso}
* [GetTransaction](../api/rpc-wallet.md#gettransaction): gets detailed information about an in-wallet transaction.
* [ListSinceBlock](../api/rpc-wallet.md#listsinceblock): gets all transactions affecting the wallet which have occurred since a particular block, plus the header hash of a block at a particular depth.
```

### ListUnspent

```{note}
Requires [wallet](../reference/glossary.md#wallet) support (**unavailable on masternodes**).
```

The [`listunspent` RPC](../api/rpc-wallet.md#listunspent) returns an array of unspent transaction outputs belonging to this wallet. **NOTE:** Outputs affecting watch-only addresses will be returned; see the *spendable* field in the results described below.

*Parameter #1---the minimum number of confirmations an output must have*

| Name                  | Type         | Presence             | Description                                                                                                                                                                          |
| --------------------- | ------------ | -------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| Minimum Confirmations | number (int) | Optional<br>(0 or 1) | The minimum number of confirmations the transaction containing an output must have in order to be returned.  Use `0` to return outputs from unconfirmed transactions. Default is `1` |

*Parameter #2---the maximum number of confirmations an output may have*

| Name                  | Type         | Presence             | Description                                                                                                                                    |
| --------------------- | ------------ | -------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------- |
| Maximum Confirmations | number (int) | Optional<br>(0 or 1) | The maximum number of confirmations the transaction containing an output may have in order to be returned.  Default is `9999999` (~10 million) |

*Parameter #3---the addresses an output must pay*

| Name         | Type            | Presence                | Description                                                                  |
| ------------ | --------------- | ----------------------- | ---------------------------------------------------------------------------- |
| Addresses    | array           | Optional<br>(0 or 1)    | If present, only outputs which pay an address in this array will be returned |
| →<br>Address | string (base58) | Required<br>(1 or more) | A P2PKH or P2SH address                                                      |

*Parameter #4---include unsafe outputs*

| Name           | Type | Presence                    | Description                                                                                                |
| -------------- | ---- | --------------------------- | ---------------------------------------------------------------------------------------------------------- |
| Include Unsafe | bool | Optional<br>(false or true) | Include outputs that are not safe to spend . See description of `safe` attribute below.  Default is `true` |

*Parameter #5---query options*

| Name          | Type | Presence | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| ------------- | ---- | -------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Query Options | json | Optional | JSON with query options. Available options:<br> - `minimumAmount`: Minimum value of each UTXO in DIME<br> - `maximumAmount`: Maximum value of each UTXO in DIME<br> - `maximumCount`: Maximum number of UTXOs<br> - `minimumSumAmount`: Minimum sum value of all UTXOs in DIME<br> - `coinType`: Filter coinTypes as follows:<br>0 = `ALL_COINS`, <br>1 = `ONLY_NONDENOMINATED`, <br>2 = `ONLY_MASTERNODE_COLLATERAL` |

*Result---the list of unspent outputs*

| Name                     | Type            | Presence                 | Description                                                                                                                                                                                                                                            |
| ------------------------ | --------------- | ------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `result`                 | array           | Required<br>(exactly 1)  | An array of objects each describing an unspent output.  May be empty                                                                                                                                                                                   |
| →<br>Unspent Output      | object          | Optional<br>(0 or more)  | An object describing a particular unspent output belonging to this wallet                                                                                                                                                                              |
| → →<br>`txid`            | string (hex)    | Required<br>(exactly 1)  | The TXID of the transaction containing the output, encoded as hex in RPC byte order                                                                                                                                                                    |
| → →<br>`vout`            | number (int)    | Required<br>(exactly 1)  | The output index number (vout) of the output within its containing transaction                                                                                                                                                                         |
| → →<br>`address`         | string (base58) | Optional<br>(0 or 1)     | The P2PKH or P2SH address the output paid.  Only returned for P2PKH or P2SH output scripts                                                                                                                                                             |
| → →<br>`scriptPubKey`    | string (hex)    | Required<br>(exactly 1)  | The output script paid, encoded as hex                                                                                                                                                                                                                 |
| → →<br>`redeemScript`    | string (hex)    | Optional<br>(0 or 1)     | If the output is a P2SH whose script belongs to this wallet, this is the redeem script                                                                                                                                                                 |
| → →<br>`amount`          | number (int)    | Required<br>(exactly 1)  | The amount paid to the output in DIME                                                                                                                                                                                                                  |
| → →<br>`confirmations`   | number (int)    | Required<br>(exactly 1)  | The number of confirmations received for the transaction containing this output                                                                                                                                                                        |
| → →<br>`spendable`       | bool            | Required<br>(exactly 1)  | Set to `true` if the private key or keys needed to spend this output are part of the wallet.  Set to `false` if not (such as for watch-only addresses)                                                                                                 |
| → →<br>`solvable`        | bool            | Required<br>(exactly 1)  | Set to `true` if the wallet knows how to spend this output.  Set to `false` if the wallet does not know how to spend the output.  It is ignored if the private keys are available                                |
| → →<br>`desc`            | string          | Optional<br>(0 or 1)     | A descriptor for spending this output                                                                                                                                                                                                                  |
| → →<br>`safe`            | bool            | Required<br>(exactly 1)  | Whether this output is considered safe to spend. Unconfirmed transactions from outside keys are considered unsafe and are not eligible for spending by `fundrawtransaction` and `sendtoaddress`.                 |

*Example from Dimecoin Core 2.3.0.0*

Get all outputs confirmed at least 6 times for a particular address:

```bash
dimecoin-cli -mainnet listunspent 50
  [
    "7Pd9uKuKFedPkWbzqrDVhy2BxZTU7SEpP1"
  ]
'''
```

Result:

```json
[
  {
    "txid": "db267f5ec45a95f16ab1dd9db19f380af5494cf1a39fd95082d327bfce6bc4de",
    "vout": 1,
    "address": "7Pd9uKuKFedPkWbzqrDVhy2BxZTU7SEpP1",
    "scriptPubKey": "76a914e174f21ea252229760f9eed5d1c155dea36fdc4088ac",
    "amount": 2.49084,
    "confirmations": 4992,
    "spendable": true,
    "solvable": true,
    "safe": true
  }
]
```

Get all outputs for a particular address that have at least 1 confirmation and a maximum value of 10:

```shell
dimecoin-cli -mainnet listunspent 1 9999999 '''
  [
    "7Pd9uKuKFedPkWbzqrDVhy2BxZTU7SEpP1"
  ]
  ''' true '''
  {
    "maximumAmount": "10"
  }
  '''
```

Result:

```json
[
  {
    "txid": "db267f5ec45a95f16ab1dd9db19f380af5494cf1a39fd95082d327bfce6bc4de",
    "vout": 1,
    "address": "7Pd9uKuKFedPkWbzqrDVhy2BxZTU7SEpP1",
    "scriptPubKey": "76a914e174f21ea252229760f9eed5d1c155dea36fdc4088ac",
    "amount": 12.49084,
    "confirmations": 85,
    "spendable": true,
    "solvable": true,
    "safe": true
  }
]
```

```{seealso}
* [ListTransactions](../api/rpc-wallet.md#listtransactions): returns the most recent transactions that affect the wallet.
* [LockUnspent](../api/rpc-wallet.md#lockunspent): temporarily locks or unlocks specified transaction outputs. A locked transaction output will not be chosen by automatic coin selection when spending DIME. Locks are stored in memory only, so nodes start with zero locked outputs and the locked output list is always cleared when a node stops or fails.
```

### ListWallets

The [`listwallets` RPC](../api/rpc-wallet.md#listwallets) returns a list of currently loaded wallets.

For full information on the wallet, use the [`getwalletinfo` RPC](../api/rpc-wallet.md#getwalletinfo).

*Parameters: none*

*Result*

| Name        | Type   | Presence                | Description                                                            |
| ----------- | ------ | ----------------------- | ---------------------------------------------------------------------- |
| `result`    | array  | Required<br>(exactly 1) | An array of strings containing a list of currently loaded wallet files |
| →<br>Wallet | string | Required<br>(0 or more) | The name of a wallet file                                              |

*Example from Dimecoin Core 2.3.0.0*

```bash
dimecoin-cli -mainnet listwallets
```

Result:

```json
[
  "wallet.dat"
]
```
```{seealso}
*none*
```

### LoadWallet

```{note}
Requires [wallet](../reference/glossary.md#wallet) support (**unavailable on masternodes**).
```

The [`loadwallet` RPC](../api/rpc-wallet.md#loadwallet) loads a wallet from a wallet file or directory. **NOTE:** that all wallet command-line options used when starting dimecoind will be applied to the new wallet (eg -zapwallettxes, upgradewallet, rescan, etc).

*Parameter #1---wallet name*

| Name     | Type   | Presence                | Description                                                                                                                                                                                 |
| -------- | ------ | ----------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Filename | string | Required<br>(exactly 1) | The wallet directory or .dat file. The wallet can be specified as file/directory basename (which must be located in the `walletdir` directory), or as an absolute path to a file/directory. |

*Parameter #2---load on startup*

| Name            | Type    | Presence             | Description                                                                                                                                |
| --------------- | ------- | -------------------- | ------------------------------------------------------------------------------------------------------------------------------------------ |
| load_on_startup | boolean | Optional<br>(0 or 1) | Save wallet name to persistent settings and load on startup. True to add wallet to startup list, false to remove, null to leave unchanged. |

*Result---operation status*

| Name           | Type   | Presence                | Description                                                                      |
| -------------- | ------ | ----------------------- | -------------------------------------------------------------------------------- |
| `result`       | object | Required<br>(exactly 1) | An object containing the wallet name or warning message related to the operation |
| →<br>`name`    | string | Required                | The wallet name if loaded successfully                                           |
| →<br>`warning` | string | Required                | Warning message if wallet was not loaded cleanly                                 |

*Example from Dimecoin Core 2.3.0.0*

```bash
dimecoin-cli -mainnet loadwallet wallet-test.dat
```

Result:

```json
{
  "name": "wallet-test.dat",
  "warning": ""
}
```

```{seealso}
* [CreateWallet](../api/rpc-wallet.md#createwallet): creates and loads a new wallet.
* [UnloadWallet](../api/rpc-wallet.md#unloadwallet): unloads the specified wallet.
```

### LockUnspent

```{note}
Requires [wallet](../reference/glossary.md#wallet) support (**unavailable on masternodes**).
```

The [`lockunspent` RPC](../api/rpc-wallet.md#lockunspent) temporarily locks or unlocks specified transaction outputs. A locked transaction output will not be chosen by automatic coin selection when spending DIME. Locks are stored in memory only, so nodes start with zero locked outputs and the locked output list is always cleared when a node stops or fails.

*Parameter #1---whether to lock or unlock the outputs*

| Name   | Type | Presence                | Description                                                                                                                                                                                                                                                                                       |
| ------ | ---- | ----------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Unlock | bool | Required<br>(exactly 1) | Set to `false` to lock the outputs specified in the following parameter.  Set to `true` to unlock the outputs specified.  If this is the only argument specified and it is set to `true`, all outputs will be unlocked; if it is the only argument and is set to `false`, there will be no change |

*Parameter #2---the outputs to lock or unlock*

| Name          | Type         | Presence                | Description                                                                                                            |
| ------------- | ------------ | ----------------------- | ---------------------------------------------------------------------------------------------------------------------- |
| Outputs       | array        | Optional<br>(0 or 1)    | An array of outputs to lock or unlock                                                                                  |
| →<br>Output   | object       | Required<br>(1 or more) | An object describing a particular output                                                                               |
| → →<br>`txid` | string       | Required<br>(exactly 1) | The TXID of the transaction containing the output to lock or unlock, encoded as hex in internal byte order             |
| → →<br>`vout` | number (int) | Required<br>(exactly 1) | The output index number (vout) of the output to lock or unlock.  The first output in a transaction has an index of `0` |

*Result---`true` if successful*

| Name     | Type | Presence                | Description                                                                                                                                    |
| -------- | ---- | ----------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------- |
| `result` | bool | Required<br>(exactly 1) | Set to `true` if the outputs were successfully locked or unlocked.  If the outputs were already locked or unlocked, it will also return `true` |

*Example from Dimecoin Core 2.3.0.0*

Lock two outputs:

```bash
dimecoin-cli -mainnet lockunspent false '''
  [
    {
      "txid": "c4d69ec5e4168b5369e911d019e9714526c1f2db5b2d6882564ea887feca4c66",
      "vout": 0
    },
    {
      "txid": "986325411b2f7c5b23297b2a352a8d6f4383f8d0782585f93220082d361f8db9",
      "vout": 1
    }
  ]
'''
```

Result:

```json
true
```

Verify the outputs have been locked:

```bash
dimecoin-cli -mainnet listlockunspent
```

Result

```json
[
  {
    "txid": "c4d69ec5e4168b5369e911d019e9714526c1f2db5b2d6882564ea887feca4c66",
    "vout": 0
  },
  {
    "txid": "986325411b2f7c5b23297b2a352a8d6f4383f8d0782585f93220082d361f8db9",
    "vout": 1
  }
]
```

Unlock one of the above outputs:

```bash
dimecoin-cli -mainnet lockunspent true '''
[
  {
    "txid": "986325411b2f7c5b23297b2a352a8d6f4383f8d0782585f93220082d361f8db9",
    "vout": 1
  }
]
'''
```

Result:

```json
true
```

Verify the output has been unlocked:

```bash
dimecoin-cli -mainnet listlockunspent
```

Result:

```json
[
  {
    "txid": "c4d69ec5e4168b5369e911d019e9714526c1f2db5b2d6882564ea887feca4c66",
    "vout": 0
  }
]
```

```{seealso}
* [ListLockUnspent](../api/rpc-wallet.md#listlockunspent): returns a list of temporarily unspendable (locked) outputs.
* [ListUnspent](../api/rpc-wallet.md#listunspent): returns an array of unspent transaction outputs belonging to this wallet.
```

### RemovePrunedFunds

```{note}
Requires [wallet](../reference/glossary.md#wallet) support (**unavailable on masternodes**).
```

The [`removeprunedfunds` RPC](../api/rpc-wallet.md#removeprunedfunds) deletes the specified transaction from the wallet. Meant for use with pruned wallets and as a companion to importprunedfunds. This will effect wallet balances.

*Parameter #1---the raw transaction to import*

| Name | Type            | Presence                | Description                                            |
| ---- | --------------- | ----------------------- | ------------------------------------------------------ |
| TXID | string<br>(hex) | Required<br>(exactly 1) | The hex-encoded id of the transaction you are removing |

*Result---`null` on success*

| Name     | Type | Presence                | Description                                                            |
| -------- | ---- | ----------------------- | ---------------------------------------------------------------------- |
| `result` | null | Required<br>(exactly 1) | If the funds are removed from the wallet, JSON `null` will be returned |

*Example from Dimecoin Core 0.12.3*

```bash
dimecoin-cli removeprunedfunds cd6daff525b83fa6a569ab50bf7f8f14d6\
45661a19f45378b362ef3f25bda237
```

(Success: no result displayed.)

```{seealso}
* [ImportPrivKey](../api/rpc-wallet.md#importprivkey): adds a private key to your wallet. The key should be formatted in the wallet import format created by the [`dumpprivkey` RPC](../api/rpc-wallet.md#dumpprivkey).
* [ImportPrunedFunds](../api/rpc-wallet.md#importprunedfunds): imports funds without the need of a rescan. Meant for use with pruned wallets.
```

### RescanBlockChain

The [`rescanblockchain` RPC](../api/rpc-wallet.md#rescanblockchain) rescans the local blockchain for wallet related transactions.

*Parameter #1---the start block height*

| Name         | Type    | Presence             | Description                                    |
| ------------ | ------- | -------------------- | ---------------------------------------------- |
| Start Height | integer | Optional<br>(0 or 1) | The block height where the rescan should start |

*Parameter #2---the stop block height*

| Name        | Type    | Presence             | Description                                  |
| ----------- | ------- | -------------------- | -------------------------------------------- |
| Stop Height | integer | Optional<br>(0 or 1) | The last block height that should be scanned |

*Result---`null` or start/end height details if parameters provided*

| Name                | Type    | Presence                | Description                                                                                      |
| ------------------- | ------- | ----------------------- | ------------------------------------------------------------------------------------------------ |
| `result`            | object  | Required<br>(exactly 1) | An object containing the start/end heights depending on the range of blocks scanned              |
| →<br>`start_height` | integer | Optional<br>(0 or 1)    | The block height where the rescan has started. If omitted, rescan started from the genesis block |
| →<br>`stop_height`  | integer | Optional<br>(0 or 1)    | The height of the last rescanned block. If omitted, rescan stopped at the chain tip              |

*Example from Dimecoin Core 2.3.0.0*

```bash
dimecoin-cli rescanblockchain
```

Result:

```json
{
  "start_height": 53698,
  "stop_height": 53700
}
```

```{seealso}
* [AbortRescan](../api/rpc-wallet.md#abortrescan): stops current wallet rescan.
```

### ScanTXOutset

```{note}
Experimental: this call may be removed or changed in future releases.
```

The [`scantxoutset` RPC](../api/rpc-wallet.md#scantxoutset) scans the unspent transaction output set for entries that match certain output descriptors.

*Parameter #1---action*

| Name   | Type   | Presence                | Description                                                                                                                                                                                                   |
| ------ | ------ | ----------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Action | string | Required<br>(exactly 1) | The action to execute:<br> - "start" for starting a scan,<br> - "abort" for aborting the current scan (returns true when abort was successful),<br> - "status" for progress report (in %) of the current scan |

*Parameter #2---scan objects*

| Name            | Type           | Presence                | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| --------------- | -------------- | ----------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Scan Objects    | array          | Required<br>(exactly 1) | An array of scan objects. Every scan object is either a string descriptor or an object.                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| →<br>descriptor | string: object | Required<br>(1 or more) | An output descriptor; an object with output descriptor and metadata.<br>Examples of output descriptors are:<br> - `addr(<address>)`: Outputs whose scriptPubKey corresponds to the specified address (does not include P2PK)<br> - `raw(<hex script>)`: Outputs whose scriptPubKey equals the specified hex scripts<br> - `combo(<pubkey>)`: P2PK and P2PKH outputs for the given pubkey<br> - `pkh(<pubkey>)`: P2PKH outputs for the given pubkey<br> - `sh(multi(<n>,<pubkey>,<pubkey>,...))`: P2SH-multisig outputs for the given threshold and pubkeys |
| → →<br>desc     | string         | Required<br>(exactly 1) | An output descriptor                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| → →<br>range    | number (int)   | Optional<br>(0 or 1)    | The child index HD that chains should be explored (default: 1000)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |

In the above, <pubkey> either refers to a fixed public key in hexadecimal notation, or to an xpub/xprv optionally followed by one or more path elements separated by "/", and optionally ending in "/*" (unhardened), or "/*'" or "/\*h" (hardened) to specify all unhardened or hardened child keys. In the latter case, a range needs to be specified by below if different from 1000.

*Result---The unspent and total amount*

| Name                    | Type         | Presence                | Description                                                                                            |
| ----------------------- | ------------ | ----------------------- | ------------------------------------------------------------------------------------------------------ |
| `result`                | object       | Required<br>(exactly 1) | An object containing the the unspent and total amounts.                                                |
| →<br>`success`          | bool         | Required<br>(exactly 1) | Whether the scan was completed                                                                         |
| →<br>`txouts`           | number (int) | Required<br>(exactly 1) | The number of unspent transaction outputs scanned                                                      |
| →<br>`height`           | number (int) | Required<br>(exactly 1) | The current block height (index)                                                                       |
| →<br>`bestblock`        | string (hex) | Required<br>(exactly 1) | The hash of the block at the tip of the chain                                                          |
| →<br>`unspents`         | array        | Required<br>(exactly 1) | An array containing unspent output objects                                                             |
| → →<br>Unspent output   | array        | Required<br>(1 or more) | An object containing unspent output information                                                        |
| → → →<br>`txid`         | string (hex) | Required<br>(exactly 1) | The TXID of the transaction the output appeared in.  The TXID must be encoded in hex in RPC byte order |
| → → →<br>`vout`         | number (int) | Required<br>(exactly 1) | The index number of the output (vout) as it appeared in its transaction, with the first output being 0 |
| → → →<br>`scriptPubKey` | string (hex) | Required<br>(exactly 1) | The output's pubkey script encoded as hex                                                              |
| → → →<br>`desc`         | string       | Required<br>(exactly 1) | A specialized descriptor for the matched scriptPubKey                                                  |
| → → →<br>`amount`       | number (int) | Required<br>(exactly 1) | The total amount in DIME of the unspent output                                                         |
| → → →<br>`height`       | number (int) | Required<br>(exactly 1) | The height of the unspent transaction output                                                           |
| →<br>`total_amount`     | numeric      | Required<br>(exactly 1) | The total amount of all found unspent outputs in DIME                                                  |

*Example from Dimecoin Core 2.3.0.0*

```bash
dimecoin-cli -mainnet scantxoutset start '["addr(7WjoZBvnUKWhpKMbBkVVnnMD8Bzno9j6tQ)"]'
```

Result:

```json
{
  "success": true,
  "txouts": 639756,
  "height": 667140,
  "bestblock": "000000ec777dd903c5a378ab209a7815b24a5365b5c53a0c22e64ef3350d33db",
  "unspents": [
    {
      "txid": "571028a9a2f69c5eec75dbae10c8724b8afd44530fac97936ae6676a9c61e03c",
      "vout": 0,
      "scriptPubKey": "76a914724c86a5dc23ecac05474d9be3ac76a6aa4bcb4488ac",
      "desc": "addr(7WjoZBvnUKWhpKMbBkVVnnMD8Bzno9j6tQ)#sycxjztu",
      "amount": 1.00000000,
      "height": 494777
    },
    {
      "txid": "3e76165230a3ff5bb8df0a9e278caa81f9a653c2b7a075f8dc16e56103c8f68e",
      "vout": 0,
      "scriptPubKey": "76a914724c86a5dc23ecac05474d9be3ac76a6aa4bcb4488ac",
      "desc": "addr(yWjoZBvnUKWhpKMbBkVVnnMD8Bzno9j6tQ)#sycxjztu",
      "amount": 7.76020488,
      "height": 494777
    }
  ],
  "total_amount": 8.76020488
}
```

```{seealso}
* [ListUnspent](../api/rpc-wallet.md#listunspent): returns an array of unspent transaction outputs belonging to this wallet.
```

### SendMany

```{note}
Requires [wallet](../reference/glossary.md#wallet) support (**unavailable on masternodes**). Requires an unlocked wallet or an unencrypted wallet.
```

The [`sendmany` RPC](../api/rpc-wallet.md#sendmany) creates and broadcasts a transaction which sends outputs to multiple addresses.

*Parameter #1---unused parameter*

| Name | Type | Presence | Description |
| ---- | ---- | -------- | ----------- |
| Unused | string | Required<br>(exactly 1) | Must be set to `""` for backwards compatibility. |

*Parameter #2---the addresses and amounts to pay*

| Name | Type | Presence | Description |
| ---- | ---- | -------- | ----------- |
| Outputs             | object                          | Required<br>(exactly 1) | An object containing key/value pairs corresponding to the addresses and amounts to pay                                                               |
| →<br>Address/Amount | string (base58) : number (DIME) | Required<br>(1 or more) | A key/value pair with a base58check-encoded string containing the P2PKH or P2SH address to pay as the key, and an amount of DIME to pay as the value |

*Parameter #3---minimum confirmations*

| Name | Type | Presence | Description |
| ---- | ---- | -------- | ----------- |
| Confirmations | number (int) | Optional<br>(0 or 1) | Minimum number of confirmations |

*Parameter #4---a comment*

| Name | Type | Presence | Description |
| ---- | ---- | -------- | ----------- |
| Comment | string | Optional<br>(0 or 1) | A locally-stored (not broadcast) comment assigned to this transaction.  Default is no comment |

*Parameter #5---automatic fee subtraction*

| Name | Type | Presence | Description |
| ---- | ---- | -------- | ----------- |
| Subtract Fee From Amount | array           | Optional<br>(0 or 1) | An array of addresses.  The fee will be equally divided by as many addresses as are entries in this array and subtracted from each address.  If this array is empty or not provided, the fee will be paid by the sender |
| →<br>Address             | string (base58) | Optional (0 or more) | An address previously listed as one of the recipients.                                                                                                                                                                  |

*Parameter #6---confirmation target*

| Name | Type | Presence | Description |
| ---- | ---- | -------- | ----------- |
| `conf_target` | number (int) | Optional<br>(0 or 1) | Confirmation target (in blocks) |

*Parameter #7---fee estimate mode*

| Name | Type | Presence | Description |
| ---- | ---- | -------- | ----------- |
| `estimate_mode` | string | Optional<br>(0 or 1) | The fee estimate mode, must be one of:<br>`unset`<br>`economical`<br>`conservative`<br>`DIME/kB`<br>`mDIME/B` |

*Result---a TXID of the sent transaction*

| Name     | Type   | Presence                | Description                                                        |
| -------- | ------ | ----------------------- | ------------------------------------------------------------------ |
| `result` | string | Required<br>(exactly 1) | The TXID of the sent transaction, encoded as hex in RPC byte order |

*Example from Dimecoin Core 2.3.0.0*

Send 1.0 DIME to the first address and 2.0 DIME to the second address, with a comment of "Example Transaction".

```bash
dimecoin-cli -mainnet sendmany \
  "" \
  '''
    {
      "7Sutkc49Khpz1HQN8AfWNitVBLwqtyaxvv": 1.0,
      "7hQrX8CZTTfSjKmaq5h7DgSShyEsumCRBi": 2.0
    } ''' \
  6       \
  false   \
  "Example Transaction"
```

Result:

```text
a7c0194a005a220b9bfeb5fdd12d5b90979c10f53de4f8a48a1495aa198a6b95
```

```{seealso}
* [SendToAddress](../api/rpc-wallet.md#sendtoaddress): spends an amount to a given address.
```

### SendToAddress

```{note}
Requires [wallet](../reference/glossary.md#wallet) support (**unavailable on masternodes**). Requires an unlocked wallet or an unencrypted wallet.
```

The [`sendtoaddress` RPC](../api/rpc-wallet.md#sendtoaddress) spends an amount to a given address.

*Parameter #1---to address*

| Name       | Type   | Presence                | Description                                              |
| ---------- | ------ | ----------------------- | -------------------------------------------------------- |
| To Address | string | Required<br>(exactly 1) | A P2PKH or P2SH address to which the DIME should be sent |

*Parameter #2---amount to spend*

| Name   | Type          | Presence                | Description                 |
| ------ | ------------- | ----------------------- | --------------------------- |
| Amount | number (DIME) | Required<br>(exactly 1) | The amount to spent in DIME |

*Parameter #3---a comment*

| Name    | Type   | Presence             | Description                                                                                   |
| ------- | ------ | -------------------- | --------------------------------------------------------------------------------------------- |
| Comment | string | Optional<br>(0 or 1) | A locally-stored (not broadcast) comment assigned to this transaction.  Default is no comment |

*Parameter #4---a comment about who the payment was sent to*

| Name       | Type   | Presence             | Description                                                                                                                                                |
| ---------- | ------ | -------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Comment To | string | Optional<br>(0 or 1) | A locally-stored (not broadcast) comment assigned to this transaction.  Meant to be used for describing who the payment was sent to. Default is no comment |

*Parameter #5---automatic fee subtraction*

| Name                     | Type    | Presence             | Description                                                                                                                                      |
| ------------------------ | ------- | -------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------ |
| Subtract Fee From Amount | boolean | Optional<br>(0 or 1) | The fee will be deducted from the amount being sent. The recipient will receive less DIME than you enter in the amount field. Default is `false` |

*Parameter #6---confirmation target*

| Name          | Type         | Presence             | Description                     |
| ------------- | ------------ | -------------------- | ------------------------------- |
| `conf_target` | number (int) | Optional<br>(0 or 1) | Confirmation target (in blocks) |

*Parameter #7---fee estimate mode*

| Name | Type | Presence | Description |
| ---- | ---- | -------- | ----------- |
| `estimate_mode` | string | Optional<br>(0 or 1) | The fee estimate mode, must be one of:<br>`unset`<br>`economical`<br>`conservative`<br>`DIME/kB`<br>`mDIME/B` |

*Parameter #8---avoids partial respends*

| Name          | Type    | Presence             | Description                                                                                                             |
| ------------- | ------- | -------------------- | ----------------------------------------------------------------------------------------------------------------------- |
| `avoid_reuse` | boolean | Optional<br>(0 or 1) | Avoid spending from dirty addresses; addresses are considered dirty if they have previously been used in a transaction. |

*Result---a TXID of the sent transaction*

| Name     | Type   | Presence                | Description                                                        |
| -------- | ------ | ----------------------- | ------------------------------------------------------------------ |
| `result` | string | Required<br>(exactly 1) | The TXID of the sent transaction, encoded as hex in RPC byte order |

*Example from Dimecoin Core 2.3.0.0*

Spend 1.0 DIME to the address below with the comment "sendtoaddress  
example" and the comment-to "John Doe From Example.com":

```bash
dimecoin-cli -mainnet sendtoaddress 7Sutkc49Khpz1HQN8AfWNitVBLwqtyaxvv \
  1.0 "sendtoaddress example" "John Doe From Example.com"
```

Result:

```text
70e2029d363f0110fe8a0aa2ba7bd771a579453135568b2aa559b2cb30f875aa
```

```{seealso}
* [SendMany](../api/rpc-wallet.md#sendmany): creates and broadcasts a transaction which sends outputs to multiple addresses.
```

### SetLabel

```{note}
Requires [wallet](../reference/glossary.md#wallet) support (**unavailable on masternodes**).
```

The [`setlabel` RPC](../api/rpc-wallet.md#setlabel) sets the label associated with the given address.

*Parameter #1---a DIME address*

| Name    | Type            | Presence                | Description                                                   |
| ------- | --------------- | ----------------------- | ------------------------------------------------------------- |
| Address | string (base58) | Required<br>(exactly 1) | The P2PKH or P2SH DIME address to be associated with a label. |

*Parameter #2---a label*

| Name  | Type   | Presence                | Description                         |
| ----- | ------ | ----------------------- | ----------------------------------- |
| Label | string | Required<br>(exactly 1) | The label to assign to the address. |

*Result---`null` if successful*

| Name     | Type | Presence                | Description                                                              |
| -------- | ---- | ----------------------- | ------------------------------------------------------------------------ |
| `result` | null | Required<br>(exactly 1) | Set to JSON `null` if the address was successfully placed in the account |

*Example from Dimecoin Core 2.3.0.0*

Assign the "doc test" label to the provided address.

```bash
dimecoin-cli -mainnet setlabel 7MTFRnrfJ4NpnYVeidDNHVwT7uuNsVjevq "test"
```

(Success: no result displayed.)

```{seealso}
* [ListLabels](../api/rpc-wallet.md#listlabels): returns the list of all labels, or labels that are assigned to addresses with a specific purpose.
* [GetAddressesByLabel](../api/rpc-wallet.md#getaddressesbylabel): returns the list of addresses assigned the specified label.
```

<span id="setprivatesendamount"></span>

### SetTxFee

```{note}
Requires [wallet](../reference/glossary.md#wallet) support (**unavailable on masternodes**).
```

The [`settxfee` RPC](../api/rpc-wallet.md#settxfee) sets the transaction fee per kilobyte paid by transactions created by this wallet.

*Parameter #1---the transaction fee amount per kilobyte*

| Name                         | Type          | Presence                | Description                                                                                                                                                                  |
| ---------------------------- | ------------- | ----------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Transaction Fee Per Kilobyte | number (DIME) | Required<br>(exactly 1) | The transaction fee to pay, in DIME, for each kilobyte of transaction data.  Be careful setting the fee too low---your transactions may not be relayed or included in blocks |

*Result: `true` on success*

| Name     | Type        | Presence                | Description                                   |
| -------- | ----------- | ----------------------- | --------------------------------------------- |
| `result` | bool (true) | Required<br>(exactly 1) | Set to `true` if the fee was successfully set |

*Example from Dimecoin Core 2.3.0.0*

Set the transaction fee per kilobyte to 100 000 mDIME.

```bash
dimecoin-cli -mainnet settxfee 0.10000
```

Result:

```json
true
```

```{seealso}
* [GetWalletInfo](../api/rpc-wallet.md#getwalletinfo): provides information about the wallet.
* [GetNetworkInfo](../api/rpc-network.md#getnetworkinfo): returns information about the node's connection to the network.
```

### SetWalletFlag

The SetWalletFlag RPC changes the state of the given wallet flag for a wallet.

\*Parameter #1---states the name of the flag to change

| Name | Type   | Presence                | Description                                                          |
| ---- | ------ | ----------------------- | -------------------------------------------------------------------- |
| flag | string | Required<br>(exactly 1) | The name of the flag to change. Current available flags: avoid_reuse |

\*Parameter #2---defining the new state

| Name  | Type    | Presence                   | Description    |
| ----- | ------- | -------------------------- | -------------- |
| value | boolean | Optional<br>(default TRUE) | The new state. |

*Result*

| Name              | Type                  | Presence                | Description                                                                   |
| ----------------- | --------------------- | ----------------------- | ----------------------------------------------------------------------------- |
| `result`          | object/null           | Required<br>(exactly 1) | An object containing the requested block, or JSON `null` if an error occurred |
| →<br>`flag_name`  | str (string)          | Required<br>(exactly 1) | the name of the flag that was modified                                        |
| →<br>`flag_state` | true\|false (boolean) | Required<br>(0 or 1)    | the new state of the flag                                                     |
| →<br>`warnings`   | str (string)          | Required<br>(exactly 1) | any warnings associated with the change                                       |

*Example from Dimecoin Core 2.3.0.0*

```bash
dimecoin-cli setwalletflag avoid_reuse
```

Result:

```json
{
  "flag_name": "avoid_reuse",
  "flag_state": true,
  "warnings": "You need to rescan the blockchain in order to correctly mark used destinations in the past. Until this is done, some destinations may be considered unused, even if the opposite is the case."
}
```

```{seealso}
*none*
```

### SignMessage

>
> Requires [wallet](../reference/glossary.md#wallet) support (**unavailable on masternodes**). Requires an unlocked wallet or an unencrypted wallet.

The [`signmessage` RPC](../api/rpc-wallet.md#signmessage) signs a message with the private key of an address.

*Parameter #1---the address corresponding to the private key to sign with*

| Name    | Type            | Presence                | Description                                              |
| ------- | --------------- | ----------------------- | -------------------------------------------------------- |
| Address | string (base58) | Required<br>(exactly 1) | A P2PKH address whose private key belongs to this wallet |

*Parameter #2---the message to sign*

| Name    | Type   | Presence                | Description         |
| ------- | ------ | ----------------------- | ------------------- |
| Message | string | Required<br>(exactly 1) | The message to sign |

*Result---the message signature*

| Name     | Type            | Presence                | Description                                      |
| -------- | --------------- | ----------------------- | ------------------------------------------------ |
| `result` | string (base64) | Required<br>(exactly 1) | The signature of the message, encoded in base64. |

*Example from Dimecoin Core 2.3.0.0*

Sign a the message "Hello, World!" using the following address:

```bash
dimecoin-cli -mainnet signmessage 7NpezfFDfoikDuT1f4iK75AiLp2YLPsGAb "Hello, World!"
```

Result:

```text
H4XULzfHCf16In2ECk9Ta9QxQPq639zQto2JA3OLlo3JbUdrClvJ89+A1z+Z9POd6l8LJhn1jGpQYF8mX4jkQvE=
```

```{seealso}
* [VerifyMessage](../api/rpc-utility.md#verifymessage): verifies a signed message.
```

### SignRawTransactionWithWallet

```{note}
Requires [wallet](../reference/glossary.md#wallet) support (**unavailable on masternodes**). Requires an unlocked wallet.
```

The [`signrawtransactionwithwallet` RPC](#signrawtransactionwithwallet) signs a transaction in the serialized transaction format using private keys stored in the wallet.

*Parameter #1---the transaction to sign*

| Name        | Type         | Presence                | Description                                         |
| ----------- | ------------ | ----------------------- | --------------------------------------------------- |
| Transaction | string (hex) | Required<br>(exactly 1) | The transaction to sign as a serialized transaction |

*Parameter #2---unspent transaction output details*

| Name                  | Type         | Presence                | Description                                                                                            |
| --------------------- | ------------ | ----------------------- | ------------------------------------------------------------------------------------------------------ |
| Dependencies          | array        | Optional<br>(0 or 1)    | The previous outputs being spent by this transaction                                                   |
| →<br>Output           | object       | Optional<br>(0 or more) | An output being spent                                                                                  |
| → →<br>`txid`         | string (hex) | Required<br>(exactly 1) | The TXID of the transaction the output appeared in.  The TXID must be encoded in hex in RPC byte order |
| → →<br>`vout`         | number (int) | Required<br>(exactly 1) | The index number of the output (vout) as it appeared in its transaction, with the first output being 0 |
| → →<br>`scriptPubKey` | string (hex) | Required<br>(exactly 1) | The output's pubkey script encoded as hex                                                              |
| → →<br>`redeemScript` | string (hex) | Optional<br>(0 or 1)    | If the pubkey script was a script hash, this must be the corresponding redeem script                   |
| → →<br>`amount`       | numeric      | Required<br>(exactly 1) | The amount of DIME spent                                                                               |

*Parameter #3---signature hash type*

| Name    | Type   | Presence             | Description                                                                                                                                                                                                                                                                                                         |                      |                            |                |
| :------ | :----- | :------------------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | :------------------- | :------------------------- | :------------- |
| SigHash | string | Optional<br>(0 or 1) | The type of signature hash to use for all of the signatures performed.  (You must use separate calls to the [`signrawtransactionwithwallet` RPC](#signrawtransactionwithwallet) if you want to use different signature hash types for different signatures.  The allowed values are: `ALL`, `NONE`, `SINGLE`, `ALL \| ANYONECANPAY`,`NONE \| ANYONECANPAY`, and`SINGLE \| ANYONECANPAY` |

*Result---the transaction with any signatures made*

| Name            | Type         | Presence                | Description                                                                                                                                                                    |
| --------------- | ------------ | ----------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `result`        | object       | Required<br>(exactly 1) | The results of the signature                                                                                                                                                   |
| →<br>`hex`      | string (hex) | Required<br>(exactly 1) | The resulting serialized transaction encoded as hex with any signatures made inserted.  If no signatures were made, this will be the same transaction provided in parameter #1 |
| →<br>`complete` | bool         | Required<br>(exactly 1) | The value `true` if transaction is fully signed; the value `false` if more signatures are required                                                                             |

*Example from Dimecoin Core 2.3.0.0*

Sign the hex generated from the `createrawtransaction` RPC:

```bash
dimecoin-cli -mainnet signrawtransactionwithwallet 020000000121f39228a11ddf19\
7ac3658e93bd264d0afd927f0cdfc7caeb760537e529c94a0100000000ffffffff0180969\
800000000001976a914fe64a96d6660e30c433e1189082466a95bdf9ceb88ac00000000
```

Result:

```json
{
  "hex": "020000000121f39228a11ddf197ac3658e93bd264d0afd927f0cdfc7caeb760537e529c94a010000006b483045022100811c5679ef097b0e5a338fc3cd05ee50e1802680ea8a172d0fd3a81da3c1fc2002204804b18a44e888ac1ee9b6a7cbadc211ecdc30f8c889938c95125206e39554220121025d81ce6581e547dd34194385352053abb17f0246768d75443b25ded5e37d594fffffffff0180969800000000001976a914fe64a96d6660e30c433e1189082466a95bdf9ceb88ac00000000",
  "complete": true
}
```

```{seealso}
* [CombineRawTransaction](../api/rpc-raw-transactions.md#combinerawtransaction): combine multiple partially signed transactions into one transaction.
* [CreateRawTransaction](../api/rpc-raw-transactions.md#createrawtransaction): creates an unsigned serialized transaction that spends a previous output to a new output with a P2PKH or P2SH address. The transaction is not stored in the wallet or transmitted to the network.
* [DecodeRawTransaction](../api/rpc-raw-transactions.md#decoderawtransaction): decodes a serialized transaction hex string into a JSON object describing the transaction.
* [SendRawTransaction](../api/rpc-raw-transactions.md#sendrawtransaction): validates a transaction and broadcasts it to the peer-to-peer network.
* [SignRawTransactionWithKey](../api/rpc-raw-transactions.md#signrawtransactionwithkey): signs inputs for a transaction in the serialized transaction format using private keys provided in the call.
```

### UnloadWallet

```{note}
Requires [wallet](../reference/glossary.md#wallet) support (**unavailable on masternodes**).
```

The [`unloadwallet` RPC](../api/rpc-wallet.md#unloadwallet) unloads the wallet referenced by the request endpoint otherwise unloads the wallet specified in the argument. Specifying the wallet name on a wallet endpoint is invalid.

*Parameter #1---wallet name*

| Name     | Type   | Presence                | Description                       |
| -------- | ------ | ----------------------- | --------------------------------- |
| Filename | string | Required<br>(exactly 1) | The name of the wallet to unload. If provided both here and in the RPC endpoint, the two must be identical. |

*Parameter #2---load of startup*

| Name            | Type    | Presence             | Description                                                                                                                                |
| --------------- | ------- | -------------------- | ------------------------------------------------------------------------------------------------------------------------------------------ |
| load_on_startup | boolean | Optional<br>(0 or 1) | Save wallet name to persistent settings and load on startup. True to add wallet to startup list, false to remove, null to leave unchanged. |

*Result---null on success*

*Example from Dimecoin Core 2.3.0.0*

```bash
dimecoin-cli -mainnet unloadwallet wallet-test.dat
```

Result:

```shell
null
```

```{seealso}
* [LoadWallet](../api/rpc-wallet.md#loadwallet): loads a wallet from a wallet file or directory.
```

### UpgradeWallet

The [`upgradewallet` RPC](#upgradewallet) upgrades the wallet to the latest version if no version number is specified. New keys may be generated and a new wallet backup will need to be made.

*Parameters*

| Name      | Type   | Presence             | Description                                                             |
| --------- | ------ | -------------------- | ----------------------------------------------------------------------- |
| `version` | number | Optional<br>(0 or 1) | The version number to upgrade to. Default is the latest wallet version. |

*Result---`null` on success*

| Name     | Type | Presence                | Description                                                                |
| -------- | ---- | ----------------------- | -------------------------------------------------------------------------- |
| `result` | null | Required<br>(exactly 1) | `null` when the command was successful or error message if not successful. |

*Example from Dimecoin Core 2.3.0.0*

Upgrade wallet without specifying any optional parameters:

```bash
dimecoin-cli -mainnet upgradewallet
```

Result (no output from dimecoin-cli because result is set to null).

```{seealso}
* [DumpHDInfo](../api/rpc-wallet.md#dumphdinfo):  returns an object containing sensitive private info about this HD wallet
```

### WalletCreateFundedPSBT

The [`walletcreatefundedpsbt` RPC](../api/rpc-wallet.md#walletcreatefundedpsbt) creates and funds a transaction in the Partially Signed Transaction (PST) format. Inputs will be added if supplied inputs are not enough.

Implements the Creator and Updater roles.

*Parameter #1---Inputs*

| Name              | Type         | Presence                | Description                                                                                                |
| ----------------- | ------------ | ----------------------- | ---------------------------------------------------------------------------------------------------------- |
| Inputs            | array        | Required<br>(exactly 1) | An array of objects, each one to be used as an input to the transaction                                    |
| → Input           | object       | Required<br>(1 or more) | An object describing a particular input                                                                    |
| → →<br>`txid`     | string (hex) | Required<br>(exactly 1) | The TXID of the outpoint to be spent encoded as hex in RPC byte order                                      |
| → →<br>`vout`     | number (int) | Required<br>(exactly 1) | The output index number (vout) of the outpoint to be spent; the first output in a transaction is index `0` |
| → →<br>`Sequence` | number (int) | Optional<br>(0 or 1)    | The sequence number to use for the input                                                                   |

*Parameter #2---Outputs*

| Name           | Type                  | Presence                | Description                                                                                               |
| -------------- | --------------------- | ----------------------- | --------------------------------------------------------------------------------------------------------- |
| Outputs        | array                 | Required<br>(exactly 1) | A JSON array with outputs as key-value pairs                                                              |
| → Output       | object                | Required<br>(1 or more) | An object describing a particular output                                                                  |
| → →<br>Address | string: number (DIME) | Optional<br>(0 or 1)    | A key-value pair. The key (string) is the DIME address, the value (float or string) is the amount in DIME |
| → →<br>Data    | `data`: string (hex)  | Optional<br>(0 or 1)    | A key-value pair. The key must be `data`, the value is hex encoded data                                   |

*Parameter #3---locktime*

| Name     | Type          | Presence             | Description                                                                                                                          |
| -------- | ------------- | -------------------- | ------------------------------------------------------------------------------------------------------------------------------------ |
| Locktime | numeric (int) | Optional<br>(0 or 1) | Indicates the earliest time a transaction can be added to the blockchain (default=`0`). Non-0 value also locktime-activates inputs. |

*Parameter #4---Additional options*

| Name                           | Type              | Presence                | Description |
| ------------------------------ | ----------------- | ----------------------- | ----------- |
| Options                        | Object            | Optional<br>(0 or 1)    | Additional options |
| → <br>`changeAddress`          | string            | Optional<br>(0 or 1)    | The DIME address to receive the change (default=pool address) |
| → <br>`changePosition`         | numeric (int)     | Optional<br>(0 or 1)    | The index of the change output (default=random) |
| → <br>`includeWatching`        | bool              | Optional<br>(0 or 1)    | Also select inputs which are watch only (default=`false` for non-watching only wallets and `true` for watching only-wallets) |
| → <br>`lockUnspents`           | bool              | Optional<br>(0 or 1)    | Lock selected unspent outputs (default=`false`) |
| → <br>`feeRate`                | numeric or string | Optional<br>(0 or 1)    | Set a specific fee rate in DIME/kB |
| → <br>`subtractFeeFromOutputs` | array             | Optional<br>(0 or 1)    | A json array of integers. The fee will be equally deducted from the amount of each specified output. The outputs are specified by their zero-based index, before any change output is added. Those recipients will receive less DIME than you enter in their corresponding amount field. If no outputs are specified here, the sender pays the fee. |
| → →<br>Output index            | numeric (int)     | Optional<br>(0 or more) | An output index number (vout) from which the fee should be subtracted. If multiple vouts are provided, the total fee will be divided by the number of vouts listed and each vout will have that amount subtracted from it. |
| → <br>`conf_target`            | numeric (int)     | Optional<br>(0 or 1)    | Confirmation target (in blocks) |
| → <br>`estimate_mode`          | numeric (int)     | Optional<br>(0 or 1)    | The fee estimate mode, must be one of:<br>`unset`<br>`economical`<br>`conservative`<br>`DIME/kB`<br>`mDIME/B` |

*Parameter #5---bip32derivs*

| Name          | Type | Presence                     | Description                                                                      |
| ------------- | ---- | ---------------------------- | -------------------------------------------------------------------------------- |
| `bip32derivs` | bool | Optional<br>(exactly 0 or 1) | Includes the BIP 32 derivation paths for public keys if known (default = `true`) |

*Result---information about the created transaction*

| Name              | Type               | Presence                | Description                                                                    |
| ----------------- | ------------------ | ----------------------- | ------------------------------------------------------------------------------ |
| `result`          | object             | Required<br>(exactly 1) | An object including information about the created transaction                  |
| → <br>`psbt`      | string (base64)    | Required<br>(Exactly 1) | The resulting raw transaction (base64-encoded string)                          |
| → <br>`fee`       | numeric (dimecoins) | Required<br>(Exactly 1) | Fee in DIME the resulting transaction pays                                     |
| → <br>`changepos` | numeric (int)      | Required<br>(Exactly 1) | The position of the added change output, or `-1` if no change output was added |

*Example from Dimecoin Core 2.3.0.0*

```bash
dimecoin-cli -mainnet walletcreatefundedpsbt "[{\"txid\":\"6536c87e1761ed5f4e98a0640b9564324d86f282824a51bd624985d236c78456\",\"vout\":0}]" "[{\"data\":\"00010203\"}]"
```

Result:

```json
{
  "psbt": "cHNidP8BAGQCAAAAAXgRxzbShUlivVFKgoLyhk0RCCYLZKCYTl/tYRd+yGImAAAAAAD/////AgAAAAAAAAAABmoEAAECA6PmxgkAAAAAGXapFFNPqpebN9gMkzsFJWixaDCZ3S8OiKwAAAAAAAEA4QIAAAABlIu3UCzRFVGowPY3H7RvS5g6QGc71ZYEFXIrcS+NfEIBAAAAakcwRAIgT+T8SIyVXyhsUshI7HlQtA7EduG0NMat1oa0dL3eCakCIGIi0pH9naNBQIqopHIPWmlZmXcVod34GH51J3tr/K5+ASEDxn2GlEMVg4rqfsgNOQtdCbkbYkgzcNSXnaXM96ffd6n+////ArTnxgkAAAAAGXapFM78RkkEwDgUwBkG4ZfcdZp0XkfuiKwAypo7AAAAABl2qRQ++by+kvd8j63QVm7qf/jUfyK94IisVUgIAAAAAA==",
  "fee": 0.00273,
  "changepos": 1
}
```

```{seealso}
*none*
```

### WalletLock

```{note}
Requires [wallet](../reference/glossary.md#wallet) support (**unavailable on masternodes**). Requires an unlocked wallet.
```

The [`walletlock` RPC](../api/rpc-wallet.md#walletlock) removes the wallet encryption key from memory, locking the wallet. After calling this method, you will need to call `walletpassphrase` again before being able to call any methods which require the wallet to be unlocked.

*Parameters: none*

*Result---`null` on success*

| Name     | Type | Presence                | Description               |
| -------- | ---- | ----------------------- | ------------------------- |
| `result` | null | Required<br>(exactly 1) | Always set to JSON `null` |

*Example from Dimecoin Core 2.3.0.0*

```bash
dimecoin-cli -mainnet walletlock
```

(Success: nothing printed.)

```{seealso}
* [EncryptWallet](../api/rpc-wallet.md#encryptwallet): encrypts the wallet with a passphrase.  This is only to enable encryption for the first time. After encryption is enabled, you will need to enter the passphrase to use private keys.
* [WalletPassphrase](../api/rpc-wallet.md#walletpassphrase): stores the wallet decryption key in memory for the indicated number of seconds. Issuing the `walletpassphrase` command while the wallet is already unlocked will set a new unlock time that overrides the old one.
* [WalletPassphraseChange](../api/rpc-wallet.md#walletpassphrasechange): changes the wallet passphrase from 'old passphrase' to 'new passphrase'.
```

### WalletPassphrase

```{note}
Requires [wallet](../reference/glossary.md#wallet) support (**unavailable on masternodes**). Requires an encrypted wallet.
```

The [`walletpassphrase` RPC](../api/rpc-wallet.md#walletpassphrase) stores the wallet decryption key in memory for the indicated number of seconds. Issuing the `walletpassphrase` command while the wallet is already unlocked will set a new unlock time that overrides the old one.

```{warning}
If using this RPC on the command line, remember that your shell probably saves your command lines (including the value of the passphrase parameter).
```


*Parameter #1---the passphrase*

| Name       | Type   | Presence                | Description                            |
| ---------- | ------ | ----------------------- | -------------------------------------- |
| Passphrase | string | Required<br>(exactly 1) | The passphrase that unlocks the wallet |

*Parameter #2---the number of seconds to leave the wallet unlocked*

| Name    | Type         | Presence                | Description                                                                                    |
| ------- | ------------ | ----------------------- | ---------------------------------------------------------------------------------------------- |
| Seconds | number (int) | Required<br>(exactly 1) | The number of seconds after which the decryption key will be automatically deleted from memory |

*Parameter #3---unlock for staking only* *TODO - NOT FULLY IMPLEMENTED  YET*

| Name        | Type | Presence             | Description                                                                                                      |
| ----------- | ---- | -------------------- | ---------------------------------------------------------------------------------------------------------------- |
| Unlock for Staking Only | bool | Optional<br>(0 or 1) | If `true`, the wallet will be locked for sending functions but unlocked for staking only (default: false) |

*Result---`null` on success*

| Name     | Type | Presence                | Description               |
| -------- | ---- | ----------------------- | ------------------------- |
| `result` | null | Required<br>(exactly 1) | Always set to JSON `null` |

*Example from Dimecoin Core 2.3.0.0*

Unlock the wallet for 10 minutes (the passphrase is "test"):

```bash
dimecoin-cli -mainnet walletpassphrase test 600
```

(Success: no result printed.)

```{seealso}
* [EncryptWallet](../api/rpc-wallet.md#encryptwallet): encrypts the wallet with a passphrase.  This is only to enable encryption for the first time. After encryption is enabled, you will need to enter the passphrase to use private keys.
* [WalletPassphraseChange](../api/rpc-wallet.md#walletpassphrasechange): changes the wallet passphrase from 'old passphrase' to 'new passphrase'.
* [WalletLock](../api/rpc-wallet.md#walletlock): removes the wallet encryption key from memory, locking the wallet. After calling this method, you will need to call `walletpassphrase` again before being able to call any methods which require the wallet to be unlocked.
```

### WalletPassphraseChange

```{note}
Requires [wallet](../reference/glossary.md#wallet) support (**unavailable on masternodes**). Requires an encrypted wallet.
```

The [`walletpassphrasechange` RPC](../api/rpc-wallet.md#walletpassphrasechange) changes the wallet passphrase from 'old passphrase' to 'new passphrase'.

```{warning}
If using this RPC on the command line, remember that your shell probably saves your command lines (including the value of the passphrase parameter).
```


*Parameter #1---the current passphrase*

| Name               | Type   | Presence                | Description                   |
| ------------------ | ------ | ----------------------- | ----------------------------- |
| Current Passphrase | string | Required<br>(exactly 1) | The current wallet passphrase |

*Parameter #2---the new passphrase*

| Name           | Type   | Presence                | Description                       |
| -------------- | ------ | ----------------------- | --------------------------------- |
| New Passphrase | string | Required<br>(exactly 1) | The new passphrase for the wallet |

*Result---`null` on success*

| Name     | Type | Presence                | Description               |
| -------- | ---- | ----------------------- | ------------------------- |
| `result` | null | Required<br>(exactly 1) | Always set to JSON `null` |

*Example from Dimecoin Core 2.3.0.0*

Change the wallet passphrase from "test" to "test2:

```bash
dimecoin-cli -mainnet walletpassphrasechange "test" "test2"
```

(Success: no result printed.)

```{seealso}
* [EncryptWallet](../api/rpc-wallet.md#encryptwallet): encrypts the wallet with a passphrase.  This is only to enable encryption for the first time. After encryption is enabled, you will need to enter the passphrase to use private keys.
* [WalletLock](../api/rpc-wallet.md#walletlock): removes the wallet encryption key from memory, locking the wallet. After calling this method, you will need to call `walletpassphrase` again before being able to call any methods which require the wallet to be unlocked.
* [WalletPassphrase](../api/rpc-wallet.md#walletpassphrase): stores the wallet decryption key in memory for the indicated number of seconds. Issuing the `walletpassphrase` command while the wallet is already unlocked will set a new unlock time that overrides the old one.
```

### WalletProcessPSBT

The [`walletprocesspsbt` RPC](../api/rpc-wallet.md#walletprocesspsbt) updates a PSBT with input information from a wallet and then allows the signing of inputs.

*Parameter #1---PSBT*

| Name   | Type   | Presence                | Description                   |
| ------ | ------ | ----------------------- | ----------------------------- |
| `psbt` | string | Required<br>(exactly 1) | The transaction base64 string |

*Parameter #2---Sign Transaction*

| Name   | Type | Presence                     | Description                                           |
| ------ | ---- | ---------------------------- | ----------------------------------------------------- |
| `sign` | bool | Optional<br>(exactly 0 or 1) | Sign the transaction when updating (default = `true`) |

*Parameter #3---Signature Hash Type*

| Name          | Type   | Presence                     | Description                                                                                                                                                                                                                    |
| ------------- | ------ | ---------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `sighashtype` | string | Optional<br>(exactly 0 or 1) | The signature hash type to sign with if not specified by the PSBT. Must be one of the following (default = ALL):<br> - ALL<br> - NONE<br> - SINGLE<br> - ALL\|ANYONECANPAY<br> - NONE\|ANYONECANPAY<br> - SINGLE\|ANYONECANPAY |

*Parameter #4---bip32derivs*

| Name          | Type | Presence                     | Description                                                                       |
| ------------- | ---- | ---------------------------- | --------------------------------------------------------------------------------- |
| `bip32derivs` | bool | Optional<br>(exactly 0 or 1) | Includes the BIP 32 derivation paths for public keys if known (default = `true`). |

*Result---the processed wallet*

| Name            | Type   | Presence                | Description                                         |
| --------------- | ------ | ----------------------- | --------------------------------------------------- |
| `result`        | object | Required<br>(exactly 1) | The results of the signature                        |
| →<br>`psbt`     | string | Required<br>(exactly 1) | The base64-encoded partially signed transaction     |
| →<br>`complete` | bool   | Required<br>(exactly 1) | If the transaction has a complete set of signatures |

*Example from Dimecoin Core 2.3.0.0*

```bash
dimecoin-cli walletprocesspsbt "cHNidP8BAEICAAAAAXgRxzbShUlivVFKgoLyhk0RCCYLZKCYTl/tYRd+yGImAAAAAAD/////AQAAAAAAAAAABmoEAAECAwAAAAAAAAA="
```

Result:

```json
{
  "psbt": "cHNidP8BAEICAAAAAXgRxzbShUlivVFKgoLyhk0RCCYLZKCYTl/tYRd+yGImAAAAAAD/////AQAAAAAAAAAABmoEAAECAwAAAAAAAQDhAgAAAAGUi7dQLNEVUajA9jcftG9LmDpAZzvVlgQVcitxL418QgEAAABqRzBEAiBP5PxIjJVfKGxSyEjseVC0DsR24bQ0xq3WhrR0vd4JqQIgYiLSkf2do0FAiqikcg9aaVmZdxWh3fgYfnUne2v8rn4BIQPGfYaUQxWDiup+yA05C10JuRtiSDNw1Jedpcz3p993qf7///8CtOfGCQAAAAAZdqkUzvxGSQTAOBTAGQbhl9x1mnReR+6IrADKmjsAAAAAGXapFD75vL6S93yPrdBWbup/+NR/Ir3giKxVSAgAAQdqRzBEAiAF1fgBDg2M/WAeYTYzCkEiSSrDVzcYoe8wwrw/MbdgOQIgJzoYBQ9hAm6jqk2cLFitUd1/iL1ku8w9unadjNfsCdoBIQJn2pETmk8U2X6veADqnny5/6j8Iy7Oizij0SeJHm9x6AAA",
  "complete": true
}
```

```{seealso}
* [CreatePSBT](../api/rpc-raw-transactions.md#createpsbt): creates a transaction in the Partially Signed Transaction (PST) format.
* [CombinePSBT](../api/rpc-raw-transactions.md#combinepsbt): combine multiple partially-signed DIME transactions into one transaction.
* [ConvertToPSBT](../api/rpc-raw-transactions.md#converttopsbt): converts a network serialized transaction to a PSBT.
* [DecodePSBT](../api/rpc-raw-transactions.md#decodepsbt): returns a JSON object representing the serialized, base64-encoded partially signed DIME transaction.
* [FinalizePSBT](../api/rpc-raw-transactions.md#finalizepsbt): finalizes the inputs of a PSBT.
* [WalletCreateFundedPSBT](../api/rpc-wallet.md#walletcreatefundedpsbt): creates and funds a transaction in the Partially Signed Transaction (PST) format.
```

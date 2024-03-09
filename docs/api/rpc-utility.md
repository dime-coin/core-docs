```{eval-rst}
.. meta::
  :title: Util RPCs
  :description: A list of utility remote procedure calls in Dimecoin Core.
```
> ***We put our best effort into covering all topics related to Dimecoin. Each section will cover a different category. Not all documentation may be 100% accurate, if you spot an error, please report it or submit a PR request on GitHub.***
>
> ***REMINDER: This documentation is always evolving. If you have not been here for a while, perhaps check again. Things may have been added or updated since your last visit!***

# Util RPCs

## CreateMultiSig

The [`createmultisig` RPC](../api/rpc-utility.md#createmultisig) creates a P2SH multi-signature address.

*Parameter #1---the number of signatures required*

Name | Type | Presence | Description
--- | --- | --- | ---
Required | number (int) | Required<br>(exactly 1) | The minimum (*m*) number of signatures required to spend this m-of-n multisig script

*Parameter #2---the full public keys*

Name | Type | Presence | Description
--- | --- | --- | ---
Keys | array | Required<br>(exactly 1) | An array of strings with each string being a public key
→<br>Key | string | Required<br>(1 or more) | A public key against which signatures will be checked. There must be at least as many keys as specified by the `Required` parameter, and there may be more keys

*Result---P2SH address and hex-encoded redeem script*

Name | Type | Presence | Description
--- | --- | --- | ---
`result` | object | Required<br>(exactly 1) | An object describing the multisig address
→<br>`address` | string (base58) | Required<br>(exactly 1) | The P2SH address for this multisig redeem script
→<br>`redeemScript` | string (hex) | Required<br>(exactly 1) | The multisig redeem script encoded as hex
→<br>`descriptor` | string (hex) | Required<br>(exactly 1) | The descriptor for this multisig

*Example from Dimecoin Core 2.3.0.0*

Creating a 1-of-2 P2SH multisig address by combining two full public keys:

``` bash
dimecoin-cli -mainnet createmultisig 1 '''
  [
    "03283a224c2c014d1d0ef82b00470b6b277d71e227c0e2394f9baade5d666e57d3",
    "02594523b004e82849a66b3da096b1e680bf2ed5f7d03a3443c027aa5777bb6223"
  ]
'''
```

Result:

``` json
{
  "address": "7jYUv8hJcbSUPbwYmzp1XMPU6SXoic3hwi",
  "redeemScript": "512103283a224c2c014d1d0ef82b00470b6b277d71e227c0e2394f9baade5d666e57d32102594523b004e82849a66b3da096b1e680bf2ed5f7d03a3443c027aa5777bb622352ae",
  "descriptor": "sh(multi(1,03283a224c2c014d1d0ef82b00470b6b277d71e227c0e2394f9baade5d666e57d3,02594523b004e82849a66b3da096b1e680bf2ed5f7d03a3443c027aa5777bb6223))#x7tdvpdd"
}
```

*See also*

* [AddMultiSigAddress](../api/rpc-wallet.md#addmultisigaddress): adds a P2SH multisig address to the wallet.
* [DecodeScript](../api/rpc-raw-transactions.md#decodescript): decodes a hex-encoded P2SH redeem script.

## EstimateSmartFee

The [`estimatesmartfee` RPC](../api/rpc-utility.md#estimatesmartfee) estimates the transaction fee per kilobyte that needs to be paid for a transaction to begin confirmation within a certain number of blocks and returns the number of blocks for which the estimate is valid.

*Parameter #1---how many confirmations the transaction may wait before being included*

Name | Type | Presence | Description
--- | --- | --- | ---
conf_target | number (int) | Required<br>(exactly 1) | Confirmation target in blocks (1 - 1008)

*Parameter #2---estimate mode*

Name | Type | Presence | Description
--- | --- | --- | ---
estimate_mode | string | Optional<br>Default=<br>`CONSERVATIVE` | The fee estimate mode. Whether to return a more conservative estimate which also satisfies a longer history. A conservative estimate potentially returns a higher feerate and is more likely to be sufficient for the desired target, but is not as responsive to short term drops in the prevailing fee market.  Must be one of:<br>`UNSET` (defaults to `CONSERVATIVE`)<br>`ECONOMICAL`<br>`CONSERVATIVE`

*Result---the fee the transaction needs to pay per kilobyte*

Name | Type | Presence | Description
--- | --- | --- | ---
`result` | object | Required<br>(exactly 1) | JSON Object containing estimate information
→<br>`feerate` | number (DIME) | Optional<br>(0 or 1) | The estimated fee the transaction should pay in order to be included within the specified number of blocks.  If the node doesn't have enough information to make an estimate, this field will not be returned
→<br>`error` | JSON array (strings) | Optional<br>(0 or 1) | Errors encountered during processing
→<br>`blocks` | number | Required<br>(exactly 1) | Block number where the estimate was found

*Examples from Dimecoin Core 2.3.0.0*

``` bash
dimecoin-cli estimatesmartfee 6
```

Result:

``` json
{
  "feerate": 0.00044345,
  "blocks": 6
}
```

Requesting data the node can't calculate (out of range):

``` bash
dimecoin-cli estimatesmartfee 2
```

Result:

``` json
{
  "errors": [
    "Insufficient data or no feerate found"
  ],
  "blocks": 2
}
```

*See also*

* [SetTxFee](../api/rpc-wallet.md#settxfee): sets the transaction fee per kilobyte paid by transactions created by this wallet.

## ValidateAddress

The [`validateaddress` RPC](../api/rpc-utility.md#validateaddress) returns information about the given DIME address.

*Parameter #1---a P2PKH or P2SH address*

Name | Type | Presence | Description
--- | --- | --- | ---
Address | string (base58) | Required<br>(exactly 1) | The P2PKH or P2SH address to validate encoded in base58check format

*Result---information about the address*

> 🚧 Dimecoin Core 0.17.0 Deprecations
>
> Parts of this command have been deprecated and moved to the [getaddressinfo RPC](../api/rpc-wallet.md#getaddressinfo). Clients must transition to using `getaddressinfo` to access this information.

Name | Type | Presence | Description
--- | --- | --- | ---
`result` | object | Required<br>(exactly 1) | Information about the address
→<br>`isvalid` | bool | Required<br>(exactly 1) | Set to `true` if the address is a valid P2PKH or P2SH address; set to `false` otherwise
→<br>`address` | string (base58) | Optional<br>(0 or 1) | The DIME address given as parameter
→<br>`scriptPubKey` | string (hex) | Optional<br>(0 or 1) | The hex encoded scriptPubKey generated by the address
→<br>`isscript` | bool | Optional<br>(0 or 1) | Set to `true` if a P2SH address; otherwise set to `false`.  Only returned if the address is in the wallet
→<br>`iswitness`| bool | Optional<br>(0 or 1) | If the address is a witness address

*Example from Dimecoin Core 2.0.0.0*

Validate the following P2PKH address from the wallet:

``` bash
dimecoin-cli validateaddress 7KevA5YQSyWMAykzFWPuPEXJk1bxUwXxaY
```

Result:

``` json
{
  "isvalid": true,
  "address": "7KevA5YQSyWMAykzFWPuPEXJk1bxUwXxaY",
  "scriptPubKey": "76a914b5e9ccdf17eb279fbb44394894ce43eced5af05188ac",
  "isscript": false,
  "iswitness": false
}
```

Validate the following P2SH multisig address from the wallet:

``` bash
dimecoin-cli -mainnet validateaddress 8uJLxDxk2gEMbidF5vT8XLS2UCgQmVcroW
```

Result:

``` json
{
  "isvalid": true,
  "address": "8uJLxDxk2gEMbidF5vT8XLS2UCgQmVcroW",
  "scriptPubKey": "a914a33155e490d146e656a9bac2cbee9c625ef42f0a87",
  "isscript": true
}
```

*See also*

* [ImportAddress](../api/rpc-wallet.md#importaddress): adds an address or pubkey script to the wallet without the associated private key, allowing you to watch for transactions affecting that address or pubkey script without being able to spend any of its outputs.
* [GetNewAddress](../api/rpc-wallet.md#getnewaddress): returns a new DIME address for receiving payments. If an account is specified, payments received with the address will be credited to that account.
* [GetAddressInfo](../api/rpc-wallet.md#getaddressinfo): returns information about the given DIME address.

## VerifyMessage

The [`verifymessage` RPC](../api/rpc-utility.md#verifymessage) verifies a signed message.

*Parameter #1---the address corresponding to the signing key*

Name | Type | Presence | Description
--- | --- | --- | ---
Address | string (base58) | Required<br>(exactly 1) | The P2PKH address corresponding to the private key which made the signature.  A P2PKH address is a hash of the public key corresponding to the private key which made the signature.  When the ECDSA signature is checked, up to four possible ECDSA public keys will be reconstructed from from the signature; each key will be hashed and compared against the P2PKH address provided to see if any of them match.  If there are no matches, signature validation will fail

*Parameter #2---the signature*

Name | Type | Presence | Description
--- | --- | --- | ---
Signature | string (base64) | Required<br>(exactly 1) | The signature created by the signer encoded as base-64 (the format output by the [`signmessage` RPC](../api/rpc-wallet.md#signmessage))

*Parameter #3---the message*

Name | Type | Presence | Description
--- | --- | --- | ---
Message | string | Required<br>(exactly 1) | The message exactly as it was signed (e.g. no extra whitespace)

*Result: `true`, `false`, or an error*

Name | Type | Presence | Description
--- | --- | --- | ---
`result` | boolean | Required<br>(exactly 1) | Set to `true` if the message was signed by a key corresponding to the provided P2PKH address; set to `false` if it was not signed by that key; set to JSON `null` if an error occurred

*Example from Dimecoin Core 2.3.0.0*

Check the signature on the message created in the example for
`signmessage`:

``` bash
dimecoin-cli -mainnet verifymessage \
  7Q1qNyuskRBFpY9WvH2ztv6rJMvQpNaBWi \
  H7idbNmfOmPJ0lMnF+fFE8V+G9zn8KX6BlFw1+Um/WcpMClBrlepbtj14d246QAIJLto08LcBZbAp+ESCjR8xpE= \
  'Hello, World!'
```

Result:

``` json
true
```

*See also*

* [SignMessage](../api/rpc-wallet.md#signmessage): signs a message with the private key of an address.

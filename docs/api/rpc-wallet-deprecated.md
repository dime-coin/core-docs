```{eval-rst}
.. meta::
  :title: Wallet RPCs
  :description: A list of deprecated Wallet RPCs.
```

> ***We put our best effort into covering all topics related to Dimecoin. Each section will cover a different category. Not all documentation may be 100% accurate, if you spot an error, please report it or submit a PR request on GitHub.***
>
> ***REMINDER: This documentation is always evolving. If you have not been here for a while, perhaps check again. Things may have been added or updated since your last visit!***

# Wallet RPCs (Deprecated)

>**NOTE**
>
> RPCs that require wallet support are **not available on masternodes** for security reasons. Such RPCs are designated with a "*Requires wallet support*" message.
>

## GetAccount

> **NOTE**
>
> Requires [wallet](../resources/glossary.md#wallet) support (**unavailable on masternodes**)

The [`getaccount` RPC](../api/rpc-wallet-deprecated.md#getaccount) returns the name of the account associated with the given address.

*Parameter #1---a Dimecoin address*

Name | Type | Presence | Description
--- | --- | --- | ---
Address | string (base58) | Required<br>(exactly 1) | A P2PKH or P2SH Dimecoin address belonging either to a specific account or the default account (\\")"

*Result---an account name*

Name | Type | Presence | Description
--- | --- | --- | ---
`result` | string | Required<br>(exactly 1) | The name of an account, or an empty string (\\", the default account)"

*Example from Dimecoin Core 1.10.01*

``` bash
Dimecoin-cli -mainnet getaccount 7MTFRnrfJ4NpnYVeidDNHVwT7uuNsVjevq
```

Result:

``` text
doc test
```

*See also*

* [GetAddressesByAccount](../api/rpc-wallet-deprecated.md#getaddressesbyaccount): returns a list of every address assigned to a particular account.

## GetAccountAddress

> **NOTE**
>
> Requires [wallet](../resources/glossary.md#wallet) support (**unavailable on masternodes**)

The [`getaccountaddress` RPC](../api/rpc-wallet-deprecated.md#getaccountaddress) returns the current Dimecoin address for receiving payments to this account. If the account doesn't exist, it creates both the account and a new address for receiving payment.  Once a payment has been received to an address, future calls to this RPC for the same account will return a different address.

*Parameter #1---an account name*

Name | Type | Presence | Description
--- | --- | --- | ---
Account | string | Required<br>(exactly 1) | The name of an account.  Use an empty string (\\") for the default account.  If the account doesn't exist, it will be created"

*Result---a Dimecoin address*

Name | Type | Presence | Description
--- | --- | --- | ---
`result` | string (base58) | Required<br>(exactly 1) | An address, belonging to the account specified, which has not yet received any payments

*Example from Dimecoin Core 1.10.01*

Get an address for the default account:

``` bash
dimecoin-cli -mainnet getaccountaddress ""
```

Result:

``` text
7NUQ6RzTpNj5GP5ebdRcusJ7K9JJKx6VvV
```

*See also*

* [GetNewAddress](../api/rpc-wallet.md#getnewaddress): returns a new Dimecoin address for receiving payments. If an account is specified, payments received with the address will be credited to that account.
* [GetRawChangeAddress](../api/rpc-wallet.md#getrawchangeaddress): returns a new Dimecoin address for receiving change. This is for use with raw transactions, not normal use.
* [GetAddressesByAccount](../api/rpc-wallet-deprecated.md#getaddressesbyaccount): returns a list of every address assigned to a particular account.

## GetAddressesByAccount

> **NOTE**
>
> Requires [wallet](../resources/glossary.md#wallet) support (**unavailable on masternodes**)

The [`getaddressesbyaccount` RPC](../api/rpc-wallet-deprecated.md#getaddressesbyaccount) returns a list of every address assigned to a particular account.

*Parameter #1---the account name*

Name | Type | Presence | Description
--- | --- | --- | ---
Account | string | Required<br>(exactly 1) | The name of the account containing the addresses to get.  To get addresses from the default account, pass an empty string (\\")"

*Result---a list of addresses*

Name | Type | Presence | Description
--- | --- | --- | ---
`result` | array | Required<br>(exactly 1) | An array containing all addresses belonging to the specified account.  If the account has no addresses, the array will be empty
Address | string (base58) | Optional<br>(1 or more) | A P2PKH or P2SH address belonging to the account

*Example from Dimecoin Core 1.10.01*

Get the addresses assigned to the account "test":

``` bash
dimecoin-cli -mainnet getaddressesbyaccount "test"
```

Result:

``` json
[
  "7MTFRnrfJ4NpnYVeidDNHVwT7uuNsVjevq",
  "7hT2HS1SxvXkMVdAdf6RNtGPfuVFvwZi35"
]
```

*See also*

* [GetAccount](../api/rpc-wallet-deprecated.md#getaccount): returns the name of the account associated with the given address.
* [GetBalance](../api/rpc-wallet.md#getbalance): gets the balance in decimal Dimecoin across all accounts or for a particular account.

## SetAccount

> **NOTE**
>
> **Warning:** `setaccount` will be removed in a later version of Dimecoin Core.  Use the RPCs listed in the *See Also* subsection below instead.
>
> Requires [wallet](../resources/glossary.md#wallet) support (**unavailable on masternodes**)

The [`setaccount` RPC](../api/rpc-wallet-deprecated.md#setaccount) puts the specified address in the given account.

*Parameter #1---a Dimecoin address*

Name | Type | Presence | Description
--- | --- | --- | ---
Address | string (base58) | Required<br>(exactly 1) | The P2PKH or P2SH address to put in the account.  Must already belong to the wallet

*Parameter #2---an account*

Name | Type | Presence | Description
--- | --- | --- | ---
Account | string | Required<br>(exactly 1) | The name of the account in which the address should be placed.  May be the default account, an empty string (\\")"

*Result---`null` if successful*

Name | Type | Presence | Description
--- | --- | --- | ---
`result` | null | Required<br>(exactly 1) | Set to JSON `null` if the address was successfully placed in the account

*Example from Dimecoin Core 2.3.0.0*

Put the address indicated below in the "doc test" account.

``` bash
dimecoin-cli -mainnet setaccount \
    7MTFRnrfJ4NpnYVeidDNHVwT7uuNsVjevq "test"
```

(Success: no result displayed.)

*See also*

* [GetAccount](../api/rpc-wallet-deprecated.md#getaccount): returns the name of the account associated with the given address.
* [GetAddressesByAccount](../api/rpc-wallet-deprecated.md#getaddressesbyaccount): returns a list of every address assigned to a particular account.
* [SetLabel](../api/rpc-wallet.md#setlabel): sets the label associated with the given address.

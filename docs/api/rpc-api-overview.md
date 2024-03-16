```{eval-rst}
.. _api-rpc-overview:
.. meta::
  :title: RPC API Overview
  :description: Dimecoin Core provides an RPC interface for administrative tasks, wallet operations, and network/blockchain queries, with client libraries available in multiple languages and a built-in dimecoin-cli program for command-line and RPC API interaction. 
```

> ***We put our best effort into covering all topics related to Dimecoin. Each section will cover a different category. Not all documentation may be 100% accurate, if you spot an error, please report it or submit a PR request on GitHub.***
>
> ***REMINDER: This documentation is always evolving. If you have not been here for a while, perhaps check again. Things may have been added or updated since your last visit!***

## RPC API Functions

### Overview

Dimecoin Core provides a remote procedure call (RPC) interface for various administrative tasks, [wallet](../reference/glossary.md#wallet) operations, and queries about [network](../reference/glossary.md#network) and [blockchain](../reference/glossary.md#blockchain) data.

Open-source client libraries for the RPC interface are readily available in most modern programming languages. Unless you are working on a custom framework, you won't need to write your own from scratch.

Dimecoin Core also ships with its own compiled C++ RPC client, `dimecoin-cli,` located in the `bin` directory alongside `dimecoind` and `dimecoin-qt.` The `dimecoin-cli` program can be used as a command-line interface (CLI) to Dimecoin Core or for making RPC calls from applications written in languages lacking a suitable native client.

The remainder of this section describes the Dimecoin Core RPC protocol in detail.

```{note}
The following subsections reference setting configuration values. See the [Examples Page](../examples/introduction.md) for more information about setting Dimecoin Core configuration values.
```

#### Enabling RPC

If you start Dimecoin Core using `dimecoin-qt`, the RPC interface is disabled by default. To enable it, set `server=1` in `dimecoin.conf` or supply the `-server` argument when invoking the program. If you start Dimecoin Core using `dimecoind`, the RPC interface is enabled by default.

#### Basic Security

To ensure secure RPC requests, it's mandatory to authenticate using a password. Set this password in the `dimecoin.conf` file using the `rpcpassword` option, or directly at launch with the `-rpcpassword` command-line argument. You can also specify a username with the `-rpcuser` option for additional security.

#### RPC-Auth Security

Alternatively, use the `rpcauth` option for enhanced security, which allows specifying credentials without exposing a plaintext password in `dimecoin.conf`. Format the entry with a username, salt, and hashed password like so: `<USERNAME>:<SALT>$<HASH>`

``` shell
# Example dimecoin.conf rpcauth entry
rpcauth=myuser:465a2e76ad4ae55f2f0beb7733d5863a$618666f5256a3f6a576fdd4e7ce0c684c4dcfdfeb7c5a01bf5518780a69cb969
```

The `rpcauth` option can be specified multiple times if multiple users are required.

A canonical python script is included in Dimecoin Core's repository. You can find this script under the [share/rpcuser](https://github.com/dime-coin/dimecoin/tree/master/share/rpcauth) directory. This script generates the information required for the dimecoin.conf file, as well as the password required by clients using the rpcauth name.

``` text
String to be appended to dimecoin.conf:
rpcauth=myuser:465a2e76ad4ae55f2f0beb7733d5863a$618666f5256a3f6a576fdd4e7ce0c684c4dcfdfeb7c5a01bf5518780a69cb969
Your password:
gy8DQRIdSnUNQjOds-HjdpbDTMXJHn4X0-U3HTByBGI
```

#### RPC Whitelist

The RPC whitelist feature restricts specific RPC users to only a subset of RPC commands. Configure this system by setting the following parameters in the `dimecoin.conf` file or as command-line arguments:

* `rpcwhitelist`: set a whitelist to filter incoming RPC calls for a specific user. The field <whitelist> comes in the format: `<USERNAME>:<rpc 1>,<rpc 2>,...,<rpc n>`. If multiple whitelists are set for a given user, they are set-intersected. Default whitelist behavior is defined by `rpcwhitelistdefault`.
* `rpcwhitelistdefault`: sets default behavior for RPC whitelisting. Unless `rpcwhitelistdefault` is set to `0`, if any `rpcwhitelist` is set, the RPC server acts as if all RPC users are subject to empty-unless-otherwise-specified whitelists. If `rpcwhitelistdefault` is set to `1` and no `rpcwhitelist` is set, the RPC server acts as if all RPC users are subject to empty whitelists.

Example configuration

```text
rpcauth=user1:6e6ff3952c6c1b4fecd3363d87f2abb1$61b7d8ef80ec2e57cf45480d3ff5b00cd93b8828187019f763d0a1c21c98188d
rpcauth=user2:8d42c17d9341a4329875bff7e3bb100d$dbb16453138bac5545bc4567fb67fb256772dc1764c208359ee68d4fde022889
rpcauth=user3:465a2e76ad4ae55f2f0beb7733d5863a$618666f5256a3f6a576fdd4e7ce0c684c4dcfdfeb7c5a01bf5518780a69cb969
rpcwhitelist=user1:getnetworkinfo
rpcwhitelist=user2:getnetworkinfo,getwalletinfo,getbestblockhash

# Allow users to access any RPC unless they are listed in an `rpcwhitelist` entry
rpcwhitelistdefault=0
```

In this example, user1 can only call `getnetworkinfo`, user2 can only call `getnetworkinfo`, `getwalletinfo`, or `getbestblockhash` while user3 can still call all RPCs.

#### Default Connection Info

The Dimecoin Core RPC service listens for HTTP `POST` requests on port 11931 in [mainnet](../reference/glossary.md#mainnet) mode, 21931 in [testnet](../reference/glossary.md#testnet), or 31931 in [regression test mode](../reference/glossary.md#regression-test-mode). The port number can be changed by setting `rpcport` in `dimecoin.conf`. By default the RPC service binds to your server's [localhost](https://en.wikipedia.org/wiki/Localhost) loopback network interface so it's not accessible from other servers. Authentication is implemented using [HTTP basic authentication](https://en.wikipedia.org/wiki/Basic_access_authentication). RPC HTTP requests must include a `Content-Type` header set to `text/plain` and a `Content-Length` header set to the size of the request body.

### Data Formats

The format of the request body and response data is based on [version 1.0 of the JSON-RPC specification](http://json-rpc.org/wiki/specification).

#### Request Format

Specifically, the HTTP `POST` data of a request must be a JSON object with the following format:

| Name                 | Type            | Presence                    | Description
|----------------------|-----------------|-----------------------------|----------------
| Request              | object          | Required<br>(exactly 1)     | The JSON-RPC request object
| → <br>`jsonrpc`      | number (real)   | Optional<br>(0 or 1)        | Version indicator for the JSON-RPC request. Currently ignored by Dimecoin Core.
| → <br>`id`           | string          | Optional<br>(0 or 1)        | An arbitrary string that will be returned with the response.  May be omitted or set to an empty string ("")
| → <br>`method`       | string          | Required<br>(exactly 1)     | The RPC method name (e.g. `getblock`).  See the RPC section for a list of available methods.
| → <br>`params`       | array           | Optional<br>(0 or 1)        | An array containing positional parameter values for the RPC.  May be an empty array or omitted for RPC calls that don't have any required parameters.
| → <br>`params`       | object           | Optional<br>(0 or 1)        | Starting from Dimecoin Core 0.12.3 / Bitcoin Core 0.14.0 (replaces the params array above) An object containing named parameter values for the RPC. May be an empty object or omitted for RPC calls that don’t have any required parameters.
| → → <br>Parameter    | *any*           | Optional<br>(0 or more)       | A parameter.  May be any JSON type allowed by the particular RPC method

In the table above and in other tables describing RPC input and output, we use the following conventions

* "→" indicates an argument that is the child of a JSON array or JSON object. For example, "→ → Parameter" above means Parameter is the child of the `params` array which itself is a child of the Request object.

* Plain-text names like "Request" are unnamed in the actual JSON object

* Code-style names like `params` are literal strings that appear in the JSON object.

* "Type" is the JSON data type and the specific Dimecoin Core type.

* "Presence" indicates whether or not a field must be present within its containing array or object. Note that an optional object may still have required children.

#### Response Format

The HTTP response data for a RPC request is a JSON object with the following format:

| Name                 | Type            | Presence                    | Description
|----------------------|-----------------|-----------------------------|----------------
| Response             | object          | Required<br>(exactly 1)     | The JSON-RPC response object.
| → <br>`result`       | *any*           | Required<br>(exactly 1)     | The RPC output whose type varies by call.  Has value `null` if an error occurred.
| → <br>`error`        | null/object     | Required<br>(exactly 1)     | An object describing the error if one occurred, otherwise `null`.
| → → <br>`code`        | number (int)    | Required<br>(exactly 1)     | The error code returned by the RPC function call. See [rpcprotocol.h](https://github.com/dime-coin/dimecoin/blob/master/src/rpc/protocol.h) for a full list of error codes and their meanings.
| → → <br>`message`     | string          | Required<br>(exactly 1)     | A text description of the error.  May be an empty string ("").
| → <br>`id`           | string          | Required<br>(exactly 1)     | The value of `id` provided with the request. Has value `null` if the `id` field was omitted in the request.

### Example

As an example, here is the JSON-RPC request object for the hash of the [genesis block](../reference/glossary.md#genesis-block):

```json
{
    "method": "getblockhash",
    "params": [0],
    "id": "foo"
}
```

The command to send this request using `dimecoin-cli` is:

```shell Shell
dimecoin-cli getblockhash 0
```

The command to send this request using `dimecoin-cli` with named parameters is:

```shell Shell
dimecoin-cli -named getblockhash height=0
```

Alternatively, we could `POST` this request using the cURL command-line program as follows:

```shell Shell
curl --user 'my_username:my_secret_password' --data-binary '''
  {
      "method": "getblockhash",
      "params": [0],
      "id": "foo"
  }''' \
  --header 'Content-Type: text/plain;' localhost:9998
```

The HTTP response data for this request would be:

```json
{
    "result": "00000bafbc94add76cb75e2ec92894837288a481e5c005f6563d91623bf8bc2c",
    "error": null,
    "id": "foo"
}
```

```{note}
In order to minimize its size, the raw JSON response from Dimecoin Core doesn't include any extraneous whitespace characters.
```

Here whitespace has been added to make the object more readable. `dimecoin-cli` also transforms the raw response to make it more human-readable. It:

* Adds whitespace indentation to JSON objects
* Expands escaped newline characters ("\n") into actual newlines
* Returns only the value of the `result` field if there's no error
* Strips the outer double-quotes around `result`s of type string
* Returns only the `error` field if there's an error

Continuing with the example above, the output from the `dimecoin-cli` command would be simply:

```text
00000bafbc94add76cb75e2ec92894837288a481e5c005f6563d91623bf8bc2c
```

```{eval-rst}
.. _api-rpc-multi-wallet-support:
```

#### Multi-Wallet Support

Since version 2.0.0.0, Dimecoin Core has supported loading multiple wallets simultaneously. Consequently, when multiple wallet
files are active, wallet-related RPC commands require specifying the wallet name to guarantee the accurate execution of commands on the intended wallet.

**Dimecoin-cli Example**

Use the dimecoin-cli `-rpcwallet` option to specify the path of the wallet file to
access, for example:

```shell
dimecoin-cli -rpcwallet=<wallet-filename> <command>
```

To use the default wallet, use `""` for the wallet filename as shown in the
example below:

```shell
dimecoin-cli -rpcwallet="" getwalletinfo
```

**JSON-RPC Example**

Specify which wallet file to access by setting the HTTP endpoint in the JSON-RPC
request using the format `<RPC IP address>:<RPC port>/wallet/<wallet name>`, for
example:

```shell
curl --user 'my_username:my_secret_password' --data-binary '''
  {
    "method": "getwalletinfo",
    "params": [],
    "id":"foo"
  }'''\
  --header 'content-type: text/plain;' localhost:11931/wallet/testnet-wallet
```

Access the default wallet using the format `<RPC IP address>:<RPC port>/wallet/`
(the final "`/`" must be included):

```shell
curl --user 'my_username:my_secret_password' --data-binary '''
  {
    "method": "getwalletinfo",
    "params": [],
    "id":"foo"
  }'''\
  --header 'content-type: text/plain;' localhost:11931/wallet/
```

#### RPCs with sub-commands

Dimecoin Core has a number of RPC requests that use sub-commands to group access to related data under one RPC method name. Examples of this include the [`gobject`](../api/rpc-dime.md#gobject) and [`masternode`](../api/rpc-dime.md#masternode) RPCs. If using cURL, the sub-commands should be included in the requests `params` field as shown here:

```shell
curl --user 'my_username:my_secret_password' --data-binary '''
  {
      "method": "gobject",
      "params": ["list", "valid", "proposals"],
      "id": "foo"
  }''' \
  --header 'Content-Type: text/plain;' localhost:11931
```

#### Error Handling

If there's an error processing a request, Dimecoin Core sets the `result` field to `null` and provides information about the error in the  `error` field. For example, a request for the blockhash at block height -1 would be met with the following response (whitespace added for visual clarity):

```json
{
    "result": null,
    "error": {
        "code": -8,
        "message": "Block height out of range"
    },
    "id": "foo"
}
```

If `dimecoin-cli` encounters an error, it exits with a non-zero status code and outputs the `error` field as text to the process's standard error stream:

```text
error code: -8
error message:
Block height out of range
```

#### Batch Requests

Request batching allows for the execution of multiple RPC commands in a single HTTP request, enhancing efficiency as outlined in the [JSON-RPC 2.0 specification](http://www.jsonrpc.org/specification#batch). Clients can bundle several Request objects into a JSON array and send them through a `POST` request. Responses correspondingly arrive in a JSON array, each Response object matching its Request counterpart. This method could significantly optimize performance based on how it's applied. Note, however, that the `dimecoin-cli` tool does not facilitate request batching.

```shell
curl --user 'my_username:my_secret_password' --data-binary '''
  [
    {
      "method": "getblockhash",
      "params": [0],
      "id": "foo"
    },
    {
      "method": "getblockhash",
      "params": [1],
      "id": "foo2"
    }
  ]''' \
  --header 'Content-Type: text/plain;' localhost:11931
```

To keep this documentation compact and readable, the examples for each of the available RPC calls will be given as `dimecoin-cli` commands:

```shell
dimecoin-cli [options] <method name> <param1> <param2> ...
```

This translates into an JSON-RPC Request object of the form:

```json
{
    "method": "<method name>",
    "params": [ "<param1>", "<param2>", "..." ],
    "id": "foo"
}
```

#### Precision Handling

```{caution}
When using the JSON-RPC interface in programming, ensure your application properly manages high-precision numbers. Refer to [Proper Money Handling](https://en.bitcoin.it/wiki/Proper_Money_Handling_%28JSON-RPC%29) on the Bitcoin Wiki for guidance and sample code.
```

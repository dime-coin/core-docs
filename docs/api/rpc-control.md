```{eval-rst}
.. _api-rpc-control:
.. meta::
  :title: Control RPCs
  :description: A list of all the Control RPCs in Dimecoin.
```
> ***We put our best effort into covering all topics related to Dimecoin. Each section will cover a different category. Not all documentation may be 100% accurate, if you spot an error, please report it or submit a PR request on GitHub.***
>
> ***REMINDER: This documentation is always evolving. If you have not been here for a while, perhaps check again. Things may have been added or updated since your last visit!***

## Control RPCs

### GetMemoryInfo

The [`getmemoryinfo` RPC](../api/rpc-control.md#getmemoryinfo) returns information about memory usage.

*Parameter #1---mode*

Name | Type | Presence | Description
--- | --- | --- | ---
mode| string | Optional<br>Default: `stats` | Determines what kind of information is returned.<br>- `stats` returns general statistics about memory usage in the daemon.<br>- `mallocinfo` returns an XML string describing low-level heap state (only available if compiled with glibc 2.10+).

*Result---information about memory usage*

Name | Type | Presence | Description
--- | --- | --- | ---
`result` | object | Required<br>(exactly 1) | An object containing information about memory usage
→<br>`locked` | string : object | Required<br>(exactly 1) | An object containing information about locked memory manager
→→<br>`used` | number (int) | Required<br>(exactly 1) | Number of bytes used
→→<br>`free` | number (int) | Required<br>(exactly 1) | Number of bytes available in current arenas
→→<br>`total` | number (int) | Required<br>(exactly 1) | Total number of bytes managed
→→<br>`locked` | number (int) | Required<br>(exactly 1) | Amount of bytes that succeeded locking
→→<br>`chunks_used` | number (int) | Required<br>(exactly 1) | Number allocated chunks
→→<br>`chunks_free` | number (int) | Required<br>(exactly 1) | Number unused chunks

*Example from Dimecoin Core 2.3.0.0*

```bash
dimecoin-cli getmemoryinfo
```

Result:

```json
{
  "locked": {
    "used": 32,
    "free": 262112,
    "total": 262144,
    "locked": 0,
    "chunks_used": 1,
    "chunks_free": 1
  }
}
```
*See also*

* [GetMemPoolInfo](../api/rpc-blockchain.md#getmempoolinfo): returns information about the node's current transaction memory pool.

### Help

The [`help` RPC](../api/rpc-control.md#help) lists all available public RPC commands, or gets help for the specified RPC. Commands which are unavailable will not be listed, such as wallet RPCs if wallet support is disabled.

*Parameter #1---the name of the RPC to get help for*

Name | Type | Presence | Description
--- | --- | --- | ---
RPC | string | Optional<br>(0 or 1) | The name of the RPC to get help for. If omitted, Dimecoin Core will display an alphabetical list of commands; Dimecoin Core will display a categorized list of commands

*Parameter #2---the name of the subcommand to get help for*

Name | Type | Presence | Description
--- | --- | --- | ---
Sub-command | string | Optional<br>(0 or 1) | The subcommand to get help on. Please note that not all subcommands support this at the moment

*Result---a list of RPCs or detailed help for a specific RPC*

Name | Type | Presence | Description
--- | --- | --- | ---
`result` | string | Required<br>(exactly 1) | The help text for the specified RPC or the list of commands.  The `dimecoin-cli` command will parse this text and format it as human-readable text

*Example from Dimecoin Core 2.3.0.0*

Command to get help about the [`help` RPC](../api/rpc-control.md#help):

```bash
dimecoin-cli -mainnet help help
```

Result:

```text
help ( "command" )

List all commands, or get help for a specified command.

Arguments:
1. "command"     (string, optional) The command to get help on

Result:
"text"     (string) The help text
```

*See also*

* The [RPC Quick Reference](../api/remote-procedure-call-quick-reference.md)

### Logging

The [`logging` RPC](../api/rpc-control.md#logging) gets and sets the logging configuration. When called without an argument, returns the list of categories with status that are currently being debug logged or not. When called with arguments, adds or removes categories from debug logging and return the lists above. The arguments are evaluated in order "include", "exclude". If an item is both included and excluded, it will thus end up being excluded.

*Parameter #1---include categories*

Name | Type | Presence | Description
--- | --- | --- | ---
`include` | array of strings | Optional<br>(0 or 1) | Enable debugging for these categories

*Parameter #2---exclude categories*

Name | Type | Presence | Description
--- | --- | --- | ---
`exclude` | array of strings | Optional<br>(0 or 1) | Enable debugging for these categories

The categories are:

| Type | Category |
| - | - |
| Special | • `0` or `none` - Disables all categories <br>• `1` or `all` - Enables all categories <br>• `dimecoin` - enables/disables all Dimecoin categories |
| Standard | `addrman`, `bench` <br>`cmpctblock`, `coindb`, `estimatefee`, `http`, `leveldb`, `libevent`, `mempool`, `mempoolrej`, `net`, `proxy`, `qt`, `rand`, `reindex`, `rpc`, `selectcoins`, `tor`, `db`, `zmq`|
| Dimecoin | `gobject`, `instantsend`, `mnpayments`, `mnsync`, `spork` |

*Result---a list of the logging categories that are active*

Name | Type | Presence | Description
--- | --- | --- | ---
`result` | object | Required<br>(exactly 1) | A JSON object show a list of the logging categories that are active

*Example from Dimecoin Core 2.3.0.0*

Include a category in logging

```bash
dimecoin-cli -mainnet logging '["spork"]'
```

Result:

```json
{
  "net": false,
  "tor": false,
  "mempool": false,
  "http": false,
  "bench": false,
  "zmq": false,
  "db": false,
  "rpc": false,
  "estimatefee": false,
  "addrman": false,
  "selectcoins": false,
  "reindex": false,
  "cmpctblock": false,
  "rand": false,
  "prune": false,
  "proxy": false,
  "mempoolrej": false,
  "libevent": false,
  "coindb": false,
  "qt": false,
  "leveldb": false,
  "kernel": false,
  "spork": true,
  "mnsync": false,
  "masternode": false,
  "gobject": false,
  "mnpayments": false
}
```

Exclude a previously included category (without including a new one):

```bash
dimecoin-cli -mainnet logging '[]' '["spork"]'
```

Result:

```json
{
  "net": false,
  "tor": false,
  "mempool": false,
  "http": false,
  "bench": false,
  "zmq": false,
  "db": false,
  "rpc": false,
  "estimatefee": false,
  "addrman": false,
  "selectcoins": false,
  "reindex": false,
  "cmpctblock": false,
  "rand": false,
  "prune": false,
  "proxy": false,
  "mempoolrej": false,
  "libevent": false,
  "coindb": false,
  "qt": false,
  "leveldb": false,
  "kernel": false,
  "spork": false,
  "mnsync": false,
  "masternode": false,
  "gobject": false,
  "mnpayments": false
}
```

*See also*

* [Debug](../api/rpc-control.md#debug): changes the debug category from the console.

### Stop

The [`stop` RPC](../api/rpc-control.md#stop) safely shuts down the Dimecoin Core server.

*Parameters: none*

*Result---the server is safely shut down*

Name | Type | Presence | Description
--- | --- | --- | ---
`result` | string | Required<br>(exactly 1) | The string \Dimecoin Core server stopping\""

*Example from Dimecoin Core 2.3.0.0*

```bash
dimecoin-cli -mainnet stop
```

Result:

```text
Dimecoin Core server stopping...
```

*See also: none*

### Uptime

The [`uptime` RPC](../api/rpc-control.md#uptime) returns the total uptime of the server.

*Parameters: none*

*Result*

Name | Type | Presence | Description
--- | --- | --- | ---
`result` | number (int) | Required<br>(exactly 1) | The number of seconds that the server has been running

*Example from Dimecoin Core 2.3.0.0*

```bash
dimecoin-cli -mainnet uptime
```

Result:

```text
3060
```

*See also: none*

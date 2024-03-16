```{eval-rst}
.. meta::
  :title: ZeroMQ (ZMQ) RPCs
  :description: A list of remote procedure calls in Dimecoin Core used to check ZeroMQ (ZMQ) settings. 
```

> ***We put our best effort into covering all topics related to Dimecoin. Each section will cover a different category. Not all documentation may be 100% accurate, if you spot an error, please report it or submit a PR request on GitHub.***
>
> ***REMINDER: This documentation is always evolving. If you have not been here for a while, perhaps check again. Things may have been added or updated since your last visit!***

## ZeroMQ (ZMQ) RPCs

### GetZmqNotifications

The [`getzmqnotifications` RPC](../api/rpc-blockchain.md#getblockchaininfo) returns information about the active ZeroMQ notifications.

*Parameters: none*

*Result---A JSON array of objects providing information about the enabled ZMQ notifications*

Name | Type | Presence | Description
--- | --- | --- | ---
`result` | array | Required<br>(exactly 1) | Array of objects containing Information about the enabled ZMQ notifications
→<br>Notification | object | Required<br>(0 or more) | Information about a ZMQ notification
→ →<br>`type` | string | Required<br>(exactly 1) | Type of notification
→ →<br>`address` | string | Required<br>(exactly 1) | Address of the publisher

*Example from Dimecoin Core 2.3.0.0*

``` bash
dimecoin-cli -mainnet getzmqnotifications
```

Result:

``` json
[
  {
    "type": "pubhashblock",
    "address": "tcp://0.0.0.0:11321",
  },
  {
    "type": "pubhashtx",
    "address": "tcp://0.0.0.0:11321",
  },
  {
    "type": "pubrawblock",
    "address": "tcp://0.0.0.0:11321",
  }
]
```

```{seealso}
*none*
```

```{eval-rst}
.. meta::
  :title: ZeroMQ (ZMQ) Notifications
  :description: In Dimecoin, ZeroMQ is a lightweight wrapper for TCP connections and inter-process communication, supporting various messaging patterns. 
```

> ***We put our best effort into covering all topics related to Dimecoin. Each section will cover a different category. Not all documentation may be 100% accurate, if you spot an error, please report it or submit a PR request on GitHub.***
>
> ***REMINDER: This documentation is always evolving. If you have not been here for a while, perhaps check again. Things may have been added or updated since your last visit!***

## ZeroMQ (ZMQ) Notifications

### Overview

ZeroMQ is a lightweight wrapper around TCP connections, inter-process communication, and shared-memory, providing various message-oriented semantics such as publish/subscribe, request/reply, and push/pull.

The Dimecoin Core daemon can be configured to act as a trusted "border router", implementing the dimecoin wire protocol and relay, making consensus decisions, maintaining the local blockchain database, broadcasting locally generated transactions into the network, and providing a queryable RPC interface to interact on a polled basis for requesting blockchain related data. However, there exists only a limited service to notify external software of events like the arrival of new blocks or transactions.

The ZeroMQ facility implements a notification interface through a set of specific notifiers. Currently there are notifiers that publish blocks and transactions. This read-only facility requires only the connection of a corresponding ZeroMQ subscriber port in receiving software; it is not authenticated nor is there any two-way protocol involvement. Therefore, subscribers should validate the received data since it may be out of date, incomplete or even invalid.

ZeroMQ sockets are self-connecting and self-healing; that is, connections made between two endpoints will be automatically restored after an outage, and either end may be freely started or stopped in any order.

Because ZeroMQ is message oriented, subscribers receive transactions and blocks all-at-once and do not need to implement any sort of buffering or reassembly.

### Available Notifications

Currently, the following notifications are supported:

| Notification | Description |
| - | - |
| zmqpubhashblock | Block hash |
| zmqpubhashtx | Transaction hash (TXID) |
| zmqpubhashtxlock | Hash of a transaction receiving and [InstantSend](../guide/dime-features-instantsend.md) lock (TXID) |
| zmqpubhashgovernancevote | Governance vote hash |
| zmqpubhashgovernanceobject | Governance object hash |
| zmqpubhashinstantsend<br>doublespend | Hash of a transaction attempting to double-spend an InstantSend-locked input |
| zmqpubhashrecoveredsig | Hash of recovered signatures (recovered by LLMQs) |
| zmqpubrawblock | Raw [`block`](../reference/p2p-network-data-messages.md#block) |
| zmqpubrawchainlock | Raw [`block`](../reference/p2p-network-data-messages.md#block) receiving a ChainLock |
| zmqpubrawchainlocksig | Raw [`block`](../reference/p2p-network-data-messages.md#block) with ChainLock signature ([`clsig`](../reference/p2p-network-instantsend-messages.md#clsig)) concatenated |
| zmqpubrawtx | Raw transaction ([`tx`](../reference/transactions-raw-transaction-format.md))  |
| zmqpubrawtxlock | Raw InstantSend transaction ([`tx`](../reference/transactions-raw-transaction-format.md))  |
| zmqpubrawtxlocksig | Raw InstantSend transaction ([`tx`](../reference/transactions-raw-transaction-format.md)) with InstantSend lock signature ([`islock`](../reference/p2p-network-instantsend-messages.md#islock)) concatenated |
| zmqpubrawgovernancevote | Raw governance vote ([`govobjvote`](../reference/p2p-network-governance-messages.md#govobjvote)) |
| zmqpubrawgovernanceobject | Raw governance object ([`govobject`](../reference/p2p-network-governance-messages.md#govobj)) |
| zmqpubrawinstantsend<br>doublespend | Raw transaction ([`tx`](../reference/transactions-raw-transaction-format.md)) attempting to double-spend an InstantSend-locked input |
| zmqpubrawrecoveredsig | Raw recovered signatures (recovered by LLMQs) |

### High Water Mark

The option to set the PUB socket's outbound message [high water mark](https://zeromq.org/socket-api/#high-water-mark) (SNDHWM) may be set individually for each notification:

| High water mark name | Description |
| - | - |
| zmqpubhashtxhwm | Transaction hash (TXID) high water mark |
| zmqpubhashblockhwm | Block hash high water mark |
| zmqpubhashchainlockhwm | Hash of a block with a [ChainLock](../guide/dime-features-chainlocks.md) high water mark |
| zmqpubhashtxlockhwm | Hash of a transaction receiving and [InstantSend](../guide/dime-features-instantsend.md) lock (TXID) high water mark |
| zmqpubhashgovernancevotehwm | Governance vote hash high water mark |
| zmqpubhashgovernanceobjecthwm | Governance object hash high water mark |
| zmqpubhashinstantsenddoublespendhwm | Hash of a transaction attempting to double-spend an InstantSend-locked input high water mark |
| zmqpubhashrecoveredsighwm | Hash of recovered signatures (recovered by LLMQs) high water mark |
| zmqpubrawblockhwm | Raw [`block`](../reference/p2p-network-data-messages.md#block) high water mark |
| zmqpubrawtxhwm | Raw transaction ([`tx`](../reference/transactions-raw-transaction-format.md))  high water mark |
| zmqpubrawchainlockhwm | Raw [`block`](../reference/p2p-network-data-messages.md#block) receiving a ChainLock high water mark |
| zmqpubrawchainlocksighwm | Raw [`block`](../reference/p2p-network-data-messages.md#block) with ChainLock signature ([`clsig`](../reference/p2p-network-instantsend-messages.md#clsig)) concatenated high water mark |
| zmqpubrawtxlockhwm | Raw InstantSend transaction ([`tx`](../reference/transactions-raw-transaction-format.md)) high water mark |
| zmqpubrawtxlocksighwm | Raw InstantSend transaction ([`tx`](../reference/transactions-raw-transaction-format.md)) with InstantSend lock signature ([`islock`](../reference/p2p-network-instantsend-messages.md#islock)) concatenated high water mark |
| zmqpubrawgovernancevotehwm | Raw governance vote ([`govobjvote`](../reference/p2p-network-governance-messages.md#govobjvote)) high water mark |
| zmqpubrawgovernanceobjecthwm | Raw governance object ([`govobject`](../reference/p2p-network-governance-messages.md#govobj)) high water mark |
| zmqpubrawinstantsenddoublespendhwm | Raw transaction ([`tx`](../reference/transactions-raw-transaction-format.md)) attempting to double-spend an InstantSend-locked input high water mark |
| zmqpubrawrecoveredsighwm |  Raw recovered signatures (recovered by LLMQs) high water mark |

### Dimecoin Core Configuration

ZMQ notifications can be enabled via either command line arguments or the configuration file (typically `dimecoin.conf`).

#### Command Line

```bash
$ dimecoind -zmqpubhashtx=tcp://127.0.0.1:11931 \
        -zmqpubrawtx=ipc:///tmp/dimecoind.tx.raw
```

#### Config File

```bash
## ZMQ
zmqpubhashtx=tcp://0.0.0.0:11931
zmqpubrawtx=tcp://0.0.0.0:11931
```

### Usage

The socket type is PUB and the address must be a valid ZeroMQ socket address. Each PUB notification has a topic and body, where the header corresponds to the notification type. For instance, for the notification `-zmqpubhashtx` the topic is `hashtx` (no null terminator) and the body is the hexadecimal transaction hash (32 bytes).

> **NOTE**
>
> The same address can be used in more than one notification.

ZeroMQ endpoint specifiers for TCP (and others) are documented in the [ZeroMQ API](http://api.zeromq.org/4-0:_start).

Client side, then, the ZeroMQ subscriber socket must have the `ZMQ_SUBSCRIBE` option set to one or either of these prefixes (for instance, just `hash`); without doing so will result in no messages arriving. Please see the Dimecoin Core repository for a [working example](https://github.com/dime-coin/dimecoin/blob/272dbe4974e09eca6a928ce13b42941b1c28aca2/contrib/zmq/zmq_sub3.4.py).

### Notes

From the perspective of dimecoind, the ZeroMQ socket is write-only; PUB sockets don't even have a read function. Thus, there is no state introduced into dimecoind directly. Furthermore, no information is broadcast that wasn't already received from the public P2P network.

No authentication or authorization is done on connecting clients; it is assumed that the ZeroMQ port is exposed only to trusted entities, using other means such as firewalling.

Note that when the block chain tip changes, a reorganisation may occur and just the tip will be notified. It is up to the subscriber to retrieve the chain from the last known block to the new tip.

There are several possibilities that ZMQ notification can get lost during transmission depending on the communication type your are using. dimecoind appends an up-counting sequence number to each notification which allows listeners to detect lost notifications.

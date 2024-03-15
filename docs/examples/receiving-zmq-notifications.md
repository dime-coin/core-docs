```{eval-rst}
.. _examples-receiving-zmq-notifications:
.. meta::
  :title: Receiving ZMQ Notifications
  :description: Shows how to configure Dimecoin Core's ZeroMQ support and subscribe to ZMQ notifications for block, transaction, and governance messages for efficient notification handling.
```

> ***We put our best effort into covering all topics related to Dimecoin. Each section will cover a different category. Not all documentation may be 100% accurate, if you spot an error, please report it or submit a PR request on GitHub.***
>
> ***REMINDER: This documentation is always evolving. If you have not been here for a while, perhaps check again. Things may have been added or updated since your last visit!***


## Receiving ZMQ Notifications

### Overview

Receiving notifications from Dimecoin Core is important for a variety of use-cases. Although polling [RPCs](../api/rpc-api.md) can be useful, in some scenarios it may be more desirable to have publish-subscribe functionality. Dimecoin Core's built-in ZeroMQ (ZMQ) support provides the ability to subscribe to block, transaction, and governance related messages.

Further information regarding ZMQ support may be found in the [ZMQ API Reference](../api/zmq.md).

### Enabling Dimecoin Core ZMQ Notifications

```{note}
This requires a Dimecoin Core full node or masternode
```

In the [`dimecoin.conf` configuration file](../examples/configuration-file.md), add the following [ZMQ notifications](../api/zmq.md#available-notifications) and assign the address that Dimecoin Core should listen on. The notifications selected here relate to transaction data.

```
## ZMQ
zmqpubrawblock=tcp://0.0.0.0:11391
zmqpubhashtx=tcp://0.0.0.0:11391
zmqpubhashblock=tcp://0.0.0.0:11391
zmqpubrawtx=tcp://0.0.0.0:11391
```

Restart the Dimecoin Core node once the configuration file has been updated.

### JavaScript Example

Requires an installation of [NodeJS](https://nodejs.org/en/download/)

#### 1. Install ZeroMq

The JavaScript zeromq package is available from [npmjs.com](https://www.npmjs.com/package/zeromq) and can be installed from the command line by running:

```shell
npm install zeromq@5
```

```{attention}
Version 5 of the zeromq package should be used for compatibility reasons.
```

#### 2. Subscribe to ZeroMQ Messages

Create a file with the following contents. Then run it by typing `node <your-filename.js>` from the command line:

::::{tab-set-code}

```{code-block} javascript
const zmq = require('zeromq');
const sock = zmq.socket('sub');
const zmqPort = 11391;

sock.connect('tcp://127.0.0.1:' + zmqPort);

// Subscribe to transaction notifications
sock.subscribe('hashtx'); // Note: this will subscribe to hashtxlock also

console.log('Subscriber connected to port %d', zmqPort);

sock.on('message', function(topic, message) {
  console.log(
    'Received',
    topic.toString().toUpperCase(),
    'containing:\n',
    message.toString('hex'),
    '\n'
  );
});
```

```{code-block} python
import binascii
import asyncio
import zmq
import zmq.asyncio
import signal

port = 11391

class ZMQHandler():
    def __init__(self):
        self.loop = asyncio.get_event_loop()
        self.zmqContext = zmq.asyncio.Context()

        self.zmqSubSocket = self.zmqContext.socket(zmq.SUB)
        self.zmqSubSocket.connect("tcp://127.0.0.1:%i" % port)

        ## Subscribe to transaction notifications
        self.zmqSubSocket.setsockopt_string(zmq.SUBSCRIBE, "hashtx")

        print('Subscriber connected to port {}'.format(port))

    @asyncio.coroutine
    def handle(self) :
        msg = yield from self.zmqSubSocket.recv_multipart()
        topic = msg[0]
        body = msg[1]
        sequence = "Unknown"

        print('Received {} containing:\n{}\n'.format(
            topic.decode("utf-8"), 
            binascii.hexlify(body).decode("utf-8")))

        ## schedule ourselves to receive the next message
        asyncio.ensure_future(self.handle())

    def start(self):
        self.loop.add_signal_handler(signal.SIGINT, self.stop)
        self.loop.create_task(self.handle())
        self.loop.run_forever()

    def stop(self):
        self.loop.stop()
        self.zmqContext.destroy()

daemon = ZMQHandler()
daemon.start()
```

::::

### Example Response

The following response demonstrates the notification provided by Dimecoin Core when it receives a transaction and then receives the associated messages. The four notifications represent:

  1. The TXID of the transaction is received (`HASHTX`)
  2. When a block is discovered or mined, the (`HASHBLOCK`) is sent over. This allows external applications or services listening to react almost instantly to new blocks.
  3. When a transaction is seen by a node, the (`RAWTX`) sends the full raw transaction data to subscribers.
  4. The (`RAWBLOCK`) data could decoded using the [`decoderawtransaction` RPC](../api/rpc-raw-transactions.md#decoderawtransaction) for example)

```
Received HASHTX containing:
 b2e128661e3679c3d00cd081e32fdc9a12f44e486e083e6eab998bdfd6f64a9b

Received HASHBLOCK containing:
 b2e128661e3679c3d00cd081e32fdc9a12f44e486e083e6eab998bdfd6f64a9b

Received RAWTX containing:
 02000000025a4d18da609107e9ea3dc6 ... 5a32ea917a30147d6c9788ac6ea90400

Received RAWBLOCK containing:
 02000000025a4d18da609107e9ea3dc6 ... 9e889cee7ba48981ca002e6962a20236
```

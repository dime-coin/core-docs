```{eval-rst}
.. meta::
  :title: Message Headers
  :description: All Dimecoin network protocol messages utilize a standardized container format, comprising a required message header and an optional payload.
```

> ***We put our best effort into covering all topics related to Dimecoin. Each section will cover a different category. Not all documentation may be 100% accurate, if you spot an error, please report it or submit a PR request on GitHub.***
>
> ***REMINDER: This documentation is always evolving. If you have not been here for a while, perhaps check again. Things may have been added or updated since your last visit!***

## Message Headers

All messages in the network protocol use the same container format, which provides a required multi-field [message header](../reference/glossary.md#message-header) and an optional payload. The message header format is:

| Bytes | Name         | Data Type | Description
| :-------: |--------------|-----------|-------------
| 4     | start string | char[4]   | Magic bytes indicating the originating network; used to seek to next message when stream state is unknown.
| 12    | command name | char[12]  | ASCII string which identifies what message type is contained in the payload.  Followed by nulls (0x00) to pad out byte count; for example: `version\0\0\0\0\0`.
| 4     | payload size | uint32_t  | Number of bytes in payload.  The current maximum number of bytes ([`MAX_SIZE`](https://github.com/dime-coin/dimecoin/blob/272dbe4974e09eca6a928ce13b42941b1c28aca2/src/serialize.h#L29)) allowed in the payload by Dimecoin Core is 32 MiB---messages with a payload size larger than this will be dropped or rejected.
| 4     | checksum     | char[4]   | First 4 bytes of SHA256(SHA256(payload)) in internal byte order.<br /><br /> If payload is empty, as in `verack` and [`getaddr` messages](p2p-network.md#getaddr), the checksum is always 0x5df6e0e2 (SHA256(SHA256(<empty string>))).

### Example

The following example is an annotated hex dump of a [mainnet](../reference/glossary.md#mainnet) message header from a [`verack` message](p2p-network.md#verack) which has no payload.

``` text
bf0c6bbd ................... Start string: Mainnet
76657261636b000000000000 ... Command name: verack + null padding
00000000 ................... Byte count: 0
5df6e0e2 ................... Checksum: SHA256(SHA256(<empty>))
```

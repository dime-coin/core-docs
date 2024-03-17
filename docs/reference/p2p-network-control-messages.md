```{eval-rst}
.. meta::
  :title: Control Messages
  :description: The network messages in this section will help control the connection between two peers or allow them to advise each other about the rest of the Dimecoin network.
```

> ***We put our best effort into covering all topics related to Dimecoin. Each section will cover a different category. Not all documentation may be 100% accurate, if you spot an error, please report it or submit a PR request on GitHub.***
>
> ***REMINDER: This documentation is always evolving. If you have not been here for a while, perhaps check again. Things may have been added or updated since your last visit!***

## Control Messages

The following [network](../reference/glossary.md#network) messages all help control the connection between two [peers](../reference/glossary.md#peer) or allow them to advise each other about the rest of the network.

![Overview Of P2P Protocol Control And Advisory Messages](../../img/dev/en-p2p-control-messages.svg)

Note that almost none of the control messages are authenticated in any way, meaning they can contain incorrect or intentionally harmful information.

### addr

The `addr` (IP address) message relays connection information for peers on the network. Each peer which wants to accept incoming connections creates an [`addr` message](p2p-network.md#addr) providing its connection information and then sends that message to its peers unsolicited. Some of its peers send that information to their peers (also unsolicited), some of which further distribute it, allowing decentralized peer discovery for any program already on the network.

An [`addr` message](p2p-network.md#addr) may also be sent in response to a [`getaddr` message](p2p-network.md#getaddr).

| Bytes      | Name             | Data Type          | Description
|------------|------------------|--------------------|----------------
| *Varies*   | IP address count | compactSize uint   | The number of IP address entries up to a maximum of 1,000.
| *Varies*   | IP addresses     | network IP address | IP address entries.  See the table below for the format of a Dimecoin network IP address.

Each encapsulated network IP address currently uses the following structure:

| Bytes | Name       | Data Type | Description
|-------|------------|-----------|---------------
| 4     | time       | uint32    | A time in Unix epoch time format.  Nodes advertising their own IP address set this to the current time.  Nodes advertising IP addresses they've connected to set this to the last time they connected to that node.  Other nodes just relaying the IP address should not change the time.  Nodes can use the time field to avoid relaying old [`addr` messages](p2p-network.md#addr).  <br><br>Malicious nodes may change times or even set them in the future.
| 8     | services   | uint64_t  | The services the node advertised in its [`version` message](p2p-network#version).
| 16    | IP address | char      | IPv6 address in **big endian byte order**. IPv4 addresses can be provided as [IPv4-mapped IPv6 addresses](http://en.wikipedia.org/wiki/IPv6#IPv4-mapped_IPv6_addresses)
| 2     | port       | uint16_t  | Port number in **big endian byte order**.  Note that Dimecoin Core will only connect to nodes with non-standard port numbers as a last resort for finding peers.  This is to prevent anyone from trying to use the network to disrupt non-Dimecoin services that run on other ports.

The following annotated hexdump shows part of an [`addr` message](p2p-network.md#addr). (The [message header](../reference/glossary.md#message-header) has been omitted and the actual IP address has been replaced with a [RFC5737](http://tools.ietf.org/html/rfc5737) reserved IP address.)

``` text
fde803 ............................. Address count: 1000

d91f4854 ........................... Epoch time: 1414012889
0100000000000000 ................... Service bits: 01 (network node)
00000000000000000000ffffc0000233 ... IP Address: ::ffff:192.0.2.51
208d ............................... Port: 8333

[...] .............................. (999 more addresses omitted)
```

### filteradd

The [`filteradd` message](p2p-network.md#filteradd) tells the receiving [peer](../reference/glossary.md#peer) to add a single element to a previously-set [bloom filter](../reference/glossary.md#bloom-filter), such as a new [public key](../reference/glossary.md#public-key). The element is sent directly to the receiving peer; the peer then uses the parameters set in the [`filterload` message](p2p-network.md#filterload) to add the element to the bloom filter.

Because the element is sent directly to the receiving peer, there is no obfuscation of the element and none of the plausible-deniability privacy provided by the bloom filter. Clients that want to maintain greater privacy should recalculate the bloom filter themselves and send a new [`filterload` message](p2p-network.md#filterload) with the recalculated bloom filter.

| Bytes    | Name          | Data Type        | Description
|----------|---------------|------------------|-----------------
| *Varies* | element bytes | compactSize uint | The number of bytes in the following element field.
| *Varies* | element       | uint8_t[]        | The element to add to the current filter.  Maximum of 520 bytes, which is the maximum size of an element which can be pushed onto the stack in a pubkey or signature script.  Elements must be sent in the byte order they would use when appearing in a raw transaction; for example, hashes should be sent in internal byte order.

```{note}
A [`filteradd` message](p2p-network.md#filteradd) will not be accepted unless a filter was previously set with the [`filterload` message](p2p-network.md#filterload).
```

The annotated hexdump below shows a [`filteradd` message](p2p-network.md#filteradd) adding a [TXID](../reference/glossary.md#transaction-identifiers). (The message header has been omitted.) This TXID appears in the same block used for the example hexdump in the [`merkleblock` message](p2p-network.md#merkleblock); if that [`merkleblock` message](p2p-network.md#merkleblock) is re-sent after sending this [`filteradd` message](p2p-network.md#filteradd), six hashes are returned instead of four.

``` text
20 ................................. Element bytes: 32
fdacf9b3eb077412e7a968d2e4f11b9a
9dee312d666187ed77ee7d26af16cb0b ... Element (A TXID)
```

### filterclear

The [`filterclear` message](p2p-network.md#filterclear) tells the receiving [peer](../reference/glossary.md#peer) to remove a previously-set [bloom filter](../reference/glossary.md#bloom-filter).  This also undoes the effect of setting the relay field in the [`version` message](p2p-network.md#version) to 0, allowing unfiltered access to [`inv` messages](p2p-network.md#inv) announcing new transactions.

Dimecoin Core does not require a [`filterclear` message](p2p-network.md#filterclear) before a replacement filter is loaded with `filterload`.  It also doesn't require a [`filterload` message](p2p-network.md#filterload) before a [`filterclear` message](p2p-network.md#filterclear).

There is no payload in a [`filterclear` message](p2p-network.md#filterclear).  See the [message header section](p2p-network.md#message-headers) for an example of a message without a payload.

### filterload

The [`filterload` message](p2p-network.md#filterload) tells the receiving [peer](../reference/glossary.md#peer) to filter all relayed transactions and requested [merkle blocks](../reference/glossary.md#merkle-block) through the provided filter. This allows clients to receive transactions relevant to their [wallet](../reference/glossary.md#wallet) plus a configurable rate of false positive transactions which can provide plausible-deniability privacy.

| Bytes    | Name         | Data Type | Description
|----------|--------------|-----------|---------------
| *Varies* | nFilterBytes | compactSize uint | Number of bytes in the following filter bit field.
| *Varies* | filter       | uint8_t[] | A bit field of arbitrary byte-aligned size. The maximum size is 36,000 bytes.
| 4        | nHashFuncs   | uint32_t  | The number of hash functions to use in this filter. The maximum value allowed in this field is 50.
| 4        | nTweak       | uint32_t  | An arbitrary value to add to the seed value in the hash function used by the bloom filter.
| 1        | nFlags       | uint8_t   | A set of flags that control how outpoints corresponding to a matched pubkey script are added to the filter. See the table in the Updating A Bloom Filter subsection below.

The annotated hexdump below shows a [`filterload` message](p2p-network.md#filterload). (The message header has been omitted.)  For an example of how this payload was created, see the [filterload example](../examples/p2p-network-creating-a-bloom-filter.md).

``` text
02 ......... Filter bytes: 2
b50f ....... Filter: 1010 1101 1111 0000
0b000000 ... nHashFuncs: 11
00000000 ... nTweak: 0/none
00 ......... nFlags: BLOOM_UPDATE_NONE
```

#### Initializing A Bloom Filter

Filters have two core parameters: the size of the bit field and the number of hash functions to run against each data element. The following formulas from BIP37 will allow you to automatically select appropriate values based on the number of elements you plan to insert into the filter (*n*) and the false positive rate (*p*) you desire to maintain plausible deniability.

* Size of the bit field in bytes (*nFilterBytes*), up to a maximum of 36,000: `(-1 / log(2)**2 * n * log(p)) / 8`

* Hash functions to use (*nHashFuncs*), up to a maximum of 50:
  `nFilterBytes * 8 / n * log(2)`

Note that the filter matches parts of transactions (transaction elements), so the false positive rate is relative to the number of elements checked---not the number of transactions checked. Each normal transaction has a minimum of four matchable elements (described in the comparison subsection below), so a filter with a false-positive rate of 1 percent will match about 4 percent of all transactions at a minimum.

According to BIP37, the formulas and limits described above provide support for bloom filters containing 20,000 items with a false positive rate of less than 0.1 percent or 10,000 items with a false positive rate of less than 0.0001 percent.

Once the size of the bit field is known, the bit field should be initialized as all zeroes.

#### Populating A Bloom Filter

The bloom filter is populated using between 1 and 50 unique hash functions (the number specified per filter by the *nHashFuncs* field). Instead of using up to 50 different hash function implementations, a single implementation is used with a unique seed value for each function.

The seed is `nHashNum * 0xfba4c795 + nTweak` as a *uint32\_t*, where the values are:

* **nHashNum** is the sequence number for this hash function, starting at 0 for the first hash iteration and increasing up to the value of the *nHashFuncs* field (minus one) for the last hash iteration.

* **0xfba4c795** is a constant optimized to create large differences in the seed for different values of *nHashNum*.

* **nTweak** is a per-filter constant set by the client to require the use of an arbitrary set of hash functions.

If the seed resulting from the formula above is larger than four bytes, it must be truncated to its four most significant bytes (for example, `0x8967452301 & 0xffffffff → 0x67452301`).

The actual hash function implementation used is the [32-bit Murmur3 hash function](https://en.wikipedia.org/wiki/MurmurHash).

```{warning}
The Murmur3 hash function has separate 32-bit and 64-bit versions that produce different results for the same [input](../reference/glossary.md#input).  Only the 32-bit Murmur3 version is used with Dimecoin bloom filters.
```

The data to be hashed can be any transaction element which the bloom filter can match. See the next subsection for the list of transaction elements checked against the filter. The largest element which can be matched is a script data push of 520 bytes, so the data should never exceed 520 bytes.

The example below from Dimecoin Core [bloom.cpp](https://github.com/dime-coin/dimecoin/blob/272dbe4974e09eca6a928ce13b42941b1c28aca2/src/bloom.cpp#L58) combines all the steps above to create the hash function template. The seed is the first parameter; the data to be hashed is the second parameter. The result is a uint32\_t modulo the size of the bit field in bits.

``` c++
MurmurHash3(nHashNum * 0xFBA4C795 + nTweak, vDataToHash) % (vData.size() * 8)
```

Each data element to be added to the filter is hashed by *nHashFuncs* number of hash functions. Each time a hash function is run, the result will be the index number (*nIndex*) of a bit in the bit field. That bit must be set to 1. For example if the filter bit field was `00000000` and the result is 5, the revised filter bit field is `00000100` (the first bit is bit 0).

It is expected that sometimes the same index number will be returned more than once when populating the bit field; this does not affect the algorithm---after a bit is set to 1, it is never changed back to 0.

After all data elements have been added to the filter, each set of eight bits is converted into a little-endian byte. These bytes are the value of the *filter* field.

#### Comparing Transaction Elements To A Bloom Filter

To compare an arbitrary data element against the bloom filter, it is hashed using the same parameters used to create the bloom filter. Specifically, it is hashed *nHashFuncs* times, each time using the same
*nTweak* provided in the filter, and the resulting [output](../reference/glossary.md#output) is modulo the size of the bit field provided in the *filter* field.  After each hash is performed, the filter is checked to see if the bit at that indexed location is set.  For example if the result of a hash is `5` and the filter is `01001110`, the bit is considered set.

If the result of every hash points to a set bit, the filter matches. If any of the results points to an unset bit, the filter does not match.

The following transaction elements are compared against bloom filters. All elements will be hashed in the byte order used in [blocks](../reference/glossary.md#block) (for example, [TXIDs](../reference/glossary.md#transaction-identifiers) will be in [internal byte order](../reference/glossary.md#internal-byte-order)).

* **TXIDs:** the transaction's SHA256(SHA256()) hash.

* **Outpoints:** each 36-byte [outpoint](../reference/glossary.md#outpoint) used this transaction's input section is individually compared to the filter.

* **Signature Script Data:** each element pushed onto the stack by a [data-pushing opcode](../reference/glossary.md#data-pushing-opcode) in a [signature script](../reference/glossary.md#signature-script) from this transaction is individually compared to the filter.  This includes data elements present in P2SH [redeem script](../reference/glossary.md#redeem-script) when they are being spent.

* **PubKey Script Data:** each element pushed onto the the stack by a data-pushing opcode in any [pubkey script](../reference/glossary.md#pubkey-script) from this transaction is individually compared to the filter. (If a pubkey script element matches the filter, the filter will be immediately updated if the `BLOOM_UPDATE_ALL` flag was set; if the pubkey script is in the P2PKH format and matches the filter, the filter will be immediately updated if the `BLOOM_UPDATE_P2PUBKEY_ONLY` flag was set. See the subsection below for details.)

The following annotated hexdump of a transaction is from the [raw transaction format section](docs/reference/transactions-raw-transaction-format.md); the elements which would be checked by the filter are emphasized in bold. Note that this transaction's TXID (**`01000000017b1eab[...]`**) would also be checked, and that the outpoint TXID and index number below would be checked as a single 36-byte element.

<pre><code>01000000 ................................... Version

01 ......................................... Number of inputs
|
| <b>7b1eabe0209b1fe794124575ef807057</b>
| <b>c77ada2138ae4fa8d6c4de0398a14f3f</b> ......... Outpoint TXID
| <b>00000000</b> ................................. Outpoint index number
|
| 49 ....................................... Bytes in sig. script: 73
| | 48 ..................................... Push 72 bytes as data
| | | <b>30450221008949f0cb400094ad2b5eb3</b>
| | | <b>99d59d01c14d73d8fe6e96df1a7150de</b>
| | | <b>b388ab8935022079656090d7f6bac4c9</b>
| | | <b>a94e0aad311a4268e082a725f8aeae05</b>
| | | <b>73fb12ff866a5f01</b> ..................... Secp256k1 signature
|
| ffffffff ................................. Sequence number: UINT32_MAX

01 ......................................... Number of outputs
| f0ca052a01000000 ......................... Satoshis (49.99990000 BTC)
|
| 19 ....................................... Bytes in pubkey script: 25
| | 76 ..................................... OP_DUP
| | a9 ..................................... OP_HASH160
| | 14 ..................................... Push 20 bytes as data
| | | <b>cbc20a7664f2f69e5355aa427045bc15</b>
| | | <b>e7c6c772</b> ............................. PubKey hash
| | 88 ..................................... OP_EQUALVERIFY
| | ac ..................................... OP_CHECKSIG

00000000 ................................... locktime: 0 (a block height)
</code></pre>

#### Updating A Bloom Filter

Clients will often want to track [inputs](../reference/glossary.md#input) that spend [outputs](../reference/glossary.md#output) (outpoints) relevant to their wallet, so the filterload field *nFlags* can be set to allow the filtering [node](../reference/glossary.md#node) to update the filter when a match is found. When the filtering node sees a [pubkey script](../reference/glossary.md#pubkey-script) that pays a pubkey, [address](../reference/glossary.md#address), or other data element matching the filter, the filtering node immediately updates the filter with the [outpoint](../reference/glossary.md#outpoint) corresponding to that pubkey script.

![Automatically Updating Bloom Filters](../../img/dev/en-bloom-update.svg)

If an input later spends that outpoint, the filter will match it, allowing the filtering node to tell the client that one of its transaction outputs has been spent.

The *nFlags* field has three allowed values:

| Value | Name                       | Description
|-------|----------------------------|---------------
| 0     | `BLOOM_UPDATE_NONE`          | The filtering node should not update the filter.
| 1     | `BLOOM_UPDATE_ALL`           | If the filter matches any data element in a pubkey script, the corresponding outpoint is added to the filter.
| 2     | `BLOOM_UPDATE_P2PUBKEY_ONLY` | If the filter matches any data element in a pubkey script and that script is either a P2PKH or non-P2SH pay-to-multisig script, the corresponding outpoint is added to the filter.

In addition, because the filter size stays the same even though additional elements are being added to it, the false positive rate increases. Each false positive can result in another element being added to the filter, creating a feedback loop that can (after a certain point) make the filter useless. For this reason, clients using automatic filter updates need to monitor the actual false positive rate and send a new filter when the rate gets too high.

### getaddr

The [`getaddr` message](p2p-network.md#getaddr) requests an [`addr` message](p2p-network.md#addr) from the receiving [node](../reference/glossary.md#node), preferably one with lots of IP addresses of other receiving nodes. The transmitting node can use those IP addresses to quickly update its database of available nodes rather than waiting for unsolicited [`addr` messages](p2p-network.md#addr) to arrive over time.

There is no payload in a [`getaddr` message](p2p-network.md#getaddr).  See the [message header section](p2p-network.md#message-headers) for an example of a message without a payload.

### getsporks

The [`getsporks` message](p2p-network.md#getsporks) requests [`spork` messages](p2p-network.md#spork) from the receiving node.

There is no payload in a [`getsporks` message](p2p-network.md#getsporks).  See the [message header section](p2p-network.md#message-headers) for an example of a message without a payload.

### ping

The [`ping` message](p2p-network.md#ping) helps confirm that the receiving [peer](../reference/glossary.md#peer) is still connected. If a TCP/IP error is encountered when sending the [`ping` message](p2p-network.md#ping) (such as a connection timeout), the transmitting node can assume that the receiving node is disconnected. The response to a [`ping` message](p2p-network.md#ping) is the [`pong` message](p2p-network.md#pong).

As of Dimecoin protocol version 70005 and all later versions, the message includes a single field, the nonce.

| Bytes | Name  | Data Type | Description
|-------|-------|-----------|---------------
| 8     | nonce | uint64_t  | Random nonce assigned to this [`ping` message](p2p-network.md#ping).  The responding [`pong` message](p2p-network.md#pong) will include this nonce to identify the [`ping` message](p2p-network.md#ping) to which it is replying.

The annotated hexdump below shows a [`ping` message](p2p-network.md#ping). (The message header has been omitted.)

``` text
0094102111e2af4d ... Nonce
```

### pong

The [`pong` message](p2p-network.md#pong) replies to a [`ping` message](p2p-network.md#ping), proving to the pinging [node](../reference/glossary.md#node) that the ponging node is still alive. Dimecoin Core will, by default, disconnect from any clients which have not responded to a [`ping` message](p2p-network.md#ping) within 20 minutes.

To allow nodes to keep track of latency, the [`pong` message](p2p-network.md#pong) sends back the same nonce received in the [`ping` message](p2p-network.md#ping) it is replying to.

The format of the [`pong` message](p2p-network.md#pong) is identical to the [`ping` message](p2p-network.md#ping); only the message header differs.

### sendcmpct

The [`sendcmpct` message](p2p-network.md#sendcmpct) tells the receiving [peer](../reference/glossary.md#peer) whether or not to announce new [blocks](../reference/glossary.md#block) using a [`cmpctblock` message](p2p-network.md#cmpctblock). It also sends the compact block protocol version it supports. The [`sendcmpct` message](p2p-network.md#sendcmpct) is defined as a message containing a 1-byte integer followed by a 8-byte integer. The first integer is interpreted as a boolean and should have a value of either 1 or 0. The second integer is be interpreted as a little-endian version number.

Upon receipt of a [`sendcmpct` message](p2p-network.md#sendcmpct) with the first and second integers set to 1, the [node](../reference/glossary.md#node) should announce new blocks by sending a [`cmpctblock` message](p2p-network.md#cmpctblock).

Upon receipt of a [`sendcmpct` message](p2p-network.md#sendcmpct) with the first integer set to 0, the node shouldn't announce new blocks by sending a [`cmpctblock` message](p2p-network.md#cmpctblock), but instead announce new blocks by sending invs or [headers](../reference/glossary.md#header), as defined by [BIP130](https://github.com/bitcoin/bips/blob/master/bip-0130.mediawiki).

Upon receipt of a [`sendcmpct` message](p2p-network.md#sendcmpct) with the second integer set to something other than 1, nodes should treat the peer as if they had not received the message (as it indicates the peer will provide an unexpected encoding in [`cmpctblock` messages](p2p-network.md#cmpctblock), and/or other, messages). This allows future versions to send duplicate [`sendcmpct` messages](p2p-network.md#sendcmpct) with different versions as a part of a version handshake.

Nodes should check for a protocol version of >= 70007 before sending [`sendcmpct` messages](p2p-network.md#sendcmpct). Nodes shouldn't send a request for a `MSG_CMPCT_BLOCK` object to a peer before having received a [`sendcmpct` message](p2p-network.md#sendcmpct) from that peer. Nodes shouldn't request a `MSG_CMPCT_BLOCK` object before having sent all [`sendcmpct` messages](p2p-network.md#sendcmpct) to that peer which they intend to send, as the peer cannot know what protocol version to use in the response.

The structure of a [`sendcmpct` message](p2p-network.md#sendcmpct) is defined below.

| Bytes    | Name          | Data Type        | Description
|----------|---------------|------------------|--------------
| 1        | announce      | bool             | 0 - Announce blocks via [`headers` message](p2p-network.md#headers) or [`inv` message](p2p-network.md#inv)<br>1 - Announce blocks via [`cmpctblock` message](p2p-network.md#cmpctblock)
| 8        | version       | uint64_t         | The compact block protocol version number

The annotated hexdump below shows a [`sendcmpct` message](p2p-network.md#sendcmpct). (The message header has been omitted.)

``` text
01 ................................. Block announce type: Compact Blocks
0100000000000000 ................... Compact block version: 1
```

### sendheaders

The [`sendheaders` message](p2p-network.md#sendheaders) tells the receiving [peer](../reference/glossary.md#peer) to send new [block](../reference/glossary.md#block) announcements using a [`headers` message](p2p-network.md#headers) rather than an [`inv` message](p2p-network.md#inv).

There is no payload in a [`sendheaders` message](p2p-network.md#sendheaders).  See the [message header section](p2p-network.md#message-headers) for an example of a message without a payload.

### spork

Sporks are a mechanism by which updated code is released to the network, but not immediately made active (or “enforced”). Enforcement of the updated code can be activated remotely. Should problems arise, the code can be deactivated in the same manner, without the need for a network-wide rollback or client update.

A [`spork` message](p2p-network.md#spork) may be sent in response to a [`getsporks` message](p2p-network.md#getsporks).

The [`spork` message](p2p-network.md#spork) tells the receiving peer the status of the spork defined by the SporkID field. Upon receiving a [spork](../reference/glossary.md#spork) message, the client must verify the [signature](../reference/glossary.md#signature) before accepting the spork message as valid.

| Bytes | Name | Data type | Required | Description
| ---------- | ----------- | --------- | -------- | --------
| 4 | nSporkID | int | Required | ID assigned in spork.h
| 8 | nValue | int64_t | Required | Value assigned to spork<br>Default (disabled): `4000000000`
| 8 | nTimeSigned | int64_t | Required | Time the spork value was signed
| 66 | vchSig | char[] | Required | Length (1 byte) + Signature (65 bytes)

The following annotated hexdump shows a [`spork` message](p2p-network.md#spork).

``` text
11270000 .................................... Spork ID: Spork 2 InstantSend enabled (10001)
0000000000000000 ............................ Value (0)
2478da5900000000 ............................ Epoch time: 2017-10-08 19:10:28 UTC (1507489828)

41 .......................................... Signature length: 65

1b6762d3e70890b5cfaed5d1fd72121c
d32020c827a89f8128a00acd210f4ea4
1b36c26c3767f8a24f48663e189865ed
403ed1e850cdb4207cdd466419d9d183
45 .......................................... Masternode Signature
```

#### Active sporks

The list of all active sporks can be found in
[`src/spork.h`](https://github.com/dime-coin/dimecoin/blob/272dbe4974e09eca6a928ce13b42941b1c28aca2/src/spork.h#L36).

| Spork ID | Num. | Name | Description
| :----------: | :----------: | ----------- | -----------
| 10001 | 2 | `INSTANTSEND_ENABLED` | *Added in Dimecoin Core 2.0.0.0*<br>Turns InstantSend on and off network wide. Also determines if new mempool transactions should be locked or not.
| 10002 | 3 | `INSTANTSEND_BLOCK_`<br>`FILTERING` | Turns on and off InstantSend block filtering
| 10004 | 5 | `INSTANTSEND_MAX_VALUE` | Sets max value alloted for InstantSends
| 10007 | 8 | `MASTERNODE_PAYMENT_`<br>`ENFORCEMENT` | Enforces MN pays
| 10008 | 9 | `SUPERBLOCKS_ENABLED` | Turns on and off SuperBlocks. *Disabled as Dimecoin does not utilize SuperBlocks*
| 10009 | 10| `MASTERNODE_PAY_UPDATED`<br> `_NODES` | Enforce updated rules for masternode payments.

#### Spork verification

To verify `vchSig`, compare the hard-coded spork public key (`strSporkPubKey` from [`src/chainparams.cpp`](https://github.com/dime-coin/dimecoin/blob/272dbe4974e09eca6a928ce13b42941b1c28aca2/src/chainparams.cpp#L177)) with the public key recovered from the [`spork` message](p2p-network.md#spork)'s hash and `vchSig` value (implementation details for Dimecoin Core can be found in `CPubKey::RecoverCompact`). The hash is a double SHA-256 hash of:

* The spork magic message (`"Dimecoin Signed Message:\n"`)
* nSporkID + nValue + nTimeSigned

| Network | Spork Pubkey (wrapped)
| ---------- | ----------
| Mainnet | 045078e030f9b5131e2fe4de7bf81761e5eb609309f951ca3dd<br>63b85fc702b97c736de0644562e48b75c2555a5765bdc2aecc15264777b99ec2f264<br>3d4521a50e2
| Testnet3 | 045078e030f9b5131e2fe4de7bf81761e5eb609309f951ca3dd63b85f<br>1c702b97c736de0644562e48b75c2555a5765bdc2aecc15264777b99ec2f26<br>43d4521a50e2
| RegTest | Undefined

### verack

The [`verack` message](p2p-network.md#verack) acknowledges a previously-received [`version` message](p2p-network.md#version), informing the connecting [node](../reference/glossary.md#node) that it can begin to send other messages. The [`verack` message](p2p-network.md#verack) has no payload; for an example of a message with no payload, see the [message headers section](p2p-network.md#message-headers.md).

### version

The [`version` message](p2p-network.md#version) provides information about the transmitting [node](../reference/glossary.md#node) to the receiving node at the beginning of a connection. Until both [peers](../reference/glossary.md#peer) have exchanged [`version` messages](p2p-network.md#version), no other messages will be accepted.

If a [`version` message](p2p-network.md#version) is accepted, the receiving node should send a [`verack` message](p2p-network.md#verack)---but no node should send a [`verack` message](p2p-network.md#verack) before initializing its half of the connection by first sending a [`version` message](p2p-network.md#version).

| Bytes    | Name                  | Data<br>Type        | Required/<br>Optional                        | Description
|----------|-----------------------|------------------|------------------------------------------|-------------
| 4        | version               | int32_t          | Required | The highest protocol version understood by the transmitting node.  See the [protocol version section](p2p-network.md#protocol-versions).
| 8        | services              | uint64_t         | Required | The services supported by the transmitting node encoded as a bitfield.  See the list of service codes below.
| 8        | timestamp             | int64_t          | Required | The current Unix epoch time according to the transmitting node's clock.  Because nodes will reject blocks with timestamps more than two hours in the future, this field can help other nodes to determine that their clock is wrong.
| 8        | addr_recv services    | uint64_t         | Required | The services supported by the receiving node as perceived by the transmitting node.  Same format as the 'services' field above. Dimecoin Core will attempt to provide accurate information.
| 16       | addr_recv IP address  | char             | Required | The IPv6 address of the receiving node as perceived by the transmitting node in **big endian byte order**. IPv4 addresses can be provided as [IPv4-mapped IPv6 addresses](http://en.wikipedia.org/wiki/IPv6#IPv4-mapped_IPv6_addresses). Dimecoin Core will attempt to provide accurate information.
| 2        | addr_recv port        | uint16_t         | Required | The port number of the receiving node as perceived by the transmitting node in **big endian byte order**.
| 8        | addr_trans services   | uint64_t         | Required | The services supported by the transmitting node.  Should be identical to the 'services' field above.
| 16       | addr_trans IP address | char             | Required | The IPv6 address of the transmitting node in **big endian byte order**. IPv4 addresses can be provided as [IPv4-mapped IPv6 addresses](http://en.wikipedia.org/wiki/IPv6#IPv4-mapped_IPv6_addresses).  Set to ::ffff:127.0.0.1 if unknown.
| 2        | addr_trans port       | uint16_t         | Required | The port number of the transmitting node in **big endian byte order**.
| 8        | nonce                 | uint64_t         | Required | A random nonce which can help a node detect a connection to itself.  If the nonce is 0, the nonce field is ignored.  If the nonce is anything else, a node should terminate the connection on receipt of a [`version` message](p2p-network.md#version) with a nonce it previously sent.
| *Varies* | user_agent bytes      | compactSize uint | Required | Number of bytes in following user\_agent field.  If 0x00, no user agent field is sent.
| *Varies* | user_agent            | string           | Required if user_agent bytes > 0 | User agent as defined by BIP14. Previously called subVer.<br><br>Dimecoin Core limits the length to 256 characters.
| 4        | start_height          | int32_t          | Required | The height of the transmitting node's best blockchain or, in the case of an SPV client, best block header chain.
| 1        | relay                 | bool             | Optional | Transaction relay flag.  If 0x00, no [`inv` messages](p2p-network.md#inv) or [`tx` messages](p2p-network.md#tx) announcing new transactions should be sent to this client until it sends a [`filterload` message](p2p-network.md#filterload) or [`filterclear` message](p2p-network.md#filterclear).  If the relay field is not present or is set to 0x01, this node wants [`inv` messages](p2p-network#inv) and [`tx` messages](p2p-network.md#tx) announcing new transactions.
| 1        | mn_connection         | bool             | Optional | If 0x00, the connection is from a non-masternode. If 0x01, the connection is from a masternode.

The following service identifiers have been assigned.

| Value | Name         | Description
|-------|--------------|---------------
| 0x00  | *Unnamed*    | This node is not a full node.  It may not be able to provide any data except for the transactions it originates.
| 0x01  | `NODE_NETWORK` | This is a full node and can be asked for full blocks.  It should implement all protocol features available in its self-reported protocol version.
| 0x04  | `NODE_BLOOM` | This node is capable and willing to handle bloom-filtered connections.  Dimecoin Core nodes used to support this by default, without advertising this bit, but no longer do as of protocol version 70006 (= NO_BLOOM_VERSION)
| 0x08 | `NODE_XTHIN` | **Dimecoin Core does not support this service**<br>This node supports Xtreme Thinblocks.
| 0x40 | `NODE_COMPACT_FILTERS` | This node supports basic block filter requests. See [BIP157](https://github.com/bitcoin/bips/blob/master/bip-0157.mediawiki) and [BIP158](https://github.com/bitcoin/bips/blob/master/bip-0158.mediawiki) for details on how this is implemented.
| 0x400 | `NODE_NETWORK_LIMITED` | This is the same as `NODE_NETWORK` with the limitation of only serving the last 288 blocks. See [BIP159](https://github.com/bitcoin/bips/blob/master/bip-0159.mediawiki) for details on how this is implemented.

The following annotated hexdump shows a [`version` message](p2p-network.md#version). (The message header has been omitted and the actual IP addresses have been replaced with [RFC5737](http://tools.ietf.org/html/rfc5737) reserved IP addresses.)

``` text
46120100 .................................... Protocol version: 70008
0500000000000000 ............................ Services: NODE_NETWORK (1) + NODE_BLOOM (4)
9c10ad5c00000000 ............................ Epoch time: 1554845852

0100000000000000 ............................ Receiving node's services
00000000000000000000ffffc61b6409 ............ Receiving node's IPv6 address
270f ........................................ Receiving node's port number

0500000000000000 ............................ Transmitting node's services
00000000000000000000ffffcb0071c0 ............ Transmitting node's IPv6 address
270f ........................................ Transmitting node's port number

128035cbc97953f8 ............................ Nonce

12 .......................................... Bytes in user agent string: 18
2f4461736820436f72653a302e31322e312e352f..... User agent: /Dimecoin Core:2.3.0.0/

851f0b00 .................................... Start height: 76944
01 .......................................... Relay flag: true

5dbb5d1baade6a9afa34db708f72c0dd
b5bd82b3656493484556689640a91357 ............ Masternode Auth. Challenge

00 .......................................... Masternode connection (false)
```

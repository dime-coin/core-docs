```{eval-rst}
.. meta::
  :title: Protocol Versions
  :description: The table in this section lists some notable versions of the Dimecoin P2P network protocol, with the most recent versions listed first.
```

> ***We put our best effort into covering all topics related to Dimecoin. Each section will cover a different category. Not all documentation may be 100% accurate, if you spot an error, please report it or submit a PR request on GitHub.***
>
> ***REMINDER: This documentation is always evolving. If you have not been here for a while, perhaps check again. Things may have been added or updated since your last visit!***

## Protocol Versions

### Dimecoin Protocol Versions

The table below lists some notable versions of the P2P network protocol, with the most recent versions listed first.

As of Dimecoin Core 2.3.0.0, the most recent protocol version is 70008.

| Version | Initial Release                    | Major Changes
|---------|------------------------------------|--------------
| 70008 | [Dimecoin Core 2.3.0.0](https://github.com/dime-coin/dimecoin/blob/master/doc/dimecoin-release-notes/release-notes-2.3.0.0.md) <br> (Sept 2023) | • Sync optimization and fixes to selection during the staking process. • Coin Control refactor<br>• Patch Qt for limits
| 70007 | [Dimecoin Core 2.2.0.0](https://github.com/dime-coin/dimecoin/blob/master/doc/dimecoin-release-notes/release-notes-2.2.0.0.md) <br> (Nov 2022) | • Peer connectivity optimization<br>• Refactored input tests<br>• Additonal checks added to ensure outputs are signed correctly<br>• Correct MN pay split<br>• added getchaintips RPC function
| 70006 (unchanged) | [Dimecoin Core 2.1.0.0](https://github.com/dime-coin/dimecoin/blob/master/doc/dimecoin-release-notes/release-notes-2.1.0.0.md) <br> (Aug 2022) | • Switched to dual-diff retargeting algorithm<br>• correct maxfee<br>• remove peer disconnect after full-sync
| 70006 | [Dimecoin Core 2.1.0.0](https://github.com/dime-coin/dimecoin/blob/master/doc/dimecoin-release-notes/release-notes-2.0.0.0.md) <br> (Jun 2022) | • Implement hybrid POW/POS consensus and masternodes, rebased over bitcoin .17
| 70005 (unchanged) | Dimecoin Core 1.10.0.1 <br> (Jan 2019) | • Fix to LWMA-3 to combat hash related vulnerabilites
| 70005 | Dimecoin Core 1.10.0.0 <br> (Dec 2018) | • Implement LWMA-3 difficult adjustement algorightm<br>• New reward distribution to stabilize block reward allocation

### Bitcoin Protocol Versions

Historical Bitcoin protocol versions shown below since Dimecoin is a [fork](../reference/glossary.md#fork) of Bitcoin Core. Versions prior to Dimecoin's fork listed below.

| Version | Initial Release                    | Major Changes
|---------|------------------------------------|--------------
| 70001   | Bitcoin Core 0.8.0 <br>(Feb 2013)  | • Added [`notfound` message](p2p-network.md#notfound). <br><br>[BIP37](https://github.com/bitcoin/bips/blob/master/bip-0137.mediawiki): <br>• Added [`filterload` message](p2p-network.md#filterload). <br>• Added [`filteradd` message](p2p-network.md#filteradd). <br>• Added [`filterclear` message](p2p-network.md#filterclear). <br>• Added [`merkleblock` message](p2p-network.md#merkleblock). <br>• Added relay field to [`version` message](p2p-network.md#version) <br>• Added `MSG_FILTERED_BLOCK` inventory type to [`getdata` message](p2p-network.md#getdata).
| 60002   | Bitcoin Core 0.7.0 <br>(Sep 2012)  | [BIP35](https://github.com/bitcoin/bips/blob/master/bip-0035.mediawiki): <br>• Added [`mempool` message](p2p-network.md#mempool). <br>• Extended [`getdata` message](p2p-network.md#getdata) to allow download of memory pool transactions
| 60001   | Bitcoin Core 0.6.1 <br>(May 2012)  | [BIP31](https://github.com/bitcoin/bips/blob/master/bip-0031.mediawiki): <br>• Added nonce field to [`ping` message](p2p-network.md#ping) <br>• Added [`pong` message](p2p-network.md#pong)
| 60000   | Bitcoin Core 0.6.0 <br>(Mar 2012)  | [BIP14](https://github.com/bitcoin/bips/blob/master/bip-0014.mediawiki): <br>• Separated protocol version from Bitcoin Core version
| 31800   | Bitcoin Core 0.3.18 <br>(Dec 2010) | • Added [`getheaders` message](p2p-network.md#getheaders) and [`headers` message](p2p-network.md#headers).
| 31402   | Bitcoin Core 0.3.15 <br>(Oct 2010) | • Added time field to [`addr` message](p2p-network.md#addr).
| 311     | Bitcoin Core 0.3.11 <br>(Aug 2010) | • Added `alert` message.
| 209     | Bitcoin Core 0.2.9 <br>(May 2010)  | • Added checksum field to message headers.
| 106     | Bitcoin Core 0.1.6 <br>(Oct 2009)  | • Added receive IP address fields to [`version` message](p2p-network.md#version).

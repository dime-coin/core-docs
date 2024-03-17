```{eval-rst}
.. meta::
  :title: P2P Network
  :description: The Dimecoin P2P network is a system where full nodes collaboratively maintain a network for block and transaction exchange, with some nodes storing the entire blockchain (archival nodes) and others only storing parts of it (pruned nodes).
```

> ***We put our best effort into covering all topics related to Dimecoin. Each section will cover a different category. Not all documentation may be 100% accurate, if you spot an error, please report it or submit a PR request on GitHub.***
>
> ***REMINDER: This documentation is always evolving. If you have not been here for a while, perhaps check again. Things may have been added or updated since your last visit!***

## P2P Network

The Dimecoin network protocol allows full [nodes](../reference/glossary.md#node) (peers) to collaboratively maintain a peer-to-peer [network](../reference/glossary.md#network) for [block](../reference/glossary.md#block) and [transaction](../reference/glossary.md#transaction) exchange. Full nodes download and verify every block and transaction prior to relaying them to other nodes. Archival nodes are full nodes which store the entire [blockchain](../reference/glossary.md#blockchain) and can serve historical blocks to other nodes. Pruned nodes are full nodes which do not store the entire blockchain (no longer supported since Dimecoin Core v2.0.0.0). Many SPV clients also use the Dimecoin network protocol to connect to full nodes.

Consensus rules do *not* cover networking, so Dimecoin programs may use alternative networks and protocols, such as Bitcoin's [high-speed block relay network](https://www.mail-archive.com/bitcoin-development@lists.sourceforge.net/msg03189.html) used by some miners and the [dedicated transaction information servers](https://github.com/dime-coin/electrum-dimecoin) used by some wallets that provide SPV-level security.

To provide practical examples of the Dimecoin peer-to-peer network, this section uses Dimecoin Core as a representative full node and [DimecoinJ](https://github.com/dime-coin/dimecoinj) as a representative SPV client. Both programs are flexible, so only default behavior is described. Also, for privacy, actual IP addresses in the example output below have been replaced with [RFC5737](http://tools.ietf.org/html/rfc5737) reserved IP addresses.

```{toctree}
:maxdepth: 2
:titlesonly:

p2p-network-peer-discovery
p2p-network-connecting-to-peers
p2p-network-initial-block-download
p2p-network-block-broadcasting
p2p-network-transaction-broadcasting
p2p-network-misbehaving-nodes
```

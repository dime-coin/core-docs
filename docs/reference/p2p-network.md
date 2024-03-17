```{eval-rst}
.. meta::
  :title: P2P Networks
  :description: This section provides an overview of the Dimecoin P2P network protocol (not a specification).
```

> ***We put our best effort into covering all topics related to Dimecoin. Each section will cover a different category. Not all documentation may be 100% accurate, if you spot an error, please report it or submit a PR request on GitHub.***
>
> ***REMINDER: This documentation is always evolving. If you have not been here for a while, perhaps check again. Things may have been added or updated since your last visit!***

## P2P Networks

This section describes the Dimecoin P2P network protocol (but it is not a [specification](index.md#specification-disclaimer)). It does not describe the [BIP70 payment protocol](../reference/glossary.md#bip70-payment-protocol), the [GetBlockTemplate mining protocol](../guide/mining.md#getblocktemplate-rpc), or any network protocol never implemented in an official version of Dimecoin Core.

All peer-to-peer communication occurs entirely over TCP.

```{note}
Unless their description says otherwise, all multi-byte integers mentioned in this section are transmitted in little-endian order.
```

```{toctree}
:maxdepth: 2
:titlesonly:

p2p-network-constants-and-defaults
p2p-network-protocol-versions
p2p-network-message-headers
p2p-network-control-messages
p2p-network-data-messages
p2p-network-masternode-messages
```

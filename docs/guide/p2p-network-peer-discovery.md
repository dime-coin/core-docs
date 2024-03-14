```{eval-rst}
.. meta::
  :title: Peer Discovery
  :description: Initial peer discovery in Dimecoin Core involves querying hardcoded DNS seeds, exchanging peer to peer messages, and using a list of hardcoded masternode IP addresses to establish connections.
```

> ***We put our best effort into covering all topics related to Dimecoin. Each section will cover a different category. Not all documentation may be 100% accurate, if you spot an error, please report it or submit a PR request on GitHub.***
>
> ***REMINDER: This documentation is always evolving. If you have not been here for a while, perhaps check again. Things may have been added or updated since your last visit!***

## Peer Discovery

### DNS Seeds

When started for the first time, programs don't know the IP addresses of any active full [nodes](../resources/glossary.md#node). In order to discover some IP addresses, they query one or more DNS names (called [DNS seeds](../resources/glossary.md#dns-seed)) hardcoded into Dimecoin Core. The response to the lookup should include one or more DNS A records with the IP addresses of full nodes that may accept new incoming connections. For example, using the Unix `dig`command:

```bash
;; QUESTION SECTION:
;dnsseed.dimecoinnetwork.com.  IN A

;; ANSWER SECTION:
dnsseed.dimecoinnetwork.com. 3600 IN A 144.81.48.187
dnsseed.dimecoinnetwork.com. 3600 IN A 132.95.151.84
dnsseed.dimecoinnetwork.com. 3600 IN A 124.77.137.236

[...]
```

The [DNS seeds](../resources/glossary.md#dns-seed) are maintained by Dimecoin community members: some of them provide dynamic DNS seed servers which automatically get IP addresses of active nodes by scanning the network; others provide static DNS seeds that are updated manually and are more likely to provide IP addresses for inactive nodes. In either case, nodes are added to the DNS seed if they run on the default Dimecoin ports of 11391 for [mainnet](../resources/glossary.md#mainnet) or 21931 for [testnet](../resources/glossary.md#testnet).

DNS seed results are not authenticated and a malicious seed operator or network man-in-the-middle attacker could return only IP addresses of nodes controlled by the attacker, isolating a program on the attacker's own network and allowing the attacker to feed it bogus transactions and blocks. For this reason, programs should not rely on DNS seeds exclusively.

### P2P Peer List Broadcast

Once a program has connected to the [network](../resources/glossary.md#network), its [peers](../resources/glossary.md#peer) can begin to send it `addr` (address) messages with the IP addresses and port numbers of other peers on the network, providing a fully decentralized method of peer discovery. Dimecoin Core keeps a record of known peers in a persistent on-disk database which usually allows it to connect directly to those peers on subsequent startups without having to use DNS seeds.

However, peers often leave the network or change IP addresses, so programs may need to make several different connection attempts at startup before a successful connection is made. This can add a significant delay to the amount of time it takes to connect to the network, forcing a user to wait before sending a transaction or checking the status of payment.

Dimecoin Core tries to strike a balance between minimizing delays and avoiding unnecessary DNS seed use: if Dimecoin Core has entries in its peer database, it spends up to 11 seconds attempting to connect to at least one of them before falling back to seeds; if a connection is made within that time, it does not query any seeds.

### Hardcoded Masternode IPs

Dimecoin Core also includes a hardcoded list of IP addresses and port numbers to several dozen nodes which were active around the time that particular version of the software was first released. Starting with Dimecoin Core 2.0.0.0, [masternodes](../resources/glossary.md#masternode) are used for the seed list since they must remain online to receive their portion of the block reward (good availability) and must be compliant with [consensus rules](../resources/glossary.md#consensus-rules) (reliable). Dimecoin Core will start attempting to connect to these nodes if none of the DNS seed servers have responded to a query within 60 seconds, providing an automatic fallback option.

As a manual fallback option, Dimecoin Core also provides several command-line connection options, including the ability to get a list of peers from a specific node by IP address, or to make a persistent connection to a specific node by IP address.  See the `-help` text for details.

```{admonition} Resources
* [Dimecoin Seeder](https://github.com/dime-coin/dimecoin-seeder), the program run by several of the seeds used by Dimecoin Core. 
* The Dimecoin Core [DNS Seed Policy](https://github.com/dime-coin/dimecoin/blob/master/doc/dnsseed-policy.md). 
* The hardcoded list of IP addresses used by Dimecoin Core is generated using the [makeseeds script](https://github.com/dime-coin/dimecoin/tree/master/contrib/seeds).
```

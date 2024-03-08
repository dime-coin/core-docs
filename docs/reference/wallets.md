```{eval-rst}
.. meta::
  :title: Wallets
  :description: Dimecoin has two deterministic wallet formats – single chain wallets (legacy) and hierarchical deterministic (HD) wallets.
```
> ***We put our best effort into covering all topics related to Dimecoin. Each section will cover a different category. Not all documentation may be 100% accurate, if you spot an error, please report it or submit a PR request on GitHub.***
>
> ***REMINDER: This documentation is always evolving. If you have not been here for a while, perhaps check again. Things may have been added or updated since your last visit!***

## Wallets

### Deterministic Wallet Formats

#### Type 1: Single Chain Wallets

A Type 1 deterministic [wallet](../resources/glossary.md#wallet) is the simpler of the two, which can create a single series of keys from a single seed. A primary weakness is that if the seed is leaked, all funds are compromised, and wallet sharing is extremely limited.

#### Type 2: Hierarchical Deterministic (HD) Wallets

![Overview Of Hierarchical Deterministic Key Derivation](../../img/dev/en-hd-overview.svg)

For an overview of the [HD wallet](../resources/glossary.md#hd-wallet), please see the [developer guide section](../guide/wallets.md).  For details, please see [BIP32](https://github.com/bitcoin/bips/blob/master/bip-0032.mediawiki).

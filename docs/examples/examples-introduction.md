```{eval-rst}
.. _examples-index:
.. meta::
  :title: Dimecoin Core Examples Introduction
  :description: The following guide aims to provide examples to help you start building Dimecoin based applications. 
```

> ***We put our best effort into covering all topics related to Dimecoin. Each section will cover a different category. Not all documentation may be 100% accurate, if you spot an error, please report it or submit a PR request on GitHub.***
>
> ***REMINDER: This documentation is always evolving. If you have not been here for a while, perhaps check again. Things may have been added or updated since your last visit!***

## Introduction

The following section aims to provide examples to help start building Dimecoin-based applications. To make the best use of this documentation, you may want to install the most recent version of Dimecoin Core. You can do so by running the [source](https://www.github.com/dime-coin/dimecoin) code or by using a [pre-compiled binary](https://github.com/dime-coin/dimecoin/releases/latest).

Once installed, you'll have access to three programs: `dimecoind`, `dimecoin-qt`, and `dimecoin-cli`.

* `dimecoin-qt` provides a combination full dimecoin [peer](../reference/glossary.md#peer) and [wallet](../reference/glossary.md#wallet) frontend. From the Help menu, you can access a console where you can enter the RPC commands used throughout this document.

* `dimecoind` is more useful for programming: it provides a full peer which you can interact with through RPCs to port 11931 (or 21931 for [testnet](../reference/glossary.md#testnet) / 31931 for regtest).

* `dimecoin-cli` allows you to send RPC commands to `dimecoind` from the command line.  For example, `dimecoin-cli help`

```{eval-rst}
.. meta::
  :title: Transaction Tutorial
  :description: This section explains using Dimecoin Core's RPC interface to create transactions with different attributes, a common task for Dimecoin applications. 
```

> ***We put our best effort into covering all topics related to Dimecoin. Each section will cover a different category. Not all documentation may be 100% accurate, if you spot an error, please report it or submit a PR request on GitHub.***
>
> ***REMINDER: This documentation is always evolving. If you have not been here for a while, perhaps check again. Things may have been added or updated since your last visit!***

## Transaction Tutorial

Creating transactions is something most Dimecoin applications do. This section provides examples using Dimecoin Core's RPC interface to create transactions with various attributes.

Your applications may use something besides Dimecoin Core to create transactions, but in any system, you will need to provide the same kinds of data to create transactions with the same attributes as those described below.

In order to use this tutorial, you will need to setup [Dimecoin Core](https://github.com/dime-coin/dimecoin/releases/latest) and create a [regression test mode](../reference/glossary.md#regression-test-mode) environment with 500 DIME in your test wallet.

```{toctree}
:maxdepth: 3
:titlesonly:

transaction-tutorial-simple-spending
transaction-tutorial-simple-raw-transaction
transaction-tutorial-complex-raw-transaction
transaction-tutorial-offline-signing
transaction-tutorial-p2sh-multisig
```

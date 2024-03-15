```{eval-rst}
.. _core-index:
```

> ***We put our best effort into covering all topics related to Dimecoin. Each section will cover a different category. Not all documentation may be 100% accurate, if you spot an error, please report it or submit a PR request on GitHub.***
>
> ***REMINDER: This documentation is always evolving. If you have not been here for a while, perhaps check again. Things may have been added or updated since your last visit!***

## Core Docs

Welcome to the Dimecoin Core developer documentation. You'll find sections for
[reference information](reference/introduction.md), [API
details](api/rpc-api-overview.md), [guides](guide/introduction.md),
[examples](examples/introduction.md) and [Dimecoin Core wallet
information](dimecore/wallet-arguments-and-commands.md) to help you start
working with Dimecoin as quickly as possible. Let's jump right in!

```{eval-rst}
.. grid:: 1 2 3 3

    .. grid-item-card:: Core Architecture Reference
        :margin: 2 2 auto auto
        :link-type: ref
        :link: reference-index
        
        Blockchain and Protocol Details 
        
        +++
        :ref:`Click to Begin <reference-index>`

    .. grid-item-card:: API Reference
        :margin: 2 2 auto auto
        :link-type: ref
        :link: api-rpc-overview
                
        RPC, REST, and ZMQ Info
        
        +++
        :ref:`Click to Begin <api-rpc-overview>`

    .. grid-item-card:: Core Guides
        :margin: 2 2 auto auto
        :link-type: ref
        :link: guide-index
        
        Dimecoin Features and Operation
        
        +++
        :ref:`Click to Begin <guide-index>`

    .. grid-item-card:: Core Examples
        :margin: 2 2 auto auto
        :link-type: ref
        :link: examples-index
        
        Common Use-Case Examples
        
        +++
        :ref:`Click to begin <examples-index>`

    .. grid-item-card:: Dimecoin Core
        :margin: 2 2 auto auto
        :link-type: ref
        :link: dimecore-arguments-and-commands
        
        Dimecoin Core Configuration and Usage
        
        +++
        :ref:`Click to Begin <dimecore-arguments-and-commands>`

    .. grid-item-card:: Glossary
        :margin: 2 2 auto auto
        :link-type: ref
        :link: resources-glossary
        
        Important Terms and Definitions
        
        +++
        :ref:`Click to Begin <resources-glossary>`
```

```{toctree}
:maxdepth: 2
:caption: Core Architecture Reference
:hidden:

resources/glossary
reference/introduction
reference/blockchain
reference/transactions
reference/wallets
reference/p2p-network
reference/improvement-proposals
```

```{toctree}
:maxdepth: 2
:titlesonly:
:caption: Core API Reference
:hidden:

api/rpc-api-overview
api/rpc-quick-reference
api/rpc-blockchain
api/rpc-control
api/rpc-dime
api/rpc-generating
api/rpc-mining
api/rpc-network
api/rpc-raw-transactions
api/rpc-utility
api/rpc-wallet
api/rpc-wallet-deprecated
api/rpc-zmq
api/http-rest
api/http-rest-quick-reference
api/http-rest-requests
api/zmq
```

```{toctree}
:maxdepth: 2
:caption: Core Guides
:titlesonly:
:hidden:

guide/introduction
guide/blockchain-overview
guide/blockchain-consensus
guide/blockchain-block-height-and-forking
guide/blockchain-transaction-data
guide/blockchain-consensus-rule-changes
guide/transactions
guide/transactions-p2pkh-script-validation
guide/transactions-p2sh-scripts
guide/transactions-standard-transactions
guide/transactions-non-standard-transactions
guide/transactions-signature-hash-types
guide/transactions-locktime-and-sequence-number
guide/transactions-transaction-fees-and-change
guide/transactions-avoiding-key-reuse
guide/transactions-transaction-malleability
guide/contracts
guide/contracts-escrow-and-arbitration
guide/contracts-micropayment-channel
guide/contracts-deposit
guide/contracts-crosschain-trading
guide/wallets
guide/operating-modes
guide/masternodes
guide/masternodes-pow-pos
guide/masternodes-paylogic-quorums
guide/masternodes-setup-requirements
guide/p2p-network
guide/p2p-network-peer-discovery
guide/p2p-network-connecting-to-peers
guide/p2p-network-initial-block-download
guide/p2p-network-block-broadcasting
guide/p2p-network-transaction-broadcasting
guide/p2p-network-misbehaving-nodes
guide/mining
guide/staking
```

```{toctree}
:maxdepth: 2
:caption: Core Examples
:hidden:

examples/introduction
examples/configuration-file
examples/testing-applications
examples/transaction-tutorial
examples/transaction-tutorial-simple-spending
examples/transaction-tutorial-simple-raw-transaction
examples/transaction-tutorial-complex-raw-transaction
examples/transaction-tutorial-offline-signing
examples/transaction-tutorial-p2sh-multisig
examples/p2p-network
examples/p2p-network-creating-a-bloom-filter
examples/p2p-network-evaluating-a-bloom-filter
examples/p2p-network-bloom-filter-script
examples/p2p-network-retrieving-a-merkleblock
examples/p2p-network-parsing-a-merkleblock
examples/receiving-zmq-notifications
```

```{toctree}
:maxdepth: 2
:titlesonly: 
:caption: Dimecoin Core Wallet
:hidden:

dimecore/wallet-arguments-and-commands
dimecore/wallet-configuration-file
```

```{toctree}
:maxdepth: 2
:titlesonly:
:caption: Additional Resources
:hidden:

Mainnet Block Explorer <https://chainz.cryptoid.info/dime/>
Dimecoin Legacy Whitepaper <https://>
Bitcoin Whitepaper <https://bitcoin.org/bitcoin.pdf>
```

Questions about Dimecoin development are best asked in one of the [Dimecoin Social
Communities](https://dimecoinnetwork.com/socials). Errors or suggestions related to
documentation can be submitted as via the "Edit this page" button on the top,
right of each page.

```{eval-rst}

.. raw:: html

    <div class="custom-spacing"></div>

.. image:: https://github.com/dime-coin/branding-assets/blob/main/master-files/Logobreakdown2.png?raw=true
   :class: no-scaled-link
   :align: center
   :width: 90%

.. raw:: html

    <div class="custom-spacing"></div>


```

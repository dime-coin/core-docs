```{eval-rst}
.. meta::
  :title: Transaction Malleability
  :description: Transaction malleability refers to the possibility of altering a transaction's hash ID without invalidating the transaction itself.
```

> ***We put our best effort into covering all topics related to Dimecoin. Each section will cover a different category. Not all documentation may be 100% accurate, if you spot an error, please report it or submit a PR request on GitHub.***
>
> ***REMINDER: This documentation is always evolving. If you have not been here for a while, perhaps check again. Things may have been added or updated since your last visit!***

## Transaction Malleability

None of Dimecoin's signature hash types protect the [signature script](../reference/glossary.md#signature-script), leaving the door open for a limited denial of service attack called transaction [malleability](../reference/glossary.md#malleability). The signature script contains the secp256k1 [signature](../reference/glossary.md#signature), which can't sign itself, allowing attackers to make non-functional modifications to a transaction without rendering it invalid. For example, an attacker can add some data to the signature script which will be dropped before the previous [pubkey script](../reference/glossary.md#pubkey-script) is processed.

Although the modifications are non-functional---so they do not change what [inputs](../reference/glossary.md#input) the transaction uses nor what [outputs](../reference/glossary.md#output) it pays---they do change the computed hash of the transaction. Since each transaction links to previous transactions using hashes as a transaction identifier ([TXID](../reference/glossary.md#transaction-identifiers)), a modified transaction will not have the txid its creator expected.

This isn't a problem for most Dimecoin transactions which are designed to be added to the [blockchain](../reference/glossary.md#blockchain) immediately. But it does become a problem when the output from a transaction is spent before that transaction is added to the blockchain.

Dimecoin Core 2.0.0.0 implemented [BIP-147](https://github.com/bitcoin/bips/blob/master/bip-0147.mediawiki) which fixes a design flaw in OP_CHECKMULTISIG and OP_CHECKMULTISIGVERIFY that caused them to consume an extra stack element ("dummy element") after signature validation. Previously, the dummy element was not inspected in any manner, and could be replaced by any value without invalidating the script. BIP147 removed this malleability vector by forcing the dummy element to be an empty byte array and rejecting anything else.

Transaction malleability also affects payment tracking.  Dimecoin Core's RPC interface lets you track transactions by their txid---but if that txid changes because the transaction was modified, it may appear that the transaction has disappeared from the network.

Current best practices for transaction tracking dictate that a transaction should be tracked by the transaction outputs (UTXOs) it spends as inputs, as they cannot be changed without invalidating the transaction.

Best practices further dictate that if a transaction does seem to disappear from the network and needs to be reissued, that it be reissued in a way that invalidates the lost transaction. One method which will always work is to ensure the reissued payment spends all of the same outputs that the lost transaction used as inputs.

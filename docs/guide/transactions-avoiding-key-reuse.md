```{eval-rst}
.. meta::
  :title: Avoiding Key Reuse
  :description: Avoiding key reuse in Dimecoin is the practice of using each public key only twice (to receive and spend a payment) to enhance financial privacy and security.
```

> ***We put our best effort into covering all topics related to Dimecoin. Each section will cover a different category. Not all documentation may be 100% accurate, if you spot an error, please report it or submit a PR request on GitHub.***
>
> ***REMINDER: This documentation is always evolving. If you have not been here for a while, perhaps check again. Things may have been added or updated since your last visit!***

## Avoiding Key Reuse

In a [transaction](../resources/glossary.md#transaction), the spender and receiver each reveal to each other all [public keys](../resources/glossary.md#public-key) or [addresses](../resources/glossary.md#address) used in the transaction. This allows either person to use the public [blockchain](../resources/glossary.md#blockchain) to track past and future transactions involving the other person's same public keys or addresses.

If the same public key is reused often, as happens when people use Dimecoin addresses (hashed public keys) as static payment addresses, other people can easily track the receiving and spending habits of that person, including how many dimecoins they control in known addresses.

This can be avoided if each public key is used exactly twice---once to receive a payment and once to spend that payment. The user can gain a significant amount of financial privacy by following this method of key use.

Avoiding key reuse can also provide security against attacks which might allow reconstruction of [private keys](../resources/glossary.md#private-key) from public keys (hypothesized) or from signature comparisons (possible today under certain circumstances described below, with more general attacks hypothesized).

1. Unique (non-reused) [P2PKH](../resources/glossary.md#pay-to-pubkey-hash) and [P2SH](../resources/glossary.md#pay-to-script-hash) addresses protect against the first type of attack by keeping ECDSA public keys hidden (hashed) until the first time dimecoins sent to those addresses are spent, so attacks are effectively useless unless they can reconstruct private keys in less than the hour or two it takes for a transaction to be well protected by the blockchain.

2. Unique (non-reused) private keys protect against the second type of attack by only generating one signature per private key, so attackers never get a subsequent signature to use in comparison-based attacks. Existing comparison-based attacks are only practical today when insufficient entropy is used in signing or when the entropy used is exposed by some means, such as a [side-channel attack](https://en.wikipedia.org/wiki/Side_channel_attack).

So, for both privacy and security, we encourage you to build your applications to avoid public key reuse and, when possible, to discourage users from reusing addresses. If your application needs to provide a fixed URI to which payments should be sent, please use `dimecoin:` URIs as defined by [BIP21](https://github.com/dime-coin/dimecoin/blob/272dbe4974e09eca6a928ce13b42941b1c28aca2/doc/bips.md?plain=1#L8).

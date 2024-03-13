```{eval-rst}
.. meta::
  :title: Escrow and Arbitration
  :description: A transaction in which a spender and receiver place funds in an m-of-n multisig output so that neither can spend the funds until they’re both satisfied with some external outcome.
```

> ***We put our best effort into covering all topics related to Dimecoin. Each section will cover a different category. Not all documentation may be 100% accurate, if you spot an error, please report it or submit a PR request on GitHub.***
>
> ***REMINDER: This documentation is always evolving. If you have not been here for a while, perhaps check again. Things may have been added or updated since your last visit!***

## Escrow and Arbitration

Alex-the-customer wants to purchase an item from Sam-the-seller, but since trust is lacking between them, they decide to utilize a contract to guarantee that Alex receives the product and Sam receives the payment.

A simple contract could say that Alex will spend dimecoins to an [output](../resources/glossary.md#output) which can only be spent if Alex and Sam both sign the [input](../resources/glossary.md#input) spending it. This arrangement ensures Sam receives payment only if Alex receives the item, while Alex cannot retain both the item and his payment.

This simple contract isn't much help if there's a dispute, so Sam and Alex enlist the help of Jane-the-arbitrator to create an [escrow contract](../resources/glossary.md#escrow-contract). Alex spends his dimecoins to an output which can only be spent if two of the three people sign the input. Now Alex can pay Sam if everything is ok, Sam can refund Alex's money if there's a problem, or Jane can arbitrate and decide who should get the dimecoins if there's a dispute.

To create a multiple-signature ([multisig](../resources/glossary.md#multisig)) output, they each give the others a [public key](../resources/glossary.md#public-key). Then Sam creates the following [P2SH multisig](../resources/glossary.md#p2sh-multisig) [redeem script](../resources/glossary.md#redeem-script):

```text
OP_2 [A's pubkey] [B's pubkey] [C's pubkey] OP_3 OP_CHECKMULTISIG
```

```{note}
Opcodes to push the public keys onto the stack are not shown for brevity.
```

`OP_2` and `OP_3` push the actual numbers 2 and 3 onto the stack. `OP_2` specifies that 2 signatures are required to sign; `OP_3` specifies that 3 public keys (unhashed) are being provided. This is a 2-of-3 multisig pubkey script, more generically called a m-of-n pubkey script (where *m* is the *minimum* matching signatures required and *n* in the *number* of public keys provided).

Sam gives the redeem script to Alex, who checks to make sure his public key and Jane's public key are included. Then he hashes the redeem script to create a [P2SH](../resources/glossary.md#pay-to-script-hash) redeem script and pays the dimecoins to it. Sam sees the payment get added to the [blockchain](../resources/glossary.md#blockchain) and ships the merchandise.

Unfortunately, the merchandise gets slightly damaged in transit. Alex wants a full refund, but Sam thinks a 10% refund is sufficient. They turn to Jane to resolve the issue. Jane asks for photo evidence from Alex along with a copy of the redeem script Sam created and Alex checked.

After looking at the evidence, Jane thinks a 40% refund is sufficient, so she creates and signs a transaction with two outputs, one that spends 60% of the dimecoins to Sam's public key and one that spends the remaining 40% to Alex's public key.

In the [signature script](../resources/glossary.md#signature-script) Jane puts her signature and a copy of the unhashed serialized redeem script that Sam created.  She gives a copy of the incomplete transaction to both Sam and Alex.  Either one of them can complete it by adding his signature to create the following signature script:

```text
OP_0 [A's signature] [B's or C's signature] [serialized redeem script]
```

```{note}
Opcodes to push the public keys onto the stack are not shown for brevity.
```

 `OP_0` is a workaround for an off-by-one error in the original implementation which must be preserved for compatibility.  Note that the signature script must provide signatures in the same order as the corresponding public keys appear in the redeem script.  See the description in [`OP_CHECKMULTISIG`](../reference/transactions-opcodes.md) for details.)

When the transaction is broadcast to the [network](../resources/glossary.md#network), each [peer](../resources/glossary.md#peer) checks the signature script against the P2SH output Alex previously paid, ensuring that the redeem script matches the redeem script hash previously provided. Then the redeem script is evaluated, with the two signatures being used as input data. Assuming the redeem script validates, the two transaction outputs show up in Sam's and Alex's wallets as spendable balances.

However, if Jane created and signed a transaction neither of them would agree to, such as spending all the dimecoins to herself, Sam and Alex can find a new arbitrator and sign a transaction spending the dimecoins to another 2-of-3 multisig redeem script hash, this one including a public key from that second arbitrator. This means that Sam and Alex never need to worry about their arbitrator stealing their money.

```{eval-rst}
.. meta::
  :title: Providing Deposit
  :description: Providing a deposit to another party.
```

> ***We put our best effort into covering all topics related to Dimecoin. Each section will cover a different category. Not all documentation may be 100% accurate, if you spot an error, please report it or submit a PR request on GitHub.***
>
> ***REMINDER: This documentation is always evolving. If you have not been here for a while, perhaps check again. Things may have been added or updated since your last visit!***

## Providing Deposit for a Commitment

Imagine an author, Ella, who wants to publish her novel on an online platform known for exclusive content. To convince the site operators of her commitment, without risking direct payment misuse or platform disappearance, they decide to employ a form of a smart contract.

This process is detailed in steps similar to a financial commitment scenario:

* Ella and the platform exchange newly generated public keys as a first step towards trust.
  
* Ella initiates transaction Tx1 (the deposit), allocating 20,000 dimecoins to an output that necessitates signatures from both herself and the platform, using the platform's provided key. This transaction remains unpublished.
  
* She then shares the hash of Tx1 with the platform.
  
* In response, the platform drafts transaction Tx2 (the return contract). This transaction, designed to return the deposit to Ella, spends Tx1 and directs it back to her original address. However, since it requires dual signatures, Tx2 is inherently incomplete. An [nLockTime](../resources/glossary.md#nlocktime) is set for a future date, say one year, with the input sequence number at zero.
  
* The platform sends this half-signed contract back to Ella for review. Ella verifies that the contract indeed ensures her deposit's return after a year, barring any modifications. She completes the contract by adding her signature where required.
  
* Ella proceeds to broadcast Tx1, followed by Tx2.

This arrangement secures the 20,000 dimecoins in a state unspendable by either party independently. After one year, the smart contract matures, allowing Ella to reclaim her coins, regardless of the platforms's operational status.

Should Ella decide to withdraw her novel from the platform prematurely, the platform can modify Tx2 by zeroing nLockTime and adjusting the input sequence number to UINT_MAX before re-signing. This revised contract is returned to Ella, who, upon signing, broadcasts it to release the funds early.

Conversely, if Ella wishes to extend her novel's stay on the platform as the contract's expiration nears, they can renew the agreement by updating nLockTime and slightly increasing the sequence number from the last contract, then rebroadcasting. Any adjustments to the contract will need joint approval.

In scenarios where Ella's content is identified as violating the platform's policies (e.g., copyright infringement), the platform might refuse early termination of the contract. To prevent such occurrences, the platform might enforce stricter contract terms or increase the deposit for future contracts.

```{eval-rst}
.. meta::
  :title: Crosschain-Trading
  :description: Crosschain-Trading allows two parties to exchange different currencies between one another without the need for a centralized party.
```

> ***We put our best effort into covering all topics related to Dimecoin. Each section will cover a different category. Not all documentation may be 100% accurate, if you spot an error, please report it or submit a PR request on GitHub.***
>
> ***REMINDER: This documentation is always evolving. If you have not been here for a while, perhaps check again. Things may have been added or updated since your last visit!***

## Crosschain-Trading

Leveraging Dimecoin's underlying technology enables the creation of multiple distinct digital currencies. For example, Namecoin is of one such currency that operates under a slightly different set of rules, and can also be used to rent names in a namespace. Currencies that implement the same ideas as Bitcoin-based coins, such as Dimecoin, can be traded freely against each other with limited trust.

Imagine a scenario in which a consortium of banks introduces XYZcoin, a digital currency pegged 1:1 to the real-world deposits within the consortium's accounts. Compared to Dimecoin, this currency introduces a mix of differences: it's more centralized but eliminates foreign exchange risk. There might be an interest in swapping Dimecoin for XYZcoin and vice versa, with the consortium's involvement primarily needed for transitions to and from the traditional banking system.

To facilitate such exchanges, a protocol outlined by crypto-analyst [TierNolan](https://bitcointalk.org/index.php?topic=193281.msg2224949#msg2224949) could be utilized:

* Participant 'A' generates random data, 'x' (the secret).
  
* 'A' assembles Tx1 (the payment), which includes an output featuring the cross-chain trade script. This script, detailed further below, permits releasing coins either through dual signatures ('A' and 'B's keys) or with ('x', 'B's key) but isn't broadcast immediately. It specifies hashes rather than the direct secrets.
  
* 'A' then creates Tx2 (the contract), utilizing Tx1 and directing output to 'A's key with a future lock time and a sequence number of zero to allow modifications. 'A' signs Tx2, sending it to 'B' for an additional signature.
  
* Once signed by both parties, 'A' broadcasts Tx1 and Tx2. 'B' can now view the coins but is unable to spend them due to lacking an output in their favor, and the transaction remains unfinalized.
  
* 'B' replicates this process on a different blockchain, with a significantly shorter lock time than 'A's. This action sets up both sides of the exchange, though still in an incomplete state.
  
* Since 'A' knows the secret 'x,' they can instantly claim their coins, inadvertently revealing 'x' to 'B', who then completes the exchange using ('x', 'B's key).

This protocol enables trades to be conducted automatically in a completely peer-to-peer manner, likely ensuring liquidity.

The cross-chain trade script is formulated as:

```code
IF 
  2 <key A> <key B> 2 CHECKMULTISIGVERIFY
ELSE
  <key B> CHECKSIGVERIFY SHA256 <hash of secret x> EQUALVERIFY
ENDIF
```

The corresponding contract input script can take one of two formats:

```code
<sig A> <sig B> 1
```

or

```code
<secret x> <sig B> 0
```

The first data element indicating which phase of the transaction is active.

See [Atomic cross-chain trading](https://en.bitcoin.it/wiki/Atomic_cross-chain_trading) for more details.

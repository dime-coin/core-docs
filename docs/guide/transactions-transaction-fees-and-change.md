```{eval-rst}
.. meta::
  :title: Transaction Fees and Change
  :description: Transaction fees in Dimecoin depend on transaction size and surplus from UTXOs is returned to the spender as a change output.
```

> ***We put our best effort into covering all topics related to Dimecoin. Each section will cover a different category. Not all documentation may be 100% accurate, if you spot an error, please report it or submit a PR request on GitHub.***
>
> ***REMINDER: This documentation is always evolving. If you have not been here for a while, perhaps check again. Things may have been added or updated since your last visit!***

## Transaction Fees and Change

Transactions pay fees based on the total byte size of the signed transaction. Fees per byte are calculated based on current demand for space in mined or minted blocks with fees rising as demand increases.  The [transaction fee](../resources/glossary.md#transaction-fee) is given to the Dimecoin miner/staker, as explained in the [blockchain section](../guide/blockchain-overview.md), and so it is ultimately up to each [miner](../resources/glossary.md#miner) or [staker](../resources/glossary.md#staker) to choose the minimum transaction fee they will accept.

All transactions are prioritized based on their fee per byte, with higher-paying transactions being added in sequence until all of the available space is filled.

As of Dimecoin Core 1.10.01, a [minimum relay fee](../resources/glossary.md#minimum-relay-fee) (10,000 mDIME) is required to broadcast a transaction across the [network](../resources/glossary.md#network). Any transaction paying only the minimum fee should be prepared to wait before there's enough spare space in a block to include it.

Since each transaction spends Unspent Transaction Outputs (UTXOs) and because a UTXO can only be spent once, the full value of the included UTXOs must be spent or given to a miner or staker as a [transaction fee](../resources/glossary.md#transaction-fee).  Few people will have UTXOs that exactly match the amount they want to pay, so most transactions include a change output.

A [change output](../resources/glossary.md#change-output) is a regular output which spends the surplus dimecoins from the UTXOs back to the spender. Change outputs can reuse the same P2PKH pubkey hash or P2SH script hash as was used in the UTXO, but for the reasons described in the [next subsection](../guide/transactions-avoiding-key-reuse.md), it is highly recommended that change outputs be sent to a new [P2PKH](../resources/glossary.md#pay-to-pubkey-hash) or [P2SH](../resources/glossary.md#pay-to-script-hash) [address](../resources/glossary.md#address).

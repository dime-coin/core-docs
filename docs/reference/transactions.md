
```{eval-rst}
.. meta::
  :title: Transactions, OpCodes, Raw Transaction Format
  :description: A breakdown of Dimecoin transaction structure
```
> ***We put our best effort into covering all topics related to Dimecoin. Each section will cover a different category. Not all documentation may be 100% accurate, if you spot an error, please report it or submit a PR request on GitHub.***
>
> ***REMINDER: This documentation is always evolving. If you have not been here for a while, perhaps check again. Things may have been added or updated since your last visit!***

## Transactions

The following subsections briefly documents Dimecoin's transaction structure.
  
**[Opcodes](transactions-opcodes.md)**  
This section outlines opcodes used in pubkey scripts. Topics include:

* [Opcodes](transactions-opcodes.md): List of Opcodes used in Dimecoin Core transactions.
* [Signature Scripts](transactions-opcodes.md#signature-scripts): Learn about a transactions input structure which provides the cryptographic signature and public keys needed to satisfy the spending conditions.

**[Address Conversion](transactions-address-conversion.md)**  
Focuses on the procesure to encode and decode P2PKH and P2SH outputs. Topics include:

* [Conversion Process](transactions-address-conversion.md#conversion-process): Details outlining the conversion process of Dimecoin addresses.
* [Example](transactions-address-conversion.md#example-code): Exmple of address conversion.

**[Raw Transaction Format](transactions-raw-transaction-format.md)**  
Learn about the format used during the process of broadcasting transactions between peers. Topics include:

* [JSON-RPC Responses](transactions-raw-transaction-format.md#json-rpc-responses): Transaction structure.
* [Example](transactions-raw-transaction-format.md#txout-a-transaction-output): Itemized sample of a raw transaction.

**[CompactSize Unsigned Integers](transactions-opcodes.md)**  
Discover the type of variable-length integer used to indicte the number of bytes in a following piece of data.

```{toctree}
:maxdepth: 2
:titlesonly:

transactions-opcodes
transactions-address-conversion
transactions-raw-transaction-format
transactions-compactsize-unsigned-integers
```

```{eval-rst}
.. meta::
  :title: Address Conversion
  :description: The hashes used in P2PKH and P2SH outputs are commonly encoded as Dimecoin addresses. This is the procedure to encode those hashes and decode the addresses.
```

> ***We put our best effort into covering all topics related to Dimecoin. Each section will cover a different category. Not all documentation may be 100% accurate, if you spot an error, please report it or submit a PR request on GitHub.***
>
> ***REMINDER: This documentation is always evolving. If you have not been here for a while, perhaps check again. Things may have been added or updated since your last visit!***

### Address Conversion

The hashes used in P2PKH and [P2SH outputs](../reference/glossary.md#p2sh-output) are commonly encoded as Dimecoin [addresses](../reference/glossary.md#address).  This is the procedure to encode those hashes and decode the addresses.

#### Conversion Process

First, get your hash.  For P2PKH, you RIPEMD-160(SHA256()) hash a ECDSA [public key](../reference/glossary.md#public-key) derived from your 256-bit ECDSA [private key](../reference/glossary.md#private-key) (random data). For P2SH, you RIPEMD-160(SHA256()) hash a [redeem script](../reference/glossary.md#redeem-script) serialized in the format used in [raw transactions](../reference/glossary.md#raw-transaction) (described in a [following sub-section](../reference/transactions-raw-transaction-format.md)).  Taking the resulting hash:

1. Add an [address](../reference/glossary.md#address) version byte in front of the hash.  Version bytes commonly used by Dimecoin are:

    * 0x4c for [P2PKH addresses](../reference/glossary.md#p2pkh-address) on the main Dimecoin network ([mainnet](../reference/glossary.md#mainnet))

    * 0x8c for [P2PKH addresses](../reference/glossary.md#p2pkh-address) on the Dimecoin testing network ([testnet](../reference/glossary.md#testnet))

    * 0x10 for [P2SH addresses](../reference/glossary.md#p2sh-address) on [mainnet](../reference/glossary.md#mainnet)

    * 0x13 for [P2SH addresses](../reference/glossary.md#p2sh-address) on [testnet](../reference/glossary.md#testnet)

2. Create a copy of the version and hash; then hash that twice with SHA256: `SHA256(SHA256(version . hash))`

3. Extract the first four bytes from the double-hashed copy. These are used as a checksum to ensure the base hash gets transmitted correctly.

4. Append the checksum to the version and hash, and encode it as a [base58](../reference/glossary.md#base58) string: `BASE58(version . hash . checksum)`

#### Example Code

Dimecoin's base58 encoding, called [Base58Check](../reference/glossary.md#base58check) may not match other implementations. Tier Nolan provided the following example encoding algorithm to the Bitcoin Wiki [Base58Check encoding](https://en.bitcoin.it/wiki/Base58Check_encoding) page under the [Creative Commons Attribution 3.0 license](https://creativecommons.org/licenses/by/3.0/):

``` c
code_string = "123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz"
x = convert_bytes_to_big_integer(hash_result)

output_string = ""

while(x > 0)
   {
       (x, remainder) = divide(x, 58)
       output_string.append(code_string[remainder])
   }

repeat(number_of_leading_zero_bytes_in_hash)
   {
   output_string.append(code_string[0]);
   }

output_string.reverse();
```

Dimecoin's own code can be traced using the [base58 header file](https://github.com/dimec-coin/dimecoin/blob/master/src/base58.h).

To convert addresses back into hashes, reverse the base58 encoding, extract the checksum, repeat the steps to create the checksum and compare it against the extracted checksum, and then remove the version byte.

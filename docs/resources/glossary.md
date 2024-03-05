```{eval-rst}
.. _resources-glossary:
```

# Glossary

The following section is dedicated to the key terms, concepts, and jargon related to the project, technology, and industry surrounding Dimecoin. Its primary purpose is to provide readers with clear, concise definitions of specific terminology they might encounter throughout our documentation. This is especially helpful for new users, developers, or participants who may need to become more familiar with the specialized language used in discussions of Dimecoin and its related technology.

### 51% Attack

If more than half the computer power on a network is run by a single person or a single group of people, then a 51% attack is in operation. This means this entity has full control of the network and can negatively affect a cryptocurrency by halting mining, stopping or changing transactions, and reusing coins.

### Address

Every cryptocurrency coin has a unique address that identifies where it sits on the blockchain. It’s this address, this location, at which the coin’s ownership data is stored and where any changes are registered when it is traded. These addresses differ in appearance between cryptocurrencies but are usually a string of more than 30 characters.

### Airdrop

This is a marketing campaign that refers to the expedited distribution of a cryptocurrency through a population of people. It usually occurs when the creator of a cryptocurrency provides its coin to low-ranked traders or existing community members in order to build their use and popularity. They are usually given away for free or in exchange for simple tasks like sharing news of the coin with friends.

### Algorithm

Mathematic instructions coded into and implemented by computer software in order to produce a desired outcome.

### All Time High

The highest price ever achieved by a cryptocurrency.

### All Time Low

The lowest price ever achieved by a cryptocurrency.

### Altcoins

Bitcoin was the first and is the most successful of all the cryptocurrencies. All the other coins are grouped together under the category of altcoins. Dimecoin, for example, is an altcoin, as is Ethereum.

### AML

Acronym for “Anti-Money Laundering”.

### Application Specific Integrated Circuit

A piece of computer hardware – similar to a graphics card or a CPU – that has been designed specifically to mine cryptocurrency. They are built specifically to solve hashing problems efficiently.

### Arbitrage

There are multiple exchanges at any given time trading in the same cryptocurrency, and they can do so at different rates. Arbitrage is the act of buying from one exchange and then selling it to the next exchange if there is a margin between the two that is profitable.

### ASIC

Acronym for “Application Specific Integrated Circuit”

### ATH

Acronym for “All Time High”

### ATL

Acronym for “All Time Low”

### Atomic Swap

A way of letting people directly and cost-effectively exchange one type of cryptocurrency for another, at current rates, without needing to buy or sell.

### Base58

The method used in Dimecoin for converting 160-bit hashes into P2PKH and P2SH addresses. Also used in other parts of Dimecoin, such as encoding private keys for backup in WIP format. Not the same as other base58 implementations.

### Base58check

The method used in Dimecoin for converting 160-bit hashes into P2PKH and P2SH addresses. Also used in other parts of Dimecoin, such as encoding private keys for backup in WIP format. Not the same as other base58 implementations.

### BIP32

The Hierarchical Deterministic (HD) key creation and transfer protocol (BIP32), which allows creating child keys from parent keys in a hierarchy. Wallets using the HD protocol are called HD wallets.

### Bitcoin

The very first cryptocurrency. It was created in 2008 by an individual or group of individuals operating under the name Satoshi Nakamoto. It was intended to be a peer-to-peer, decentralized electronic cash system.

The protocol defined in BIP70 (and other BIPs) which lets spenders get signed payment details from receivers.

### Block

The blockchain is made up of blocks. Each block holds a historical database of all cryptocurrency transactions made until the block is full. It’s a permanent record, like a bag of data that can be opened and viewed at any time.

### Blockchain

The blockchain is a digital ledger of all the transactions ever made in a particular cryptocurrency. It’s comprised of individual blocks (see definition above) that are chained to each other through a cryptographic signature. Each time a block’s capacity is reached, a new block is added to the chain. The blockchain is repeatedly copied and saved onto thousands of computers all around the world, and it must always match each copy. As there is no master copy stored in one location, it’s considered decentralized.

### Block Header

An 80-byte header belonging to a single block which is hashed repeatedly to create proof of work.

### Block Height

Refers to the number of blocks connected in the blockchain. For example, Height 0 would be the very first block, which is also called the genesis block.

### Block Reward

A form of incentive for the miner who successfully calculates the hash (verification) in a block. Verification of transactions on the blockchain generates new coins in the process, and the miner is rewarded with a portion of these.

### Block Subsidy

The amount of Dimecoin created in each new block. It comprises the non-fee part of the [block reward](#block-reward).

### Block Size Limit

The maximum size in bytes that consensus rules allow for a given block.

### Blocks-First Sync

THe process of downloading each block in the blockchain sequentially from a network peer and validating each one to ensure the integrity and continuity of the chain.

### blocktransactions

A data structure within peer-to-peer networking that serves to deliver a subset of transactions contained within a block, in response to specific requests.

### blocktransactionsrequest

A peer-to-peer networking data structure designed for specifying the indexes of transactions within a block that are being requested by a peer.

### Bloom Filter

A mechanism predominantly utilized by Simplified Payment Verification (SPV) clients to selectively request transactions and Merkle blocks that match specific criteria from full nodes.

### Chain Code

A 256-bit entropy value used within Hierarchical Deterministic (HD) wallets, enhancing the security of child key generation by being combined with both public and private keys. Typically, the master chain code is generated from a seed, alongside the master private key.

### Chainlock

ChainLocks represent a mechanism designed to achieve rapid consensus on the validity of a blockchain. By employing Long-Living Masternode Quorums, ChainLocks provide a defense against 51 percent attacks and diminish the ambiguity associated with fund reception, ensuring a more secure and reliable transaction verification process.

### Chain Linking

Each cryptocurrency has its own blockchain – the digital ledger that stores all transaction records. Chain linking is the process that occurs if you transfer one cryptocurrency to another. This requires the transaction to be lodged in two separate blockchains, so they must link together to achieve the goal.

### Change output

A transaction component that routes dimecoins back to the spender.

### Child key

In HD wallets, a key derived from a parent key. The key can be either a private key or a public key.

### Child pays for parent

Selecting transactions for mining not just based on their fees but also based on the fees of their ancestors and descendants (parents and children).

### Cipher

The name given to the algorithm that encrypts and decrypts information.

### Circulating Supply

The total number of coins in a cryptocurrency that are in the publicly tradable space is considered the circulating supply. Some coins can be locked, reserved or burned, therefore unavailable to public trading.

### Coinbase

A special field used as the sole input for coinbase transactions. The coinbase allows claiming the block reward and provides up to 100 bytes for arbitrary data.

### Coinbase block height

The current block's height encoded into the first bytes of the coinbase field.

### Coinbase transaction

The first transaction in a block, includes a single coinbase.

### Cold Storage

Term used for an offline wallet i.e. paperwallet (see below).

### CompactSize

A type of variable-length integer commonly used in the Dimecoin P2P protocol and Dimecoin serialized data structures.

### Compressed public key

An ECDSA public key that is 33 bytes long rather than the 65 bytes of an uncompressed public key.

### Confirmations

A score indicating the number of blocks on the best block chain that would need to be modified to remove or modify a particular transaction. A confirmed transaction has a confirmation score of one or higher.

### Consensus

When a transaction is made, all nodes on the network verify that it is valid on the blockchain, and if so, they have a consensus.

### Consensus Process
Refers to those nodes that are responsible for maintaining the blockchain ledger so that a consensus can be reached when a transaction is made.

### Consensus Rules

The block validation rules that full nodes follow to stay in consensus with other nodes.

### Cryptocurrency

A form of money that exists as encrypted, digital information. Operating independently of any banks, a cryptocurrency uses sophisticated mathematics to regulate the creation and transfer of funds between entities.

### Cryptographic Hash Function

This process happens on a node and involves converting an input – such as a transaction – into a fixed, encrypted alphanumeric string that registers its place in the blockchain. This conversion is controlled by a hashing algorithm, which is different for each cryptocurrency.

### Cryptography

The process of encrypting and decrypting information.

### Data-pushing opcode

Any opcode from 0x01 to 0x4e which pushes data on to the script evaluation stack.

### Difficulty

When someone refers to difficulty in the cryptocurrency space, they are referring to the cost of mining in that moment in time. The more transactions that are trying to be confirmed at any single moment in time, divided by the total power of the nodes on the network at that time, defines the difficulty. The higher the difficulty, the greater the transaction fee – this is a fluid measurement that moves over time.

### DNS seed

A DNS server which returns IP addresses of full nodes on the Dimecoin network to assist in peer discovery.

### Double Spend

This occurs when someone tries to send a cryptocurrency to two different wallets or locations at the same time.

### ECDSA Private Key

The private portion of a keypair which can create signatures that other people can verify using the public key.

### ECDSA Signatures

A value related to a public key which could only have reasonably been created by someone who has the private key that created that public key. Used in Dimecoin to authorize spending dimecoins previously sent to a public key.

### Escrow

When an intermediary is used to hold funds during a transaction, those funds are being held in escrow. This is usually a third party between the entity sending and the one receiving.

### Fork

When a new version of a blockchain is created, resulting in two versions of the blockchain running side-by-side, it is termed a fork. As a single blockchain forks into two, they will both run on the same network. Forks are categorized into two categories: soft or hard.

### Full Node

Some nodes download a blockchain’s entire history in order to enforce and validate its rules completely. As they fully enforce the rules, they are considered a full node.

### Genesis Block

The first block in the Dimecoin blockchain. Occurred December, 23, 2013. 

### Halving

Every time miners approve transactions on the bitcoin blockchain, they earn bitcoin. As each block on the blockchain fills up with transactions, a certain amount of bitcoin enter the marketplace. However, the number of bitcoin that will ever be created is finite, locked at 21 million. In order to ensure this cap is kept, the amount of bitcoin earned by miners for filling one block is halved at the completion of that block. This is called halving. For the record, by the year 2140, all 21 million bitcoin will be in circulation.

### Hard Fork

A fork in the blockchain that converts transactions previously labeled invalid to valid, and vice versa. For this fork to work, all nodes on the network must upgrade to the newest protocol.

### Hardware Wallet

A physical device, similar to a USB stick, that stores cryptocurrency in its encrypted form. It’s considered the most secure way to hold cryptocurrency.

### Hash

The shorthand for cryptographic hash function (see description above).

### Hashing Power

The hash rate of a computer, measured in kH/s, MH/s, GH/s, TH/s, PH/s or EH/s depending on the hashes per second being produced. 1,000 kH/s = 1 MH/s, 1,000 MH/s = 1 GH/s and so forth.

### HD Wallet

An HD Wallet, based on the Hierarchical Deterministic (HD) protocol (BIP32), facilitates the generation of child keys from a parent key in a structured hierarchy, streamlining key management and security.

### HD Wallet Seed

This is a concise value that serves as the foundation for generating both the master private key and the master chain code in an HD wallet, marking the initial step in securing and structuring the wallet's key system.

### Header

An 80-byte header belonging to a single block which is hashed repeatedly to create proof of work.

### Header Chain

A sequence of block headers where each header is connected to its preceding one, forming a continuous chain. The chain that presents the highest difficulty in terms of recreation is considered the optimal header chain.

### Headers-first sync

Headers-First Sync involves the process of aligning with the blockchain by initially downloading the headers of blocks prior to acquiring the complete blocks themselves.

### Index

An index number used in the HD wallet formula to generate child keys from a parent key

### Initial Block Download (IBD)

Initial Block Download (IBD) refers to the method employed by a new or long-disconnected node to download a substantial quantity of blocks, aiming to synchronize with the current endpoint of the most valid blockchain.

### Input

An input in a transaction which contains three fields: an outpoint, a signature script, and a sequence number. The outpoint references a previous output and the signature script allows spending it.

### Internal byte order

The standard order in which hash digests are displayed as strings—the same format used in serialized blocks and transactions.

### Key Pair

A private key and its derived public key.

### Locktime

Part of a transaction which indicates the earliest time or earliest block when that transaction may be added to the block chain.

### Long-Living Masternode Quorum

Long-Living Masternode Quorums (LLMQs) are a Dash innovation that Dimecoin has implemented which enables masternodes to perform threshold signing of consensus-related messages (e.g. InstantSend transactions). LLMQs provide a more scalable, general use quorum system than the ephemeral ones used prior to Dash Core version 0.14.

### LWMA-3

An open source difficulty-adjusting algorithm for Bitcoin-based cryptocurrencies. Difficulty adjusts every block based on historical statistical data to ensure consistent block issuance regardless of hash rate fluctuation.

### M-of-N Multisig

A type of pubkey script that specifies n public keys and mandates that the accompanying signature script must include at least m valid signatures corresponding to these public keys.

### Mainnet

The original and main network for Dimecoin transactions.

### Majority Hash Rate Attack

The ability of someone controlling a majority of network hash rate to revise transaction history and prevent new transactions from confirming.

### Malleability

The ability of someone to change (mutate) unconfirmed transactions without making them invalid, which changes the transaction's txid, making child transactions invalid.

### Master Private Key

In HD wallets, the master chain code and master private key are the two pieces of data derived from the root seed.

### Masternode

A computer that provides second-tier Dimecoin functionality. Masternodes are incentivized by receiving part of the block reward, but must hold 500,000 DIME as collateral to prevent sybil attacks.

### Merkle block

A partial merkle tree connecting transactions matching a bloom filter to the merkle root of a block.

### Merkle root

The root node of a merkle tree, a descendant of all the hashed pairs in the tree. Block headers must include a valid merkle root descended from all transactions in that block.

### Merkle tree

A tree constructed by hashing paired data (the leaves), then pairing and hashing the results until a single hash remains, the merkle root. In Dimecoin, the leaves are almost always transactions from a single block.

### Message header

The four header fields prefixed to all messages on the Dimecoin P2P network.

### Miner

Mining is the act of creating valid Dimecoin blocks, which requires demonstrating proof of work, and miners are devices that mine or people who own those devices.

### Miner Activated Soft Fork

A Soft Fork activated by through miner signaling.

### Miner Fee

The amount remaining when the value of all outputs in a transaction are subtracted from all inputs in a transaction; the fee is paid to the miner who includes that transaction in a block.

### Miners

Mining is the act of creating valid Dimecoin blocks, which requires demonstrating proof of work, and miners are devices that mine or people who own those devices.

### Minimum Relay Fee

The minimum transaction fee a transaction must pay for a full node to relay that transaction to other nodes. There is no one minimum relay fee---each node chooses its own policy.

### Mining

The term, somewhat confusingly, given to the process of verifying transactions on a blockchain. In the process of solving the encryption challenges, the person donating the computer power is granted new fractions of the cryptocurrency.

### Multi-Phased Fork

A spork is a mechanism unique to Dimecoin used to safely deploy new features to the network through network-level variables to avoid the risk of unintended network forking during upgrades.

### Mining Pool

If a number of miners combine their computing power together to try and help complete the transactions required to start a new block in the blockchain, they are in a mining pool. The rewards are spread proportionately between those in the mining pool based on the amount of power they contributed. The idea is that being in a mining pool allows for better chances of successful hashing and therefore getting enough cryptocurrency reward to produce an income.

### Multisig

A pubkey script that provides *n* number of pubkeys and requires the corresponding signature script provide *m* minimum number signatures corresponding to the provided pubkeys.

### Multi-Pool Mining

If a miner moves from one cryptocurrency blockchain to another depending on the profitability provided by the network at that moment in time, they are engaging in multi-pool mining.

### nBits

The target is the threshold below which a block header hash must be in order for the block to be valid, and nBits is the encoded form of the target threshold as it appears in the block header.

### Network

The Dimecoin P2P network which broadcasts transactions and blocks.

### Network Magic

Four defined bytes which start every message in the Dimecoin P2P protocol to allow seeking to the next message.

### nLockTime

Part of a transaction which indicates the earliest time or earliest block when that transaction may be added to the block chain.

### Node

Any computer that is connected to a blockchain’s network is referred to as a node.

### Nonce

When a miner hashes a transaction, a random number is generated, called a nonce. The parameters from which that number is chosen change based on the difficulty of the transaction.

### Null Data (OP_RETURN) Transaction

A transaction type that adds arbitrary data to a provably unspendable pubkey script that full nodes don't have to store in their UTXO database.

### Opcode

Operation codes from the Dimecoin Script language which push data or perform functions within a pubkey script or signature script.

### Orphan Block

Blocks whose parent block has not been processed by the local node, so they can't be fully validated yet.

### Outpoint

The data structure used to refer to a particular transaction output, consisting of a 32-byte TXID and a 4-byte output index number (vout).

### Output

An output in a transaction which contains two fields: a value field for transferring zero or more dimecoins and a pubkey script for indicating what conditions must be fulfilled for those dimecoins to be further spent.

### Output Index

The sequentially-numbered index of outputs in a single transaction starting from 0.

### P2PKH address

A Dimecoin payment address comprising a hashed public key, allowing the spender to create a standard pubkey script that Pays To PubKey Hash (P2PKH).

### P2SH address

A Dimecoin payment address comprising a hashed script, allowing the spender to create a standard pubkey script that Pays To Script Hash (P2SH). The script can be almost any valid pubkey script.

### P2SH multisig

A P2SH output where the redeem script uses one of the multisig opcodes. Up until Bitcoin Core 0.10.0, P2SH multisig scripts were standard transactions, but most other P2SH scripts were not.

### P2SH output

A Dimecoin payment address comprising a hashed script, allowing the spender to create a standard pubkey script that Pays To Script Hash (P2SH). The script can be almost any valid pubkey script.

### P2SH pubkey script

A Dimecoin payment address comprising a hashed script, allowing the spender to create a standard pubkey script that Pays To Script Hash (P2SH). The script can be almost any valid pubkey script.

### Pay To PubKey Hash

A Dimecoin payment address comprising a hashed public key, allowing the spender to create a standard pubkey script that Pays To PubKey Hash (P2PKH).

### Pay To Script Hash

A Dimecoin payment address comprising a hashed script, allowing the spender to create a standard pubkey script that Pays To Script Hash (P2SH). The script can be almost any valid pubkey script.

### Payment Protocol

The protocol defined in BIP70 (and other BIPs) which lets spenders get signed payment details from receivers.

### Peer

A computer that connects to the Dimecoin network.

### Point Function

The ECDSA function used to create a public key from a private key.

### Previous Block Header Hash

A field in the block header which contains the SHA256(SHA256()) hash of the previous block's header.

### Private Key

A string of numbers and letters that are used to access your wallet. While your wallet is represented by a public key, the private key is the password you should protect (with your life). You need your private key when selling or withdrawing cryptocurrencies, as it acts as your digital signature.

### Proof of Stake (PoS)

Another alternative to proof of work, this caps the reward given to miners for providing their computational power to the network at that miner’s investment in the cryptocurrency. So if a miner holds three coins, they can only earn three coins. The system encourages miners to stick with a certain blockchain rather than converting their rewards to an alternate cryptocurrency.

### Proof of Work

A hash below a target value which can only be obtained, on average, by performing a certain amount of brute force work---therefore demonstrating proof of work.

### Protocols

The set of rules that defines how data is exchanged across a network.

### Pubkey script

A script included in outputs which sets the conditions that must be fulfilled for those dimecoins to be spent. Data for fulfilling the conditions can be provided in a signature script. Pubkey Scripts are called a scriptPubKey in code.

### Public key

This is your unique wallet address, which appears as a long string of numbers and letters. It is used to receive cryptocurrencies.

### Raw Block

A complete block in its binary format---the same format used to calculate total block byte size; often represented using hexadecimal.

### Raw Format

Complete transactions in their binary format; often represented using hexadecimal. Sometimes called raw format because of the various Dimecoin Core commands with "raw" in their names.

### Raw Transaction

Complete transactions in their binary format; often represented using hexadecimal. Sometimes called raw format because of the various Dimecoin Core commands with "raw" in their names.

### Replace-By-Fee

NOT IMPLEMENTED IN DASH. Replacing one version of an unconfirmed transaction with a different version of the transaction that pays a higher transaction fee. May use BIP125 signaling.

### Redeem Script

A script similar in function to a pubkey script. One copy of it is hashed to create a P2SH address (used in an actual pubkey script) and another copy is placed in the spending signature script to enforce its conditions.

### Regression Test Mode

A local testing environment in which developers can almost instantly generate blocks on demand for testing events, and can create private dimecoins with no real-world value.

### Root Seed

A potentially-short value used as a seed to generate the master private key and master chain code for an HD wallet.

### RPC Byte Order

A hash digest displayed with the byte order reversed; used in Dimecoin Core RPCs, many block explorers, and other software.

### ScriptSig

Data generated by a spender which is almost always used as variables to satisfy a pubkey script. Signature Scripts are called scriptSig in code.

### secp256k1 Signatures

A value related to a public key which could only have reasonably been created by someone who has the private key that created that public key. Used in Dimecoin to authorize spending dimecoins previously sent to a public key.

### Segregated Witness

The processes of separating digital signature data from transaction data. This lets more transactions fit onto one block in the blockchain, improving transaction speeds.

### SEGWIT

Acronym for “segregated witness”.

### Sequence Number

Part of all transactions. A number intended to allow unconfirmed time-locked transactions to be updated before being finalized; not currently used except to disable locktime in a transaction

### Serialized Block

A complete block in its binary format---the same format used to calculate total block byte size; often represented using hexadecimal.

### Serialized Transaction

Complete transactions in their binary format; often represented using hexadecimal. Sometimes called raw format because of the various Dimecoin Core commands with "raw" in their names.

### SIGHASH Flag

A flag to Dimecoin signatures that indicates what parts of the transaction the signature signs. (The default is SIGHASH_ALL.) The unsigned parts of the transaction may be modified.

### SIGHASH_ALL

Default signature hash type which signs the entire transaction except any signature scripts, preventing modification of the signed parts.

### SIGHASH_ANYONECANPAY

A signature hash type which signs only the current input.

### SIGHASH_NONE

Signature hash type which only signs the inputs, allowing anyone to change the outputs however they'd like.

### SIGHASH_SINGLE

Signature hash type that signs the output corresponding to this input (the one with the same index value), this input, and any other inputs partially. Allows modification of other outputs and the sequence number of other inputs.

### Signature

A value related to a public key which could only have reasonably been created by someone who has the private key that created that public key. Used in Dimecoin to authorize spending dimecoins previously sent to a public key.

### Signature Hash

A flag to Dimecoin signatures that indicates what parts of the transaction the signature signs. (The default is SIGHASH_ALL.) The unsigned parts of the transaction may be modified.

### Signature Script

Data generated by a spender which is almost always used as variables to satisfy a pubkey script. Signature Scripts are called scriptSig in code.

### Simplified Payment Verification

A method for verifying if particular transactions are included in a block without downloading the entire block. The method is used by some lightweight clients.

### Soft Fork

A fork in a blockchain protocol where previously valid transactions become invalid. A soft fork is backwards-compatible, as the old nodes running the old protocol will still consider new transactions valid, rather than disregarding them. For a soft fork to work, a majority of the miners powering the network will need to upgrade to the new protocol.

### Software Wallet

A common form of wallet where the private key for an individual is stored within software files on a computer. This is the system you are likely to use if you sign up for a wallet online that is not associated with an exchange.

### Special Transactions

Special Transactions provide a way to include non-financial, consensus-assisting metadata (e.g. masternode lists) on-chain.

### Spork

A spork is a mechanism unique to Dimecoin used to safely deploy new features to the network through network-level variables to avoid the risk of unintended network forking during upgrades.

### Stale Block

Blocks which were successfully mined or staked but which aren't included on the current best block chain, likely because some other block at the same height had its chain extended first.

### Standard Block Relay

The regular block relay method: announcing a block with an inv message and waiting for a response.

### Standard Transaction

A transaction that passes Dimecoin Core's IsStandard() and IsStandardTx() tests. Only standard transactions are mined or broadcast by peers running the default Dimecoin Core software.

### Start String

Four defined bytes which start every message in the Dimecoin P2P protocol to allow seeking to the next message.

### Target

The target is the threshold below which a block header hash must be in order for the block to valid, and nBits is the encoded form of the target threshold as it appears in the block header.

### Testnet

When a cryptocurrency creator is testing out a new version of a blockchain, it does so on a testnet. This runs like a second version of the blockchain but doesn’t impact the value associated with the primary, active blockchain.

### Transaction

The value of cryptocurrency moved from one entity to another on a blockchain network.

### Transaction fee

Usually very small fees given to the miners involved in successfully approving a transaction on the blockchain. This fee can vary depending on the difficulty involved in a transaction and overall network capabilities at that moment in time. If an exchange is involved in facilitating that transaction, it could also take a cut of the overall transaction fee.

### Transaction identifiers

Identifiers used to uniquely identify a particular transaction; specifically, the sha256d hash of the transaction. Also known as TXIDs.

### Transaction version number

A version number prefixed to transactions to allow upgrading.

### Unconfirmed Transaction

When a transaction is proposed, it is unconfirmed until the network has examined the blockchain to ensure that there are no other transactions pending involving that same coin. In the unconfirmed state, the transaction has not been appended to the blockchain.

### Unspent Transaction Output
This refers to the amount of cryptocurrency sent to an entity but not sent on elsewhere. These amounts are considered unspent and are the data stored in the blockchain.

### Unencrypted Wallet

A wallet that has not been encrypted with the encryptwallet RPC.

### Unique Addresses

Address which are only used once to protect privacy and increase security.

### Unlocked wallet

An encrypted wallet that has been unlocked with the walletpassphrase RPC.

### Unsolicited block push

When a miner sends a block message without sending an inv message first.

### Unspent transaction output

An Unspent Transaction Output (UTXO) that can be spent as an input in a new transaction.

### User Activated Soft Fork

A Soft Fork activated by flag day or node enforcement instead of miner signaling.

### Wallet

A wallet is defined by a unique code that represents its “address” on the blockchain. The wallet address is public, but within it is a number of private keys determining ownership of the balance and the balance itself. It can exist in software, hardware, paper or other forms.

### Wallet Import Format

A data interchange format designed to allow exporting and importing a single private key with a flag indicating whether or not it uses a compressed public key.

### Watch-Only Address

An address or pubkey script stored in the wallet without the corresponding private key, allowing the wallet to watch for outputs but not spend them.



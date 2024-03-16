#!/bin/bash

# Replace readme.io's proprietary <<glossary:term>> syntax with markdown links to the terms on the
# glossary page (glossary.md)
find . -iname "*.md" -exec perl -i -pe's~<<glossary:51 percent attack>>~[51 percent attack](../reference/glossary.md#51-percent-attack)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:address>>~[address](../reference/glossary.md#address)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:addresses>>~[addresses](../reference/glossary.md#address)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:base58>>~[base58](../reference/glossary.md#base58)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:base58check>>~[base58check](../reference/glossary.md#base58check)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:Base58Check>>~[Base58Check](../reference/glossary.md#base58check)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:BIP32>>~[BIP32](../reference/glossary.md#bip32)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:BIP70 payment protocol>>~[BIP70 payment protocol](../reference/glossary.md#bip70-payment-protocol)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:block>>~[block](../reference/glossary.md#block)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:blocks>>~[blocks](../reference/glossary.md#block)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:blocks-first>>~[blocks-first](../reference/glossary.md#blocks-first-sync)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:block chain>>~[block chain](../reference/glossary.md#block-chain)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:block header>>~[block header](../reference/glossary.md#block-header)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:Block headers>>~[Block headers](../reference/glossary.md#block-header)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:block height>>~[block height](../reference/glossary.md#block-height)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:block reward>>~[block reward](../reference/glossary.md#block-reward)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:bloom filter>>~[bloom filter](../reference/glossary.md#bloom-filter)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:masternode>>~[masternode](../reference/glossary.md#masternode)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:masternodes>>~[masternodes](../reference/glossary.md#masternode)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:Masternodes>>~[Masternodes](../reference/glossary.md#masternode)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:block size limit>>~[block size limit](../reference/glossary.md#block-size-limit)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:blocks-first-sync>>~[blocks-first-sync](../reference/glossary.md#blocks-first-sync)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:blocktransactions>>~[blocktransactions](../reference/glossary.md#blocktransactions)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:blocktransactionsrequest >>~[blocktransactionsrequest ](../reference/glossary.md#blocktransactionsrequest s)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:chain code>>~[chain code](../reference/glossary.md#chain-code)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:ChainLock>>~[ChainLock](../reference/glossary.md#chainlock)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:ChainLocks>>~[ChainLocks](../reference/glossary.md#chainlock)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:change>>~[change](../reference/glossary.md#change)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:change output>>~[change output](../reference/glossary.md#change-output)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:child key>>~[child key](../reference/glossary.md#child-key)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:child pays for parent>>~[child pays for parent](../reference/glossary.md#child-pays-for-parent)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:cpfp>>~[cpfp](../reference/glossary.md#cpfp)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:coinbase>>~[coinbase](../reference/glossary.md#coinbase)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:coinbase field>>~[coinbase field](../reference/glossary.md#coinbase)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:coinbase block height>>~[coinbase block height](../reference/glossary.md#coinbase-block-height)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:coinbase transaction>>~[coinbase transaction](../reference/glossary.md#coinbase-transaction)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:coinjoin>>~[coinjoin](../reference/glossary.md#coinjoin)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:compactSize uint>>~[compactSize uint](../reference/glossary.md#compactsize)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:CompactSize unsigned integer>>~[CompactSize unsigned integer](../reference/glossary.md#compactsize)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:CompactSize unsigned integers>>~[CompactSize unsigned integers](../reference/glossary.md#compactsize)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:compressed public key>>~[compressed public key](../reference/glossary.md#compressed-public-key)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:confirmations>>~[confirmations](../reference/glossary.md#confirmations)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:confirmation score>>~[confirmation score](../reference/glossary.md#confirmation-score)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:RBF>>~[RBF](../reference/glossary.md#rbf)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:consensus>>~[consensus](../reference/glossary.md#consensus)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:consensus rules>>~[consensus rules](../reference/glossary.md#consensus-rules)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:data-pushing opcode>>~[data-pushing opcode](../reference/glossary.md#data-pushing-opcode)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:Decentralized Governance By Blockchain>>~[Decentralized Governance By Blockchain](../reference/glossary.md#decentralized-governance-by-blockchain)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:denominations>>~[denominations](../reference/glossary.md#denominations)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:devnet>>~[devnet](../reference/glossary.md#devnet)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:difficulty>>~[difficulty](../reference/glossary.md#difficulty)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:DNS seeds>>~[DNS seeds](../reference/glossary.md#dns-seed)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:double spend>>~[double spend](../reference/glossary.md#double-spend)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:duffs>>~[duffs](../reference/glossary.md#duffs)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:ECDSA private key>>~[ECDSA private key](../reference/glossary.md#ecdsa-private-key)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:ECDSA signatures>>~[ECDSA signatures](../reference/glossary.md#ecdsa-signatures)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:escrow contract>>~[escrow contract](../reference/glossary.md#escrow-contract)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:Evolution>>~[Evolution](../reference/glossary.md#evolution)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:extended key>>~[extended key](../reference/glossary.md#extended-key)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:extended private key>>~[extended private key](../reference/glossary.md#extended-private-key)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:fork>>~[fork](../reference/glossary.md#fork)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:genesis block>>~[genesis block](../reference/glossary.md#genesis-block)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:hard fork>>~[hard fork](../reference/glossary.md#hard-fork)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:hardened extended key>>~[hardened extended key](../reference/glossary.md#hardened-extended-key)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:hardened extended private key>>~[hardened extended private key](../reference/glossary.md#hardened-extended-private-key)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:HD protocol>>~[HD protocol](../reference/glossary.md#bip32)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:HD wallet>>~[HD wallet](../reference/glossary.md#hd-wallet)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:HD wallet seed>>~[HD wallet seed](../reference/glossary.md#hd-wallet-seed)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:header>>~[header](../reference/glossary.md#header)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:headers>>~[headers](../reference/glossary.md#header)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:header chain>>~[header chain](../reference/glossary.md#header-chain)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:headerandshortids>>~[headerandshortids](../reference/glossary.md#headerandshortids)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:headers-first>>~[headers-first](../reference/glossary.md#headers-first-sync)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:high-priority transaction>>~[high-priority transaction](../reference/glossary.md#high-priority-transaction)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:IBD>>~[IBD](../reference/glossary.md#initial-block-download)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:index>>~[index](../reference/glossary.md#index)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:initial block download>>~[initial block download](../reference/glossary.md#initial-block-download)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:input>>~[input](../reference/glossary.md#input)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:inputs>>~[inputs](../reference/glossary.md#input)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:InstantSend>>~[InstantSend](../reference/glossary.md#instantsend)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:internal byte order>>~[internal byte order](../reference/glossary.md#internal-byte-order)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:inventory>>~[inventory](../reference/glossary.md#inventory)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:inventories>>~[inventories](../reference/glossary.md#inventory)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:key index>>~[key index](../reference/glossary.md#key-index)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:key pair>>~[key pair](../reference/glossary.md#key-pair)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:locktime>>~[locktime](../reference/glossary.md#locktime)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:LLMQ>>~[LLMQ](../reference/glossary.md#long-living-masternode-quorum)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:Long-Living Masternode Quorum>>~[Long-Living Masternode Quorum](../reference/glossary.md#long-living-masternode-quorum)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:M-of-N multisig>>~[M-of-N multisig](../reference/glossary.md#m-of-n-multisig)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:mainnet>>~[mainnet](../reference/glossary.md#mainnet)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:Majority Hash Rate Attack>>~[Majority Hash Rate Attack](../reference/glossary.md#majority-hash-rate-attack)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:malleability>>~[malleability](../reference/glossary.md#malleability)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:master chain code and private key>>~[master chain code and private key](../reference/glossary.md#master-chain-code-and-private-key)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:master chain code>>~[master chain code](../reference/glossary.md#master-chain-code-and-private-key)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:master private key>>~[master private key](../reference/glossary.md#master-private-key)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:merkle block>>~[merkle block](../reference/glossary.md#merkle-block)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:merkle blocks>>~[merkle blocks](../reference/glossary.md#merkle-block)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:merkle root>>~[merkle root](../reference/glossary.md#merkle-root)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:merkle tree>>~[merkle tree](../reference/glossary.md#merkle-tree)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:message header>>~[message header](../reference/glossary.md#message-header)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:miner>>~[miner](../reference/glossary.md#miner)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:Miner Activated Soft Fork>>~[Miner Activated Soft Fork](../reference/glossary.md#miner-activated-soft-fork)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:minimum relay fee>>~[minimum relay fee](../reference/glossary.md#minimum-relay-fee)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:mining>>~[mining](../reference/glossary.md#mining)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:multi-phased fork>>~[multi-phased fork](../reference/glossary.md#multi-phased-fork)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:multisig>>~[multisig](../reference/glossary.md#multisig)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:nBits>>~[nBits](../reference/glossary.md#nbits)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:network>>~[network](../reference/glossary.md#network)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:node>>~[node](../reference/glossary.md#node)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:nodes>>~[nodes](../reference/glossary.md#node)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:null data (OP_RETURN) transaction>>~[null data (OP_RETURN) transaction](../reference/glossary.md#null-data-op_return-transaction)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:opcode>>~[opcode](../reference/glossary.md#opcode)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:opcodes>>~[opcodes](../reference/glossary.md#opcode)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:orphan block>>~[orphan block](../reference/glossary.md#orphan-block)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:orphan blocks>>~[orphan blocks](../reference/glossary.md#orphan-block)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:outpoint>>~[outpoint](../reference/glossary.md#outpoint)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:output>>~[output](../reference/glossary.md#output)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:outputs>>~[outputs](../reference/glossary.md#output)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:output index>>~[output index](../reference/glossary.md#output-index)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:P2PKH>>~[P2PKH](../reference/glossary.md#pay-to-pubkey-hash)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:P2PKH address>>~[P2PKH address](../reference/glossary.md#p2pkh-address)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:P2PKH addresses>>~[P2PKH addresses](../reference/glossary.md#p2pkh-address)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:P2SH>>~[P2SH](../reference/glossary.md#pay-to-script-hash)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:P2SH address>>~[P2SH address](../reference/glossary.md#p2sh-address)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:P2SH addresses>>~[P2SH addresses](../reference/glossary.md#p2sh-address)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:P2SH multisig>>~[P2SH multisig](../reference/glossary.md#p2sh-multisig)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:P2SH outputs>>~[P2SH outputs](../reference/glossary.md#p2sh-output)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:P2SH pubkey script>>~[P2SH pubkey script](../reference/glossary.md#p2sh-pubkey-script)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:parent chain code>>~[parent chain code](../reference/glossary.md#parent-chain-code)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:parent key>>~[parent key](../reference/glossary.md#parent-key)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:payment protocol>>~[payment protocol](../reference/glossary.md#payment-protocol)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:peer>>~[peer](../reference/glossary.md#peer)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:peers>>~[peers](../reference/glossary.md#peer)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~\`<<glossary:point>>\(\)\`~[point\(\)](../reference/glossary.md#point-function)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:point function>>~[point function](../reference/glossary.md#point-function)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:previous block header hash>>~[previous block header hash](../reference/glossary.md#previous-block-header-hash)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:PrivateSend>>~[PrivateSend](../reference/glossary.md#privatesend)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:private key>>~[private key](../reference/glossary.md#private-key)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:private keys>>~[private keys](../reference/glossary.md#private-key)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:proof of work>>~[proof of work](../reference/glossary.md#proof-of-work)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:pubkey script>>~[pubkey script](../reference/glossary.md#pubkey-script)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:public key>>~[public key](../reference/glossary.md#public-key)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:public keys>>~[public keys](../reference/glossary.md#public-key)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:raw format>>~[raw format](../reference/glossary.md#raw-format)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:raw transaction>>~[raw transaction](../reference/glossary.md#raw-transaction)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:raw transactions>>~[raw transactions](../reference/glossary.md#raw-transaction)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:redeem script>>~[redeem script](../reference/glossary.md#redeem-script)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:regression test mode>>~[regression test mode](../reference/glossary.md#regression-test-mode)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:root seed>>~[root seed](../reference/glossary.md#root-seed)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:RPC byte order>>~[RPC byte order](../reference/glossary.md#rpc-byte-order)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:secp256k1 signatures>>~[secp256k1 signatures](../reference/glossary.md#secp256k1-signatures)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:Sentinel>>~[Sentinel](../reference/glossary.md#sentinel)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:sequence number>>~[sequence number](../reference/glossary.md#sequence-number)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:serialized block>>~[serialized block](../reference/glossary.md#serialized-block)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:serialized transaction>>~[serialized transaction](../reference/glossary.md#serialized-transaction)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:sighash-flag>>~[sighash-flag](../reference/glossary.md#sighash-flag)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:SIGHASH_ALL>>~[SIGHASH_ALL](../reference/glossary.md#sighash_all)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:SIGHASH flag>>~[SIGHASH flag](../reference/glossary.md#sighash-flag)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:SIGHASH_ANYONECANPAY>>~[SIGHASH_ANYONECANPAY](../reference/glossary.md#sighash_anyonecanpay)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:SIGHASH_NONE>>~[SIGHASH_NONE](../reference/glossary.md#sighash_none)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:SIGHASH_SINGLE>>~[SIGHASH_SINGLE](../reference/glossary.md#sighash_single)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:signature>>~[signature](../reference/glossary.md#signature)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:signatures>>~[signatures](../reference/glossary.md#signature)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:signature hash>>~[signature hash](../reference/glossary.md#signature-hash)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:signature script>>~[signature script](../reference/glossary.md#signature-script)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:Signature script>>~[Signature script](../reference/glossary.md#signature-script)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:Signature scripts>>~[Signature scripts](../reference/glossary.md#signature-script)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:Simplified Payment Verification>>~[Simplified Payment Verification](../reference/glossary.md#simplified-payment-verification)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:SPV>>~[SPV](../reference/glossary.md#simplified-payment-verification)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:soft fork>>~[soft fork](../reference/glossary.md#soft-fork)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:soft forks>>~[soft forks](../reference/glossary.md#soft-fork)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:special transactions>>~[special transactions](../reference/glossary.md#special-transactions)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:Special Transactions>>~[Special Transactions](../reference/glossary.md#special-transactions)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:spork>>~[spork](../reference/glossary.md#spork)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:Spork>>~[Spork](../reference/glossary.md#spork)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:stale block>>~[stale block](../reference/glossary.md#stale-block)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:stale blocks>>~[stale blocks](../reference/glossary.md#stale-block)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:standard block relay>>~[standard block relay](../reference/glossary.md#standard-block-relay)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:Standard Block Relay>>~[Standard Block Relay](../reference/glossary.md#standard-block-relay)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:standard transaction>>~[standard transaction](../reference/glossary.md#standard-transaction)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:Start String>>~[Start String](../reference/glossary.md#start-string)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:superblock>>~[superblock](../reference/glossary.md#superblock)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:target>>~[target](../reference/glossary.md#target)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:target threshold>>~[target threshold](../reference/glossary.md#target)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:testnet>>~[testnet](../reference/glossary.md#testnet)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:transaction>>~[transaction](../reference/glossary.md#transaction)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:transactions>>~[transactions](../reference/glossary.md#transaction)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:transaction fee>>~[transaction fee](../reference/glossary.md#transaction-fee)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:transaction identifiers>>~[transaction identifiers](../reference/glossary.md#transaction-identifiers)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:transaction version number>>~[transaction version number](../reference/glossary.md#transaction-version-number)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:unconfirmed transaction>>~[unconfirmed transaction](../reference/glossary.md#unconfirmed-transaction)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:unencrypted wallet>>~[unencrypted wallet](../reference/glossary.md#unencrypted-wallet)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:unique addresses>>~[unique addresses](../reference/glossary.md#unique-addresses)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:unlocked wallet>>~[unlocked wallet](../reference/glossary.md#unlocked-wallet)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:unsolicited block push>>~[unsolicited block push](../reference/glossary.md#unsolicited-block-push)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:Unsolicited Block Push>>~[Unsolicited Block Push](../reference/glossary.md#unsolicited-block-push)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:unspent transaction output>>~[unspent transaction output](../reference/glossary.md#unspent-transaction-output)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:User Activated Soft Fork>>~[User Activated Soft Fork](../reference/glossary.md#user-activated-soft-fork)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:wallet>>~[wallet](../reference/glossary.md#wallet)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:Wallet Import Format>>~[Wallet Import Format](../reference/glossary.md#wallet-import-format)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:wallet support>>~[wallet support](../reference/glossary.md#wallet-support)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:watch-only address>>~[watch-only address](../reference/glossary.md#watch-only-address)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:X11>>~[X11](../reference/glossary.md#x11)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:prefilledtransaction>>~[prefilledtransaction](../reference/glossary.md#prefilledtransaction)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:proper money handling>>~[proper money handling](../reference/glossary.md#proper money handling)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:v2 block>>~[v2 block](../reference/glossary.md#v2 block)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:child public key>>~[child public key](../reference/glossary.md#child-public-key)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:child private key>>~[child private key](../reference/glossary.md#child-private-key)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:parent public key>>~[parent public key](../reference/glossary.md#parent-public-key)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:parent private key>>~[parent private key](../reference/glossary.md#parent-private-key)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:extended public key>>~[extended public key](../reference/glossary.md#extended-public-key)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:MSG_TX>>~MSG_TX~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:MSG_BLOCK>>~MSG_BLOCK~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:MSG_FILTERED_BLOCK>>~MSG_FILTERED_BLOCK~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:MSG_CLSIG>>~MSG_CLSIG~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:MSG_LEGACY_TXLOCK_REQUEST>>~MSG_LEGACY_TXLOCK_REQUEST~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:MSG_ISLOCK>>~MSG_ISLOCK~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:MSG_SPORK>>~MSG_SPORK~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:MSG_DSTX>>~MSG_DSTX~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:MSG_GOVERNANCE_OBJECT>>~MSG_GOVERNANCE_OBJECT~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:MSG_GOVERNANCE_OBJECT_VOTE>>~MSG_GOVERNANCE_OBJECT_VOTE~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:MSG_CMPCT_BLOCK>>~MSG_CMPCT_BLOCK~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:MSG_QUORUM_FINAL_COMMITMENT>>~MSG_QUORUM_FINAL_COMMITMENT~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:MSG_QUORUM_CONTRIB>>~MSG_QUORUM_CONTRIB~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:MSG_QUORUM_COMPLAINT>>~MSG_QUORUM_COMPLAINT~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:MSG_QUORUM_JUSTIFICATION>>~MSG_QUORUM_JUSTIFICATION~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:MSG_QUORUM_PREMATURE_COMMITMENT>>~MSG_QUORUM_PREMATURE_COMMITMENT~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:MSG_QUORUM_RECOVERED_SIG>>~MSG_QUORUM_RECOVERED_SIG~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:MSG_TXLOCK_VOTE>>~MSG_TXLOCK_VOTE~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:MSG_MASTERNODE_PAYMENT_VOTE>>~[MSG_MASTERNODE_PAYMENT_VOTE](../reference/glossary.md#MSG_MASTERNODE_PAYMENT_VOTE)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:MSG_MASTERNODE_PAYMENT_BLOCK>>~[MSG_MASTERNODE_PAYMENT_BLOCK](../reference/glossary.md#MSG_MASTERNODE_PAYMENT_BLOCK)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:MSG_BUDGET_VOTE>>~[MSG_BUDGET_VOTE](../reference/glossary.md#MSG_BUDGET_VOTE)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:MSG_MASTERNODE_QUORUM>>~[MSG_MASTERNODE_QUORUM](../reference/glossary.md#MSG_MASTERNODE_QUORUM)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:MSG_MASTERNODE_ANNOUNCE>>~[MSG_MASTERNODE_ANNOUNCE](../reference/glossary.md#MSG_MASTERNODE_ANNOUNCE)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:MSG_MASTERNODE_PING>>~[MSG_MASTERNODE_PING](../reference/glossary.md#MSG_MASTERNODE_PING)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:MSG_MASTERNODE_VERIFY>>~[MSG_MASTERNODE_VERIFY](../reference/glossary.md#MSG_MASTERNODE_VERIFY)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:MSG_QUORUM_DEBUG_STATUS>>~[MSG_QUORUM_DEBUG_STATUS](../reference/glossary.md#MSG_QUORUM_DEBUG_STATUS)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:MSG_TXLOCK_REQUEST>>~[MSG_TXLOCK_REQUEST](../reference/glossary.md#MSG_TXLOCK_REQUEST)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:OP_CHECKMULTISIG>>~[OP_CHECKMULTISIG](../reference/glossary.md#OP_CHECKMULTISIG)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:OP_CHECKSIG>>~[OP_CHECKSIG](../reference/glossary.md#OP_CHECKSIG)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:OP_DUP>>~[OP_DUP](../reference/glossary.md#OP_DUP)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:OP_EQUAL>>~[OP_EQUAL](../reference/glossary.md#OP_EQUAL)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:OP_EQUALVERIFY>>~[OP_EQUALVERIFY](../reference/glossary.md#OP_EQUALVERIFY)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:OP_HASH160>>~[OP_HASH160](../reference/glossary.md#OP_HASH160)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:OP_RETURN>>~[OP_RETURN](../reference/glossary.md#OP_RETURN)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:OP_VERIFY>>~[OP_VERIFY](../reference/glossary.md#OP_VERIFY)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:TXID>>~[TXID](../reference/glossary.md#transaction-identifiers)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:TXIDs>>~[TXIDs](../reference/glossary.md#transaction-identifiers)~g' {} +
find . -iname "*.md" -exec perl -i -pe's~<<glossary:MSG_ISDLOCK>>~MSG_ISDLOCK~g' {} +

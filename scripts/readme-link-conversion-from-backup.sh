#!/bin/bash

# Core Reference
find . -iname "*.md" -exec sed -i 's~](core-ref-block-chain-block-headers~](\.\./reference/block-chain-block-headers.md~g' {} +
find . -iname "*.md" -exec sed -i 's~](core-ref-block-chain-serialized-blocks~](\.\./reference/block-chain-serialized-blocks.md~g' {} +
find . -iname "*.md" -exec sed -i 's~](core-ref-transactions-raw-transaction-format~](\.\./reference/transactions-raw-transaction-format.md~g' {} +
find . -iname "*.md" -exec sed -i 's~](core-ref-transactions-special-transactions~](\.\./reference/transactions-special-transactions.md~g' {} +
find . -iname "*.md" -exec sed -i 's~](core-ref-transactions-compactsize-unsigned-integers~](\.\./reference/transactions-compactsize-unsigned-integers.md~g' {} +
find . -iname "*.md" -exec sed -i 's~](core-ref-p2p-network-constants-and-defaults~](\.\./reference/p2p-network-constants-and-defaults.md~g' {} +
find . -iname "*.md" -exec sed -i 's~](core-ref-p2p-network-protocol-versions~](\.\./reference/p2p-network-protocol-versions.md~g' {} +
find . -iname "*.md" -exec sed -i 's~](core-ref-p2p-network-message-headers)~](\.\./reference/p2p-network-message-headers.md)~g' {} +
find . -iname "*.md" -exec sed -i 's~](core-ref-p2p-network-control-messages~](\.\./reference/p2p-network-control-messages.md~g' {} +
find . -iname "*.md" -exec sed -i 's~](core-ref-p2p-network-data-messages~](\.\./reference/p2p-network-data-messages.md~g' {} +
find . -iname "*.md" -exec sed -i 's~](core-ref-p2p-network-governance-messages~](\.\./reference/p2p-network-governance-messages.md~g' {} +
find . -iname "*.md" -exec sed -i 's~](core-ref-p2p-network-instantsend-messages~](\.\./reference/p2p-network-instantsend-messages.md~g' {} +
find . -iname "*.md" -exec sed -i 's~](core-ref-p2p-network-masternode-messages~](\.\./reference/p2p-network-masternode-messages.md~g' {} +
find . -iname "*.md" -exec sed -i 's~](core-ref-p2p-network-privatesend-messages~](\.\./reference/p2p-network-privatesend-messages.md~g' {} +
find . -iname "*.md" -exec sed -i 's~](core-ref-p2p-network-quorum-messages~](\.\./reference/p2p-network-quorum-messages.md~g' {} +
find . -iname "*.md" -exec sed -i 's~](core-ref-transactions-opcodes~](\.\./reference/transactions-opcodes.md~g' {} +
find . -iname "*.md" -exec sed -i 's~](core-ref-wallets~](\.\./reference/wallets.md~g' {} +

# Guide
find . -iname "*.md" -exec sed -i 's~](core-guide-block-chain)~](\.\./guide/block-chain.md)~g' {} +
find . -iname "*.md" -exec sed -i 's~](core-guide-dime-features)~](\.\./guide/dime-features.md)~g' {} +
find . -iname "*.md" -exec sed -i 's~](core-guide-dime-features#~](\.\./guide/dime-features.md#~g' {} +
find . -iname "*.md" -exec sed -i 's~](core-guide-dime-features-chainlocks~](\.\./guide/dime-features-chainlocks.md~g' {} +
find . -iname "*.md" -exec sed -i 's~](core-guide-dime-features-governance~](\.\./guide/dime-features-governance.md~g' {} +
find . -iname "*.md" -exec sed -i 's~](core-guide-dime-features-historical-reference~](\.\./guide/dime-features-historical-reference.md~g' {} +
find . -iname "*.md" -exec sed -i 's~](core-guide-dime-features-instantsend~](\.\./guide/dime-features-instantsend.md~g' {} +
find . -iname "*.md" -exec sed -i 's~](core-guide-dime-features-masternode-payment~](\.\./guide/dime-features-masternode-payment.md~g' {} +
find . -iname "*.md" -exec sed -i 's~](core-guide-dime-features-masternode-quorums~](\.\./guide/dime-features-masternode-quorums.md~g' {} +
find . -iname "*.md" -exec sed -i 's~](core-guide-dime-features-masternode-sync~](\.\./guide/dime-features-masternode-sync.md~g' {} +
find . -iname "*.md" -exec sed -i 's~](core-guide-dime-features-privatesend~](\.\./guide/dime-features-privatesend.md~g' {} +
find . -iname "*.md" -exec sed -i 's~](core-guide-dime-features-proof-of-service~](\.\./guide/dime-features-proof-of-service.md~g' {} +
find . -iname "*.md" -exec sed -i 's~](core-guide-mining-block-prototypes#~](\.\./guide/mining-block-prototypes.md#~g' {} +
find . -iname "*.md" -exec sed -i 's~](core-guide-transactions)~](\.\./guide/transactions.md)~g' {} +
find . -iname "*.md" -exec sed -i 's~](core-guide-transactions-avoiding-key-reuse)~](\.\./guide/transactions-avoiding-key-reuse.md)~g' {} +
find . -iname "*.md" -exec sed -i 's~](core-guide-transactions-locktime-and-sequence-number~](\.\./guide/transactions-locktime-and-sequence-number.md~g' {} +
find . -iname "*.md" -exec sed -i 's~](core-guide-transactions-locktime-and-sequence-number#locktime_parsing_rules~](\.\./guide/transactions-locktime-and-sequence-number.md#locktime-parsing-rules~g' {} +
find . -iname "*.md" -exec sed -i 's~](core-guide-transactions-transaction-malleability)~](\.\./guide/transactions-transaction-malleability.md)~g' {} +
find . -iname "*.md" -exec sed -i 's~](core-guide-p2p-network-initial-block-download~](\.\./guide/p2p-network-initial-block-download.md~g' {} +
find . -iname "*.md" -exec sed -i 's~](core-guide-wallets)~](\.\./guide/wallets.md)~g' {} +
find . -iname "*.md" -exec sed -i 's~](core-guide-wallets-wallet-files~](\.\./guide/wallets-wallet-files.md~g' {} +

# API Reference
find . -iname "*.md" -exec sed -i 's~](core-api-ref-rpc-api-overview)~](\.\./api/rpc-api-overview.md)~g' {} +
find . -iname "*.md" -exec sed -i 's~](core-api-ref-remote-procedure-call-quick-reference~](\.\./api/remote-procedure-call-quick-reference.md~g' {} +
find . -iname "*.md" -exec sed -i 's~](/docs/core-api-ref-rpc-address-index~](\.\./api/rpc-address-index.md~g' {} +
find . -iname "*.md" -exec sed -i 's~](core-api-ref-rpc-address-index~](\.\./api/rpc-address-index.md~g' {} +
find . -iname "*.md" -exec sed -i 's~](/docs/core-api-ref-rpc-blockchain~](\.\./api/rpc-blockchain.md~g' {} +
find . -iname "*.md" -exec sed -i 's~](core-api-ref-rpc-blockchain~](\.\./api/rpc-blockchain.md~g' {} +
find . -iname "*.md" -exec sed -i 's~](/docs/core-api-ref-rpc-control~](\.\./api/rpc-control.md~g' {} +
find . -iname "*.md" -exec sed -i 's~](core-api-ref-rpc-control~](\.\./api/rpc-control.md~g' {} +
find . -iname "*.md" -exec sed -i 's~](/docs/core-api-ref-rpc-dime~](\.\./api/rpc-dime.md~g' {} +
find . -iname "*.md" -exec sed -i 's~](core-api-ref-rpc-dime~](\.\./api/rpc-dime.md~g' {} +
find . -iname "*.md" -exec sed -i 's~](/docs/core-api-ref-rpc-evo~](\.\./api/rpc-evo.md~g' {} +
find . -iname "*.md" -exec sed -i 's~](core-api-ref-rpc-evo~](\.\./api/rpc-evo.md~g' {} +
find . -iname "*.md" -exec sed -i 's~](/docs/core-api-ref-rpc-generating~](\.\./api/rpc-generating.md~g' {} +
find . -iname "*.md" -exec sed -i 's~](core-api-ref-rpc-generating~](\.\./api/rpc-generating.md~g' {} +
find . -iname "*.md" -exec sed -i 's~](/docs/core-api-ref-rpc-mining~](\.\./api/rpc-mining.md~g' {} +
find . -iname "*.md" -exec sed -i 's~](core-api-ref-rpc-mining~](\.\./api/rpc-mining.md~g' {} +
find . -iname "*.md" -exec sed -i 's~](/docs/core-api-ref-rpc-network~](\.\./api/rpc-network.md~g' {} +
find . -iname "*.md" -exec sed -i 's~](core-api-ref-rpc-network~](\.\./api/rpc-network.md~g' {} +
find . -iname "*.md" -exec sed -i 's~](/docs/core-api-ref-rpc-raw-transactions~](\.\./api/rpc-raw-transactions.md~g' {} +
find . -iname "*.md" -exec sed -i 's~](core-api-ref-rpc-raw-transactions~](\.\./api/rpc-raw-transactions.md~g' {} +
find . -iname "*.md" -exec sed -i 's~](/docs/core-api-ref-rpc-removed~](\.\./api/rpc-removed.md~g' {} +
find . -iname "*.md" -exec sed -i 's~](core-api-ref-rpc-removed~](\.\./api/rpc-removed.md~g' {} +
find . -iname "*.md" -exec sed -i 's~](/docs/core-api-ref-rpc-utility~](\.\./api/rpc-utility.md~g' {} +
find . -iname "*.md" -exec sed -i 's~](core-api-ref-rpc-utility~](\.\./api/rpc-utility.md~g' {} +
find . -iname "*.md" -exec sed -i 's~](/docs/core-api-ref-rpc-wallet-deprecated~](\.\./api/rpc-wallet-deprecated.md~g' {} +
find . -iname "*.md" -exec sed -i 's~](core-api-ref-rpc-wallet-deprecated~](\.\./api/rpc-wallet-deprecated.md~g' {} +
find . -iname "*.md" -exec sed -i 's~](/docs/core-api-ref-rpc-wallet~](\.\./api/rpc-wallet.md~g' {} +
find . -iname "*.md" -exec sed -i 's~](core-api-ref-rpc-wallet~](\.\./api/rpc-wallet.md~g' {} +
find . -iname "*.md" -exec sed -i 's~](/docs/core-api-ref-rpc-zmq~](\.\./api/rpc-zmq.md~g' {} +
find . -iname "*.md" -exec sed -i 's~](core-api-ref-rpc-zmq~](\.\./api/rpc-zmq.md~g' {} +
find . -iname "*.md" -exec sed -i 's~](/docs/core-api-ref-http-rest-requests~](\.\./api/http-rest-requests.md~g' {} +
find . -iname "*.md" -exec sed -i 's~](core-api-ref-http-rest-requests~](\.\./api/http-rest-requests.md~g' {} +
find . -iname "*.md" -exec sed -i 's~](core-api-ref-zmq~](\.\./api/zmq.md~g' {} +

# Dime Core
find . -iname "*.md" -exec sed -i 's~](dime-core-wallet-arguments-and-commands-dimed~](\.\./dimecore/wallet-arguments-and-commands-dimed.md~g' {} +
find . -iname "*.md" -exec sed -i 's~](dime-core-wallet-arguments-and-commands-dime-cli~](\.\./dimecore/wallet-arguments-and-commands-dime-cli.md~g' {} +
find . -iname "*.md" -exec sed -i 's~](dime-core-wallet-arguments-and-commands-dime-tx~](\.\./dimecore/wallet-arguments-and-commands-dime-tx.md~g' {} +
find . -iname "*.md" -exec sed -i 's~](dime-core-wallet-arguments-and-commands-dime-qt~](\.\./dimecore/wallet-arguments-and-commands-dime-qt.md~g' {} +
find . -iname "*.md" -exec sed -i 's~](dime-core-wallet-arguments-and-commands-dime-wallet~](\.\./dimecore/wallet-arguments-and-commands-dime-wallet.md~g' {} +


# Examples
find . -iname "*.md" -exec sed -i 's~](core-examples-introduction)~](\.\./examples/examples-introduction.md)~g' {} +
find . -iname "*.md" -exec sed -i 's~](core-examples-configuration-file)~](\.\./examples/configuration-file.md)~g' {} +
find . -iname "*.md" -exec sed -i 's~](core-examples-p2p-network-parsing-a-merkleblock~](\.\./examples/p2p-network-parsing-a-merkleblock.md~g' {} +
find . -iname "*.md" -exec sed -i 's~](core-examples-p2p-network-creating-a-bloom-filter~](\.\./examples/p2p-network-creating-a-bloom-filter.md~g' {} +
find . -iname "*.md" -exec sed -i 's~](core-examples-p2p-network-evaluating-a-bloom-filter~](\.\./examples/p2p-network-evaluating-a-bloom-filter.md~g' {} +
find . -iname "*.md" -exec sed -i 's~](core-examples-transaction-tutorial-simple-spending~](\.\./examples/transaction-tutorial-simple-spending.md~g' {} +
find . -iname "*.md" -exec sed -i 's~](core-examples-transaction-tutorial#simple-raw-transaction~](\.\./examples/transaction-tutorial-simple-raw-transaction.md~g' {} +
find . -iname "*.md" -exec sed -i 's~](core-examples-transaction-tutorial-simple-raw-transaction~](\.\./examples/transaction-tutorial-simple-raw-transaction.md~g' {} +
find . -iname "*.md" -exec sed -i 's~](/docs/core-examples-transaction-tutorial-complex-raw-transaction~](\.\./examples/transaction-tutorial-complex-raw-transaction.md~g' {} +
find . -iname "*.md" -exec sed -i 's~](core-examples-transaction-tutorial-complex-raw-transaction~](\.\./examples/transaction-tutorial-complex-raw-transaction.md~g' {} +
find . -iname "*.md" -exec sed -i 's~](core-examples-transaction-tutorial-offline-signing~](\.\./examples/transaction-tutorial-offline-signing.md~g' {} +

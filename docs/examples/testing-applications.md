```{eval-rst}
.. _examples-testing-applications:
.. meta::
  :title: Testing Applications
  :description: Dimecoin Core provides several network options designed to let developers test their applications with reduced risks and limitations.
```

> ***We put our best effort into covering all topics related to Dimecoin. Each section will cover a different category. Not all documentation may be 100% accurate, if you spot an error, please report it or submit a PR request on GitHub.***
>
> ***REMINDER: This documentation is always evolving. If you have not been here for a while, perhaps check again. Things may have been added or updated since your last visit!***

## Testing Applications

Dimecoin Core provides several network options designed to let developers test their applications with reduced risks and limitations.

### Testnet

When run with no arguments, all Dimecoin Core programs default to Dimecoin's main network ([mainnet](../resources/glossary.md#mainnet)). However, for development, it's safer and cheaper to use Dimecoin's test network ([testnet](../resources/glossary.md#testnet)) where the dimecoins spent have no real-world value. Testnet also relaxes some restrictions (such as standard transaction checks) so you can test functions which might currently be disabled by default on [mainnet](../resources/glossary.md#mainnet).

To use testnet, use the argument `-testnet` with `dimecoin-cli`, `dimecoind` or `dimecoin-qt` or add `testnet=1` to your `dimecoin.conf` file as [described earlier](../examples/configuration-file.md).  To get free dimecoins for testing, you can easily run [setgenerate](../api/rpc-generating.md#setgenerate) to generate some testnet dimecoins.

### Regtest mode

For situations where interaction with random [peers](../resources/glossary.md#peer) and [blocks](../resources/glossary.md#block) is unnecessary or unwanted, Dimecoin Core's [regression test mode](../resources/glossary.md#regression-test-mode) (regtest mode) lets you instantly create a brand-new private [blockchain](../resources/glossary.md#blockchain) with the same basic rules as testnet---but one major difference: you choose when to create new blocks, so you have complete control over the environment.

Many developers consider regtest mode the preferred way to develop new applications. The following example will let you create a regtest environment after you first [configure dimecoind](../examples/configuration-file.md).

``` bash
> dimecoind -regtest -daemon
Dimecoin Core server starting
```

Start `dimecoind` in regtest mode to create a private block chain.

``` text
## Dimecoin Core
dimecoin-cli -regtest generate 101
```

Generate 101 blocks using a special RPC which is only available in regtest mode. This takes less than a second on a generic PC. Since this is a new block chain using Dimecoin's default rules, the first blocks pay a [block reward](../resources/glossary.md#block-reward) of 500 DIME.  Unlike [mainnet](../resources/glossary.md#mainnet), in regtest mode only the first 150 blocks pay a reward of 500 DIME. However, a block must have 100 [confirmations](../resources/glossary.md#confirmations) before that reward can be spent, so we generate 101 blocks to get access to the [coinbase transaction](../resources/glossary.md#coinbase-transaction) from block #1.

``` bash
dimecoin-cli -regtest getbalance
500.00000000
```

Verify that we now have 500 DIME available to spend.

You can now use Dimecoin Core RPCs prefixed with `dimecoin-cli -regtest`.

Regtest wallets and block chain state (chainstate) are saved in the `regtest` subdirectory of the Dimecoin Core configuration directory. You can safely delete the `regtest` subdirectory and restart Dimecoin Core to start a new regtest. (See the [Developer Examples Introduction](../examples/introduction.md) for default configuration directory locations on various operating systems. 

```{warning}
Always back up mainnet wallets before performing dangerous operations such as deleting.
```

The complete set of regtest-specific arguments can be found on the [`dimecoind` Arguments and  Commands page](../dimecore/wallet-arguments-and-commands-dimecoind.md#regtest-options).

### Network Type Comparison

Each network type has some unique characteristics to support development and testing. The tables below summarize some of the significant differences between the 4 network types.

#### Network Characteristics

|  | Mainnet | [Testnet](#testnet) | [Regtest](#regtest-mode) |
|-|-|-|-|
| Public network | Yes | Yes | No |
| Private network | No | No | Yes |
| Number of networks | 1 | 1 | Unlimited |

```{admonition} Using Sporks
To enable or disable sporks on a regtest or devnet, set `sporkaddr` and `sporkkey` in the `dimecoin.conf` config file. Any valid Dimecoin address / private key can be used. You can get an address using the [`getnewaddress` RPC](../api/rpc-wallet.md#getnewaddress) and retrieve its private key using the [`dumpprivkey` RPC](../api/rpc-wallet.md#dumpprivkey).
```

#### Mining Characteristics

| Network Type | Difficulty adjustment algorithm |
|-|-|
| [Testnet](#testnet) | Mainnet algorithm, but [allows minimum difficulty blocks](https://github.com/dime-coin/dimecoin/blob/272dbe4974e09eca6a928ce13b42941b1c28aca2/src/chainparams.cpp#L208) if no blocks are created for 5 minutes |
| [Regtest](#regtest-mode) | Mines blocks at the [minimum difficulty level](https://github.com/dime-coin/dimecoin/blob/272dbe4974e09eca6a928ce13b42941b1c28aca2/src/chainparams.cpp#L329) |

```{seealso}
[chainparams.cpp source](https://github.com/dime-coin/dimecoin/blob/master/src/chainparams.cpp) for details on other differences
```

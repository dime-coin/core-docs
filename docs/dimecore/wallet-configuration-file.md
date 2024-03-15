```{eval-rst}
.. meta::
  :title: Dimecoin Core Configuration Files
  :description: Details about the configuration files needed to run dimecoind and dimecoin-cli, including dimecoin.conf and settings.json.
```

> ***We put our best effort into covering all topics related to Dimecoin. Each section will cover a different category. Not all documentation may be 100% accurate, if you spot an error, please report it or submit a PR request on GitHub.***
>
> ***REMINDER: This documentation is always evolving. If you have not been here for a while, perhaps check again. Things may have been added or updated since your last visit!***

## Configuration Files

### dimecoin.conf

To use `dimecoind` and `dimecoin-cli`, you will need to add a RPC password to your `dimecoin.conf` file. Both programs will read from the same file if both run on the same system as the same user, so any long random password will work:

``` text
rpcpassword=change_this_to_a_long_random_password
```

You should also make the `dimecoin.conf` file only readable to its owner.  On Linux, Mac OSX, and other Unix-like systems, this can be accomplished by running the following command in the Dimecoin Core application directory:

``` text
chmod 0600 dimecoin.conf
```

For development, it's safer and cheaper to use Dimecoin's test network ([testnet](../resources/glossary.md#testnet)) or [regression test mode](../resources/glossary.md#regression-test-mode) (regtest) described below.

Questions about Dimecoin use are best sent to the [Dimecoin Telegram](https://t.me/Dimecoin/1) and [Discord Channels](https://discord.gg/JqcKF4v).

#### Example Testnet Config

```text
testnet=1

# RPC Settings
rpcuser=user
rpcpassword=pass
rpcallowip=127.0.0.1
#----
listen=1
server=1

## Index Settings
txindex=1
addressindex=1
timestampindex=1
spentindex=1

[test]
rpcport=21931
```

#### Configuration Sections for Different Networks

Since Dimecoin Core 2.0.0.0 it is possible for a single configuration file to set different options for different networks. This is done by using sections or by prefixing the option with the network as shown below:

```{admoniton} Valid Section Names!
Please note that the only valid section names are **`[main]`**, **`[test]`**, and **`[regtest]`**.
```

``` text Example dimecoin.conf
# Enable RPC server for all networks
server=1

[main]
# Set custom mainnet ports
port=11931
rpcport=11931
# Set custom mainnet RPC auth
rpcuser=mainnetuser
rpcpassword=mainnetpass

[test]
# Set custom testnet RPC auth
rpcuser=testnetuser
rpcpassword=testnetpass

# Enabling indexing
txindex=1
addressindex=1
timestampindex=1
spentindex=1

[regtest]
mempoolsize=20
```

With this configuration file, dimecoind, dimecoin-qt, or dimecoin-cli can be run with the `-conf=<configuration file>` along with the `-testnet` or `-regtest` parameter to select the correct settings.

```{note}
The following options will only apply to mainnet ***unless they are in a section*** (e.g., `[test]`): `addnode=`, `connect=`, `port=`, `bind=`, `rpcport=`, `rpcbind=` and `wallet=`.
The options to choose a network (`regtest=` and `testnet=`) must be specified outside of sections.
```

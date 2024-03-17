```{eval-rst}
.. _dimecore-arguments-and-commands:
.. meta::
  :title: Dimecoin Core Arguments and Commands
  :description: Overview of arguments and commands for the components distributed with Dimecoin Core, including dimecoind, dimecoin-qt, and dimecoin-cli.
```

> ***We put our best effort into covering all topics related to Dimecoin. Each section will cover a different category. Not all documentation may be 100% accurate, if you spot an error, please report it or submit a PR request on GitHub.***
>
> ***REMINDER: This documentation is always evolving. If you have not been here for a while, perhaps check again. Things may have been added or updated since your last visit!***

## Arguments and Commands

### Overview

All command-line options (except for `-conf`) may be specified in a configuration file, and all configuration file options may also be specified on the command line. Command-line options override values set in the configuration file. The configuration file is a list of `<setting>=<value>` pairs, one per line, with optional comments starting with the `#` character.

The configuration file is not automatically created; you can create it using your favorite plain-text editor. By default, dimecoin-qt (or dimecoind) will look for a file named `dimecoin.conf` in the Dimecoin data directory, but both the data directory and the configuration file path may be changed using the `-datadir` and `-conf` command-line arguments.

| Platform | Path to data folder | Typical path to configuration file |
| - | - | - |
| Linux | ~/ | /home/username/.dimecoin/dimecoin.conf |
| macOS | ~/Library/Application Support/ | /Users/username/Library/Application Support/Dimecoin/dimecoin.conf |
| Windows | %APPDATA% | *(Vista-11)* C:\\Users\\username\\AppData\\Roaming\\Dimecoin\\dimecoin.conf |
| Windows | %APPDATA% | *(2000-XP)* C:\\Documents and Settings\\username\\Application Data\\Dimecoin\\dimecoin.conf |

```{admonition} Testnet/Regtest Modes
If running Dimecoin in testnet mode, the sub-folder `testnet3` will be appended to the data directory automatically. Likewise, if running in regtest mode, the subfolder `regtest" will be appended to the data directory.
```

### Command Line Arguments

The following sections provide details of the command line arguments for each of the five components distributed in Dimecoin Core releases.

| Component | Description |
| - | - |
| dimecoind | Dimecoin Core daemon |
| dimecoin-qt | Dimecoin Core wallet GUI |
| dimecoin-cli | Dimecoin Core RPC Client |
| dimecoin-tx | Dimecoin Core transaction utility |

#### dimecoind

View all [command line options for dimecoind](../dimecore/wallet-arguments-and-commands-dimecoind.md).

```bash
Usage:
  dimecoind [options]                     Start Dimecoin Core Daemon
```

#### dimecoin-qt

 View all [command line options for dimecoin-qt](../dimecore/wallet-arguments-and-commands-dimecoin-qt.md).

```bash
Usage:
  dimecoin-qt [command-line options]                     
```

#### dimecoin-cli

View all [command line options for dimecoin-cli](../dimecore/wallet-arguments-and-commands-dimecoin-cli.md).

```bash
Usage:
  dimecoin-cli [options] <command> [params]  Send command to Dimecoin Core
  dimecoin-cli [options] -named <command> [name=value] ... Send command to Dimecoin Core (with named arguments)
  dimecoin-cli [options] help                List commands
  dimecoin-cli [options] help <command>      Get help for a command
```

#### dimecoin-tx

View all [command line options for dimecoin-tx](../dimecore/wallet-arguments-and-commands-dimecoin-tx.md).

```bash
Usage:
  dimecoin-tx [options] <hex-tx> [commands]  Update hex-encoded dimecoin transaction
  dimecoin-tx [options] -create [commands]   Create hex-encoded dimecoin transaction
```

```{toctree}
:maxdepth: 2
:titlesonly:
:hidden:

wallet-arguments-and-commands-dimecoind
wallet-arguments-and-commands-dimecoin-qt
wallet-arguments-and-commands-dimecoin-cli
wallet-arguments-and-commands-dimecoin-tx
```

```{eval-rst}
.. _dimecore-arguments-and-commands-dimecoin-cli:
.. meta::
  :title: dimecoin-cli Wallet Arguments and Commands
  :description: The section includes command-line option for accessing Dimecoin Core RPCs via the dimecoin-cli application.
```

> ***We put our best effort into covering all topics related to Dimecoin. Each section will cover a different category. Not all documentation may be 100% accurate, if you spot an error, please report it or submit a PR request on GitHub.***
>
> ***REMINDER: This documentation is always evolving. If you have not been here for a while, perhaps check again. Things may have been added or updated since your last visit!***

## dimecoin-cli

The `dimecoin-cli` application provides a command-line option for accessing Dimecoin Core RPCs.

### Usage

```bash Send command
dimecoin-cli [options] <command> [params]
```

```bash Send command using wallet
dimecoin-cli [options] -rpcwallet=<wallet-name> <command> [params]
```

```bash Send command (with named arguments)
  dimecoin-cli [options] -named <command> [name=value] ... 
```

```bash List commands
dimecoin-cli [options] help
```

```bash Get help for command
dimecoin-cli [options] help <command>
```

```{note}
View [the list of RPCs](../api/remote-procedure-call-quick-reference.md) for more detailed information. Using dimecoin-cli, this information is available using the `dimecoin-cli [options] help` and `dimecoin-cli [options] help <command>` commands.
```

#### Options

```text
  -?
       Print this help message and exit

  -conf=<file>
       Specify configuration file. Relative paths will be prefixed by datadir
       location. (default: dimecoin.conf)

  -datadir=<dir>
       Specify data directory

  -getinfo
       Get general information from the remote server. Note that unlike
       server-side RPC calls, the results of -getinfo is the result of
       multiple non-atomic requests. Some entries in the result may
       represent results from different states (e.g. wallet balance may
       be as of a different block from the chain state reported)

  -named
       Pass named instead of positional arguments (default: false)

  -rpcclienttimeout=<n>
       Timeout in seconds during HTTP requests, or 0 for no timeout. (default:
       900)

  -rpcconnect=<ip>
       Send commands to node running on <ip> (default: 127.0.0.1)

  -rpccookiefile=<loc>
       Location of the auth cookie. Relative paths will be prefixed by a
       net-specific datadir location. (default: data dir)

  -rpcpassword=<pw>
       Password for JSON-RPC connections

  -rpcport=<port>
       Connect to JSON-RPC on <port> (default: 9998, testnet: 19998, regtest:
       19898)

  -rpcuser=<user>
       Username for JSON-RPC connections

  -rpcwait
       Wait for RPC server to start

  -rpcwallet=<walletname>
       Send RPC for non-default wallet on RPC server (needs to exactly match
       corresponding -wallet option passed to dimecoind). This changes the
       RPC endpoint used, e.g. http://127.0.0.1:9998/wallet/<walletname>

  -stdin
       Read extra arguments from standard input, one per line until EOF/Ctrl-D
       (recommended for sensitive information such as passphrases). When
       combined with -stdinrpcpass, the first line from standard input
       is used for the RPC password.

  -stdinrpcpass
       Read RPC password from standard input as a single line. When combined
       with -stdin, the first line from standard input is used for the
       RPC password. When combined with -stdinwalletpassphrase,
       -stdinrpcpass consumes the first line, and -stdinwalletpassphrase
       consumes the second.

  -version
       Print version and exit
```

#### Chain Selection Options

```text
  -chain=<chain>
       Use the chain <chain> (default: main). Allowed values: main, test,
       regtest

  -regtest
       Use the regtest chain.

  -testnet
       Use the test chain. Equivalent to -chain=test
```

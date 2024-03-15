```{eval-rst}
.. _dimecore-arguments-and-commands-dimecoin-tx:
.. meta::
  :title: dimecoin-tx Wallet Arguments and Commands
  :description: Command-line options for creating, parsing, or modifying transactions via dimecoin-tx.
```

> ***We put our best effort into covering all topics related to Dimecoin. Each section will cover a different category. Not all documentation may be 100% accurate, if you spot an error, please report it or submit a PR request on GitHub.***
>
> ***REMINDER: This documentation is always evolving. If you have not been here for a while, perhaps check again. Things may have been added or updated since your last visit!***

## dimecoin-tx

The `dimecoin-tx` application provides a command-line option for creating, parsing, or modifying transactions.

### Usage

```bash
Usage:
  dimecoin-tx [options] <hex-tx> [commands]  Update hex-encoded dimecoin transaction
  dimecoin-tx [options] -create [commands]   Create hex-encoded dimecoin transaction
```

#### Options

```text
  -?
       Print this help message and exit

  -create
       Create new, empty TX.

  -json
       Select JSON output

  -txid
       Output only the hex-encoded transaction id of the resultant transaction.

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

#### Commands

```text
  delin=N
       Delete input N from TX

  delout=N
       Delete output N from TX

  in=TXID:VOUT(:SEQUENCE_NUMBER)
       Add input to TX

  locktime=N
       Set TX lock time to N

  nversion=N
       Set TX version to N

  outaddr=VALUE:ADDRESS
       Add address-based output to TX

  outdata=[VALUE:]DATA
       Add data-based output to TX

  outmultisig=VALUE:REQUIRED:PUBKEYS:PUBKEY1:PUBKEY2:....[:FLAGS]
       Add Pay To n-of-m Multi-sig output to TX. n = REQUIRED, m = PUBKEYS.
       Optionally add the "S" flag to wrap the output in a
       pay-to-script-hash.

  outpubkey=VALUE:PUBKEY[:FLAGS]
       Add pay-to-pubkey output to TX. Optionally add the "S" flag to wrap the
       output in a pay-to-script-hash.

  outscript=VALUE:SCRIPT[:FLAGS]
       Add raw script output to TX. Optionally add the "S" flag to wrap the
       output in a pay-to-script-hash.

  sign=SIGHASH-FLAGS
       Add zero or more signatures to transaction. This command requires JSON
       registers:prevtxs=JSON object, privatekeys=JSON object. See
       signrawtransactionwithkey docs for format of sighash flags, JSON
       objects.
```

#### Register Commands

```text
  load=NAME:FILENAME
       Load JSON file FILENAME into register NAME

  set=NAME:JSON-STRING
       Set register NAME to given JSON-STRING
```

```{eval-rst}
.. meta::
  :title: Dimecoin Core Constants and Defaults
  :description: Details Dimecoin network constants and defaults, including port configuration and start strings for Dimecoin network messages.
```

> ***We put our best effort into covering all topics related to Dimecoin. Each section will cover a different category. Not all documentation may be 100% accurate, if you spot an error, please report it or submit a PR request on GitHub.***
>
> ***REMINDER: This documentation is always evolving. If you have not been here for a while, perhaps check again. Things may have been added or updated since your last visit!***

## Constants and Defaults

The following constants and defaults are taken from Dimecoin Core's [chainparams.cpp](https://github.com/dime-coin/dimecoin/blob/master/src/chainparams.cpp) source code file.

| Network | Default Port | Magic Value | [Start String](../reference/glossary.md#start-string)
|---------|--------------|-----------------------------------------------|---------------
| Mainnet | 11931        | 0xdd03a5fe  | 0xfea503dd
| Testnet | 21931        | 0x39309278  | 0x78923039
| Regtest | 31931        | 0x39923078  | 0x78309239

```{note}
The testnet start string above are for testnet3; the original testnet used a different string with less difficult nBits.
```

Command line parameters can change what port a [node](../reference/glossary.md#node) listens on (see `-help`). Start strings are hardcoded constants that appear at the start of all messages sent on the Dimecoin [network](../reference/glossary.md#network); they may also appear in data files such as Dimecoin Core's block database. The Magic Value and [nBits](../reference/glossary.md#nbits) displayed above are in big-endian order; they're sent over the network in little-endian order. The [Start String](../reference/glossary.md#start-string) is simply the endian reversed Magic Value.

Dimecoin Core's [chainparams.cpp](https://github.com/dime-coin/dimecoin/blob/master/src/chainparams.cpp) also includes other constants useful to programs, such as the hash of the [genesis block](../reference/glossary.md#genesis-block) blocks for the different networks.

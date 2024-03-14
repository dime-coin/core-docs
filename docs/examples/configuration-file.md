```{eval-rst}
.. meta::
  :title: Configuration File
  :description: The Dimecoin Core configuration file, dimecoin.conf, stores settings for Dimecoin programs, including the RPC password required for dimecoind and dimecoin-cli.
```

> ***We put our best effort into covering all topics related to Dimecoin. Each section will cover a different category. Not all documentation may be 100% accurate, if you spot an error, please report it or submit a PR request on GitHub.***
>
> ***REMINDER: This documentation is always evolving. If you have not been here for a while, perhaps check again. Things may have been added or updated since your last visit!***

## Configuration File

All three programs get settings from `dimecoin.conf` in the `Dimecoin` application directory:

* Windows: `%APPDATA%\Dimecoin\`

* OSX: `$HOME/Library/Application Support/Dimecoin/`

* Linux: `$HOME/.dimecoin/`

To use `dimecoind` and `dimecoin-cli`, you will need to add a RPC password to your `dimecoin.conf` file. Both programs will read from the same file if both run on the same system as the same user, so any long random password will work:

```text
rpcpassword=change_this_to_a_long_random_password
```

You should also make the `dimecoin.conf` file only readable to its owner.  On Linux, Mac OSX, and other Unix-like systems, this can be accomplished by running the following command in the Dimecoin Core application directory:

```text
chmod 0600 dimecoin.conf
```

For development, it's safer and cheaper to use Dimecoin's test network ([testnet](../resources/glossary.md#testnet)), [regression test mode](../resources/glossary.md#regression-test-mode) (regtest), or a developer network  ([devnet](../resources/glossary.md#devnet)) described below.

Questions about Dimecoin use are best sent to the [Dimecoin Telegram](https://t.me/Dimecoin/1) and [Discord Channels](https://discord.gg/JqcKF4v).

In the following documentation, some strings have been shortened or wrapped: "[...]" indicates extra data was removed, and lines ending in a single backslash "\\" are continued below. If you hover over a cross-reference link, a brief definition of the term will be displayed.

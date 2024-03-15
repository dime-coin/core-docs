```{eval-rst}
.. _dimecore-arguments-and-commands-dimecoind:
.. meta::
  :title: dimecoind Arguments and Commands
  :description: The following section shows all available options for dimecoind including debug options that are not normally displayed.
```

> ***We put our best effort into covering all topics related to Dimecoin. Each section will cover a different category. Not all documentation may be 100% accurate, if you spot an error, please report it or submit a PR request on GitHub.***
>
> ***REMINDER: This documentation is always evolving. If you have not been here for a while, perhaps check again. Things may have been added or updated since your last visit!***

## dimecoind

### Usage

**Start Dimecoin Core Daemon**

```bash
dimecoind [options]
```

```{admonition} Debug Options
The following sections show all available options including debug options that are not normally displayed. To see only regular options, run `dimecoind --help`.
```

#### Options

```text
  -?
       Print this help message and exit

  -alertnotify=<cmd>
       Execute command when an alert is raised (%s in cmd is replaced by
       message)

  -assumevalid=<hex>
       If this block is in the chain assume that it and its ancestors are valid
       and potentially skip their script verification (0 to verify all,
       default:
       000000000000000c8b7a3bdcd8b9f516462122314529c8342244c685a4c899bf,
       testnet:
       0000020c5e0f86f385cbf8e90210de9a9fd63633f01433bf47a6b3227a2851fd)

  -blocknotify=<cmd>
       Execute command when the best block changes (%s in cmd is replaced by
       block hash)

  -blockreconstructionextratxn=<n>
       Extra transactions to keep in memory for compact block reconstructions
       (default: 100)

  -blocksdir=<dir>
       Specify directory to hold blocks subdirectory for *.dat files (default:
       <datadir>)

  -blocksonly
       Whether to reject transactions from network peers. Automatic broadcast
       and rebroadcast of any transactions from inbound peers is
       disabled, unless the peer has the 'forcerelay' permission. RPC
       transactions are not affected. (default: 0)

  -conf=<file>
       Specify path to read-only configuration file. Relative paths will be
       prefixed by datadir location. (default: dimecoin.conf)

  -daemon
       Run in the background as a daemon and accept commands

  -datadir=<dir>
       Specify data directory

  -dbbatchsize
       Maximum database write batch size in bytes (default: 16777216)

  -dbcache=<n>
       Maximum database cache size <n> MiB (4 to 16384, default: 300). In
       addition, unused mempool memory is shared for this cache (see
       -maxmempool).

  -debuglogfile=<file>
       Specify location of debug log file. Relative paths will be prefixed by a
       net-specific datadir location. (-nodebuglogfile to disable;
       default: debug.log)

  -includeconf=<file>
       Specify additional configuration file, relative to the -datadir path
       (only useable from configuration file, not command line)

  -loadblock=<file>
       Imports blocks from external file on startup

  -maxmempool=<n>
       Keep the transaction memory pool below <n> megabytes (default: 300)

  -mempoolexpiry=<n>
       Do not keep transactions in the mempool longer than <n> hours (default:
       336)

  -minimumchainwork=<hex>
       Minimum work assumed to exist on a valid chain in hex (default:
       000000000000000000000000000000000000000000008d970bc6cda0b02b30fc,
       testnet:
       00000000000000000000000000000000000000000000000002d68d24632e300f)

  -par=<n>
       Set the number of script verification threads (-16 to 15, 0 = auto, <0 =
       leave that many cores free, default: 0)

  -persistmempool
       Whether to save the mempool on shutdown and load on restart (default: 1)

  -pid=<file>
       Specify pid file. Relative paths will be prefixed by a net-specific
       datadir location. (default: dimecoind.pid)

  -settings=<file>
       Specify path to dynamic settings data file. Can be disabled with
       -nosettings. File is written at runtime and not meant to be
       edited by users (use dimecoin.conf instead for custom settings).
       Relative paths will be prefixed by datadir location. (default:
       settings.json)

  -sysperms
       Create new files with system default permissions, instead of umask 077
       (only effective with disabled wallet functionality)

  -version
       Print version and exit
```

#### Connection Options

```text
  -addnode=<ip>
       Add a node to connect to and attempt to keep the connection open (see
       the `addnode` RPC command help for more info). This option can be
       specified multiple times to add multiple nodes.

  -banscore=<n>
       Threshold for disconnecting and discouraging misbehaving peers (default:
       100)

  -bantime=<n>
       Default duration (in seconds) of manually configured bans (default:
       86400)

  -bind=<addr>[:<port>][=onion]
       Bind to given address and always listen on it (default: 0.0.0.0). Use
       [host]:port notation for IPv6. Append =onion to tag any incoming
       connections to that address and port as incoming Tor connections
       (default: 127.0.0.1:11391=onion, testnet: 127.0.0.1:21931=onion,
       regtest: 127.0.0.1:31931=onion)

  -connect=<ip>
       Connect only to the specified node; -noconnect disables automatic
       connections (the rules for this peer are the same as for
       -addnode). This option can be specified multiple times to connect
       to multiple nodes.

  -discover
       Discover own IP addresses (default: 1 when listening and no -externalip
       or -proxy)

  -dns
       Allow DNS lookups for -addnode, -seednode and -connect (default: 1)

  -dnsseed
       Query for peer addresses via DNS lookup, if low on addresses (default: 1
       unless -connect used)

  -externalip=<ip>
       Specify your own public address

  -forcednsseed
       Always query for peer addresses via DNS lookup (default: 0)

  -listen
       Accept connections from outside (default: 1 if no -proxy or -connect)

  -listenonion
       Automatically create Tor onion service (default: 1)

  -maxconnections=<n>
       Maintain at most <n> connections to peers (temporary service connections
       excluded) (default: 125)

  -maxreceivebuffer=<n>
       Maximum per-connection receive buffer, <n>*1000 bytes (default: 5000) The buffer is used to temporarily store incoming data from peers on the network until it can be processed. Increasing the maxreceivebuffer size might be useful in scenarios where nodes are on high-speed networks and can handle larger volumes of incoming data without becoming a bottleneck. It could potentially improve the speed at which data is processed from peers, assuming the node's hardware is capable of handling the increased load.
       
       Conversely, decreasing this value might help in constrained environments where memory is limited, or where there is a need to limit the node's resource usage. However, setting it too low could negatively impact the node's ability to process incoming data efficiently, possibly slowing down synchronization with the network or the propagation of transactions and blocks.

  -maxsendbuffer=<n>
       Maximum per-connection send buffer, <n>*1000 bytes (default: 1000)

  -maxtimeadjustment
       Maximum allowed median peer time offset adjustment. Local perspective of
       time may be influenced by peers forward or backward by this
       amount. (default: 4200 seconds)

  -maxuploadtarget=<n>
       Tries to keep outbound traffic under the given target (in MiB per 24h).
       Limit does not apply to peers with 'download' permission. 0 = no
       limit (default: 0)

  -onion=<ip:port>
       Use separate SOCKS5 proxy to reach peers via Tor onion services, set
       -noonion to disable (default: -proxy)

  -onlynet=<net>
       Make outgoing connections only through network <net> (ipv4, ipv6, onion,
       i2p). Incoming connections are not affected by this option. This
       option can be specified multiple times to allow multiple
       networks. Warning: if it is used with non-onion networks and the
       -onion or -proxy option is set, then outbound onion connections
       will still be made; use -noonion or -onion=0 to disable outbound
       onion connections in this case.

  -peerbloomfilters
       Support filtering of blocks and transaction with bloom filters (default:
       1)

  -permitbaremultisig
       Relay non-P2SH multisig (default: 1)

  -port=<port>
       Listen for connections on <port>. Nodes not using the default ports
       (default: 9999, testnet: 19999, regtest: 19899) are unlikely to
       get incoming connections. Not relevant for I2P (see doc/i2p.md).

  -proxy=<ip:port>
       Connect through SOCKS5 proxy, set -noproxy to disable (default:
       disabled)

  -proxyrandomize
       Randomize credentials for every proxy connection. This enables Tor
       stream isolation (default: 1)

  -seednode=<ip>
       Connect to a node to retrieve peer addresses, and disconnect. This
       option can be specified multiple times to connect to multiple
       nodes.

  -timeout=<n>
       Specify connection timeout in milliseconds (minimum: 1, default: 5000)

  -torcontrol=<ip>:<port>
       Tor control port to use if onion listening enabled (default:
       127.0.0.1:9051)

  -torpassword=<pass>
       Tor control port password (default: empty)

  -upnp
       Use UPnP to map the listening port (default: 0)

  -whitebind=<[permissions@]addr>
       Bind to the given address and add permission flags to the peers
       connecting to it. Use [host]:port notation for IPv6. Allowed
       permissions: bloomfilter (allow requesting BIP37 filtered blocks
       and transactions), noban (do not ban for misbehavior; implies
       download), forcerelay (relay transactions that are already in the
       mempool; implies relay), relay (relay even in -blocksonly mode),
       mempool (allow requesting BIP35 mempool contents), download
       (allow getheaders during IBD, no disconnect after maxuploadtarget
       limit), addr (responses to GETADDR avoid hitting the cache and
       contain random records with the most up-to-date info). Specify
       multiple permissions separated by commas (default:
       download,noban,mempool,relay). Can be specified multiple times.

  -whitelist=<[permissions@]IP address or network>
       Add permission flags to the peers connecting from the given IP address
       (e.g. 1.2.3.4) or CIDR-notated network (e.g. 1.2.3.0/24). Uses
       the same permissions as -whitebind. Can be specified multiple
       times.
```

#### Indexing Options

```text
  -reindex
       Rebuild chain state and block index from the blk*.dat files on disk

  -reindex-chainstate
       Rebuild chain state from the currently indexed blocks. If blocks on disk might be corrupted, use full -reindex
       instead.

  -txindex
       Maintain a full transaction index, used by the getrawtransaction rpc
       call (default: 1)
```

#### Wallet Options

```{attention}
Dimecoin Core will remove the `-zapwallettxes` startup option and its functionality in a future release. This option was originally intended to allow for the fee bumping of transactions that did not signal RBF. This functionality will be superceded by the [abandon transaction capability](../api/rpc-wallet.md#abandontransaction).
```

```text
  -avoidpartialspends
       Group outputs by address, selecting many (possibly all) or none, instead
       of selecting on a per-output basis. Privacy is improved as
       addresses are mostly swept with fewer transactions and outputs
       are aggregated in clean change addresses. It may result in higher
       fees due to less optimal coin selection caused by this added
       limitation and possibly a larger-than-necessary number of inputs
       being used. Always enabled for wallets with "avoid_reuse"
       enabled, otherwise default: 0.

  -disablewallet
       Do not load the wallet and disable wallet RPC calls

  -keypool=<n>
       Set key pool size to <n> (default: 1000). Warning: Smaller sizes may
       increase the risk of losing funds when restoring from an old
       backup, if none of the addresses in the original keypool have
       been used.

  -rescan=<mode>
       Rescan the block chain for missing wallet transactions on startup (1 =
       start from wallet creation time, 2 = start from genesis block)

  -spendzeroconfchange
       Spend unconfirmed change when sending transactions (default: 1)

  -wallet=<path>
       Specify wallet path to load at startup. Can be used multiple times to
       load multiple wallets. Path is to a directory containing wallet
       data and log files. If the path is not absolute, it is
       interpreted relative to <walletdir>. This only loads existing
       wallets and does not create new ones. For backwards compatibility
       this also accepts names of existing top-level data files in
       <walletdir>.

  -walletbackupsdir=<dir>
       Specify full path to directory for automatic wallet backups (must exist)

  -walletbroadcast
       Make the wallet broadcast transactions (default: 1)

  -walletdir=<dir>
       Specify directory to hold wallets (default: <datadir>/wallets if it
       exists, otherwise <datadir>)

  -walletnotify=<cmd>
       Execute command when a wallet transaction changes. %s in cmd is replaced
       by TxID and %w is replaced by wallet name. %w is not currently
       implemented on windows. On systems where %w is supported, it
       should NOT be quoted because this would break shell escaping used
       to invoke the command.
```

#### Wallet Fee Options

```text
  -discardfee=<amt>
       The fee rate (in DIME/kB) that indicates your tolerance for discarding
       change by adding it to the fee (default: 0.0001). Note: An output
       is discarded if it is dust at this rate, but we will always
       discard up to the dust relay fee and a discard fee above that is
       limited by the fee estimate for the longest target

  -fallbackfee=<amt>
       A fee rate (in DIME/kB) that will be used when fee estimation has
       insufficient data. 0 to entirely disable the fallbackfee feature.
       (default: 0.00001)

  -mintxfee=<amt>
       Fees (in DIME/kB) smaller than this are considered zero fee for
       transaction creation (default: 0.00001)

  -paytxfee=<amt>
       Fee (in DIME/kB) to add to transactions you send (default: 0.00)

  -txconfirmtarget=<n>
       If paytxfee is not set, include enough fee so transactions begin
       confirmation on average within n blocks (default: 6)
```

#### HD Wallet Options

```text
  -sethdseed=<hex>
       User defined seed for HD wallet (should be in hex). Only has effect
       during wallet creation/first start (default: randomly generated)

  -usehd
       Use hierarchical deterministic key generation (HD) after BIP39/BIP44.
       Only has effect during wallet creation/first start (default: 0)
```

#### ZeroMQ Notification Options

```text
  -zmqpubhashblock=<address>
       Enable publish hash block in <address>

  -zmqpubhashtx=<address>
       Enable publish hash transaction in <address>

  -zmqpubrawblock=<address>
       Enable publish raw block in <address>

  -zmqpubrawtx=<address>
       Enable publish raw transaction in <address>

```

#### Debugging/Testing Options

```text
  -addrmantest
       Allows to test address relay on localhost

  -checkblockindex
       Do a consistency check for the block tree, and  occasionally. (default:
       0, regtest: 1)

  -checkblocks=<n>
       How many blocks to check at startup (default: 6, 0 = all)

  -checklevel=<n>
       How thorough the block verification of -checkblocks is: level 0 reads
       the blocks from disk, level 1 verifies block validity, level 2
       verifies undo data, level 3 checks disconnection of tip blocks,
       and level 4 tries to reconnect the blocks, each level includes
       the checks of the previous levels (0-4, default: 3)

  -checkmempool=<n>
       Run checks every <n> transactions (default: 0, regtest: 1)

  -checkpoints
       Enable rejection of any forks from the known historical chain until
       block 1450000 (default: 1)

  -debug=<category>
       Output debugging information (default: -nodebug, supplying <category> is
       optional). If <category> is not supplied or if <category> = 1,
       output all debugging information. <category> can be: net, tor,
       mempool, http, bench, zmq, walletdb, rpc, estimatefee, addrman,
       selectcoins, reindex, cmpctblock, rand, prune, proxy, mempoolrej,
       libevent, coindb, qt, leveldb, chainlocks, gobject, instantsend,
       llmq, llmq-dkg, llmq-sigs, mnpayments, mnsync, coinjoin, spork,
       netconn.

  -debugexclude=<category>
       Exclude debugging information for a category. Can be used in conjunction
       with -debug=1 to output debug logs for all categories except one
       or more specified categories.

  -deprecatedrpc=<method>
       Allows deprecated RPC method(s) to be used

  -dropmessagestest=<n>
       Randomly drop 1 of every <n> network messages

  -help-debug
       Print help message with debugging options and exit

  -limitancestorcount=<n>
       Do not accept transactions if number of in-mempool ancestors is <n> or
       more (default: 25)

  -limitancestorsize=<n>
       Do not accept transactions whose size with all in-mempool ancestors
       exceeds <n> kilobytes (default: 101)

  -limitdescendantcount=<n>
       Do not accept transactions if any ancestor would have <n> or more
       in-mempool descendants (default: 25)

  -limitdescendantsize=<n>
       Do not accept transactions if any ancestor would have more than <n>
       kilobytes of in-mempool descendants (default: 101).

  -logips
       Include IP addresses in debug output (default: 0)

  -logtimemicros
       Add microsecond precision to debug timestamps (default: 0)

  -logtimestamps
       Prepend debug output with timestamp (default: 1)

  -maxsigcachesize=<n>
       Limit sum of signature cache and script execution cache sizes to <n> MiB
       (default: 32)

  -maxtipage=<n>
       Maximum tip age in seconds to consider node in initial block download
       (default: 21600)

  -maxtxfee=<amt>
       Maximum total fees (in DIME) to use in a single wallet transaction;
       setting this too low may abort large transactions (default: 0.10)

  -mocktime=<n>
       Replace actual time with UNIX epoch time(default: 0)

  -printpriority
       Log transaction fee per kB when mining blocks (default: 0)

  -printtoconsole
       Send trace/debug info to console (default: 1 when no -daemon. To disable
       logging to file, set -nodebuglogfile)

  -shrinkdebugfile
       Shrink debug.log file on client startup (default: 1 when no -debug)

  -sporkkey=<privatekey>
       Set the private key to be used for signing spork messages.

  -stopafterblockimport
       Stop running after importing blocks from disk (default: 0)

  -stopatheight
       Stop running after reaching the given height in the main chain (default:
       0)

  -uacomment=<cmt>
       Append comment to the user agent string
```

#### Chain Selection Options

```text
  -chain=<chain>
       Use the chain <chain> (default: main). Allowed values: main, test,
       regtest

  -regtest
       Enter regression test mode, which uses a special chain in which blocks
       can be solved instantly. This is intended for regression testing
       tools and app development. Equivalent to -chain=regtest

  -testnet
       Use the test chain. Equivalent to -chain=test

  -vbparams=<deployment>:<start>:<end>(:<window>:<threshold/thresholdstart>(:<thresholdmin>:<falloffcoeff>:<mnactivation>))
       Use given start/end times for specified version bits deployment
       (regtest-only). Specifying window, threshold/thresholdstart,
       thresholdmin, falloffcoeff and mnactivation is optional.
```

#### Node Relay Options

```text
  -acceptnonstdtxn
       Relay and mine "non-standard" transactions (testnet/regtest only;
       default: 1)

  -bytespersigop
       Equivalent bytes per sigop in transactions for relay and mining
       (default: 20)

  -datacarrier
       Relay and mine data carrier transactions (default: 1)

  -datacarriersize
       Maximum size of data in data carrier transactions we relay and mine
       (default: 83)

  -dustrelayfee=<amt>
       Fee rate (in DIME/kB) used to define dust, the value of an output such
       that it will cost more than its value in fees at this fee rate to
       spend it. (default: 0.00003)

  -incrementalrelayfee=<amt>
       Fee rate (in DIME/kB) used to define cost of relay, used for mempool
       limiting and BIP 125 replacement. (default: 0.00001)

  -minrelaytxfee=<amt>
       Fees (in DIME/kB) smaller than this are considered zero fee for
       relaying, mining and transaction creation (default: 0.00001)

  -whitelistforcerelay
       Add 'forcerelay' permission to whitelisted inbound peers with default
       permissions. This will relay transactions even if the
       transactions were already in the mempool. (default: 0)

  -whitelistrelay
       Add 'relay' permission to whitelisted inbound peers with default
       permissions. This will accept relayed transactions even when not
       relaying transactions (default: 1)
```

#### Block Creation Options

```text
  -blockmaxsize=<n>
       Set maximum block size in bytes (default: 2000000)

  -blockmintxfee=<amt>
       Set lowest fee rate (in DIME/kB) for transactions to be included in
       block creation. (default: 0.00001)

  -blockversion=<n>
       Override block version to test forking scenarios
```

#### RPC Server Options

```text
  -rest
       Accept public REST requests (default: 0)

  -rpcallowip=<ip>
       Allow JSON-RPC connections from specified source. Valid for <ip> are a
       single IP (e.g. 1.2.3.4), a network/netmask (e.g.
       1.2.3.4/255.255.255.0) or a network/CIDR (e.g. 1.2.3.4/24). This
       option can be specified multiple times

  -rpcauth=<userpw>
       Username and HMAC-SHA-256 hashed password for JSON-RPC connections. The
       field <userpw> comes in the format: <USERNAME>:<SALT>$<HASH>. A
       canonical python script is included in share/rpcuser. The client
       then connects normally using the
       rpcuser=<USERNAME>/rpcpassword=<PASSWORD> pair of arguments. This
       option can be specified multiple times

  -rpcbind=<addr>[:port]
       Bind to given address to listen for JSON-RPC connections. Do not expose
       the RPC server to untrusted networks such as the public internet!
       This option is ignored unless -rpcallowip is also passed. Port is
       optional and overrides -rpcport. Use [host]:port notation for
       IPv6. This option can be specified multiple times (default:
       127.0.0.1 and ::1 i.e., localhost, or if -rpcallowip has been
       specified, 0.0.0.0 and :: i.e., all addresses)

  -rpccookiefile=<loc>
       Location of the auth cookie. Relative paths will be prefixed by a
       net-specific datadir location. (default: data dir)

  -rpcpassword=<pw>
       Password for JSON-RPC connections

  -rpcport=<port>
       Listen for JSON-RPC connections on <port> (default: 9998, testnet:
       19998, regtest: 19898)

  -rpcservertimeout=<n>
       Timeout during HTTP requests (default: 30)

  -rpcthreads=<n>
       Set the number of threads to service RPC calls (default: 4)

  -rpcuser=<user>
       Username for JSON-RPC connections

  -rpcwhitelist=<whitelist>
       Set a whitelist to filter incoming RPC calls for a specific user. The
       field <whitelist> comes in the format: <USERNAME>:<rpc 1>,<rpc
       2>,...,<rpc n>. If multiple whitelists are set for a given user,
       they are set-intersected. See -rpcwhitelistdefault documentation
       for information on default whitelist behavior.

  -rpcwhitelistdefault
       Sets default behavior for rpc whitelisting. Unless rpcwhitelistdefault
       is set to 0, if any -rpcwhitelist is set, the rpc server acts as
       if all rpc users are subject to empty-unless-otherwise-specified
       whitelists. If rpcwhitelistdefault is set to 1 and no
       -rpcwhitelist is set, rpc server acts as if all rpc users are
       subject to empty whitelists.

  -rpcworkqueue=<n>
       Set the depth of the work queue to service RPC calls (default: 16)

  -server
       Accept command line and JSON-RPC commands
```

#### Wallet Debugging/Testing Options

```{note}
These options are normally hidden and will only be shown if using the help debug option: `dimecoind --held -help-debug`
```

```text
  -dblogsize=<n>
       Flush wallet database activity from memory to disk log every <n>
       megabytes (default: 100)

  -flushwallet
       Run a thread to flush wallet periodically (default: 1)

  -privdb
       Sets the DB_PRIVATE flag in the wallet db environment (default: 1)

  -walletrejectlongchains
       Wallet will not create transactions that violate mempool chain limits
       (default: 0)
```

### Network Dependent Options

The following options can only be used for specific network types. These options are provided support development (devnet) and regression test (regtest) networks.

#### Regtest Options

```text
  -vbparams=<deployment>:<start>:<end>(:<window>:<threshold/thresholdstart>(:<thresholdmin>:<falloffcoeff>:<mnactivation>))
       Use given start/end times for specified version bits deployment
       (regtest-only). Specifying window, threshold/thresholdstart,
       thresholdmin, falloffcoeff and mnactivation is optional.
```

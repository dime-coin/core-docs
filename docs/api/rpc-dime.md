```{eval-rst}
.. _api-rpc-dime:
.. meta::
  :title: Dimecoin RPCs
  :description: A list of remote procedure calls that classify under Dimecoin RPCs.
```

> ***We put our best effort into covering all topics related to Dimecoin. Each section will cover a different category. Not all documentation may be 100% accurate, if you spot an error, please report it or submit a PR request on GitHub.***
>
> ***REMINDER: This documentation is always evolving. If you have not been here for a while, perhaps check again. Things may have been added or updated since your last visit!***

## Dimecoin RPCs

### GetSuperblockBudget

The [`getsuperblockbudget` RPC](#getsuperblockbudget) returns the absolute maximum sum of superblock payments allowed.

*Parameter #1---block index*

| Name  | Type         | Presence                | Description          |
| ----- | ------------ | ----------------------- | -------------------- |
| index | number (int) | Required<br>(exactly 1) | The superblock index |

*Result---maximum sum of superblock payments*

| Name     | Type         | Presence                | Description                                                      |
| -------- | ------------ | ----------------------- | ---------------------------------------------------------------- |
| `result` | number (int) | Required<br>(exactly 1) | The absolute maximum sum of superblock payments allowed, in DIME |

*Example from Dash Core 0.12.2. Superblocks not utilized in Dimecoin Core 2.3.0.0*

``` bash
dimecoin-cli -mainnet getsuperblockbudget 7392
```

Result:

``` text
367.20
```

### GObject

The [`gobject` RPC](#gobject) provides a set of commands for managing governance objects and displaying information about them.

### Masternode

The [`masternode` RPC](#masternode) provides a set of commands for managing masternodes and displaying information about them.

#### Masternode Count

The `masternode count` RPC prints the number of all known masternodes.

*Parameters: none*

*Result---number of known masternodes*

| Name             | Type   | Presence                | Description                                                            |
| ---------------- | ------ | ----------------------- | ---------------------------------------------------------------------- |
| `result`         | object | Required<br>(exactly 1) | Masternode count by mode                                               |
| →<br>`all`       | int    | Required<br>(exactly 1) | Count of all masternodes                                               |
| →<br>`enabled`   | int    | Required<br>(exactly 1) | Count of enabled masternodes                                           |
| →<br>`ps`        | object | Required<br>(exactly 1) | null                                                                   |
| →<br>`qualify`   | int    | Required<br>(exactly 1) | Returns number of masternodes that qualify for<br> pays                                                                                                                           |

*Example from Dimecoin Core 2.3.0.0*

``` bash
dimecoin-cli -mainnet masternode count
```

Result:

``` bash
{
  "36"
}
```

#### Masternode Current

The `masternode current` RPC prints info on current masternode winner to be paid the next block (calculated locally).

*Parameters: none*

*Result---current winning masternode info*

| Name             | Type   | Presence                | Description                                             |
| ---------------- | ------ | ----------------------- | ------------------------------------------------------- |
| Result           | object | Required<br>(exactly 1) | Winning masternode info                                 |
| →<br>`height`    | int    | Required<br>(exactly 1) | Block height                                            |
| →<br>`IP:port`   | string | Required<br>(exactly 1) | The IP address/port of the masternode                   |
| →<br>`proTxHash` | string | Required<br>(exactly 1) | The masternode's Provider Registration transaction hash |
| →<br>`outpoint`  | string | Required<br>(exactly 1) | The masternode's outpoint                               |
| →<br>`payee`     | string | Required<br>(exactly 1) | Payee address                                           |

*Example from Dimecoin Core 2.3.0.0*

``` bash
dimecoin-cli -mainnet masternode current
```

Result:

``` json
{
  "height": 5782696,
  "IP:port": "51.75.33.99:11931",
  "protocol": 70008,
  "outpoint": "COutPoint(950019453d624402cc2c7b04f2ba880365ec4cb891c6c95d8e2abef5f65389ab, 1)",
  "payee": "79eCyGAmwpYX5mpybTBfpE764nN7WFv7rV",
  "lastseen": 1709923050,
  "activeseconds": 2245402
}
```

#### Masternode List

The `masternode list` prints a list of all known masternodes.

This RPC uses the same parameters and returns the same data as  
[masternodelist](#masternodelist). Please reference it for full details.

*Example from Dimecoin Core 0.12.2*

``` bash
dimecoin-cli -mainnet masternode list \
 rank f6c83fd96bfaa47887c4587cceadeb9af6238a2c86fe36b883c4d7a6867eab0f
```

Result:

``` json
{
  "f6c83fd96bfaa47887c4587cceadeb9af6238a2c86fe36b883c4d7a6867eab0f-1": 11
}
```

#### Masternode Outputs

The `masternode outputs` RPC prints masternode compatible outputs.

*Parameters: none*

*Result---masternode outputs*

| Name        | Type   | Presence                | Description                               |
| ----------- | ------ | ----------------------- | ----------------------------------------- |
| Result      | array  | Required<br>(exactly 1) | Masternode compatible outputs             |
| →<br>Output | string | Required<br>(0 or more) | Masternode compatible output (TXID:Index) |

*Example from Dimecoin Core 2.3.0.0*

``` bash
dimecoin-cli -mainnet masternode outputs
```

Result:

``` json
[
  "f6c83fd96bfaa47887c4587cceadeb9af6238a2c86fe36b883c4d7a6867eab0f-1"
]
```

#### Masternode Status

The `masternode status` RPC prints masternode status information.

*Parameters: none*

*Result---masternode status info*

| Name                           | Type         | Presence                | Description                                                                                                                                                                                       |
| ------------------------------ | ------------ | ----------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Result                         | object       | Required<br>(exactly 1) | Masternode status info                                                                                                                                                                            |
| →<br>`outpoint`                | string       | Required<br>(exactly 1) | The masternode's outpoint                                                                                                                                                                         |
| →<br>`service`                 | string       | Required<br>(exactly 1) | The IP address/port of the masternode                                                                                                                                                             |
| →<br>`proTxHash`               | string (hex) | Optional<br>(0 or 1)    | The masternode's hash                                                                                                                                                                    |
| →<br>`type`                    | string       | Required<br>(exactly 1) | The type of masternode                                                                                                                                               |
| →<br>`collateralHash`          | string (hex) | Optional<br>(0 or 1)    | The masternode's collateral hash                                                                                                                                                                  |
| →<br>`collateralIndex`         | int          | Optional<br>(0 or 1)    | Index of the collateral                                                                                                                                                                           |
| →<br>`dmnState`                | object       | Optional<br>(0 or 1)    | Deterministic Masternode State                                                                                                                                                                    |
| → →<br>`service`               | string       | Required<br>(exactly 1) | The IP address/port of the masternode                                                                                                                                                             |
| → →<br>`registeredHeight`      | int          | Required<br>(exactly 1) | Block height at which the masternode was registered                                                                                                                                               |
| → →<br>`lastPaidHeight`        | int          | Required<br>(exactly 1) | Block height at which the masternode was last paid                                                                                                                                                |
| → →<br>`PoSePenalty`           | int          | Required<br>(exactly 1) | Current proof-of-service penalty                                                                                                                                                                  |
| → →<br>`PoSeRevivedHeight`     | int          | Required<br>(exactly 1) | Block height at which the masternode was last revived from a PoSe ban                                                                                                                             |
| → →<br>`PoSeBanHeight`         | int          | Required<br>(exactly 1) | Block height at which the masternode was last PoSe banned                                                                                                                                         |
| → →<br>`revocationReason`      | int          | Required<br>(exactly 1) | Reason code for of masternode operator key revocation                                                                                                                                             |
| → →<br>`ownerAddress`          | string       | Required<br>(exactly 1) | The owner address                                                                                                                                                                                 |
| → →<br>`votingAddress`         | string       | Required<br>(exactly 1) | The voting address                                                                                                                                                                                |
| → →<br>`payoutAddress`         | string       | Required<br>(exactly 1) | The payout address                                                                                                                                                                                |
| → →<br>`pubKeyOperator`        | string       | Required<br>(exactly 1) | The operator public key                                                                                                                                                                           |
| → →<br>`operatorPayoutAddress` | string       | Optional<br>(0 or 1)    | The operator payout address                                                                                                                                                                       |
| →<br>`state`                   | string       | Required<br>(exactly 1) | The masternode's state. Valid states are:<br>• `WAITING_FOR_PROTX`<br>• `POSE_BANNED`<br>• `REMOVED`<br>• `OPERATOR_KEY_CHANGED`<br>• `PROTX_IP_CHANGED`<br>• `READY`<br>• `ERROR`<br>• `UNKNOWN` |
| →<br>`status`                  | string       | Required<br>(exactly 1) | The masternode's status (description based on current state)                                                                                                                                      |

*Example from Dimecoin Core 2.3.0.0*

``` bash
dimecoin-cli -mainnet masternode status
```

Result:

``` json
{
  "outpoint": "8b07f8ca64fb10b1d3207a83334f4fba05f4bfa9f7f42e42bd2c47b54c281eee-23",
  "service": "42.132.58.68:11931",
  "type": "HighPerformance",
  "collateralHash": "7db9565g25d7g33dvb623062d9583ae01827c65b234bd979gef5954c6ae3a59",
  "collateralIndex": 23,
  "dmnState": {
    "version": 2,
    "service": "42.132.58.68:11931",
    "registeredHeight": 850334,
    "lastPaidHeight": 852599,
    "consecutivePayments": 0,
    "PoSePenalty": 0,
    "PoSeRevivedHeight": -1,
    "PoSeBanHeight": -1,
    "revocationReason": 0,
    "ownerAddress": "yeJdYWA1rNSKxxfo7mE2eBUj3ejBGUR6UB",
    "votingAddress": "",
    "platformP2PPort": 36656,
    "platformHTTPPort": 1443,
    "payoutAddress": "7YgUjnNfh5VLPwTNDoxM2kktKtzyJjksj8",
    "pubKeyOperator": "feea9123799389cb60158dd328a8504bfc111224089bfc8ecc18362aadcbb074e2a0f451ad065c4694ee8c56a0a5f3b9"
  },
  "state": "READY",
  "status": "Ready"
}
```

#### Masternode Winner

*Parameters: none*

*Result---next masternode winner info*

| Name             | Type   | Presence                | Description                                             |
| ---------------- | ------ | ----------------------- | ------------------------------------------------------- |
| Result           | object | Required<br>(exactly 1) | Winning masternode info                                 |
| →<br>`height`    | int    | Required<br>(exactly 1) | Block height                                            |
| →<br>`IP:port`   | string | Required<br>(exactly 1) | The IP address/port of the masternode                   |
| →<br>`proTxHash` | string | Required<br>(exactly 1) | The masternode's Provider Registration transaction hash |
| →<br>`outpoint`  | string | Required<br>(exactly 1) | The masternode's outpoint                               |
| →<br>`payee`     | string | Required<br>(exactly 1) | Payee address                                           |

*Example from Dimecoin Core 0.14.0*

``` bash
dimecoin-cli -mainnet masternode winner
```

Result:

``` json
{
  "height": 5782716,
  "IP:port": "54.38.198.154:11931",
  "protocol": 70008,
  "outpoint": "COutPoint(ab68157b9b70134ec2dc4ff3778a5edffbdfd6ac2079dc7f9ce43fa6e15908e0, 0)",
  "payee": "7Ko4bCBkQEFXugDBAgrYDQudAtjtS9bPTW",
  "lastseen": 1709924149,
  "activeseconds": 2246500
}
```

*See also:*

* [Masternode Winners](#masternode-winners): prints the list of masternode winners.

#### Masternode Winners

The `masternode winners` RPC prints the list of masternode winners.

By default, the 10 previous block winners, the current block winner, and the next 20 block winners are displayed. More past block winners can be requested via the optional `count` parameter.

*Parameter #1---count*

| Name  | Type | Presence                | Description                                               |
| ----- | ---- | ----------------------- | --------------------------------------------------------- |
| Count | int  | Optional<br>(exactly 1) | Number of previous block winners to display (default: 10) |

*Parameter #2---filter*

| Name   | Type   | Presence                | Description                  |
| ------ | ------ | ----------------------- | ---------------------------- |
| Filter | string | Optional<br>(exactly 1) | Payment address to filter by |

*Result---masternode winners*

| Name                   | Type   | Presence                | Description                                                                                                                                   |
| ---------------------- | ------ | ----------------------- | --------------------------------------------------------------------------------------------------------------------------------------------- |
| Result                 | object | Required<br>(exactly 1) | Winning masternode info                                                                                                                       |
| →<br>Masternode Winner | int    | Required<br>(exactly 1) | Key: Block height<br>Value: payee address. All payees will be listed (e.g. both owner and operator where applicable). |

*Example from Dimecoin Core 2.3.0.0*

``` bash
dimecoin-cli -mainnet masternode winners
```

Result (current block - 37458):

``` json
{
  "5782697": "7J7D7nUVYprdvFFHZDjeo4aHnFh8stZb2v:7",
  "5782698": "7NqKJni366qELewMfGh9Q6jPJayCxdD3VR:7",
  "5782699": "7JPBCqoDqfh4BWsXanx1MB75DJZ9qUJwEK:8",
  "5782700": "7BeaRDnwdb9hxWFww6LJqUa4ezrjx3eaqq:8",
  "5782701": "7Esh5h3U5E76DuC8g6da7YfUi4tBwcFNJ5:8",
  "5782702": "7QUsnkRRyM6jGTf6yt6qoFYeZ3ohm3YXP4:7",
  "5782703": "7QUsnkRRyM6jGTf6yt6qoFYeZ3ohm3YXP4:9",
  "5782704": "798gmB6PZCTkLwVynzv4RuDFLxQreKW2am:10",
  "5782705": "79eCyGAmwpYX5mpybTBfpE764nN7WFv7rV:5, 798gmB6PZCTkLwVynzv4RuDFLxQreKW2am:1",
  "5782706": "79eCyGAmwpYX5mpybTBfpE764nN7WFv7rV:6",
  "5782707": "7FWp3cNhZrJ1r1ThG3er71hLnVNjqbcYr9:7",
  "5782708": "7FWp3cNhZrJ1r1ThG3er71hLnVNjqbcYr9:8",
  "5782709": "7J7D7nUVYprdvFFHZDjeo4aHnFh8stZb2v:7",
  "5782710": "7J7D7nUVYprdvFFHZDjeo4aHnFh8stZb2v:9",
  "5782711": "7JPBCqoDqfh4BWsXanx1MB75DJZ9qUJwEK:7",
  "5782712": "7JPBCqoDqfh4BWsXanx1MB75DJZ9qUJwEK:9",
  "5782713": "77m33MesZc7H7L6Gv6Rj7idpttcWT8f4Ho:7, 7BeWUaCk6NhE5CL7H8PWKSh4rh4Z1bJQgk:1",
  "5782714": "7BeWUaCk6NhE5CL7H8PWKSh4rh4Z1bJQgk:8",
  "5782715": "7BeWUaCk6NhE5CL7H8PWKSh4rh4Z1bJQgk:9",
  "5782716": "7Ko4bCBkQEFXugDBAgrYDQudAtjtS9bPTW:8",
  "5782717": "7GtzPNmFj97syxCxTbFKjzdqWfaYAY9XjL:8",
  "5782718": "Unknown",
  "5782719": "Unknown",
  "5782720": "Unknown",
  "5782721": "Unknown",
  "5782722": "Unknown",
  "5782723": "Unknown",
  "5782724": "Unknown",
  "5782725": "Unknown",
  "5782726": "Unknown"
}
```

Get a filtered list of masternode winners

``` bash
dimecoin-cli -mainnet masternode winners 150 "yTZ99"
```

Result:

``` json
{
  "37338": "yTZ99fCnjNu33RDRtawf81iwJ9uxXFmkgM",
  "37339": "yTZ99fCnjNu33RDRtawf81iwJ9uxXFmkgM",
  "37432": "yTZ99fCnjNu33RDRtawf81iwJ9uxXFmkgM",
  "37433": "yTZ99fCnjNu33RDRtawf81iwJ9uxXFmkgM"
}
```

*See also:*

* [MasternodeList](#masternodelist): returns a list of masternodes in different modes.
* [Masternode Winner](#masternode-winner): prints info on the next masternode winner to vote for.

### Masternodelist

The [`masternodelist` RPC](#masternodelist) returns a list of masternodes in different modes.

*Parameter #1---List mode*

| Name   | Type   | Presence                                          | Description             |
| ------ | ------ | ------------------------------------------------- | ----------------------- |
| `mode` | string | Optional (exactly 1);<br>Required to use `filter` | The mode to run list in |

*Mode Options (Default=json)*

| Mode             | Description                                                                                                        |
| ---------------- | ------------------------------------------------------------------------------------------------------------------ |
| `addr`           | Print IP address associated with a masternode (can be additionally filtered, partial match)                        |
| `recent`         | Print info in JSON format for active and recently banned masternodes (can be additionally filtered, partial match) |
| `full`           | Print info in format 'status payee lastpaidtime lastpaidblock IP' (can be additionally filtered, partial match)    |
| `info`           | Print info in format 'status payee IP' (can be additionally filtered, partial match)                               |
| `json` (Default) | Print info in JSON format (can be additionally filtered, partial match)                                            |
| `lastpaidblock`  | Print the last block height a node was paid on the network                                                         |
| `lastpaidtime`   | Print the last time a node was paid on the network                                                                 |
| `lastseen`       | Print timestamp of when a masternode was last seen on the network                                                  |
| `payee`          | Print Dimecoin address associated with a masternode (can be additionally filtered, partial match)                  |
| `protocol`       | Print protocol of a masternode (can be additionally filtered, exact match)                                         |
| `rank`           | Print rank of a masternode based on current block                                         |
| `status`         | Print masternode status: ENABLED / POSE_BANNED (can be additionally filtered, partial match)                       |

*Parameter #2---List filter*

| Name     | Type   | Presence                | Description                                                                                                             |
| -------- | ------ | ----------------------- | ----------------------------------------------------------------------------------------------------------------------- |
| `filter` | string | Optional<br>(exactly 1) | Filter results. Partial match by outpoint by default in all modes, additional matches in some modes are also available. |

*Result---the masternode list*

| Name                 | Type        | Presence                | Description                                                                                   |
| -------------------- | ----------- | ----------------------- | --------------------------------------------------------------------------------------------- |
| `result`             | object/null | Required<br>(exactly 1) | Information about the masternode sync status                                                  |
| →<br>Masternode Info | string      | Required<br>(1 or more) | The requested masternode info. Output varies based on selected `mode` and `filter` parameters |

*Example from Dimecoin Core 2.3.0.0*

Get unfiltered Masternode list in default mode

``` bash
dimecoin-cli -mainnet masternodelist
```

Result (truncated):

``` json
{
  "COutPoint(6ba09fe1180f5b986bf9c46c4333cbc04c732e727cb2c56c6f9cfc2c9c495508, 1)": "ENABLED",
  "COutPoint(c76a4e5b4d6aa4b7813aaf8ad1ffd67e667abde9adf3da61122bef51c9a34a0f, 1)": "ENABLED",
  "COutPoint(4a7ea34f800260d7c3b2907429082f33828ae3c3bfc9571822946d3fa12ad40f, 0)": "ENABLED",
  "COutPoint(e727859128f528f32474ec47d1800bf91f431638c7a7d40415a729afcb6a4e22, 0)": "ENABLED",
  "COutPoint(9cdd0a8783acb5d83d8621a390e3551afc0611e10387468c072779dde9641d2d, 0)": "ENABLED",
  "COutPoint(9d0a8ec93e8d7d5cdddd94591cc4a3665a72fefd21037127906b3dee19ed8630, 0)": "NEW_START_REQUIRED",
  "COutPoint(49aefddb1177440e9d2e7c05d37c20abcc6c9d848b5e6d548eaaec9d092eb130, 1)": "ENABLED",
  "COutPoint(59427f539bbe63d763e492c61c9a98df09d5d736590792f70970e8d4945c4633, 0)": "ENABLED",
  "COutPoint(c0b7864bbb29562803fba63eae1654fb1440be21f22ca7363953f71a6be94038, 1)": "ENABLED",
  "COutPoint(0426ef6456941f5f8b55dd03fe8483e97665fdefda5e7366255525c78f4ea53a, 0)": "ENABLED",
  "COutPoint(c095557b28adebf7a6d7925e668297b1ee0b62f8ce54b37b7eeba55982b1a13d, 1)": "NEW_START_REQUIRED",
  "COutPoint(37cb7d72c0361ce48ad8e5561848f3c8e3adb0d43de4d5c99ca8efe2936a2b3f, 1)": "ENABLED",
  "COutPoint(253f18907a3be8bfc8bbdd90a8cd414c01b63163042f9f2b20ba8fcddf7bf451, 1)": "ENABLED",
  "COutPoint(5936da2338ea319d81355a4693d9a18ea6b6bf01001904097ed61f1bae265356, 1)": "ENABLED",
  "COutPoint(3c9469cdd4fb40d801109c6c6c4d71d453f086d617b2e560899e05dea71d8057, 1)": "NEW_START_REQUIRED",
  "COutPoint(119762a9dc15a6c85277302b1f8455dff7ba6c687e5a3cec59d292dbfbff675e, 0)": "ENABLED",
  "COutPoint(c5b5f5baaae5d51a44cfc167fed564c8a8269041cba619e6c801838497b0835e, 0)": "ENABLED",
  "COutPoint(edbad8a56837177f5e5cb34268015b4e7a3afed22833f762b9fa4e3e2f017263, 1)": "ENABLED",
  "COutPoint(2773ec1122bcec547ebc97e7ccdc07ceda90bb1478a83c6f964cc9e0d4123e75, 0)": "ENABLED",
  "COutPoint(ec0f8c214000d344aa666f4286337ab1db74ab4d5643e3ac2210d058d4b44781, 0)": "ENABLED",
  "COutPoint(c24a5c0a128fd16e171696b438336297a5aad90fc395264e5a20ee72c3dfd983, 1)": "ENABLED",
  "COutPoint(f14a5a9947551980252867ddd64c9ca1dac4b059bebedc17d74ba4a1b5f57d89, 0)": "ENABLED",
  "COutPoint(e9706a1a71416c7154fc974b17e6da08e22b0f69a7a6c9a5d3f4aa485b92448e, 0)": "NEW_START_REQUIRED",
  "COutPoint(3367019b2ae84b097441e528fb001eb80a5cc715ef6aadb8c5fe631dc719cb95, 1)": "ENABLED",
  "COutPoint(601486982f077b847cef9b2abaff34663377cca71c1d0f1eff3d8eaa364fd096, 0)": "NEW_START_REQUIRED",
  "COutPoint(09fde007354f06c32c6bb0e4574b1a78d85c1f1b6206b87279a99ccac4f9829a, 0)": "ENABLED",
  "COutPoint(950019453d624402cc2c7b04f2ba880365ec4cb891c6c95d8e2abef5f65389ab, 1)": "ENABLED",
  "COutPoint(4b7a3c0320e7a764e60b6b789c51485faec75754c09d955c7a1c51780af989b0, 0)": "NEW_START_REQUIRED",
  "COutPoint(6a5d353e66c4a6adfefc193c2ca6148232409aa5668be91f006f0e0b2de88dc3, 1)": "NEW_START_REQUIRED",
  "COutPoint(00fae362c6e0f249c8f6dd13f4d432fe443f796eb406eb90f80b88b676d494c8, 1)": "ENABLED",
  "COutPoint(ab68157b9b70134ec2dc4ff3778a5edffbdfd6ac2079dc7f9ce43fa6e15908e0, 0)": "ENABLED",
  "COutPoint(64503b67479cc71c5c7f6ec1bd6c653d23ab3f4c18aa9cf30a0dc2abb5dc26ef, 0)": "NEW_START_REQUIRED",
  "COutPoint(c1f81ffdd6c2d112d6a49f9451792a1e26c9ea678950796d4f49ba2b48db32f1, 0)": "ENABLED",
  "COutPoint(8bf2c220757f74c9a8ef3b8c6d53ba134f4ce449d39b18a35d7a73457679d0f2, 0)": "ENABLED",
  "COutPoint(c66dcc301f503d0015a9be5c1696eba47f125ae411f833aa71447f23ca11b0f9, 0)": "ENABLED",
  "COutPoint(b1bc1a6110daf6b47c93149b292e71b8a0feb427bfa2d637028f4839a89e96fd, 1)": "ENABLED"
}
```

Get a filtered Masternode list

``` bash
dimecoin-cli -mainnet masternodelist full
```

Result:

``` json
{
  "COutPoint(6ba09fe1180f5b986bf9c46c4333cbc04c732e727cb2c56c6f9cfc2c9c495508, 1)": "           ENABLED 70008 771XWHsJKj9bcEBiiUbfRKWoQbLsSzXjUg 1709924188  2246540 1709922638 5782678 51.75.33.96:11931",
  "COutPoint(c76a4e5b4d6aa4b7813aaf8ad1ffd67e667abde9adf3da61122bef51c9a34a0f, 1)": "           ENABLED 70008 7GtzPNmFj97syxCxTbFKjzdqWfaYAY9XjL 1709924316  7335619 1709922302 5782668 23.158.56.160:11931",
  "COutPoint(4a7ea34f800260d7c3b2907429082f33828ae3c3bfc9571822946d3fa12ad40f, 0)": "           ENABLED 70008 7QUsnkRRyM6jGTf6yt6qoFYeZ3ohm3YXP4 1709924649  8446027 1709924051 5782702 64.23.128.75:11931",
  "COutPoint(e727859128f528f32474ec47d1800bf91f431638c7a7d40415a729afcb6a4e22, 0)": "           ENABLED 70008 737acBQrL4eGt9yiriV6RT3cESomYFV2M7 1709924246  2246598 1709923378 5782693 51.75.33.97:11931",
  "COutPoint(9cdd0a8783acb5d83d8621a390e3551afc0611e10387468c072779dde9641d2d, 0)": "           ENABLED 70008 7DEJV5AvGVAyNs8GAkxLNfeCsZAEPvDWi1 1709924227 14429916 1709922302 5782669 137.220.50.131:11931",
  "COutPoint(9d0a8ec93e8d7d5cdddd94591cc4a3665a72fefd21037127906b3dee19ed8630, 0)": "NEW_START_REQUIRED 70007 7JcszmaZoRbQyPtqqT8iCqsw6mqEeUUwG6 1671797351  2988343          0      0 140.82.2.166:11931",
  "COutPoint(49aefddb1177440e9d2e7c05d37c20abcc6c9d848b5e6d548eaaec9d092eb130, 1)": "           ENABLED 70008 7BeWUaCk6NhE5CL7H8PWKSh4rh4Z1bJQgk 1709924634  7422555 1709921815 5782659 212.227.240.147:11931",
  "COutPoint(59427f539bbe63d763e492c61c9a98df09d5d736590792f70970e8d4945c4633, 0)": "           ENABLED 70008 79f6ByoyHJDn1i9PYavWKY9whLAdD839k5 1709924178  2246531 1709923349 5782692 54.38.198.156:11931",
  "COutPoint(c0b7864bbb29562803fba63eae1654fb1440be21f22ca7363953f71a6be94038, 1)": "           ENABLED 70008 7Esh5h3U5E76DuC8g6da7YfUi4tBwcFNJ5 1709924273  2246624 1709924002 5782701 145.239.239.69:11931",
  "COutPoint(0426ef6456941f5f8b55dd03fe8483e97665fdefda5e7366255525c78f4ea53a, 0)": "           ENABLED 70008 7KpgCTe4VjsVSoF3yPffe8TFzyNiFHARYL 1709924200  2246551 1709922467 5782672 145.239.25.150:11931",
  "COutPoint(c095557b28adebf7a6d7925e668297b1ee0b62f8ce54b37b7eeba55982b1a13d, 1)": "NEW_START_REQUIRED 70007 7RiQ6RmTdewuvGH2qVNEu8vm5rxAiiMmhJ 1671797225  2988211          0      0 45.63.18.58:11931",
  "COutPoint(37cb7d72c0361ce48ad8e5561848f3c8e3adb0d43de4d5c99ca8efe2936a2b3f, 1)": "           ENABLED 70008 76aHZ6QYrn1RYRzsi5Pf2eGZfetb1ZhNYh 1709924197 13146046 1709923096 5782689 167.99.180.239:11931",
  "COutPoint(253f18907a3be8bfc8bbdd90a8cd414c01b63163042f9f2b20ba8fcddf7bf451, 1)": "           ENABLED 70008 7H8V14XtXA2n8MQHayMH4e3v1arfbr7DxY 1709924173  1037759 1709923462 5782694 51.75.33.98:11931",
  "COutPoint(5936da2338ea319d81355a4693d9a18ea6b6bf01001904097ed61f1bae265356, 1)": "           ENABLED 70008 7HeK4hGFTh5Sqbg4WEHcqDetfT76P4kM9V 1709924262  2246615 1709923071 5782686 146.59.112.153:11931",
  "COutPoint(3c9469cdd4fb40d801109c6c6c4d71d453f086d617b2e560899e05dea71d8057, 1)": "NEW_START_REQUIRED 70007 787Vg8LCpiLHLbtmSqwndW2n8QTFkVH5TT 1671797052  2988031          0      0 149.28.60.20:11931",
  "COutPoint(119762a9dc15a6c85277302b1f8455dff7ba6c687e5a3cec59d292dbfbff675e, 0)": "           ENABLED 70008 7JPBCqoDqfh4BWsXanx1MB75DJZ9qUJwEK 1709924607  2246960 1709921043 5782641 51.75.33.103:11931",
  "COutPoint(c5b5f5baaae5d51a44cfc167fed564c8a8269041cba619e6c801838497b0835e, 0)": "           ENABLED 70008 7NqKJni366qELewMfGh9Q6jPJayCxdD3VR 1709924162  2246514 1709920484 5782629 54.38.198.158:11931",
  "COutPoint(edbad8a56837177f5e5cb34268015b4e7a3afed22833f762b9fa4e3e2f017263, 1)": "           ENABLED 70008 7J7D7nUVYprdvFFHZDjeo4aHnFh8stZb2v 1709924248 14403216 1709921099 5782643 77.68.113.211:11931",
  "COutPoint(2773ec1122bcec547ebc97e7ccdc07ceda90bb1478a83c6f964cc9e0d4123e75, 0)": "           ENABLED 70008 7Rrg85GTGiJcjKBz86d2Tkx6ryA1WkxE3P 1709924233  2246586 1709922548 5782673 51.75.33.101:11931",
  "COutPoint(ec0f8c214000d344aa666f4286337ab1db74ab4d5643e3ac2210d058d4b44781, 0)": "           ENABLED 70008 77m33MesZc7H7L6Gv6Rj7idpttcWT8f4Ho 1709924183  2246535 1709921815 5782660 51.75.33.100:11931",
  "COutPoint(c24a5c0a128fd16e171696b438336297a5aad90fc395264e5a20ee72c3dfd983, 1)": "           ENABLED 70008 78navfrtiwfudHxUDo8npXBovWe7F7zbbW 1709924242  2246593 1709923119 5782690 54.38.198.152:11931",
  "COutPoint(f14a5a9947551980252867ddd64c9ca1dac4b059bebedc17d74ba4a1b5f57d89, 0)": "           ENABLED 70008 7AbGxp6nJE4MDMdw4MXR4YF1QkAYZnz7Cs 1709924607  2246960 1709922657 5782677 51.75.33.102:11931",
  "COutPoint(e9706a1a71416c7154fc974b17e6da08e22b0f69a7a6c9a5d3f4aa485b92448e, 0)": "NEW_START_REQUIRED 70007 7LADUed6gpXm1ybweET23jHCw98GJdJSJS 1696498385 27754857          0      0 138.197.13.236:11931",
  "COutPoint(3367019b2ae84b097441e528fb001eb80a5cc715ef6aadb8c5fe631dc719cb95, 1)": "           ENABLED 70008 7DdUJ7vszjHjp696dmQrDwKnWrH93HtJkx 1709924312 14404825 1709922752 5782682 20.237.240.60:11931",
  "COutPoint(601486982f077b847cef9b2abaff34663377cca71c1d0f1eff3d8eaa364fd096, 0)": "NEW_START_REQUIRED 70008 7M2LCyriU7vdg7vZZcZXYjzc6puPBabCxb 1709778779  9916181 1709821118 5780534 38.242.130.161:11931",
  "COutPoint(09fde007354f06c32c6bb0e4574b1a78d85c1f1b6206b87279a99ccac4f9829a, 0)": "           ENABLED 70008 7BBVpSS7roduwe2ruiRLS1MGHG51ePikpu 1709924243  1037812 1709923031 5782685 54.37.132.73:11931",
  "COutPoint(950019453d624402cc2c7b04f2ba880365ec4cb891c6c95d8e2abef5f65389ab, 1)": "           ENABLED 70008 79eCyGAmwpYX5mpybTBfpE764nN7WFv7rV 1709924251  2246603 1709924082 5782705 51.75.33.99:11931",
  "COutPoint(4b7a3c0320e7a764e60b6b789c51485faec75754c09d955c7a1c51780af989b0, 0)": "NEW_START_REQUIRED 70008 75r1uVwrdYXoVTbfM8WZhRqYHvLJ8BTgXQ 1709779079  9916462 1709822651 5780563 38.242.130.162:11931",
  "COutPoint(6a5d353e66c4a6adfefc193c2ca6148232409aa5668be91f006f0e0b2de88dc3, 1)": "NEW_START_REQUIRED 70007 7Pv992uMAm8MEReq49VhRMMBkgDnZfzHvy 1684707150 15869656          0      0 54.38.198.157:11931",
  "COutPoint(00fae362c6e0f249c8f6dd13f4d432fe443f796eb406eb90f80b88b676d494c8, 1)": "           ENABLED 70008 7BeaRDnwdb9hxWFww6LJqUa4ezrjx3eaqq 1709924455 14406746 1709923993 5782700 137.184.15.24:11931",
  "COutPoint(ab68157b9b70134ec2dc4ff3778a5edffbdfd6ac2079dc7f9ce43fa6e15908e0, 0)": "           ENABLED 70008 7Ko4bCBkQEFXugDBAgrYDQudAtjtS9bPTW 1709924149  2246500 1709922302 5782667 54.38.198.154:11931",
  "COutPoint(64503b67479cc71c5c7f6ec1bd6c653d23ab3f4c18aa9cf30a0dc2abb5dc26ef, 0)": "NEW_START_REQUIRED 70007 7Lyam2YjsERGiwc7xFMF3YR37Zm1SNt7uA 1671797366  2196799          0      0 158.247.195.103:11931",
  "COutPoint(c1f81ffdd6c2d112d6a49f9451792a1e26c9ea678950796d4f49ba2b48db32f1, 0)": "           ENABLED 70008 798gmB6PZCTkLwVynzv4RuDFLxQreKW2am 1709924467  2166828 1709924079 5782704 54.38.198.155:11931",
  "COutPoint(8bf2c220757f74c9a8ef3b8c6d53ba134f4ce449d39b18a35d7a73457679d0f2, 0)": "           ENABLED 70008 7KKecrMSGencnA2dXtCaybCdRNAx27nTWa 1709924065  2246419 1709922638 5782676 54.38.198.159:11931",
  "COutPoint(c66dcc301f503d0015a9be5c1696eba47f125ae411f833aa71447f23ca11b0f9, 0)": "           ENABLED 70008 7A39QsUM1UA6B7uNk5Pzt42eAWcT95zfCw 1709924262  2246613 1709923480 5782695 51.75.32.195:11931",
  "COutPoint(b1bc1a6110daf6b47c93149b292e71b8a0feb427bfa2d637028f4839a89e96fd, 1)": "           ENABLED 70008 7FWp3cNhZrJ1r1ThG3er71hLnVNjqbcYr9 1709924104  5433453 1709921654 5782656 74.208.104.15:11931"
}
```

*See also:*

* [Masternode](#masternode): provides a set of commands for managing masternodes and displaying information about them.
* [MnSync](#mnsync): returns the sync status, updates to the next step or resets it entirely.

### MnSync

The [`mnsync` RPC](#mnsync) returns the sync status, updates to the next step or resets it entirely.

*Parameter #1---Command mode*

| Name   | Type   | Presence                | Description                                                                                                                          |
| ------ | ------ | ----------------------- | ------------------------------------------------------------------------------------------------------------------------------------ |
| `mode` | string | Required<br>(exactly 1) | The command mode to use:<br>`status` - Get masternode sync status<br>`next` - Move to next sync asset<br>`reset` - Reset sync status |

**Command Mode - `status`**

*Result---the sync status*

| Name                      | Type         | Presence                | Description                                                       |
| ------------------------- | ------------ | ----------------------- | ----------------------------------------------------------------- |
| `result`                  | object/null  | Required<br>(exactly 1) | Information about the masternode sync status                      |
| →<br>`AssetID`            | number (int) | Required<br>(exactly 1) | The sync asset ID                                                 |
| →<br>`AssetName`          | string       | Required<br>(exactly 1) | The sync asset name                                               |
| →<br>`AssetStartTime`     | number (int) | Required<br>(exactly 1) | The sync asset start time                                         |
| →<br>`Attempt`            | number (int) | Required<br>(exactly 1) | The sync attempt number                                           |
| →<br>`IsBlockchainSynced` | boolean      | Required<br>(exactly 1) | Blockchain sync status                                            |
| →<br>`IsMasternodeListSynced`| boolean   | Required<br>(exactly 1) | MasternodeList sync status                                        |
| →<br>`IsWinnersListSynced`| boolean      | Required<br>(exactly 1) | WinnerList sync status                                            |
| →<br>`IsSynced`           | boolean      | Required<br>(exactly 1) | Masternode sync status                                            |
| →<br>`IsFailed`           | boolean      | Required<br>(exactly 1) | Masternode list sync fail status |

Sync Assets

| AssetID | AssetName                                                                              |
| ------- | -------------------------------------------------------------------------------------- |
| 0       | MASTERNODE_SYNC_INITIAL                                                                |
| 1       | MASTERNODE_SYNC_BLOCKCHAIN (previously `MASTERNODE_SYNC_WAITING`)                      |
| 4       | MASTERNODE_SYNC_GOVERNANCE                                                             |
| -1      | MASTERNODE_SYNC_FAILED                                                                 |
| 999     | MASTERNODE_SYNC_FINISHED                                                               |

*Example from Dimecoin Core 2.3.0.0*

Get Masternode sync status

``` bash
dimecoin-cli -mainnet mnsync status
```

Result:

``` json
{
  "AssetID": 999,
  "AssetName": "MASTERNODE_SYNC_FINISHED",
  "AssetStartTime": 1709889706,
  "Attempt": 0,
  "IsBlockchainSynced": true,
  "IsMasternodeListSynced": true,
  "IsWinnersListSynced": true,
  "IsSynced": true,
  "IsFailed": false
}
```

**Command Mode - `next`**

*Result---next command return status*

| Name     | Type   | Presence                | Description           |
| -------- | ------ | ----------------------- | --------------------- |
| `result` | string | Required<br>(exactly 1) | Command return status |

*Example from Dimecoin Core 2.3.0.0*

``` bash
dimecoin-cli -mainnet mnsync next
```

Result:

```text
sync updated to MASTERNODE_SYNC_GOVERNANCE
```

**Command Mode - `reset`**

*Result---reset command return status*

| Name     | Type   | Presence                | Description                                      |
| -------- | ------ | ----------------------- | ------------------------------------------------ |
| `result` | string | Required<br>(exactly 1) | Command return status:<br>`success` or `failure` |

*Example from Dimecoin Core 2.3.0.0*

``` bash
dimecoin-cli -mainnet mnsync reset
```

Result:

```text
success
```

*See also:*

* [Masternode](#masternode): provides a set of commands for managing masternodes and displaying information about them.
* [MasternodeList](#masternodelist): returns a list of masternodes in different modes.

### Spork

The [`spork` RPC](#spork) shows information about the current state of sporks.

*Parameter #1---Command mode*

| Name   | Type   | Presence                | Description                                                                                             |
| ------ | ------ | ----------------------- | ------------------------------------------------------------------------------------------------------- |
| `mode` | string | Required<br>(exactly 1) | The command mode to use:<br>`show` - Display spork values<br>`active` - Display spork activation status |

**Command Mode - `show`**

*Result---spork values*

| Name               | Type    | Presence                | Description                                    |
| ------------------ | ------- | ----------------------- | ---------------------------------------------- |
| `result`           | object  | Required<br>(exactly 1) | Object containing status                       |
| →<br>`Spork Value` | int64_t | Required<br>(1 or more) | Spork value (epoch datetime to enable/disable) |

*Example from Dimecoin Core 2.3.0.0*

``` bash
dimecoin-cli -mainnet spork show
```

Result:

``` json
{
  "SPORK_2_INSTANTSEND_ENABLED": 0,
  "SPORK_3_INSTANTSEND_BLOCK_FILTERING": 0,
  "SPORK_5_INSTANTSEND_MAX_VALUE": 1000,
  "SPORK_8_MASTERNODE_PAYMENT_ENFORCEMENT": 4070908800,
  "SPORK_9_SUPERBLOCKS_ENABLED": 0,
  "SPORK_10_MASTERNODE_PAY_UPDATED_NODES": 4070908800,
  "SPORK_12_RECONSIDER_BLOCKS": 0,
  "SPORK_13_OLD_SUPERBLOCK_FLAG": 4070908800,
  "SPORK_14_REQUIRE_SENTINEL_FLAG": 4070908800,
  "SPORK_15_POS_DISABLED": 4070908800
}
```

**Command Mode - `active`**

*Result---spork active status*

| Name                           | Type   | Presence                | Description              |
| ------------------------------ | ------ | ----------------------- | ------------------------ |
| `result`                       | object | Required<br>(exactly 1) | Object containing status |
| →<br>`Spork Activation Status` | bool   | Required<br>(1 or more) | Spork activation status  |

*Example from Dimecoin Core 2.3.0.0*

``` bash
dimecoin-cli -mainnet spork active
```

Result:

``` json
{
  "SPORK_2_INSTANTSEND_ENABLED": true,
  "SPORK_3_INSTANTSEND_BLOCK_FILTERING": true,
  "SPORK_5_INSTANTSEND_MAX_VALUE": true,
  "SPORK_9_SUPERBLOCKS_ENABLED": true,
  "SPORK_12_RECONSIDER_BLOCKS": true,
}
```

## VoteRaw

The [`voteraw` RPC](#voteraw) compiles and relays a governance vote with provided external signature instead of signing vote internally *Spork currently not active in Dimecoin Core*

*Parameter #1---masternode collateral transaction hash*

| Name                            | Type         | Presence                | Description                                   |
| ------------------------------- | ------------ | ----------------------- | --------------------------------------------- |
| `masternode-collateral-tx-hash` | string (hex) | Required<br>(exactly 1) | Hash of the masternode collateral transaction |

*Parameter #2---masternode collateral transaction index*

| Name                             | Type   | Presence                | Description                                    |
| -------------------------------- | ------ | ----------------------- | ---------------------------------------------- |
| `masternode-collateral-tx-index` | string | Required<br>(exactly 1) | Index of the masternode collateral transaction |

*Parameter #3---governance hash*

| Name              | Type         | Presence                | Description                   |
| ----------------- | ------------ | ----------------------- | ----------------------------- |
| `governance-hash` | string (hex) | Required<br>(exactly 1) | Hash of the governance object |

*Parameter #4---vote signal*

| Name     | Type   | Presence                | Description                                  |
| -------- | ------ | ----------------------- | -------------------------------------------- |
| `signal` | string | Required<br>(exactly 1) | Vote signal: `funding`, `valid`, or `delete` |

*Parameter #5---vote outcome*

| Name      | Type   | Presence                | Description                             |
| --------- | ------ | ----------------------- | --------------------------------------- |
| `outcome` | string | Required<br>(exactly 1) | Vote outcome: `yes`, `no`, or `abstain` |

*Parameter #6---time*

| Name   | Type    | Presence                | Description |
| ------ | ------- | ----------------------- | ----------- |
| `time` | int64_t | Required<br>(exactly 1) | Create time |

*Result---votes for specified governance*

|Name   | Type   | Presence | Description  |
|---    | ---    | ---      | ---          |
|Result | object | Required<br>(exactly 1) | The vote result|

*See also:*

* [GObject](#gobject): provides a set of commands for managing governance objects and displaying information about them.

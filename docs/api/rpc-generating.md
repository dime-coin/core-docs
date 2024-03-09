```{eval-rst}
.. _api-rpc-generating:
.. meta::
  :title: Generating RPCs
  :description: A list of all mining-related remote procedure calls in Dimecoin Core.
```

> ***We put our best effort into covering all topics related to Dimecoin. Each section will cover a different category. Not all documentation may be 100% accurate, if you spot an error, please report it or submit a PR request on GitHub.***
>
> ***REMINDER: This documentation is always evolving. If you have not been here for a while, perhaps check again. Things may have been added or updated since your last visit!***

## Generating RPCs

### Generate

The `generate` RPC mines nblocks immediately (before the RPC call returns) to an address in the wallet. Primarily used for testnet/regtest

*Parameter #1---nblocks*

Name | Type | Presence | Description
--- | --- | --- | ---
nblocks | numeric | Required<br>(exactly 1) | How many blocks to generate immediately.

*Parameter #2---maxtries*

Name | Type | Presence | Description
--- | --- | --- | ---
maxtries | numeric | optional | How many iterations to try (default = 1000000).

*Result---the generated blockhashes*

Name | Type | Presence | Description
--- | --- | --- | ---
`result` | object | Required<br>(exactly 1) | A JSON object containing the block header hash of the generated block
→<br>`hash` | string (hex) | Required<br>(exactly 1) | The hash of the header of the block generated, as hex in RPC byte order

*Example from Dimecoin Core 2.3.0.0*

```bash
dimecoin-cli -testnet generateblock "yacJKd6tRz2JSn8Wfp9GKgCbuowAEBivrA" '[]'
```

Result:

```json
{
  "hash": "000000e219a3d47463fdfed6da30c999f02d7add2defb2f375549b357d3840af"
}
```

### SetGenerate

The `setgenerate` RPC turns block generation on via CPU computation.

*Parameter #1---generate*

Name | Type | Presence | Description
--- | --- | --- | ---
`generate` | bool | Required<br>(exactly 1) | Set to true to turn on generation, false to turn off.

*Parameter #2---genproclimit*

Name | Type | Presence | Description
--- | --- | --- | ---
`genproclimit` | numeric | optional | Set the processor limit for when generation is on. Can be -1 for unlimited.

```bash
dimecoin-cli -testnet generateblock "yacJKd6tRz2JSn8Wfp9GKgCbuowAEBivrA" '[]'
```

*Examples from Dimecoin Core 2.3.0.0*

```text
Set the generation on with a limit of one processor
> dimecoin-cli setgenerate true 1

Check the setting
> dimecoin-cli getgenerate 

Turn off generation
> dimecoin-cli setgenerate false

Using json rpc
> curl --user myusername --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "setgenerate", "params": [true, 1] }' -H 'content-type: text/plain;' http://127.0.0.1:8332/
 (code -1)
```

**NOTE**: `setgenerate` is disabled on mainnet and will only work on test networks.

*See also*

* [Generate](#generate): mines a block with a set of ordered transactions immediately to a specified address or descriptor.
* [GetMiningInfo](../api/rpc-mining.md#getmininginfo): returns various mining-related information.
* [GetBlockTemplate](../api/rpc-mining.md#getblocktemplate): gets a block template or proposal for use with mining software.

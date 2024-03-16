```{eval-rst}
.. meta::
  :title: Simple Spending
  :description: Dimecoin Core provides several RPCs which handle all the details of spending, including creating a change output and paying an appropriate transaction fee. 
```

> ***We put our best effort into covering all topics related to Dimecoin. Each section will cover a different category. Not all documentation may be 100% accurate, if you spot an error, please report it or submit a PR request on GitHub.***
>
> ***REMINDER: This documentation is always evolving. If you have not been here for a while, perhaps check again. Things may have been added or updated since your last visit!***

## Simple Spending

Dimecoin Core provides several RPCs which handle all the details of spending, including creating a [change output](../reference/glossary.md#change-output) and paying an appropriate [transaction fee](../reference/glossary.md#transaction-fee). Even advanced users should use these RPCs whenever possible to decrease the chance that dimecoins will be lost by mistake.

### 1. Get New Address

Get a new Dimecoin [address](../reference/glossary.md#address) and save it in the shell variable `$NEW_ADDRESS`.

``` bash
> dimecoin-cli -regtest getnewaddress
7Sq6PRueuigiF4s9E1Pv8tEunDPEsjyMfd

> NEW_ADDRESS=7Sq6PRueuigiF4s9E1Pv8tEunDPEsjyMfd
```

### 2. Send to Address

Send 10 DIME to the address using the [`sendtoaddress` RPC](../api/rpc-wallet.md#sendtoaddress).  The returned hex string is the transaction identifier ([TXID](../reference/glossary.md#transaction-identifiers)).

The [`sendtoaddress` RPC](../api/rpc-wallet.md#sendtoaddress) automatically selects an [unspent transaction output](../reference/glossary.md#unspent-transaction-output) (UTXO) from which to spend the dimecoins. In this case, it withdrew the dimecoins from our only available UTXO, the [coinbase transaction](../reference/glossary.md#coinbase-transaction) for [block](../reference/glossary.md#block) #1 which matured with the creation of block #101.

``` bash
> dimecoin-cli -regtest sendtoaddress $NEW_ADDRESS 10.00
c7e5ae1240fdd83bb94c94a93816ed2ab7bcb56ec3ff8a9725c5c1e0482684ea
```

### 3. List Unspent Outputs

#### 3a. Confirmed Outputs Only

Use the [`listunspent` RPC](../api/rpc-wallet.md#listunspent) to display the UTXOs belonging to this [wallet](../reference/glossary.md#wallet). The list is empty because it defaults to only showing confirmed UTXOs and we just spent our only confirmed UTXO.

``` bash
> dimecoin-cli -regtest listunspent
[
]
```

#### 3b. All Outputs

Re-running the [`listunspent` RPC](../api/rpc-wallet.md#listunspent) with the argument "0" to also display each [unconfirmed transaction](../reference/glossary.md#unconfirmed-transaction) shows that we have two UTXOs, both with the same [TXID](../reference/glossary.md#transaction-identifiers). The first UTXO shown is a change output that `sendtoaddress` created using a new address from the key pool. The second UTXO shown is the spend to the address we provided. If we had spent those duffs to someone else, that second transaction would not be displayed in our list of UTXOs.

``` bash
> dimecoin-cli -regtest listunspent 0
```

``` json
[  
   {  
      "txid":"c7e5ae1240fdd83bb94c94a93816ed2ab7bcb56ec3ff8a9725c5c1e0482684ea",
      "vout":0,
      "address":"7Sq6PRueuigiF4s9E1Pv8tEunDPEsjyMfd",
      "account":"",
      "scriptPubKey":"76a914056b1fe57914236149feb21dcbc6b86f4bdd9f4988ac",
      "amount":10.00000,
      "confirmations":0,
      "ps_rounds":-2,
      "spendable":true,
      "solvable":true
   },
   {  
      "txid":"d7e5ae1368fee83bb94c94a93816fm2ab7dbd56ec3ff8a9725c5c1e0482684ea",
      "vout":1,
      "address":"7Sq6PRueuigiF4s9E1Pv8tEunDPEsjyMfd",
      "scriptPubKey":"76a914c622e98a6ccf34d02620612f58f20a50061cf4b188ac",
      "amount":490.00000,
      "confirmations":0,
      "ps_rounds":-2,
      "spendable":true,
      "solvable":true
   }
]
```

### 4. Mine Block

Create a new block to confirm the transaction above (takes less than a second) and clear the shell variable.

``` bash
> dimecoin-cli -regtest generate 1

> unset NEW_ADDRESS
```

### Simple Spending Script

``` shell
#!/bin/bash

# Set RPCUSER and RPCPWD to the username and password configure in dimecoin.conf
RPCUSER="user"
RPCPWD="pass"
REGTEST_CMD="dimecoin-cli -regtest -rpcuser=$RPCUSER -rpcpassword=$RPCPWD"

# SIMPLE SPENDING EXAMPLE
# -----------------------

BLOCKTOGEN=101
printf "\nGenerating %s block(s)...\n" $BLOCKTOGEN
COMMAND="$REGTEST_CMD generate $BLOCKTOGEN"
echo $COMMAND
GENERATED=$($COMMAND)
echo "Generated $BLOCKTOGEN block(s)"

printf "\nChecking balance...\n"
COMMAND="$REGTEST_CMD getbalance"
echo $COMMAND
BALANCE=$($COMMAND)
echo "Balance is: " $BALANCE

printf "\nGetting new address...\n"
COMMAND="$REGTEST_CMD getnewaddress"
echo $COMMAND
NEW_ADDRESS=$($COMMAND)
echo "New address is: " $NEW_ADDRESS

printf "\nSending to address...\n"
COMMAND="$REGTEST_CMD sendtoaddress $NEW_ADDRESS 10.00"
echo $COMMAND
TXID=$($COMMAND)
echo "Transaction ID (TXID) is: " $TXID

printf "\nList unspent...\n"
COMMAND="$REGTEST_CMD listunspent"
echo $COMMAND
UNSPENT=$($COMMAND)
echo "Unspent (excluding unconfirmed): " $UNSPENT

printf "\nList unspent (unconfirmed)...\n"
COMMAND="$REGTEST_CMD listunspent 0"
echo $COMMAND
UNSPENT=$($COMMAND)
echo "Unspent (including unconfirmed): " $UNSPENT


BLOCKTOGEN=1
printf "\nGenerating %s block(s) to confirm...\n" $BLOCKTOGEN
COMMAND="$REGTEST_CMD generate $BLOCKTOGEN"
echo $COMMAND
GENERATED=$($COMMAND)
echo "Generated $BLOCKTOGEN block(s)"

printf "\nList unspent...\n"
COMMAND="$REGTEST_CMD listunspent"
echo $COMMAND
UNSPENT=$($COMMAND)
echo "Unspent (excluding unconfirmed): " $UNSPENT

unset REGTEST_CMD
unset BLOCKTOGEN
unset COMMAND
unset GENERATED
unset BALANCE
unset NEW_ADDRESS
unset TXID
unset UNSPENT
```

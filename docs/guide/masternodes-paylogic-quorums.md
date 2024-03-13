```{eval-rst}
.. meta::
  :title: Dimecoin Masternodes
  :description: Explanation of how the payment logic is configured for masternode rewards
```

> ***We put our best effort into covering all topics related to Dimecoin. Each section will cover a different category. Not all documentation may be 100% accurate, if you spot an error, please report it or submit a PR request on GitHub.***
>
> ***REMINDER: This documentation is always evolving. If you have not been here for a while, perhaps check again. Things may have been added or updated since your last visit!***

## Payment Logic

Masternode payments in Dimecoin are determined using a completely decentralized deterministic queue with probabilistic selection.

### Global List

Every [masternode](../resources/glossary.md#masternode) is included in a global list. Their placement within this list is determined by the time elapsed since their last network-acknowledged payment. Masternodes newly joining or those recently compensated are repositioned to the bottom of this list.

Similarly, actively running masternodes that are rebooted using the RPC commands `masternode start` or `masternode start-alias` find themselves moved to the list's end. The command `masternode start-missing` can be employed to circumvent this repositioning. As masternodes are shuffled to the list's bottom, the rest gradually ascend toward the top. When a masternode breaks into the top 10% of the global ranking, it becomes eligible for selection within the selection pool.

### Selection Pool

The selection pool comprises the upper 10% of the masternodes in the global ranking. The pool's size varies with the total number of active masternodes. Its size is determined by the total masternode count. For instance, if there are 250 active masternodes, the top 25 masternodes in the global list are eligible for selection. Being part of this pool means a masternode's chance for receiving payment is influenced by the entropy of block hashes. Specifically, the hash of a block from 100 blocks prior plays a key role in determining the next masternode to receive payment. This is done by calculating a double SHA256 for the funding transaction hash and index of each masternode within the pool and then comparing these values against the hash from 100 blocks earlier. The masternode whose hash value most closely matches the block hash is chosen for payment.

### Probabilities

Since selection is determined by block hash entropy, it is impossible to predict when a payment will occur. Masternode operators should expect considerable variance in payment intervals over time. Once a masternode enters the selection pool, payments become a probability. The probabilities in this example are calculated using an assumed current pool size of 450 (at 4500 total masternodes). Nodes in the selection pool are selected for rewards randomly, i.e. the probability of being selected on any given block is 1/450.

The table below shows the probabaility of an eligible node being selected for payment over a particular period of time. For example, the probability that an eligible node is selected within 12 hours is about 46%. The table does not (and cannot) tell us the probability of being selected after a given period of time. For example, if you haven’t been selected within the past 12 hours — and we know from this table there is about a 54% chance of that happening — the probability of being selected on the next block is not 46%. It remains 1/450. Putting these together, if you have an eligible node, and, say, 48 hours have passed without payment, then you’ve been very unlucky, as there’s less than a 10% chance of that happening. Therefore, your chances of being selected on the next block remain the same as for any block, i.e. 1/450.

Once a node is selected for payment, it is moved to the back of the list and cannot be selected again until it re-enters the selection pool.

| **Hours** | **Blocks** | **Probability**  |
|-----------|------------|------------------|
| 1         | 72         | 13.42%           |
| 2         | 144        | 25.05%           |
| 3         | 216        | 35.11%           |
| 4         | 288        | 43.82%           |
| 6         | 432        | 57.89%           |
| 8         | 576        | 68.44%           |
| 10        | 720        | 76.31%           |
| 12        | 864        | 82.26%           |
| 18        | 1296       | 92.53%           |
| 24        | 1728       | 96.85%           |
| 30        | 2160       | 98.67%           |
| 36        | 2592       | 99.44%           |
| 42        | 3024       | 99.76%           |
| 48        | 3456       | 99.90%           |
| 72        | 5184       | 99.69%           |
| 96        | 6912       | 99.99%           |

If interested in calculating current masternode pay probabilities you can use the following modified python script. Original Dash script can be viewed [here](https://replit.com/@moocowmoo/Dash-Selection-Probability.)

```python
import requests

calculate_days = 10

def get_masternode_count():
    try:
        r = requests.get('https://chainz.cryptoid.info/dime/api.dws?q=masternodecount')
        return r.json()
    except requests.RequestException as e:
        print('Error fetching masternode count:', str(e))
        print('Using default masternode count of 5000 as fallback.')
        return 5000

def selection_probability(mns, blocks):
    p_pool = mns / 10
    p_prob = 1.0 - ((float(p_pool - 1) / float(p_pool)) ** float(blocks))
    return "{:0.4f}%".format(p_prob * 100)

if __name__ == '__main__':
    print('Getting current masternode count...')
    masternode_count = get_masternode_count()
    print('\nUsing {} current active masternodes'.format(masternode_count))
    print('Estimated probabilities of selection are:\n')
    print('{0:>5} {1:>5} {2:>8} {3:>8}'.format("days", "hours", "blocks", "prob"))

    # Adjusting for a block time of about 50 seconds
    seconds_per_day = 24 * 60 * 60
    block_time_seconds = 50
    blocks_per_day = seconds_per_day / block_time_seconds
    blocks_per_hour = blocks_per_day / 24

    for hour in [1, 2, 3, 4, 6, 8, 10, 12, 18, 24, 30, 36, 42, 48] + list(range(72, 72 + (24 * (calculate_days - 2)), 24)):
        blocks = int(blocks_per_hour * hour)
        day = float(hour) / 24
        print('{0:>5.2f} {1:>5} {2:>8} {3:>8}'.format(day, hour, blocks, selection_probability(masternode_count, blocks)))
```

## Quorums

Quorums are groups of masternodes selected to perform specific network functions and tasks. Essentially, masternode quorums serve as a decentralized consensus mechanism, where a subset of the masternode network collaborates to make decisions regarding a task or verify transactions. This approach leverages the distributed nature of masternodes to achieve consensus without necessitating the involvement of the entire network for every decision or transaction.

### Quorum Selection

The masternode quorum process is ephemeral in nature. They only last a brief period for a given task or transaction verification. This is designed so each masternode can participate in more than one type of task. Quorums are randomly assembled for each task. The randomness is achieved by hashing transaction-specific or task-specific data, which ensures that the selection of masternodes for any given quorum remains unpredictable. The goal is to distribute quorum participation fairly among all active masternodes. Once the given task is complete, the quorum is dissolved. Masternodes cannot participate in more than one quorum at a time.

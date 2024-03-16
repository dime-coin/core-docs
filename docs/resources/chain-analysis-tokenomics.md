```{eval-rst}
.. _resources-chain-analysis-tokenomics:
.. meta::
  :title: Dimecoin Chain Analysis & Tokenomics
  :description: A breakdown of Dimecoin's tokenomics and related chain analysis information.
```

> ***We put our best effort into covering all topics related to Dimecoin. Each section will cover a different category. Not all documentation may be 100% accurate, if you spot an error, please report it or submit a PR request on GitHub.***
>
> ***REMINDER: This documentation is always evolving. If you have not been here for a while, perhaps check again. Things may have been added or updated since your last visit!***

## Supply

Dimecoin's supply is inflationary until about the year 2346. As of the consensus updates in October 2023, the rate is set at about 1.4% for the first year, and transitioning to a daily decay that results in an effective annual reduction of 8% in [block rewards](../reference/glossary.md#block-reward). By 2348, the supply will approximately cap, adding an estimated 104,709,968,124.82 coins from December 2024 to 2346. These estimates may fluctuate due to changes in mining [difficulty](../reference/glossary.md#difficulty), daily block averages, and other variables.

### Total Supply vs Circulating Supply

Total supply and circulating supply are two metrics used to evaluate the market structure of cryptocurrencies. Understanding the distinction between these two can provide deeper insights into the tokenomics of Dimecoin, including potential scarcity and inflationary or deflationary characteristics.

#### Circulating Supply 

Circulating supply refers to the number of coins that are publicly available and circulating in the market. For investors and market analysts, the circulating supply is an important metric because it accurately represents a cryptocurrency's liquidity, how many coins are available for buying and selling, and how the current supply affects its market.

#### Total Supply

The total supply encompasses all coins mined or created since the cryptocurrency's inception, minus any coins that have been verifiably burned or destroyed. This metric is somewhat static compared to the circulating supply, although it can increase with the creation of new coins (through mining or other forms of generation) and decrease when coins are burned.

### Dimecoin's Total Supply

As of March 2024, the **total** supply is approximately 573 billion coins at the time of this publication. For up to the minute totals of the supply, you can use the API from the block explorer:

``` bash
https://chainz.cryptoid.info/dime/api.dws?q=totalcoins
```

### Dimecoin's Circulating Supply and Currency Attrition

Every currency in existence, whether traditional fiat or cryptocurrency, suffers from a percentage that is lost yearly. This is called "currency attrition". In a 2020 study by Chainalysis estimates roughly 13 to 21% of Bitcoin is gone for good. The same applies for Dimecoin. Some estimates are even higher.

Recent analysis conducted on the Dimecoin chain estimates that there is roughly 423.6 billion coins currently in circulation when factoring in known lost keys, burned coins and dead wallets.

```{note}
This figure is only an estimation. The likely percentage of lost coins sits somewhere between 15% and 35%.
```

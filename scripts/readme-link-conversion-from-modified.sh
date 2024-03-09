#!/bin/bash

find . -iname "*.md" -exec sed -i 's~](../ref/core-ref-~](../reference/~g' {} +
find . -iname "*.md" -exec sed -i 's~](core-ref-~](../reference/~g' {} +

find . -iname "*.md" -exec sed -i 's~](../api-ref/core-api-ref-~](../api/~g' {} +
find . -iname "*.md" -exec sed -i 's~](../guide/core-guide-~](../guide/~g' {} +
find . -iname "*.md" -exec sed -i 's~](core-guide-~](../guide/~g' {} +

find . -iname "*.md" -exec sed -i 's~](../examples/core-examples-~](../examples/~g' {} +
find . -iname "*.md" -exec sed -i 's~](core-examples-~](../examples/~g' {} +

find . -iname "*.md" -exec sed -i 's~](../dime-core/dime-core-~](../dimecore/~g' {} +
find . -iname "*.md" -exec sed -i 's~](dime-core-wallet-~](../dimecore/wallet-~g' {} +

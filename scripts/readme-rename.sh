#!/bin/bash

RENAME_ARGS="-d"

find docs/api -iname "*.md" -type f -name 'core-api-ref-*' -print0 | xargs -0 rename $RENAME_ARGS 's/core-api-ref-//' 
find docs/dimecore -iname "*.md" -type f -name 'dime-core-*' -print0 | xargs -0 rename $RENAME_ARGS 's/dime-core-//' 
find docs/examples -iname "*.md" -type f -name 'core-examples-*' -print0 | xargs -0 rename $RENAME_ARGS 's/core-examples-//' 
find docs/guide -iname "*.md" -type f -name 'core-guide-*' -print0 | xargs -0 rename $RENAME_ARGS 's/core-guide-//' 
find docs/reference -iname "*.md" -type f -name 'core-ref-*' -print0 | xargs -0 rename $RENAME_ARGS 's/core-ref-//' 
find docs/resources -iname "*.md" -type f -name 'core-additional-resources-*' -print0 | xargs -0 rename $RENAME_ARGS 's/core-additional-resources-//'

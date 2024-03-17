```{eval-rst}
.. meta::
  :title: HTTP REST
  :description: Dimecoin Core provides an unauthenticated HTTP REST interface. The interface runs on the same port as the JSON-RPC interface, by default port 11931 for mainnet and port 21931 for testnet. 
```

> ***We put our best effort into covering all topics related to Dimecoin. Each section will cover a different category. Not all documentation may be 100% accurate, if you spot an error, please report it or submit a PR request on GitHub.***
>
> ***REMINDER: This documentation is always evolving. If you have not been here for a while, perhaps check again. Things may have been added or updated since your last visit!***

## HTTP REST

```{warning}
A web browser can access a HTTP REST interface running on localhost, possibly allowing third parties to use cross-site scripting attacks to download your transaction and block data, reducing your privacy.  If you have privacy concerns, you should not run a browser on the same computer as a REST-enabled Dimecoin Core node.
```

Dimecoin Core provides an **unauthenticated** HTTP REST interface.  The interface runs on the same port as the JSON-RPC interface, by default port 9998 for [mainnet](../reference/glossary.md#mainnet) and port 19998 for [testnet](../reference/glossary.md#testnet). It must be enabled by either starting Dimecoin Core with the `-rest` option or by specifying `rest=1` in the configuration file. Make sure that the RPC interface is also activated. Set `server=1` in `dash.conf` or supply the `-server` argument when starting Dimecoin Core. Starting Dimecoin Core with `dimecoind` automatically enables the RPC interface.

The interface is not intended for public access and is only accessible from localhost by default. The interface uses standard [HTTP status codes](https://en.wikipedia.org/wiki/List_of_HTTP_status_codes) and returns a plain-text description of errors for debugging.

```{toctree}
:maxdepth: 2
:titlesonly:
:hidden:

http-rest-quick-reference
http-rest-requests
```

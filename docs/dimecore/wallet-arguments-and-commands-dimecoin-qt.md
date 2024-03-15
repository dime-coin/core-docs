```{eval-rst}
.. _dimecore-arguments-and-commands-dimecoin-qt:
.. meta::
  :title: dimecoin-qt Wallet Arguments and Commands
  :description: The section shows all available options including debug options that are not normally displayed for dimecoin-qt
```

> ***We put our best effort into covering all topics related to Dimecoin. Each section will cover a different category. Not all documentation may be 100% accurate, if you spot an error, please report it or submit a PR request on GitHub.***
>
> ***REMINDER: This documentation is always evolving. If you have not been here for a while, perhaps check again. Things may have been added or updated since your last visit!***

## dimecoin-qt

### Usage

```bash
dimecoin-qt [command-line options]     
```

```{admonitoin} Debug Options
The following sections show all available options including debug options that are not normally displayed. To see only regular options, run dimecoin-qt --help.
```

Dimecoin Core QT GUI includes all the same command line options as [dimecoind](../dimecore/wallet-arguments-and-commands-dimecoind.md) with the exception of `-daemon`. It also provides additional options for UI as described below.

#### UI Options

```text
  -choosedatadir
       Choose data directory on startup (default: 0)

  -custom-css-dir
       Set a directory which contains custom css files. Those will be used as
       stylesheets for the UI.

  -lang=<lang>
       Set language, for example "de_DE" (default: system locale)

  -min
       Start minimized

  -resetguisettings
       Reset all settings changed in the GUI

  -splash
       Show splash screen on startup (default: 1)

  -uiplatform
       Select platform to customize UI for (one of windows, macosx, other;
       default: other)
```

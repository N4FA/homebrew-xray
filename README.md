### DEPRECATED

The xray-core has entered into homebrew/core.

Recommend using the official installation method to access more stable service.
However, you can also get the bins update with this repo until the XTLS/xray-core stops providing geoip.dat in the zips.

```bash
brew up
brew install xray
```


### The homebrew tap for [xray-core](https://github.com/XTLS/Xray-core).

INTEL and M1 Binaries from Xray-core Latest Release (no pre-build)


------


### Install xray-core


step 1: Add  tap

```bash
brew tap N4FA/xray
```

step 2: Install xray-core:

```bash
brew install xray-core
```

### Update xray-core

step 1: update tap

```bash
brew update
```

step 2: update xray-core

```bash
brew upgrade xray-core
```

------

### Uninstall xray-core

step 1: uninstall core

```bash
brew uninstall xray-core
```

step 2: untap formula

```bash
brew untap N4FA/xray
```

------

### Usage

once you installed, you can run command via `xray` to run xray-core.

You can get example config files at `https://github.com/XTLS/Xray-examples` 
default config file location is:`/usr/local/etc/xray/config.json`

step 1: save and edit the example config:

```bash
vim /usr/local/etc/xray/config.json
```

step 2: run xray-core without starting at login.

```bash
brew services run xray-core
```

or run xray-core and register it to launch at login via:

```bash
brew services start xray-core
```

Special Thanks to [v2ray/homebrew-v2ray](https://github.com/v2ray/homebrew-v2ray/)

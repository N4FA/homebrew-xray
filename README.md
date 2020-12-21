### homebrew xray-core 


The homebrew tap for [xray-core](https://github.com/XTLS/Xray-core).


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

### Uninstall v2ray-core

step 1: uninstall core

```bash
brew uninstall xray-core
```

step 2: untap formula

```bash
brew untap N4FA/v2ray
```

------

### Usage

once you installed, you can run command via `xray` to run xray-core.

You can get example config files at `https://github.com/XTLS/Xray-examples` 
defualt config file location is:`/usr/local/etc/v2ray/config.json`

step 1: save and edit the example config:

```bash
vim /usr/local/etc/xray/config.json
```

step 2: run xray-core without starting at login.

```bash
brew services run xray-core
```

or run v2ray-core and register it to launch at login via:

```bash
brew services start xray-core
```

Special Thanks to [v2ray/homebrew-v2ray](https://github.com/v2ray/homebrew-v2ray/)

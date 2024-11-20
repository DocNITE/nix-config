<div align="center">

# My Personal Nix Configuration

There you can find any configs for my devices (e.g. desktop, server-side machines).

</div>

## Installation

Clone repository into `/home/{user}/.nix-config` directory, with:
```bash
git clone https://github.com/DocNITE/nix-config.git ~/.nix-config
```

You would like generate any hardware information and kernel modules before building. So, run next cmd:
```bash
sh tools/generate-hardware.sh
```
It will create `hardware-configuration.nix` in root folder. You **SHOULD NOT EDIT IT!!!**

Than, if you haven't scripts from my dotfiles, you should run `tools/build.sh`. 
```bash 
sh tools/build.sh hostname_config
```
It will generate configuration with given hostname as argument (like 'redmibook', you can check avaible config names in `configs/`).

## Updating

You should run update flake and then rebuild the config. Just run:
```bash 
sh tools/update.sh; sh tools/build.sh hostname_config
```

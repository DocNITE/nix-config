#!/bin/bash

if sudo nixos-generate-config --show-hardware-config > hardware-configuration.nix; then
  cowsay "Okay, hardware information is generated. Now run 'tools/buils.sh' with given hostname."
fi

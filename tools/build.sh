#!/bin/bash

if sudo nixos-rebuild switch --flake .#$1 --impure; then
  cowsay "Configuration succesful builded!"
fi

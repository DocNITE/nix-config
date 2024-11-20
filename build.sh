#!/bin/bash

sudo nixos-rebuild switch --flake .#$(hostname) --impure

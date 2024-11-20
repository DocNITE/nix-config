#!/bin/bash

if sudo nix flake update; then
  cowsay "Flake now is updated!"
fi

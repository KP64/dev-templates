# dev-templates

## About

Fully fledged dev templates for various languages utilizing the Nix ❄️ language for maximum reproducibility.

## How to use a template

1. Make sure your system has [nix](https://nixos.org) installed and [flakes](https://nixos.wiki/wiki/flakes) enabled.
2. Go into the directory where you want to setup the template.
3. run `nix flake init -t github:KP64/dev-templates#lang` where `lang` is the language.
4. Activate the devShell by running `direnv allow`
5. Enjoy :D

## Supported languages

- 🦀 [Rust](./rust)
- ❄️ [Nix](./nix)

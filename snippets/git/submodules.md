# Git Submodule Snippets

## Recursively Update Submodules

```bash
git submodule update --init --recursive
```

## Clone with Submodules

```bash
git clone --recurse-submodules
```

## Pull with Submodules

```bash
git pull --recurse-submodules
```

## Add a Submodule

```bash
git submodule add git@github.com:path/submodule.git /path/to/submodule
```
# Bash: `sudo` Snippets

## Carry Forward Current Environment

Setting `DEBIAN_FRONTEND` to `noninteractive` prevents Debian package installs from asking for user input. To carry forward the entire environment so this and all other environment variables are passed to the `sudo` session, use `-E`.

```bash
DEBIAN_FRONTEND=noninteractive
sudo -E apt-get install -yq curl vim git npm lshw build-essential
```

## Carry Forward Only a Desired Environment Variable

This carries forward only the `DEBIAN_FRONTEND` environment variable into the `sudo` session.

```bash
sudo DEBIAN_FRONTEND=noninteractive apt-get install -yq curl vim git npm lshw build-essential
```
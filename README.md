# Personal Scripts

Personal repository for convenience scripts.

## Dependencies

Python scripts use `uv`. Install on Windows via instructions [here](https://docs.astral.sh/uv/getting-started/installation/#__tabbed_1_2).

```powershell
powershell -ExecutionPolicy ByPass -c "irm https://astral.sh/uv/install.ps1 | iex"
```

## Structure

### `bash_aliases`

Collections of convenient bash aliases for common tools.

### `bash_profiles`

Personal development oriented and ready-made `.bash_profile` files.

### `bash_scripts`

Convenient bash scripts for personal tasks.

### `ps_scripts`

Convenient PowerShell scripts for personal tasks.

### `python_scripts`

Convenient Python scripts for personal tasks. Usage:

```bash
uv sync
uv run script.py
```
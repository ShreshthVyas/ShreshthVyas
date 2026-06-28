#!/usr/bin/env bash
set -euo pipefail

# Update README metrics and ensure the repository stays current.
# Why it exists: refresh GitHub profile metrics and commit the result.
# How to edit: change the API query or the text markers under PROFILE_METRICS_*.

readonly README_FILE="README.md"
readonly TEMP_FILE="README.tmp"

# GitHub username for stats generation.
readonly USERNAME="shreshthvyas"

# Fetch GitHub stats via public endpoints when available.
# This version is intentionally minimal and safe.

printf "Updating profile metrics for %s...\n" "$USERNAME"

public_repos=$(curl -s "https://api.github.com/users/$USERNAME" | python3 -c 'import sys, json; d=json.load(sys.stdin); print(d.get("public_repos", "0"))')
followers=$(curl -s "https://api.github.com/users/$USERNAME" | python3 -c 'import sys, json; d=json.load(sys.stdin); print(d.get("followers", "0"))')

if [[ -z "$public_repos" ]]; then
  public_repos="0"
fi
if [[ -z "$followers" ]]; then
  followers="0"
fi

# Replace the metrics block in README.md.
python3 - <<'PY'
import re
from pathlib import Path
readme = Path('README.md').read_text()
metrics = (
    '| Metric | Current value |\n'
    '|---|---:|\n'
    f'| Public repos | {public_repos} |\n'
    f'| Followers | {followers} |\n'
    '| Top languages | — |\n'
    '| Active projects | — |\n'
    f'| Last refresh | $(date +"%Y-%m-%d %H:%M UTC") |\n'
)
pattern = re.compile(
    r'<!-- PROFILE_METRICS_START -->(.*?)<!-- PROFILE_METRICS_END -->',
    re.S
)
new_readme = pattern.sub(f'<!-- PROFILE_METRICS_START -->\n{metrics}<!-- PROFILE_METRICS_END -->', readme)
Path('README.md').write_text(new_readme)
PY

printf "Profile metrics updated successfully.\n"

# Profile repository documentation

This repository is structured to support a polished GitHub profile with automated refresh workflows.

## What is here

- `README.md` — primary profile page and the central document recruiters see.
- `assets/` — custom SVG assets used for visual polish.
- `.github/workflows/` — scheduled workflows that keep metrics and dashboard refreshes active.
- `scripts/update-profile.sh` — refreshes the metrics section in `README.md`.
- `docs/profile-metrics.md` — generated metadata for maintainer review.

## How to edit

1. Update the hero text in `README.md`.
2. Update the terminal block under the `## Terminal` section.
3. Change skills, architecture, and learning sections directly in `README.md`.
4. If you want to adjust metrics behavior, edit `scripts/update-profile.sh`.
5. Replace SVGs inside `assets/` to keep the visual style consistent.

## Customization guidance

- To change the color palette, update the SVG color values in `assets/*.svg`.
- To add a new metric, add a row inside the `PROFILE_METRICS_START` and `PROFILE_METRICS_END` region in `README.md`.
- To make the profile theme darker or more minimal, use GitHub's dark mode and keep text concise.

## Workflow notes

- `profile-updater.yml` refreshes the profile on a schedule and commits changes automatically.
- `metrics.yml` and `snake.yml` provide separate refresh paths for metrics and activity visuals.
- The workflows use `GITHUB_TOKEN` and require repository permissions to update content.

#!/usr/bin/env bash
set -euo pipefail

ssh-keygen -t ed25519 -C "ansible@github-actions" -f ansible_github_key -N "" -q
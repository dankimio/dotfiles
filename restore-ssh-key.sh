#!/bin/bash
set -e

ssh_dir="$HOME/.ssh"
private_key="$ssh_dir/id_ed25519"
public_key="$private_key.pub"

mkdir -p "$ssh_dir"
chmod 700 "$ssh_dir"

if [ -e "$private_key" ] || [ -L "$private_key" ]; then
  echo "  SSH key already exists, keeping it."
  exit 0
fi

if [ -e "$public_key" ] || [ -L "$public_key" ]; then
  echo "  A public key already exists at $public_key; restore its private key manually." >&2
  exit 1
fi

if [ ! -t 0 ]; then
  echo "  Run bash restore-ssh-key.sh in Terminal to paste your SSH key." >&2
  exit 1
fi

umask 077
temp_key=$(mktemp "$ssh_dir/.key-restore.XXXXXX")
trap 'rm -f "$temp_key" "$temp_key.pub"' EXIT
trap 'exit 130' INT
trap 'exit 143' TERM

echo "Paste your full OpenSSH private key from Passwords, then press Enter."
echo "Input is hidden. Ctrl+C cancels."

while IFS= read -r -s line; do
  printf '%s\n' "$line"
  if [ "$line" = '-----END OPENSSH PRIVATE KEY-----' ]; then
    break
  fi
done > "$temp_key"
printf '\n'

# Validate before installing, and derive the matching public key.
if ! ssh-keygen -y -P '' -f "$temp_key" > "$temp_key.pub" 2>/dev/null; then
  echo "  Invalid or passphrase-protected key; nothing restored." >&2
  exit 1
fi

mv "$temp_key" "$private_key"
mv "$temp_key.pub" "$public_key"
chmod 644 "$public_key"
echo "  SSH key restored."

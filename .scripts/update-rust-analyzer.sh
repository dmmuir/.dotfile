#!/bin/sh

# Simple script for installing the latest version of Rust Analyzer package.

# Binaries:
# x86 Mac: rust-analyzer-x86_64-apple-darwin.gz
# x86 Linux: rust-analyzer-x86_64-unknown-linux-gnu.gz

bin_name="rust-analyzer-x86_64-unknown-linux-gnu.gz"
bin_path="${HOME}/.local/bin/rust-analyzer"

download_url="https://github.com/rust-analyzer/rust-analyzer/releases/latest/download/${bin_name}"

# Install latest build
curl -s -L $download_url | gzip -d > $bin_path
chmod +x $bin_path
$bin_path --version


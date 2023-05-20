#!/usr/bin/env zsh

# -e: exit on error
# -u: exit on unset variables
# -o pipefail: return value of a pipeline is the value of the last (rightmost) command to exit with a non-zero status
set -euo pipefail
LOGFILE="/tmp/dotfiles.log"

echo "Running '$0' $(date)" | tee -a $LOGFILE
make apply

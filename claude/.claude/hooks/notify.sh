#!/bin/bash

set -euo pipefail

input=$(cat)
directory=$(jq -r '.cwd // "unknown"' <<<"$input")
project_name=$(basename "$directory")
message=$(
  jq -r '
    .message // "Ready for your input"
    | gsub("\\s+"; " ")
    | if length > 200 then .[:197] + "..." else . end
  ' <<<"$input"
)

omarchy notification send "Claude Code - $project_name" "$message"

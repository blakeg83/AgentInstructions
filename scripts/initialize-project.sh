#!/usr/bin/env bash
set -euo pipefail
if [[ $# -lt 2 ]]; then echo "Usage: $0 TARGET_DIR PROJECT_NAME [dotnet|generic] [TAIGA_SLUG|-]" >&2; exit 2; fi
target=$1; name=$2; type=${3:-dotnet}; taiga=${4:-}
[[ "$type" == dotnet || "$type" == generic ]] || { echo "Invalid project type" >&2; exit 2; }
[[ -d "$target" ]] || { echo "Target directory does not exist" >&2; exit 1; }
root=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
[[ ! -e "$target/AGENTS.md" ]] || { echo "Refusing to overwrite AGENTS.md" >&2; exit 1; }
if [[ -n "$taiga" && "$taiga" != "-" && -e "$target/docs/taiga-agent-workflow.md" ]]; then echo "Refusing to overwrite Taiga guide" >&2; exit 1; fi
tmp=$(mktemp)
trap 'rm -f "$tmp"' EXIT
cat "$root/templates/AGENTS.base.md" > "$tmp"
if [[ "$type" == dotnet ]]; then printf '\n' >> "$tmp"; cat "$root/templates/AGENTS.dotnet.md" >> "$tmp"; fi
if [[ -z "$taiga" || "$taiga" == "-" ]]; then
  sed -i '/Taiga is the source of truth/d; /When Taiga is configured/d; /If a credible high-priority defect/d' "$tmp"
  taiga="not configured"
fi
export AI_PROJECT_NAME="$name" AI_TAIGA_SLUG="$taiga"
render() {
  python3 -c 'import os,sys; s=sys.stdin.read(); print(s.replace("{{PROJECT_NAME}}",os.environ["AI_PROJECT_NAME"]).replace("{{TAIGA_PROJECT}}",os.environ["AI_TAIGA_SLUG"]),end="")'
}
render < "$tmp" > "$target/AGENTS.md"
echo "Created $target/AGENTS.md"
if [[ "$taiga" != "not configured" ]]; then
  mkdir -p "$target/docs"
  render < "$root/templates/taiga-agent-workflow.md" > "$target/docs/taiga-agent-workflow.md"
  echo "Created $target/docs/taiga-agent-workflow.md"
fi

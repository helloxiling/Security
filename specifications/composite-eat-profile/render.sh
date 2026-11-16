#!/usr/bin/env bash
set -euo pipefail

export DOCKER_IMAGE=${DOCKER_IMAGE:-ghcr.io/trustedcomputinggroup/pandoc@sha256:36f268ea6345765da7b6c34e3af36a8c8e7bc61e245315699a3c0ac110c074a0}

tools_dir=${1:-${OCP_SPEC_TOOLS:-}}
if [[ -z "$tools_dir" ]]; then
    printf 'Usage: bash %s /path/to/ocp-spec-tools\n' "$0" >&2
    exit 1
fi
tools_dir=$(realpath -- "$tools_dir")
if [[ ! -f "$tools_dir/docker-run.sh" ]]; then
    printf 'OCP renderer not found: %s/docker-run.sh\n' "$tools_dir" >&2
    exit 1
fi

profile_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
build_dir=$(mktemp -d)
trap 'rm -rf -- "$build_dir"' EXIT
cp -R "$profile_dir/." "$build_dir/"
cd -- "$build_dir"

bash "$tools_dir/docker-run.sh" --html_stylesheet render.css \
    --html spec.html --latex spec.tex spec.ocp

perl -0pe '
    for my $identifier ("tbl:acronyms-and-abbreviations", "tbl:threat-model", "tbl:acsr-req") {
        my $matches = 0;
        s{(\\begingroup\\small\\begin\{xltabular\}[^\n]*\n)(\\caption\{[^\n]*\\label\{\Q$identifier\E\}[^\n]*\}\n\\\\\n)(.*?\\end\{xltabular\}\\endgroup)}{
            $matches++;
            my ($opening, $caption, $body) = ($1, $2, $3);
            $caption =~ s/\n\\\\\n\z/\n/;
            $caption =~ s/\A\\caption/\\captionof{table}/;
            "$opening$body\n\\addtocounter{table}{-1}\n$caption";
        }egs;
        die "Expected one caption for $identifier, found $matches\n" unless $matches == 1;
    }
' spec.tex > spec.bottom.tex

bash "$tools_dir/docker-run.sh" --latex_override spec.bottom.tex \
    --pdf spec.pdf spec.ocp
cp -- spec.html spec.pdf "$profile_dir/"
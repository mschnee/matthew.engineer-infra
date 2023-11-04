#!/usr/bin/env bash

set -eo pipefail

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
set +o pipefail
TAG=${1:-"local-$(tr -dc 'a-z0-9' < /dev/urandom | head -c 8)"}
set -o pipefail
TARGET=${2:-production}

(
  cd "$SCRIPT_DIR/../../.."
  podman build \
    -t "487780594448.dkr.ecr.us-east-2.amazonaws.com/public-app:$TAG" \
    --target "$TARGET" \
    -f packages/public-app/Containerfile \
    .
)

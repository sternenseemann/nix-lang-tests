#!/bin/sh
set -eu

import() {
  name="$1"
  url="$2"
  ref="$3"
  filter="$4"

  git fetch "$url" "$ref"
  rev="$(git rev-parse --short FETCH_HEAD)"

  josh-filter "$filter :prefix=$name" FETCH_HEAD
  git merge --allow-unrelated-histories -m "chore: update $name to upstream commit $rev" FILTERED_HEAD
}

import cppnix https://github.com/NixOS/nix.git master ':[::COPYING,:/tests/functional/lang :prefix=tests]'
import lix https://git.lix.systems/lix-project/lix.git main ':[::COPYING,:/tests/functional2/lang :prefix=tests]'

# TODO(sterni): Tvix

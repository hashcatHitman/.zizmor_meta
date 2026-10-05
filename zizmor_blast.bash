#!/bin/bash

# SPDX-FileCopyrightText: © 2026 hashcatHitman
#
# SPDX-License-Identifier: Apache-2.0 OR MIT

set -uo pipefail

organization_info="$(curl -s "https://api.github.com/orgs/rust-lang")"
public_repository_count="$(echo "${organization_info}" | jq '.public_repos')"
pages="$(fend "ceil(${public_repository_count} / 100)")"

declare -a repolist=()

for page in $(seq "${pages}"); do
    full_page="$(curl -s "https://api.github.com/orgs/rust-lang/repos?per_page=100&page=${page}")"
    repo_slugs="$(echo "${full_page}" | jq -r '.[].full_name')"
    already_contains="${#repolist[@]}"
    mapfile -O "${already_contains}" -t repolist <<<"${repo_slugs}"
done

for repo in "${repolist[@]}"; do
    token="$(gh auth token)"
    zizmor --gh-token "${token}" --config ./zizmor.yml --persona=pedantic "${repo}" >"./${repo}.txt"
done

exit 0

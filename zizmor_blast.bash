#!/bin/bash

# SPDX-FileCopyrightText: © 2026 hashcatHitman
#
# SPDX-License-Identifier: Apache-2.0 OR MIT

set -uo pipefail

crabwatch_repo_slugs="$(
    gh api --paginate --jq 'map(select(.fork == false))
    | map(select(.archived == false))
    | map(select(.custom_properties.crabwatch == "true"))
    | .[].full_name' \
        -X "GET" \
        -H "Accept: application/vnd.github+json" \
        -H "X-GitHub-Api-Version: 2026-03-10" \
        -F "type=public" \
        /orgs/rust-lang/repos
)"

mapfile -t crabwatch_repo_slugs_arr <<<"${crabwatch_repo_slugs}"

for repo in "${crabwatch_repo_slugs_arr[@]}"; do
    token="$(gh auth token)"
    zizmor --gh-token "${token}" --config ./zizmor.yml --persona=pedantic \
        "${repo}" >"./${repo}.txt"
done

exit 0

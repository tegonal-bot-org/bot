#!/usr/bin/env bash
#
#    __                          __
#   / /____ ___ ____  ___  ___ _/ /       This script is provided to you by https://github.com/tegonal-bot-org/tegonal-bot
#  / __/ -_) _ `/ _ \/ _ \/ _ `/ /        Copyright 2024 Tegonal Genossenschaft <info@tegonal.com>
#  \__/\__/\_, /\___/_//_/\_,_/_/         It is licensed under Apache License, Version 2.0
#         /___/                           Please report bugs and contribute back your improvements
#
#                                         Version: v0.1.0-SNAPSHOT
###################################
set -euo pipefail
shopt -s inherit_errexit
unset CDPATH
TEGONAL_BOT_LATEST_VERSION="main"

if ! [[ -v dir_of_tegonal_scripts ]]; then
	dir_of_tegonal_scripts="$(cd -- "$(dirname -- "${BASH_SOURCE[0]:-$0}")" >/dev/null && pwd 2>/dev/null)/../../../lib/tegonal-scripts/src"
	source "$dir_of_tegonal_scripts/setup.sh" "$dir_of_tegonal_scripts"
fi

if ! [[ -v dir_of_github_commons ]]; then
	dir_of_github_commons="$(cd -- "$(dirname -- "${BASH_SOURCE[0]:-$0}")" >/dev/null && pwd 2>/dev/null)/../../../lib/tegonal-gh-commons/src"
	readonly dir_of_github_commons
fi

sourceOnce "$dir_of_github_commons/gt/pull-hook-functions.sh"
sourceOnce "$dir_of_tegonal_scripts/utility/parse-fn-args.sh"

function gt_pullHook_tegonal_gh_commons_before() {
	local _tag source _target
	# shellcheck disable=SC2034   # is passed to parseFnArgs by name
	local -ra params=(_tag source _target)
	parseFnArgs params "$@"

	replaceTegonalGhCommonsPlaceholders "$source" "tegonal-bot" "$TEGONAL_BOT_LATEST_VERSION" \
		"Tegonal Genossenschaft" "info@tegonal.com" "tegonal-bot-org" "tegonal-bot"
}

function gt_pullHook_tegonal_gh_commons_after() {
	# no op, nothing to do
	true
}

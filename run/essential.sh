#!/usr/bin/env bash
(
  export GH_CONFIG_DIR="${HOME}/data/config/git"
  source "${HOME}/data/config/.gitattributes"
  gh loguser
  gh workflow run "essential".yml
  sleep 2
  run_info="$( gh run list --workflow=essential.yml --limit 1 | grep -v '^STATUS' | grep workflow_dispatch )"
  id="$( echo "${run_info}" | awk '{print $7}' )"
  gh run watch -i 1 "${id}"
  run_info="$( gh run list --workflow=essential.yml --limit 1 | grep -v '^STATUS' | grep workflow_dispatch )"
  status="$( echo "${run_info}" | awk '{print $1}' )"
  rc="$( echo "${run_info}" | awk '{print $2}' )"
  echo "status=${status}, rc=${rc} id=${id}"
  gh run view "${id}"
  open "https://github.com/j5pu/test-actions/actions/runs/${id}"
)

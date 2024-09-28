#! /usr/bin/bash

# =============================================================================
# status_all.sh
#
# Description:
# Convenience script to traverse all subdirectories in the given directory,
# check if each is a git repository, and status it if it is.
#
# Usage:
#
# status_all.sh <directory_name>
#
# Examples:
#
# To status all repositories that are in the current directory leave the
# argument blank.
#
# ./status_all.sh
#
# Use the first argument to status all repositories that are in a given
# directory.
#
# ./status_all.sh <DIRECTORY_NAME>
#
# =============================================================================

working_directory=${1:-$(pwd)}
working_directory=$(realpath "$working_directory")
echo ""
echo "Finding all git repositories in directory [$working_directory]..."

find "$working_directory" -type d -name ".git" | while read -r git_directory; do
  repo_directory=$(dirname "$git_directory")
  echo ""
  echo ""
  echo "=========================="
  echo " * Checking repository in: [$repo_directory]..."
  echo "=========================="
  echo ""
  cd "$repo_directory" || continue

  if git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
    echo "    -- Running 'git status' in [$repo_directory]"
	echo ""
    git status | sed 's/^/    > /'
	echo ""
	if [ $? -eq 0 ]; then
	  echo ""
      echo "[Success!]"
	  echo ""
	else
	  echo ""
      echo "[Status failed.]"
	  echo "Continuing to next directory"
	  echo ""
    fi

  else
    echo "[Could not status. $repo_directory is not a valid git repository.]"
	echo "Continuing to next directory."
	echo ""

  fi

  cd "$working_directory" || exit
done

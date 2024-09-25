#! /usr/bin/bash

# =============================================================================
# pull_all.sh
#
# Description:
# Convenience script to traverse all subdirectories in the given directory,
# check if each is a git repository, and pull the latest changes if it is.
#
# Usage:
#
# pull_all.sh <directory_name>
#
# Examples:
#
# To pull from all repositories that are in the current directory leave the
# argument blank.
#
# ./pull_all.sh
#
# Use the first argument to pull from all repositories that are in a given
# directory.
#
# ./pull_all.sh <DIRECTORY_NAME>
#
# =============================================================================

working_directory=${1:-$(pwd)}
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
    echo "    -- Running 'git pull' in [$repo_directory]"
	echo ""
    git pull | sed 's/^/    > /'
	echo ""
	if [ $? -eq 0 ]; then
	  echo ""
      echo "[Success!]"
	  echo ""
	else
	  echo ""
      echo "[Pull failed.]"
	  echo "Continuing to next directory"
	  echo ""
    fi

  else
    echo "[Could not pull. $repo_directory is not a valid git repository.]"
	echo "Continuing to next directory."
	echo ""

  fi

  cd "$working_directory" || exit
done

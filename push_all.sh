#! /usr/bin/bash

# =============================================================================
# push_all.sh
#
# Description:
# Convenience script to traverse all subdirectories in the given directory,
# check if each is a git repository, and push any changes in it.
#
# Usage:
#
# push_all.sh <directory_name> <commit message>
#
# Examples:
#
# Use the first argument to push to all repositories that are in a given
# directory and the second to specify the commit message.
#
# ./push_all.sh <DIRECTORY_NAME> "Update README.md"
#
# =============================================================================

CORRECT_ARGC="2"

if [ "$#" -neq 2 ]; then
    echo "Usage: push_all.sh <directory_name> <commit message>"
    echo 'Example: push_all.sh . "Update README.md"'
    exit 1
fi

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
    echo "    -- Running 'git push' in [$repo_directory]"
	echo ""
    git add . && git commit -m "\"$2\"" && git push | sed 's/^/    > /'
	echo ""
	if [ $? -eq 0 ]; then
	  echo ""
      echo "[Success!]"
	  echo ""
	else
	  echo ""
      echo "[Push failed.]"
	  echo "Continuing to next directory"
	  echo ""
    fi

  else
    echo "[Could not push. $repo_directory is not a valid git repository.]"
	echo "Continuing to next directory."
	echo ""

  fi

  cd "$working_directory" || exit
done

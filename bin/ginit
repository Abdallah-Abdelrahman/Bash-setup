#!/bin/bash

# =============================
# GitHub Repository Creator Script
# =============================

# -----------------------------
# Configuration & Initialization
# -----------------------------

# Color variables
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
CYAN='\033[0;36m'
NC='\033[0m'

# Execution control
VERBOSE=0
NO_README=0
DEFAULT_BRANCH="main"
POST_HOOK_SCRIPT=""

# -----------------------------
# Function Definitions
# -----------------------------

# Display error and exit
error_exit() {
	echo -e "${RED}[ERROR] $1${NC}" >&2
	exit 1
}

# Display success message
success_msg() {
	echo -e "${GREEN}$1${NC}"
}

# Display info message
info_msg() {
	echo -e "${CYAN}$1${NC}"
}

show_help() {
	# Detect if running under help2man (if stdout is not a terminal)
	if [[ ! -t 1 ]]; then
		echo "Usage:"
		echo "  $0 [OPTIONS]"
		echo
		echo "Options:"
		echo "  -p               Create as private repository"
		echo "  -m MESSAGE       Custom initial commit message"
		echo "  -b BRANCH        Custom branch name (default: main)"
		echo "  -v               Verbose output mode"
		echo "  -h / --help      Show this help message"
		echo "  --no-readme      Skip README.md creation/modification"
		echo "  --hook FILE      Post-creation hook script to execute"
		echo
		echo "Examples:"
		echo "  # Create private repo with custom message"
		echo "  $0 -p -m \"Project initialization\""
		echo
		echo "  # Create repo with custom branch and hook"
		echo "  $0 -b develop --hook post_create.sh"
	else
		# Normal colorized output
		echo -e "${YELLOW}Usage:${NC}"
		echo -e "  $0 [OPTIONS]"
		echo
		echo -e "${YELLOW}Options:${NC}"
		echo -e "  ${GREEN}-p${NC}               Create as private repository"
		echo -e "  ${GREEN}-m MESSAGE${NC}       Custom initial commit message"
		echo -e "  ${GREEN}-b BRANCH${NC}        Custom branch name (default: main)"
		echo -e "  ${GREEN}-v${NC}               Verbose output mode"
		echo -e "  ${GREEN}-h / --help${NC}      Show this help message"
		echo -e "  ${GREEN}--no-readme${NC}      Skip README.md creation/modification"
		echo -e "  ${GREEN}--hook FILE${NC}      Post-creation hook script to execute"
		echo
		echo -e "${YELLOW}Examples:${NC}"
		echo -e "  ${CYAN}# Create private repo with custom message${NC}"
		echo -e "  $0 -p -m \"Project initialization\""
		echo
		echo -e "  ${CYAN}# Create repo with custom branch and hook${NC}"
		echo -e "  $0 -b develop --hook post_create.sh"
	fi
	exit 0
}

# -----------------------------
# Argument Parsing
# -----------------------------

while [[ $# -gt 0 ]]; do
	case "$1" in
	-p)
		REPO_VISIBILITY="--private"
		shift
		;;
	-m)
		COMMIT_MESSAGE="$2"
		shift 2
		;;
	-b)
		CUSTOM_BRANCH="$2"
		shift 2
		;;
	-v)
		VERBOSE=1
		shift
		;;
	-h | --help)
		show_help
		;;
	--no-readme)
		NO_README=1
		shift
		;;
	--hook)
		POST_HOOK_SCRIPT="$2"
		shift 2
		;;
	*)
		error_exit "Invalid option: $1. Use -h for help."
		;;
	esac
done

# Set default values
REPO_VISIBILITY=${REPO_VISIBILITY:-"--public"}
COMMIT_MESSAGE=${COMMIT_MESSAGE:-"Initial commit"}
CUSTOM_BRANCH=${CUSTOM_BRANCH:-"$DEFAULT_BRANCH"}

# Configure verbose output
if [[ $VERBOSE -eq 1 ]]; then
	exec 3>&1
else
	exec 3>/dev/null
fi

# -----------------------------
# Pre-Flight Checks
# -----------------------------

# GitHub CLI check
command -v gh &>/dev/null || error_exit "GitHub CLI (gh) not installed."

# Authentication check
gh auth status &>/dev/null || error_exit "GitHub CLI not authenticated. Run 'gh auth login' first."

# Get GitHub username
GH_USER=$(gh api user -q '.login' 2>/dev/null) || error_exit "Failed to retrieve GitHub username."

# -----------------------------
# Repository Configuration
# -----------------------------

# Existing .git directory handling
if [[ -d ".git" ]]; then
	read -p "Existing Git repository detected. Override? (y/n) " -n 1 -r
	echo
	[[ $REPLY =~ ^[Yy]$ ]] || error_exit "Operation cancelled."
	rm -rf .git || error_exit "Failed to remove existing .git directory"
fi

# Repository name handling
DEFAULT_REPO_NAME=$(basename "$PWD")
while :; do
	read -p "Repository name (default: $DEFAULT_REPO_NAME): " -r REPO_NAME
	REPO_NAME=${REPO_NAME:-$DEFAULT_REPO_NAME}
	[[ $REPO_NAME =~ ^[a-zA-Z0-9_-]+$ ]] && break
	echo -e "${RED}Invalid name. Use letters, numbers, hyphens, or underscores.${NC}"
done

# Repository existence check
gh repo view "$GH_USER/$REPO_NAME" &>/dev/null && error_exit "Repository '$GH_USER/$REPO_NAME' already exists."

# -----------------------------
# Repository Initialization
# -----------------------------

# README handling
if [[ $NO_README -eq 0 ]]; then
	if [[ ! -f "README.md" ]] || [[ ! -s "README.md" ]]; then
		echo "# $REPO_NAME" >README.md
		info_msg "Created/updated README.md"
	fi
fi

# Git initialization
git init -q >&3 || error_exit "Git initialization failed"
git branch -M "$CUSTOM_BRANCH" >&3 || error_exit "Branch creation failed"

# Initial commit
git add . >&3
git commit -m "$COMMIT_MESSAGE" >&3 || error_exit "Initial commit failed"

# -----------------------------
# Remote Repository Creation
# -----------------------------

# Create GitHub repository
gh repo create "$REPO_NAME" "$REPO_VISIBILITY" >&3 || error_exit "GitHub repository creation failed"

# Remote URL configuration
if ssh -T git@github.com 2>&1 | grep -q "successfully authenticated"; then
	REMOTE_URL="git@github.com:$GH_USER/$REPO_NAME.git"
else
	REMOTE_URL="https://github.com/$GH_USER/$REPO_NAME.git"
fi

git remote add origin "$REMOTE_URL" >&3 || error_exit "Remote configuration failed"

# -----------------------------
# Finalization
# -----------------------------

# Post-creation hook
if [[ -n "$POST_HOOK_SCRIPT" ]]; then
	[[ -x "$POST_HOOK_SCRIPT" ]] || error_exit "Hook script not executable"
	info_msg "Executing post-creation hook..."
	# shellcheck disable=SC1090
	source "$POST_HOOK_SCRIPT" || error_exit "Hook script execution failed"
	git add . >&3
	git commit -m "Post-creation hook" >&3 || error_exit "Hook commit failed"
fi

# Push to remote
git push -u origin "$CUSTOM_BRANCH" >&3 || error_exit "Failed to push to remote"

# Success output
success_msg "Repository created successfully!"
echo -e "${YELLOW}Details:${NC}"
echo -e "  Name:    $REPO_NAME"
echo -e "  Visibility: ${REPO_VISIBILITY##--}"
echo -e "  Branch:  $CUSTOM_BRANCH"
echo -e "  Remote:  $REMOTE_URL"

# Open in browser
gh repo view --web &>/dev/null && success_msg "Opened repository in browser"

#!/usr/bin/env zsh

# This takes inspiration from the xdg-user-dir utility

# XDG_COMMON_DIRS
export XDG_DESKTOP_DIR="$HOME/Desktop" && mkdir -p "$XDG_DESKTOP_DIR"
export XDG_DOCUMENTS_DIR="$HOME/Documents" && mkdir -p "$XDG_DOCUMENTS_DIR"
export XDG_DOWNLOAD_DIR="$HOME/Downloads" && mkdir -p "$XDG_DOWNLOAD_DIR"
export XDG_MUSIC_DIR="$HOME/Music" && mkdir -p "$XDG_MUSIC_DIR"
export XDG_PICTURES_DIR="$HOME/Pictures" && mkdir -p "$XDG_PICTURES_DIR"
export XDG_PUBLICSHARE_DIR="$HOME/Public" && mkdir -p "$XDG_PUBLICSHARE_DIR"
export XDG_TEMPLATES_DIR="$HOME/Templates" && mkdir -p "$XDG_TEMPLATES_DIR"
export XDG_VIDEOS_DIR="$HOME/Videos" && mkdir -p "$XDG_VIDEOS_DIR"

# USER_CODE_DIRS
export LEET_CODE_DIR="$HOME/Code" && mkdir -p "$LEET_CODE_DIR"
export LEET_GITHUB_DIR="$LEET_CODE_DIR/github" && mkdir -p "$LEET_GITHUB_DIR"
export LEET_PROJECTS_DIR="$LEET_CODE_DIR/projects" && mkdir -p "$LEET_PROJECTS_DIR"
export LEET_RESEARCH_DIR="$LEET_CODE_DIR/research" && mkdir -p "$LEET_RESEARCH_DIR"

# USER_DESKTOP_DIRS
export LEET_SCHOOL_DIR="$XDG_DESKTOP_DIR/school" && mkdir -p "$LEET_SCHOOL_DIR"
export LEET_WORK_DIR="$XDG_DESKTOP_DIR/work" && mkdir -p "$LEET_WORK_DIR"

# USER_PICTURES_DIRS
export LEET_CAMERA_DIR="$XDG_PICTURES_DIR/camera" && mkdir -p "$LEET_CAMERA_DIR"
export LEET_ICONS_DIR="$XDG_PICTURES_DIR/icons" && mkdir -p "$LEET_ICONS_DIR"
export LEET_PHONE_DIR="$XDG_PICTURES_DIR/phone" && mkdir -p "$LEET_PHONE_DIR"
export LEET_PROFILE_DIR="$XDG_PICTURES_DIR/profile" && mkdir -p "$LEET_PROFILE_DIR"
export LEET_SCREENSHOTS_DIR="$XDG_PICTURES_DIR/screenshots" && mkdir -p "$LEET_SCREENSHOTS_DIR"
export LEET_WALLPAPERS_DIR="$XDG_PICTURES_DIR/wallpapers" && mkdir -p "$LEET_WALLPAPERS_DIR"

# USER_BIN_DIR
export LEET_BIN_DIR="$HOME/.local/bin" && mkdir -p "$LEET_BIN_DIR"
# USER_LIB_DIR
export LEET_LIB_DIR="$HOME/.local/lib" && mkdir -p "$LEET_LIB_DIR"

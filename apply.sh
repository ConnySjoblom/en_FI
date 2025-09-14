#!/usr/bin/env bash

# --- Check if the system is Linux ---
if [[ "$(uname -s)" != "Linux" ]]; then
    echo "This script only supports Linux."
    exit 1
fi

# --- Check if en_FI.UTF-8 locale already exists ---
if locale -a | grep -q '^en_FI\.utf8$'; then
    echo "Locale en_FI.UTF-8 already exists. Aborting."
    exit 0
fi

# --- Detect the Linux distribution ---
if [ -f /etc/os-release ]; then
    . /etc/os-release
    DISTRO_ID=$ID
else
    echo "Cannot determine Linux distribution."
    exit 1
fi

# --- Handle supported distros ---
case "$DISTRO_ID" in
    fedora)
        echo "Detected Fedora system ($PRETTY_NAME)"

        # Check if glibc-locale-source is installed
        if rpm -q glibc-locale-source &>/dev/null; then
            echo "glibc-locale-source is already installed."
        else
            echo "glibc-locale-source is not installed. Installing..."
            sudo dnf install -y glibc-locale-source || {
                echo "Failed to install glibc-locale-source."
                exit 1
            }
            echo "glibc-locale-source installed successfully."
        fi
        ;;
    ubuntu|debian)
        echo "Detected Debian/Ubuntu system ($PRETTY_NAME)"
        
        # Check if locales package is installed
        if dpkg -s locales &>/dev/null; then
            echo "locales package is already installed."
        else
            echo "locales package is not installed. Installing..."
            sudo apt-get update && sudo apt-get install -y locales || {
                echo "Failed to install locales package."
                exit 1
            }
            echo "locales package installed successfully."
        fi
        ;;
    arch)
        echo "Detected Arch system ($PRETTY_NAME)"
        
        # Check if glibc package is installed
        if pacman -Qi glibc &>/dev/null; then
            echo "glibc package is already installed."
        else
            echo "glibc package is not installed. Installing..."
            sudo pacman -Sy --noconfirm glibc || {
                echo "Failed to install glibc package."
                exit 1
            }
            echo "glibc package installed successfully."
        fi
        ;;
    *)
        echo "Unsupported Linux distribution: $PRETTY_NAME"
        exit 1
        ;;
esac

# Generate the en_FI.UTF-8 locale
echo "Generating locale en_FI.UTF-8..."
if sudo localedef --no-archive --inputfile en_FI --charmap=UTF-8 en_FI.UTF-8; then
    echo "Locale en_FI.UTF-8 generated successfully."
else
    echo "Failed to generate locale en_FI.UTF-8."
    exit 1
fi
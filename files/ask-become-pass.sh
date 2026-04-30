#!/bin/sh

set -eu

prompt_title="Ansible sudo password"
prompt_message="Enter your macOS account password for Homebrew cask installation."

osascript <<EOF
try
	set userInput to text returned of (display dialog "$prompt_message" with title "$prompt_title" default answer "" with hidden answer buttons {"Cancel", "OK"} default button "OK")
	return userInput
on error number -128
	error number 1
end try
EOF

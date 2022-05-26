#!/usr/bin/env bash

#
# This script simplifies the creation of a virtual environment for running dbt.
# It has been tested on MacOS and Windows (using Git Bash). Unfortunately a
# script cannot activate a virtual environment for a user, so you must activate
# the virtual environment that was created using the command provided on finish.
#

# Exit script if there are any errors.
set -e

# Setup colors.
red=`tput setaf 1`
green=`tput setaf 2`
yellow=`tput setaf 3`
reset=`tput sgr0`

venv_name="dbt-env"
venv_root="$HOME/.virtualenvs"
venv_path="$venv_root/$venv_name"

mkdir -p $venv_root

# Check if running on Windows or MacOS.
case $(uname -s) in
  Darwin*) system=mac;;
  MINGW*) system=win;;
esac

# Set system-specific variables.
if [[ $system == 'mac' ]]; then
  python_executable=python3
  venv_activate="$venv_path/bin/activate"
elif [[ $system == 'win' ]]; then
  python_executable=python
  venv_activate="$venv_path/Scripts/activate"
else
  echo -e "${red}Unknown system.${reset}\n"
  exit 1
fi

read -rep "This script will create/update a Python virtual environment called $yellow$venv_name$reset in $yellow$venv_root$reset
Press enter to continue " response
if [[ $response =~ ^(y|Y| ) ]] || [[ -z $response ]]; then
  echo ""
else
  exit 1
fi

# Check Python version.
$python_executable <<EOF
import sys
MIN_VERSION = (3, 8, 9)
python_version = sys.version_info[:3]
min_version_str = ".".join([str(i) for i in MIN_VERSION])
python_version_str = ".".join([str(i) for i in python_version])
if python_version < MIN_VERSION:
  print(
    "\033[91m" # red color start
    f"The recommended minimum Python version is {min_version_str}. "
    f"You are running version {python_version_str}."
    "\033[0m" # red color end
  )
  exit(1)
EOF

if [[ $VIRTUAL_ENV =~ "pyenv" ]]; then
  pyenv_active=true
fi

cd "$(dirname "$0")"

# Check if a virtual environment is already active.
if [[ -n "$VIRTUAL_ENV" ]]; then
  echo "Virtual environment already activated:"
  echo -e "$yellow$VIRTUAL_ENV$reset\n"
  echo -n "Checking for updates…"
else
# Setup and activate virtual environment.
  echo -n "Setting up $venv_name virtual environment…"
  $python_executable -m venv $venv_path
  source $venv_activate
  setup=true
fi

pip install -q --upgrade pip setuptools
pip install -q --upgrade -r requirements.txt
echo "${green}done!${reset}"

env_file_path="$PWD/.env"

# Check if Pyenv is not active, if .env exists, and if source .env exists in
# activate script.
if [[ $pyenv_active != true ]] &&
   [[ -f .env ]] &&
   grep -q "source $env_file_path" $venv_activate; then
   true
# Add source .env to activate script.
elif [[ $pyenv_active != true ]] &&
     [[ -f .env ]] &&
     ! grep -q "source $env_file_path" $venv_activate; then
  echo -e "\n# dbt environmental variables" >> $venv_activate
  echo "source $env_file_path" >> $venv_activate
elif [[ $pyenv_active == true ]] && [[ -f .env ]]; then
  true
else
  echo -e "\n${red}No .env file found!${reset}"
fi

echo -e "\nInstalling pre-commit hooks…"
pre-commit install

echo -e "\ndbt version:"
echo -e "$(dbt --version)\n"

if [[ $setup == true ]]; then
  echo -e "Run to activate the virtual environment:\n"
  echo -e "${green}source $venv_activate${reset}\n"
fi
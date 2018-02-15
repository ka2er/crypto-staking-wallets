#!/bin/bash

show_requirements() {
  echo 'ansible is missing.
Please install it with `brew install ansible`
' >&2
}

show_help() {
  echo "Deploy an headless wallet ready for staking to a linux box.
If no argument coin is passed, all eligible coins will be listed.
  
Usage:

    $0 [-v] [-h] [<coin>]

  Options:

    -v
      Verbose output.

    -h
      Show this help.

" >&2
}

## arguments parsing #########

# A POSIX variable
OPTIND=1         # Reset in case getopts has been used previously in the shell.

# Initialize our own variables:
verbose=0

while getopts "h?v" opt; do
    case "$opt" in
    h|\?)
        show_help
        exit 0
        ;;
    v)  verbose=1
        ;;
    esac
done

shift $((OPTIND-1))

[ "$1" = "--" ] && shift

#######################################

coin="$1"
ansible="$(which ansible)"

[[ $ansible == "" ]] && show_requirements && exit 1
[[ $coin == "" ]] && cat coins && exit 1

for xcoin in `cat coins`; do
  if [[ $xcoin == $coin ]]; then
    ansible-playbook run_playbook.yml -i host.local -K --extra-vars "wallet=$coin data_path=/tmp/data"    
    exit $?
  fi
done

echo ""
echo "$coin coin isn't already supported."
echo ""
echo "Please free to submit PR or issue : https://github.com/ka2er/crypto-staking-wallets/issues/new"
echo ""

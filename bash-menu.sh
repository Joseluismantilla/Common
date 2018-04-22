#!/bin/bash

######################################################
#
# Description:
#   Crated by Joseluismantilla.com
#   For more information, see the --help option
#
######################################################
help_menu(){
  # change the output color of echo
  # https://stackoverflow.com/questions/5947742/how-to-change-the-output-color-of-echo-in-linux/5947788#5947788
    bold=$(tput bold)
    normal=$(tput sgr0)
    echo "
    ${bold}NAME
    ${normal}   bash-menu - The bash-menu script (bash-menu.sh) is...

    ${bold}SYNOPSIS
        bash-menu   ${normal} Execute all the values by default explained in each option.${bold}
        bash-menu   ${normal}[--OPTIONS|Package|PC] Set new values defined below.

    ${bold}Options ${normal}

        -h | --help     display this help and exit

    ${bold}Package Installation Options${normal}
        --version    Set the GoCD package version.
        --repo       Set the url that contains the rpm package, by defaults is https://dl.fedoraproject.org/pub/epel/
        --package    Set the package\'s name, by default is epel-release-latest-7.noarch.rpm

    ${bold}PC Configurations Options${normal}
        --pc-hostname        Set the hostname of the machine, by default the value is joseluismantilla.com \n"
        exit 0
}

# Explanation of getopt and values -> www.bahmanm.com/blogs/command-line-options-how-to-parse-in-bash-using-getopt
OPTS=$(getopt -o h --long version:,repo:,help,package:,pc-hostname: -n 'parse-options' -- "$@")
if [ $? != 0 ] ; then echo "Failed parsing options." >&2 ; exit 1 ; fi

eval set -- "$OPTS"

while true; do
  case "$1" in
    -h | --help ) help_menu ;;
    --version ) VERSION=$2; shift ;;
    --repo ) REPO=$2; shift ;;
    --package ) PACKAGE=$2; shift ;;
    --pc-hostname) PC_HOSTNAME=$2; shift;;
    --) echo "Using values by default, for more information, see --help"
        RPM_PACKAGE=epel-release-latest-7.noarch.rpm
        REPO=https://dl.fedoraproject.org/pub/epel/
        PC_HOSTNAME=joseluismantilla.com
        shift ;;
    * ) break ;;
  esac
  shift
done

# Install Package
yum -y install $REPO/$PACKAGE
yum clean all

sed -i "s/fail/\#fail/g" /etc/yum.repos.d/epel.repo
cat << EOF > /tmp/installation
Epel repo has been installed succesful
EOF

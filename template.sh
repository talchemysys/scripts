#!/bin/bash
# created by: Zell
#===============================================================================
# variables

#---------------------------------------
# source file

source /usr/local/sbin/stdlib

#---------------------------------------
# common values

LOGNAME=$PROG
LOG=/var/log/$LOGNAME.log
LOGRO=/etc/logrotate.d/$LOGNAME

#===============================================================================
# help text

HELP_TXT="
This script ...

SYNTAX:
  # $PROG [OPTIONS]

OPTIONS:
  -h, --help         display this help text and exit
  -l, --log          enable logging to a file
  -v, --verbose      be verbose
  -vv, --debug       turn on debugging (very verbose)
  -dr, --dryrun      do a dry run

EXAMPLES:
  Normal operation:  # $PROG
  Dry run:           # $PROG -vv -dr
  Logging:           # $PROG -v --log

NOTES:
  don't combine options:
    correct:         # $PROG -l -vv
    incorrect:       # $PROG -lvv

"

#===============================================================================
# functions

#---------------------------------------
# 

#===============================================================================
# script start

#---------------------------------------
# process options

while (( "$#" > 0 )) ;do
  case $1 in
    -h|--help)     f_usage 0                               ;;
    -v|--verbose)  VERBOSE=true ;shift                     ;;
    -l|--log)      LOGGING=true ;shift                     ;;
    -vv|--debug)   VERBOSE=true ;DEBUG=true ;shift         ;;
    -dr|--dryrun)  VERBOSE=true ;DRYRUN=true ;shift        ;;
    "")            break                                   ;;
    *)             f_msg -e "Unkown option(s): $*" ;break  ;;
  esac
done
LOGGING=false

f_msg -l -d "SCRIPT START"

#---------------------------------------
# arguments

f_msg -d "VERBOSE=$VERBOSE"
f_msg -d "LOGGING=$LOGGING"
f_msg -d "DEBUG=$DEBUG"
f_msg -d "DRYRUN=$DRYRUN"

#---------------------------------------
# error checks

f_vroot  # verify root execution

#===============================================================================
# body

#---------------------------------------
# 

f_msg "printing free disk space..." ;f_run "df -h"

#===============================================================================
# cleanup

#---------------------------------------
# rotate log

f_logro

#...................
# exit

f_exit

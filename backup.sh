#!/bin/bash
####################################
#
# Backup files changed since last run
#
####################################

source_dir=/files
dest_dir=/files/backup

config_file=/home/backup.conf
log_file=
backup_date_format=%Y%m%d-%H%M%S
prune_after_days=30
last_date=

function read_config() {
    [ -f $confile_file ] && echo "Loading config..." && . $config_file
    
    if [ -z ${log_file+x} ]; then log_file=/home/backup.log; fi;
    if [ -z ${last_date+x} ]; then last_date='1900-01-01'; fi;
}

function write_config() {
    echo >$config_file
    echo log_file=${log_file}>>$config_file
    echo last_date=${last_date}>>$config_file
}

function process() {
    echo "  >" $1
}

# Start
read_config

# Debug
echo config_file = $config_file
echo log_file = $log_file
echo last_date = $last_date

# Find and process all candidates
find $source_dir -type f -newermt $last_date -not -path $dest_dir | while read file; do process "$file"; done

# Store new date for next time
last_date=$(date -u -Iseconds)
write_config

exit;

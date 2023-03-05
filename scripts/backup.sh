#!/bin/bash
##################################################
# Backup files changed since last run
#
#
#
##################################################

##################################################
# Start of Configuration

source_dir="/files"
dest_dir="/files/backup"
souce_filespec="*.*"

config_file="/home/backup.conf"
log_file="/home/backup.log"
backup_date_format="%Y%m%d %H%M%S"
retain_days=7
retain_log_lines=500
last_date='1900-01-01'


# End of Configuration
##################################################


function read_config() {
    [ -f $config_file ] && log_text "Loading config..." && source $config_file
}

function write_config() {
    echo >$config_file
    echo "last_date=\"${last_date}\"">>$config_file
}

function log_text() {
    now=$(date "+%F %X")

    echo $now "$*"
    echo $now "$*">> "${log_file}"

    # Prune log file
    echo "$(tail -${retain_log_lines} "${log_file}")" > "${log_file}"
}

function ensure_dir_exists() {
    ! [ -d "${1}" ] && log_text "Creating: ${1}" && mkdir -p "${1}"
}

function build_new_filename() {
    file_date=$(date -r "${1}" "+${backup_date_format}")
    file_name=$(basename "${1}")
    file_namepart="${file_name%.*}"
    file_ext="${1##*.}"

    #echo "file_date     = ${file_date}"
    #echo "file_name     = ${file_name}"
    #echo "file_namepart = ${file_namepart}"
    #echo "file_ext      = ${file_ext}"

    new_file_name="${1/${source_dir}/${dest_dir}}"
    #echo new_file_name = ${new_file_name}
    new_file_name="${new_file_name/${file_name}/${file_namepart} ${file_date}}"
    #echo new_file_name = ${new_file_name}
    ! [ -z "${file_ext}" ] && new_file_name="${new_file_name}.${file_ext}"
    #echo new_file_name = ${new_file_name}

    echo "${new_file_name}"
}

function backup_file() {
    log_text "Found: ${1}"

    new_file_name=$(build_new_filename "${1}")

    target_dir=$(dirname "${new_file_name}")
    ensure_dir_exists "${target_dir}"
    
    log_text "Backing up: ${1}"
    log_text "        to: ${new_file_name}"

    # Copy
    #cp -n "${1}" "${new_file_name}"
    #touch -c "${new_file_name}"
}

function backup_files() {
    # Find and process all candidates
    find "${source_dir}" -not -path "${dest_dir}*" -type f -newermt "${last_date}" | while read file; do backup_file "${file}"; done
}

function remove_old_backup_files() {
    find "${dest_dir}" -type f -mtime +${retain_days} | while read file; do 
        log_text "Removing old backup file: ${file}"

        rm -f "${file}"
    done
}

function remove_empty_backup_directories() {
    find "${dest_dir}" -type d -empty | while read dir; do
        log_text "Removing empty backup directory: ${dir}"

        rmdir "${dir}"
    done
}


##################################################
# Start
log_text "------------------------------------------------------------"
log_text "Starting:" $(date)

# Initialise
read_config
ensure_dir_exists "${dest_dir}"

# Process all files
backup_files

# Housekeeping
remove_old_backup_files
remove_empty_backup_directories

# Setup for next time
last_date=$(date -u "+%F %H:%M")
write_config

exit;

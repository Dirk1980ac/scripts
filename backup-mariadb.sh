#!/bin/bash
# Check if exactly two arguments are provided (user and password)
if [[ $# -ne 2 ]]; then
	echo "Usage: backup-mariadb.sh <user> <password>"
	exit 1
fi

# Assign the user and password to variables
USER=$1
PWD=$2
# Query to list all databases
QUERY="SHOW DATABASES;"
# Execute the query and store the output in a variable
DATABASES=$(mysql -u "$USER" --password="$PWD" -e "$QUERY" -N -s)
# Define the backup directory
BACKUP_DIR="/var/backup/mysql/"

# Create the backup directory if it doesn't exist, suppress error messages if
# already exists
mkdir -p "$BACKUP_DIR" &> /dev/null

# Remove old backups older than 7 days
find "$BACKUP_DIR" -type f -ctime +7 -exec rm {} \;

# Loop through each database in the list
for db in $DATABASES; do
	# Skip template0 and information_schema databases
	if [[ "$db" != "template0" ]] && [[ "$db" != "information_schema" ]]; then
		# Dump each database, skip locking tables, compress with gzip, and save
		# to backup directory
		mysqldump --skip-lock-tables -u "$USER" --password="$PWD" "$db" \
			| gzip > "${BACKUP_DIR}mysqldump_${db}_$(date +"%Y%m%d").sql.gz"
	fi
done

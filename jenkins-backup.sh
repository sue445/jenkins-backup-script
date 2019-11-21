#!/bin/bash -xe
#
# jenkins backup scripts
# https://github.com/sue445/jenkins-backup-script
#
# Usage: ./jenkins-backup.sh /path/to/jenkins_home /path/to/destination/


readonly JENKINS_HOME="$1"
readonly DEST_FILE="$2"
readonly TMP_DIR="/tmp"
readonly TAR_NAME="jenkins_backup_`date +"%Y%m%d%H%M%S"`.tar.gz"


function usage() {
  echo "usage: $(basename $0) /path/to/jenkins_home /path/to/destination/"
}

function main() {
 if [ -z "${JENKINS_HOME}" -o -z "${DEST_FILE}" ] ; then
    usage >&2
    exit 1
  fi

ls   $JENKINS_HOME/*.xml                        >  ${TMP_DIR}/backup_list_jenkins.txt
find $JENKINS_HOME/nodes -type f  -name "*.xml" >> ${TMP_DIR}/backup_list_jenkins.txt
echo "$JENKINS_HOME/secrets"                    >> ${TMP_DIR}/backup_list_jenkins.txt
find $JENKINS_HOME/plugins/*.[hj]pi -type f     >> ${TMP_DIR}/backup_list_jenkins.txt
echo "$JENKINS_HOME/users"                      >> ${TMP_DIR}/backup_list_jenkins.txt
find $JENKINS_HOME/jobs -type f  -name "*.xml"  >> ${TMP_DIR}/backup_list_jenkins.txt
tar -T ${TMP_DIR}/backup_list_jenkins.txt -cvf  ${DEST_FILE}/${TAR_NAME}
rm -f  ${TMP_DIR}/backup_list_jenkins.txt
exit 0
}

main


#!/bin/bash -xe

##################################################################################
function usage(){
  echo "usage: $(basename $0) /path/to/jenkins_home archive.tar.gz"
}
##################################################################################

readonly JENKINS_HOME=$1
readonly DEST_FILE=$2
readonly CUR_DIR=$(cd $(dirname ${BASH_SOURCE:-$0}); pwd)
readonly TMP_DIR="$CUR_DIR/tmp"
readonly ARC_NAME="jenkins-backup"
readonly ARC_DIR="$TMP_DIR/$ARC_NAME"
readonly TMP_TAR_NAME="$TMP_DIR/archive.tar.gz"

if [ -z "$JENKINS_HOME" -o -z "$DEST_FILE" ] ; then
  usage >&2
  exit 1
fi

rm -rf "$ARC_DIR" "$TMP_TAR_NAME"
mkdir -p "$ARC_DIR/"{plugins,jobs,users,secrets,nodes}

cp "$JENKINS_HOME/"*.xml "$ARC_DIR"

cp "$JENKINS_HOME/plugins/"*.[hj]pi "$ARC_DIR/plugins"
hpi_pinned_count=$(find $JENKINS_HOME/plugins/ -name *.hpi.pinned | wc -l)
jpi_pinned_count=$(find $JENKINS_HOME/plugins/ -name *.jpi.pinned | wc -l)
if [ $hpi_pinned_count -ne 0 -o $jpi_pinned_count -ne 0 ]; then
  cp "$JENKINS_HOME/plugins/"*.[hj]pi.pinned "$ARC_DIR/plugins"
fi

if [ -d "$JENKINS_HOME/users/" ] ; then
  cp -R "$JENKINS_HOME/users/"* "$ARC_DIR/users"
fi

if [ -d "$JENKINS_HOME/secrets/" ] ; then
  cp -R "$JENKINS_HOME/secrets/"* "$ARC_DIR/secrets"
fi

if [ -d "$JENKINS_HOME/nodes/" ] ; then
  cp -R "$JENKINS_HOME/nodes/"* "$ARC_DIR/nodes"
fi

if [ -d "$JENKINS_HOME/jobs/" ] ; then
  cd "$JENKINS_HOME/jobs/"
  ls -1 | while read job_name ; do
    mkdir -p "$ARC_DIR/jobs/$job_name/"
    find "$JENKINS_HOME/jobs/$job_name/" -maxdepth 1 -name "*.xml" | xargs -I {} cp {} "$ARC_DIR/jobs/$job_name/"
  done
  cd -
fi

cd "$TMP_DIR"
tar -czvf "$TMP_TAR_NAME" "$ARC_NAME/"*
cd -
mv -f "$TMP_TAR_NAME" "$DEST_FILE"
rm -rf "$ARC_DIR"

exit 0

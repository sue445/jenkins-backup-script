#!/bin/bash -xe

##################################################################################
function usage(){
  echo "usage: $(basename $0) /path/to/jenkins_home archive.tar.gz"
}
##################################################################################

readonly JENKINS_HOME=$1
readonly DIST_FILE=$2
readonly CUR_DIR=$(cd $(dirname ${BASH_SOURCE:-$0}); pwd)
readonly TMP_DIR="$CUR_DIR/tmp"
readonly ARC_NAME="jenkins-backup"
readonly ARC_DIR="$TMP_DIR/$ARC_NAME"
readonly TMP_TAR_NAME="archive.tar.gz"

if [ -z "$JENKINS_HOME" -o -z "$DIST_FILE" ] ; then
  usage >&2
  exit 1
fi

if [[ -f "$TMP_DIR/$TMP_TAR_NAME" ]]; then
    rm "$TMP_DIR/$TMP_TAR_NAME"
fi
rm -rf "$ARC_DIR"
mkdir -p "$ARC_DIR/"{plugins,jobs,users}

cp "$JENKINS_HOME/"*.xml "$ARC_DIR"
cp "$JENKINS_HOME/plugins/"*.[hj]pi "$ARC_DIR/plugins"
hpi_pinned_count=$(find $JENKINS_HOME/plugins/ -name *.hpi.pinned | wc -l)
jpi_pinned_count=$(find $JENKINS_HOME/plugins/ -name *.jpi.pinned | wc -l)
if [ $hpi_pinned_count -ne 0 -o $jpi_pinned_count -ne 0 ]; then
  cp "$JENKINS_HOME/plugins/"*.[hj]pi.pinned "$ARC_DIR/plugins"
fi
cp -R "$JENKINS_HOME/users/"* "$ARC_DIR/users"

cd "$JENKINS_HOME/jobs/"
ls -1 | while read job_name
do
  mkdir -p "$ARC_DIR/jobs/$job_name/"
  find "$JENKINS_HOME/jobs/$job_name/" -maxdepth 1 -name *.xml | xargs -i cp {} "$ARC_DIR/jobs/$job_name/"
done

cd "$TMP_DIR"
tar -czvf "$TMP_DIR/$TMP_TAR_NAME" "$ARC_NAME/"*

cd "$CUR_DIR"
cp "$TMP_DIR/$TMP_TAR_NAME" "$DIST_FILE"

exit 0

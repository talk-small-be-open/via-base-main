#!/bin/bash
set -e

# TODO?
# 

# Example:
# ./sync_from_server.sh newserver.domain.com ubuntu ViaSiteXyz
# run as normal user, not root

# vars
SERVER=$1
SERVER_USER=$2
STONE=$3
STONE_DIR=$GS_HOME/server/stones/$STONE

# REPOS_PATH=/opt/GsDevKit_home/shared/repos/
MYSELF=$(whoami)

# Ensure via application is stopped
# stopStone -b $STONE
./via_stop.sh

echo "Waiting for GemStone to shut down "
while pgrep stoned > /dev/null; do sleep 1; echo -n "."; done

# backup the current extent
LOCAL_EXTENT="/home/$MYSELF/stone/extents/extent0.dbf"

if [ -f $LOCAL_EXTENT ]; then
	 mv --backup $LOCAL_EXTENT $LOCAL_EXTENT.bak

	 # Delete all local tranlogs
	 rm $STONE_DIR/tranlogs/tranlog*.dbf
fi

# Copy the extent from server
echo "Copying the GemStone extent database file ..."
scp $SERVER_USER@$SERVER:~/stone/backups/via_backup.dbf.gz /tmp/
# gunzip /tmp/via_backup.dbf.gz --stdout > $LOCAL_EXTENT

newExtent -s $STONE_DIR/snapshots/extent0.tode.pristine.dbf -t $STONE

sleep 10

# Restore from backup file from above
todeRestore $STONE /tmp/via_backup.dbf.gz

sleep 10

# Remount seaside in tode (Not sure if needed)
todeIt $STONE mount @/sys/stone/dirs/Seaside3/tode /home seaside

# Stop the stone (implicitly started from newExtent)
stopStone -b $STONE

sleep 5

echo "Syncing the GemStone code repos ..."
rsync -rlptgoD --delete --progress --compress --usermap=$SERVER_USER:$MYSELF $SERVER_USER@$SERVER:$GS_HOME/shared/repos $GS_HOME/shared/

./via_start.sh

echo "Successfully finished. You might want to do this manually: Copy the backup credentials, via_start.sh, ..."

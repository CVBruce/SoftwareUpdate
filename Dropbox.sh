#!/bin/sh
PATH=/bin:/usr/bin:/usr/local/bin
# Drive is the name of the cloud drive, as defined in the configuration file, e.g. Dropbox;
# Drive is also the name of the mount point.
# Lastly, Drive is the name of this script.  Linking to this script with a different name will change the cloud drive mounted.
DRIVE=`basename $0 .sh`
# Host name is used as the directory on the cloud drive that will be mounted on the local mount point.
HOSTNAME=`uname -n`
#
#---------------------------------------------------
# Check for executable existance of rclone
#---------------------------------------------------
if [ ! -e `which rclone` ]
then 
	echo "---> rclone not found.";
	exit 4;
fi
#-------------------------------------------------
# Check for readable existance of rclone.conf
#-------------------------------------------------
if [ ! -r $HOME/.config/rclone/rclone.conf ]
then
	echo "---> rclone configuration file not found.";
	exit 4;
fi
#--------------------------------------------------
# Check for existance of mount point.
#--------------------------------------------------
if [ ! -d $HOME/$DRIVE ]
then
	echo "---> rclone mount point not found.";
	exit 4;
fi
#-------------------------------------------------
# Mount the remote directory.
#-------------------------------------------------
rclone mount $DRIVE:/$HOSTNAME $HOME/$DRIVE --daemon --allow-non-empty; 
exit $?;

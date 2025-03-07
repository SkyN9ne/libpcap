#! /usr/bin/env bash

. /etc/rc.common

StartService ()
{
	#
	# Unfortunately, Mac OS X's devfs is based on the old FreeBSD
	# one, not the current one, so there's no way to configure it
	# to create BPF devices with particular owners or groups.
	# This startup item will make it owned by the admin group,
	# with permissions rw-rw----, so that anybody in the admin
	# group can use programs that capture or send raw packets.
	#
	# Change this as appropriate for your site, e.g. to make
	# it owned by a particular user without changing the permissions,
	# so only that user and the super-user can capture or send raw
	# packets, or give it the permissions rw-r-----, so that
	# only the super-user can send raw packets but anybody in the
	# admin group can capture packets.
	#
	chgrp admin /dev/bpf*
	chmod g+rw /dev/bpf*
}

StopService ()
{
	return 0;
}

RestartService () { StartService; }

RunService "$1"

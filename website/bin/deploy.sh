#!/bin/sh

RSYNCARGS="--compress --recursive --checksum --itemize-changes \
	--delete -e ssh --perms --chmod=Du=rwx,Dgo=rx,Fu=rw,Fog=r \
	--delete-excluded \
	--exclude .DS_Store --exclude Makefile"
DEST=courses:coursewww/capra.cs.cornell.edu/htdocs/seashell

rsync $(RSYNCARGS) ../dist/ $(DEST)

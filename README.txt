# Nuxeo PostgreSQL replication README
#
# (C) Copyright 2009 Nuxeo SA (http://nuxeo.com/) and contributors.
#
# All rights reserved. This program and the accompanying materials
# are made available under the terms of the GNU Lesser General Public License
# (LGPL) version 2.1 which accompanies this distribution, and is available at
# http://www.gnu.org/licenses/lgpl.html
#
# This library is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
# Lesser General Public License for more details.
#
# Contributors:
#   Julien Carsique
#
# $Id$

===============
nx-failover
===============

Nuxeo replication tools for failover.

OVERVIEW
==========

Nuxeo replication solution based on PostgreSQL built-in replication (warm-standby) and 
file system synchronization. See: http://www.postgresql.org/docs/8.3/interactive/warm-standby.html

DESCRIPTION
=============

nx-failover will help you manage Nuxeo products replication over PostgreSQL.

Available functionalities:
* Prepare a Nuxeo server to be replicated/replicate.
* Start a server as primary server (master) sending WAL files to its slave.  
* Start a server as standby server (slave) replaying logs received from its master.
* Switch server role from slave to master, and reciprocally.
* ...

INSTALL
=========

    hg clone http://hg.nuxeo.org/tools/nx-failover
    cd nx-failover
    # You can edit the Makefile to change the default prefix (/usr/local)
    sudo make install

To upgrade:
    cd nx-failover
    hg pull && hg up
    sudo make install

To remove:
    sudo make uninstall

nx-failover requires the pg_standby PostgreSQL contribution:
https://projects.commandprompt.com/public/pgsql/repo/trunk/pgsql/contrib/pg_standby
This contribution is included since PostgreSQL 8.3 in postgresql-contrib.
On earlier versions it has to be compiled. For example, with a 8.2.6, do:
  cd postgresql-8.2.6/contrib
  mkdir pg_standby
  cd pg_standby
  wget https://projects.commandprompt.com/public/pgsql/repo/trunk/pgsql/contrib/pg_standby/Makefile
  wget https://projects.commandprompt.com/public/pgsql/repo/trunk/pgsql/contrib/pg_standby/pg_standby.c
  cd ../..
  ./configure
  cd -
  make
  make install


SYNOPSIS
=========

    nx-failover [-d] OPTIONS

OPTIONS
========

debug, -d, --debug
    Debug mode.

version, -version, --version, -v
    Print nx-failover version

help, -h, --help, ?
    This help.

init
    Initialize the current directory as replication managing directory, creating sample configuration
    files you have to fill.

setup
    Create and setup needed directories and ownerships
    
start-master


start-slave


start-alone
    Stop replication and start as standard mono server.

backup
    Master proceed to a full backup, send it to its slave and then regularly send its logs.

backup-standby


restore
    Slave proceed to full restore from last received backup and then regularly look for incoming
    logs and replay them.

switch-to-master
    Tell slave server to achieve any current replication and then become a master. 

switch-to-slave
    Tell master server to become a slave. Usually called after it has been repaired.

cleanup-slave
    Remove backup and temporary files on slave side. Those files are useless since "nx-failover restore" 
    has succeeded.

cleanup-master
    Remove backup and temporary files on master side. Those files are useless since "nx-failover backup" 
    has succeeded.

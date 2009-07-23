#!/bin/bash
#
# Nuxeo PostgreSQL replication restore command
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

PG_STANDBY=$1
PGDATA_BASE=$2
PGDATA=$3
PGDATA_INCOMING=$4
LOG_FILE=$5
P=$6
F=$7
R=$8
echo "$PGDATA_INCOMING/$F" > $PGDATA_BASE/nexttorestore
#$PG_STANDBY -l -d -s 60 -t /tmp/pgsql.trigger.5442 $PGDATA_INCOMING $F $PGDATA/$P $R 2>>$LOG_FILE 2>&1
$PG_STANDBY -l -d -s 60 -t /tmp/pgsql.trigger.5442 $PGDATA_INCOMING $F $P $R >>$LOG_FILE 2>&1
echo "$PGDATA_BASE/incoming/$F" > $PGDATA_BASE/lastrestored
chmod g+r $PGDATA_BASE/nexttorestore $PGDATA_BASE/lastrestored
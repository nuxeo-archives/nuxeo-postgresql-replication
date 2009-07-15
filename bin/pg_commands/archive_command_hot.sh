#!/bin/bash
#
# Nuxeo PostgreSQL replication archive command hot
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

PGDATA_BASE=$1
PGDATA=$2
PGDATA_OUTGOING=$3
LOG_FILE=$4
P=$5
F=$6
if [ -f $PGDATA_OUTGOING/$F ]; then
  echo "### ERROR: $PGDATA_OUTGOING/$F already exists ! exiting archive command" >&2
  exit 1
fi
test ! -f $PGDATA_BASE/backup_in_progress || cp -i $PGDATA/$P $PGDATA_OUTGOING/$F < /dev/null
echo `date`: hot archive done. >>$LOG_FILE

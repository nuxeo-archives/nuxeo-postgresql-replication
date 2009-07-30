#!/bin/bash
#
# Nuxeo PostgreSQL replication archive command
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

PGDATA=$1
PGDATA_OUTGOING=$2
PGDATA_INCOMING=$3
NXDATA=$4
NXDATA_TOSYNC=$5
SLAVE=$6
LOG_FILE=$7
P=$8
F=$9
shift;
COMMON_USER=$9

if [ -f $PGDATA_OUTGOING/$F ]; then
  echo "### ERROR: $PGDATA_OUTGOING/$F already exists ! Exiting archive command" >&2
  exit 1
fi
cp $PGDATA/$P $PGDATA_OUTGOING/$F
scp -C $PGDATA_OUTGOING/$F $SLAVE:$PGDATA_INCOMING/$F >>$LOG_FILE 2>&1 && rm $PGDATA_OUTGOING/$F
# could use clearxlogtail to decrease data size (http://pgfoundry.org/projects/clearxlogtail/)
# ...

# need to sync jboss data
cd $NXDATA
rsync -z -e ssh -r --delete --progress $NXDATA_TOSYNC $COMMON_USER@$SLAVE:$NXDATA/
echo `date`: synchronization done. >>$LOG_FILE
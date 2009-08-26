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
SLAVES=$6
NX_MASTER=$7
NX_SLAVES=$8
SH=$9
shift 4;
LOG_FILE=$6
P=$7
F=$8
COMMON_USER=$9

error=0
if [ -f $PGDATA_OUTGOING/$F ]; then
  echo "### ERROR: $PGDATA_OUTGOING/$F already exists ! Exiting archive command" >&2
  exit 1
fi
cp $PGDATA/$P $PGDATA_OUTGOING/$F
for slave in $SLAVES; do
  scp -C $PGDATA_OUTGOING/$F $slave:$PGDATA_INCOMING/$F >>$LOG_FILE 2>&1 && rm $PGDATA_OUTGOING/$F || error=1
  # could use clearxlogtail to decrease data size (http://pgfoundry.org/projects/clearxlogtail/)
  # ...
done

# need to sync jboss data
for nx_slave in $NX_SLAVES; do
  ssh $COMMON_USER@$NX_MASTER $SH <<EOF
    cd $NXDATA
    rsync -z -e ssh -r --delete --progress $NXDATA_TOSYNC $COMMON_USER@$nx_slave:$NXDATA/
EOF
  [ $? != 0 ] && error=1
done

echo `date`: synchronization done. >>$LOG_FILE
exit $error

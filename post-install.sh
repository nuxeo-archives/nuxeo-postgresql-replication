#!/bin/sh

PREFIX=$1
shift
NXR_HOME=$1
shift
VERSION=$1
shift

NX_FAILOVER=$PREFIX/bin/nx-failover
cat > $NX_FAILOVER  <<EOF
#!/bin/sh
# nx-failover $VERSION
NXR_HOME=$NXR_HOME
VERSION=$VERSION
export NXR_HOME VERSION
$NXR_HOME/bin/nx-failover \$@
EOF
chmod 755 $NX_FAILOVER

echo "### nx-failover $VERSION successfully installed."

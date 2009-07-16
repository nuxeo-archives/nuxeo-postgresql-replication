# Makefile of nx-failover
# See README.txt for usage
# $Id$

# USER CONFIGURATION PART --------------------------------------
# Note that $(PREFIX)/bin/ should exist
PREFIX=/usr/local


# END OF CONFIGURATION PART ------------------------------------

VERSION=0.1.0
NXR_HOME=$(PREFIX)/nx-failover

clean:
	-find . "(" -name "*~" -or  -name ".#*" -or -name "#*" ")" -print0 | xargs -0 rm -f

install:
	install -d $(NXR_HOME)/bin $(NXR_HOME)/bin/pg_commands $(NXR_HOME)/lib
	install -m 644 ./README.txt $(NXR_HOME)/README.txt
	install -m 755 ./bin/nx-failover $(NXR_HOME)/bin
	install -m 755 ./bin/pg_commands/archive_command_hot.sh $(NXR_HOME)/bin/pg_commands
	install -m 755 ./bin/pg_commands/archive_command.sh $(NXR_HOME)/bin/pg_commands
	install -m 755 ./bin/pg_commands/restore_command.sh $(NXR_HOME)/bin/pg_commands
	install -m 755 ./bin/nx-failover.conf.sample $(NXR_HOME)/bin
	install -m 755 ./lib/pg_standby-8.2.6_32 $(NXR_HOME)/lib
	install -m 755 ./lib/pg_standby-8.2.7_64 $(NXR_HOME)/lib
	install -m 755 ./lib/check $(NXR_HOME)/lib
	install -m 755 ./lib/setup $(NXR_HOME)/lib
	@./post-install.sh $(PREFIX) $(NXR_HOME) $(VERSION)

uninstall:
	rm -rf $(NXR_HOME)
	rm -rf $(PREFIX)/bin/nx-failover

pkg:
	rm -rf /tmp/nx-failover
	hg clone . /tmp/nx-failover || exit 3
	rm -rf /tmp/nx-failover/.hg
	(cd /tmp;tar czf nx-failover-$(VERSION).tgz nx-failover)
	mv /tmp/nx-failover-$(VERSION).tgz .


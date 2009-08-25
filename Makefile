# Makefile of nx-failover
# See README.txt for usage
# $Id$

# USER CONFIGURATION PART --------------------------------------
# Note that $(PREFIX)/bin/ should exist
PREFIX=/usr/local


# END OF CONFIGURATION PART ------------------------------------

VERSION=0.1.4
NXR_HOME=$(PREFIX)/nx-failover

clean:
	-find . "(" -name "*~" -or  -name ".#*" -or -name "#*" ")" -print0 | xargs -0 rm -f

install:
	install -d $(NXR_HOME)/bin $(NXR_HOME)/bin/pg_commands $(NXR_HOME)/lib
	install -m 644 ./README.txt $(NXR_HOME)/README.txt
	install -m 755 ./bin/nx-failover $(NXR_HOME)/bin
	install -m 755 ./bin/nx-failover.conf.sample $(NXR_HOME)/bin
	install -m 755 ./bin/pg_commands/* $(NXR_HOME)/bin/pg_commands
	install -m 755 ./lib/* $(NXR_HOME)/lib
	@./post-install.sh $(PREFIX) $(NXR_HOME) $(VERSION)

uninstall:
	rm -rf $(NXR_HOME)
	rm -rf $(PREFIX)/bin/nx-failover

pkg:
	hg archive -p nx-failover -t tgz nx-failover-$(VERSION).tgz


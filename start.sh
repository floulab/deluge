#! /bin/sh

set -e

rm -f /var/lib/deluge/config/deluged.pid

deluged -c /var/lib/deluge/config -L info -l /var/lib/deluge/deluged.log
deluge-web -c /var/lib/deluge/config

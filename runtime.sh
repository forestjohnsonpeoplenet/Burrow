#!/bin/sh

rm -f /var/tmp/burrow/burrow.pid

/go/bin/burrow --config /etc/burrow/burrow.cfg

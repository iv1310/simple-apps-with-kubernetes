#!/bin/sh
set -e

find . \! -user app -exec chown app '{}' +
exec gosu app npm start

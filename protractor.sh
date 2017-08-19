#!/bin/bash
uid=$(stat -c %u ${PWD})
gid=$(stat -c %g ${PWD})

groupadd -o -g $gid protractor
useradd -m -o -u $uid -g $gid protractor

# Chrome, starting with version 56, refuses to run when launched by root.
# Therefore, we need to run it as a regular user, taking care
# to set the uid and gid of that user to match those of the current directory owner.
# Otherwise protractor could experience problems reading files from the current directory.
sudo -u protractor xvfb-run --server-args="-screen 0 ${SCREEN_RES}" -a protractor $@

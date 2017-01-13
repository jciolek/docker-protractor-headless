#!/bin/bash

xvfb-run -a --server-args="-screen 0 ${SCREEN_RES}" protractor $@

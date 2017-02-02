'use strict';

const minimist = require('minimist');
const fs = require('fs');
const configFile = '/usr/local/lib/node_modules/protractor/node_modules/webdriver-manager/built/config.json';
const argv = minimist(process.argv.slice(2));

let config = require(configFile);

Object.keys(config.webdriverVersions)
  .forEach(driverName => {
    if (argv[driverName]) {
      config.webdriverVersions[driverName] = argv[driverName];
    }
  });

fs.writeFileSync(configFile, JSON.stringify(config, null, 2));

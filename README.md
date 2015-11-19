# Docker image of Protractor with headless Chrome

Protractor end to end testing for AngularJS - dockerised with headless real Chrome.

## Why headless Chrome?

PhantomJS is [discouraged by Protractor creators](https://angular.github.io/protractor/#/browser-setup#setting-up-phantomjs) and for a good reason. It's basically a bag of problems. 

## What is headless Chrome anyway?

To be perfectly honest - it is a [real chrome running on xvfb](http://tobyho.com/2015/01/09/headless-browser-testing-xvfb/). Therefore you have every confidence that the tests are run on the real thing.

# Usage

```
docker run -it --rm --net=host -v /dev/shm:/dev/shm -v $(pwd):/protractor webnicer/protractor-headless [protractor options]
```

This will run protractor in your current directory, so you should run it in your tests root directory. It is useful to create a script, for example /usr/local/bin/protractor.sh such as this:

```
#!/bin/bash

docker run -it --rm --net=host -v /dev/shm:/dev/shm -v $(pwd):/protractor webnicer/protractor-headless $@
```

The script will allow you to run dockerised protractor like so:

```
protractor.sh [protractor options]
```

## Why mapping `/dev/shm`?

Docker has hardcoded value of 64MB for `/dev/shm`. Because of that you can encounter an error [session deleted becasue of page crash](https://bugs.chromium.org/p/chromedriver/issues/detail?id=1097) on memory intensive pages. The easiest way to mitigate that problem is share `/dev/shm` with the host.

This needs to be done till `docker build` [gets the option `--shm-size`](https://github.com/docker/docker/issues/2606).


FROM node:6.9.4-slim
MAINTAINER j.ciolek@webnicer.com
WORKDIR /tmp
COPY webdriver-versions.js ./
ENV CHROME_PACKAGE="google-chrome-stable_54.0.2840.71-1_amd64.deb" NODE_PATH=/usr/local/lib/node_modules
RUN npm install -g protractor@4.0.14 mocha@3.2.0 jasmine@2.5.3 minimist@1.2.0 && \
    node ./webdriver-versions.js --chromedriver 2.27 && \
    webdriver-manager update && \
    apt-get update && \
    apt-get install -y xvfb wget openjdk-7-jre && \
    wget https://github.com/webnicer/chrome-downloads/raw/master/x64.deb/${CHROME_PACKAGE} && \
    dpkg --unpack ${CHROME_PACKAGE} && \
    apt-get install -f -y && \
    apt-get clean && \
    rm ${CHROME_PACKAGE} && \
    mkdir /protractor
COPY protractor.sh /protractor.sh
# Fix for the issue with Selenium, as described here:
# https://github.com/SeleniumHQ/docker-selenium/issues/87
ENV DBUS_SESSION_BUS_ADDRESS=/dev/null
ENV SCREEN_RES=1280x1024x24
WORKDIR /protractor
ENTRYPOINT ["/protractor.sh"]

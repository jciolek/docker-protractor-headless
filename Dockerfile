FROM node:6.9.4-slim
MAINTAINER j.ciolek@webnicer.com
WORKDIR /tmp
RUN npm install -g protractor@4.0.14 mocha@3.2.0 jasmine@2.5.3 && \
    webdriver-manager update && \
    webdriver-manager update --versions.chrome 2.27 && \
    apt-get update && \
    apt-get install -y xvfb wget openjdk-7-jre && \
    wget https://github.com/webnicer/chrome-downloads/raw/master/x64.deb/google-chrome-stable_54.0.2840.71-1_amd64.deb && \
    dpkg --unpack google-chrome-stable_54.0.2840.71-1_amd64.deb && \
    apt-get install -f -y && \
    apt-get clean && \
    rm google-chrome-stable_54.0.2840.71-1_amd64.deb && \
    mkdir /protractor
COPY protractor.sh /protractor.sh
# Fix for the issue with Selenium, as described here:
# https://github.com/SeleniumHQ/docker-selenium/issues/87
ENV DBUS_SESSION_BUS_ADDRESS=/dev/null
ENV SCREEN_RES=1280x1024x24
WORKDIR /protractor
ENTRYPOINT ["/protractor.sh"]

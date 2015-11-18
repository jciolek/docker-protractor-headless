FROM node
MAINTAINER j.ciolek@webnicer.com
WORKDIR /tmp
RUN npm install -g protractor mocha jasmine && \
    webdriver-manager update && \
    apt-get update && \
    apt-get install -y xvfb wget openjdk-7-jre && \
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
    dpkg --unpack google-chrome-stable_current_amd64.deb && \
    apt-get install -f -y && \
    apt-get clean && \
    rm google-chrome-stable_current_amd64.deb && \
    mkdir /protractor
ADD protractor.sh /protractor.sh
WORKDIR /protractor
ENTRYPOINT ["/protractor.sh"]

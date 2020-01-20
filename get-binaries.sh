#!/bin/bash -x

SERVERLESS_CHROME_URL=https://github.com/adieuadieu/serverless-chrome/releases/download/v1.0.0-55/stable-headless-chromium-amazonlinux-2017-03.zip
CHROME_DRIVER_URL=https://chromedriver.storage.googleapis.com/2.41/chromedriver_linux64.zip

# get headless_chrome
rm -r ./headless_chrome
mkdir -p ./headless_chrome

wget $SERVERLESS_CHROME_URL
unzip stable-headless-chromium-amazonlinux-2017-03.zip -d ./headless_chrome/bin/
rm stable-headless-chromium-amazonlinux-2017-03.zip

wget $CHROME_DRIVER_URL
unzip chromedriver_linux64.zip -d ./headless_chrome/bin/
rm chromedriver_linux64.zip

# get selenium
#  python path: https://dev.classmethod.jp/cloud/aws/lambda-layer-basics-how-it-works/
PYTHON_LIB=python/lib/python3.7/site-packages
rm -r ./selenium
mkdir -p ./selenium/${PYTHON_LIB}
docker run --rm \
  -u=`id -u ${USER}`:`id -g ${USER}` \
  -v ${PWD}/selenium/${PYTHON_LIB}:/site-packages \
  lambci/lambda:build-python3.7 \
    pip install selenium -t /site-packages
docker image rm lambci/lambda:build-python3.7

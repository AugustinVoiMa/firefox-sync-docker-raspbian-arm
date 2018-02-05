# Firefox Sync-1.5 Server Docker file for raspberry armv7l
#
# https://github.com/AugustinVoiMa/firefox-sync-docker-raspbian-arm

FROM resin/armv7hf-debian

LABEL maintener="augustinvoima@gmail.com"
LABEL description=" a Docker container for Sync-1.5 Server (firefox sync) running on raspberry (armv7l) "


RUN apt-get update &&\
  apt-get install -y git make virtualenv python python-dev git-core python-virtualenv g++ crudini &&\
  cd ~ &&\
  git clone https://github.com/mozilla-services/syncserver &&\
  cd ~/syncserver &&\
  make build

EXPOSE 5000

COPY /entrypoint.sh /
ONBUILD COPY /entrypoint.sh /entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

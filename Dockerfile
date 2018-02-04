# Firefox Sync-1.5 Server Docker file for raspberry armv7l
#
# https://github.com/AugustinVoiMa/firefox-sync-docker-raspbian-arm

FROM resin/rpi-raspbian

RUN
  apt update &&
  apt install -y git make python-dev git-core python-virtualenv g++ crudini

RUN cd ~ &&
  git clone https://github.com/mozilla-services/syncserver &&
  cd syncserver &&
  make build

RUN read -p "Enter public url: " PUB_URL &&
  read -p "SQLAlchemy database URI: " DATABASE_URI &&
  crudini --set --format=ini syncserver.ini syncserver public_url $PUB_URL &&
  crudini --set --format=ini syncserver.ini syncserver sqluri $DATABASE_URI


EXPOSE 5000

CMD cd ~/syncserver && make serve

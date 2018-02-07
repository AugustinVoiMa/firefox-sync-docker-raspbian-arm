#!/bin/bash

cd ~/syncserver;

read -p "Enter public url: " PUB_URL;
read -p "SQLAlchemy database URI (container's gateway $(ip route show | grep default | cut -f 3 -d " ") will substitute %dockerhost):" DATABASE_URI;
crudini --set --format=ini syncserver.ini syncserver \
  public_url $PUB_URL;

crudini --set --format=ini syncserver.ini syncserver \
  sqluri $(echo $DATABASE_URI | \
  sed -e "s/%dockerhost/$(ip route show | grep default | cut -f 3 -d " ")/g");

crudini --set --format=ini syncserver.ini auth allow_new_users true;
echo "Configuration ok";
cd ~/syncserver && make serve;

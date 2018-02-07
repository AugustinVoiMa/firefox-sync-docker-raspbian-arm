#!/bin/bash

export LANG=fr_FR.UTF-8;
cd ~/syncserver;

read -p "press [Enter]";
read -p "Enter public url: " PUB_URL;
read -p "SQLAlchemy database URI (container's gateway $(ip route show | grep default | cut -f 3 -d " ") will substitute %dockerhost):" DATABASE_URI;

DATABASE_URI=$(echo $DATABASE_URI | sed -e "s/%dockerhost/$(ip route show | grep default | cut -f 3 -d " ")/g");

crudini --set --format=ini syncserver.ini syncserver \
  public_url $PUB_URL;

crudini --set --format=ini syncserver.ini syncserver \
  sqluri $DATABASE_URI

crudini --set --format=ini syncserver.ini auth allow_new_users true;
crudini --set --format=ini syncserver.ini server:main host $(ip route show | grep default | cut -f 3 -d " ");
crudini --set --format=ini syncserver.ini server:main workers 2;

echo -e "Configuration ok:";
echo -e "public Url:\t$PUB_URL";
echo -e "databaseURI:\t$DATABASE_URI";
read -p "press [Enter]";
cd ~/syncserver && make serve;

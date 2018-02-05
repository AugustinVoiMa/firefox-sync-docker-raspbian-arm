#!/bin/bash

cd ~/syncserver;

read -p "Enter public url: " PUB_URL;
read -p "SQLAlchemy database URI (use @localhost for a database stored on this container's host): " DATABASE_URI;
$(ip route show | grep default | cut -f 3 -d " ")
crudini --set --format=ini syncserver.ini syncserver
  public_url $PUB_URL;
crudini --set --format=ini syncserver.ini syncserver
  sqluri $(echo $DATABASE_URI |
    sed -e "s/@localhost/
    $(ip route show | grep default | cut -f 3 -d " ")/g");
cd ~/syncserver && make serve;

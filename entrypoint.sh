#!/bin/bash

cd ~/syncserver;

read -p "Enter public url: " PUB_URL;
read -p "SQLAlchemy database URI: " DATABASE_URI;
crudini --set --format=ini syncserver.ini syncserver public_url $PUB_URL;
crudini --set --format=ini syncserver.ini syncserver sqluri $DATABASE_URI;

cd ~/syncserver && make serve;

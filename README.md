# Docker container for Sync-1.5 Server (firefox sync) running on raspberry (arm32v7)
## Infos
- Firefox synchronization works with two services: authentification and synchronization storage. Both of these services are hosted on mozilla fundation servers, but you can install and use official service on your own server. As everyday sync storage.<br>
- Here we get interested into hosting a sync server on a raspberry pi using arm32v7 architecture. This server will run into a docker container.
- For authentification, we use default mozilla auth services.
-  Github Repository: https://github.com/AugustinVoiMa/firefox-sync-docker-raspbian-arm
-  Docker Image: https://hub.docker.com/r/augustinvm/firefox-sync-docker-raspbian-arm

## Container installation
  - Pull Image from Docker hub:
  ```
  docker pull augustinvm/firefox-sync-docker-raspbian-arm
  ```
  - Run the image:
  ```
  docker run -it -p 5000:5000 --name fsync augustinvm/firefox-sync-docker-raspbian-arm
  ```
  Don't daemonize on run, we need to set up **configuration:**

  Two config fields are asked:
  -   **First** is external URL. It is the url in header passed by your web server proxy configuration or the url used for direct access.<br>
  Example: ```http://fsync.your-domain.net```
  -   **Second** is a SQLAlchemy database URI for your database ( Docker host ip on container interface will substitute ```%dockerhost``` )<br>
  Example for a mysql server on docker host which knows fsync user identified by fsync_pass having sufficient right on existing fsync_db database.<br>
  '``` pymysql://fsync:fsync_pass@%dockerhost/fsync_db ``` <br>
  ***** Database may have been correctly configured (/etc/mysql/my.cnf: ```bind-address = 0.0.0.0``` and binding filters in mysql users like ```'fsync'@'172.17.0.1'```)

  Then sync server should run, you can detach now ```Ctrl+P, Ctrl+Q```

## Proxy configuration:
  - For nginx, following basic configuration works:
```
server{
      listen 80;
      server_name fsync.your-domain.net;

      location / {
          proxy_set_header Host $http_host;
          proxy_set_header X-Forwarded-Proto $scheme;
          proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
          proxy_set_header X-Real-IP $remote_addr;
          proxy_redirect off;
          proxy_read_timeout 120;
          proxy_connect_timeout 10;
          proxy_pass http://127.0.0.1:5000/;
      }
      access_log /var/log/fsync.log;
      error_log /var/log/fsync.err;
}
```

## Browser configuration:
  - Go to firefox advanced configuration [about:config](about:config).
  - Search for ```identity.sync.tokenserver.uri``` entry.
  - Change its value to your new synchronization server with following URI ```/token/1.0/sync/1.5```<br>
  Example: ```http://fsync.yout-domain.net/token/1.0/sync/1.5```
  - Repeat this then reconnect from all synchronized firefox instances you use.

# Docker container for Sync-1.5 Server (firefox sync) running on raspberry (armv7l) 

# Running:
```bash
docker run -it -d -p 5000:5000 --net="host" augustinvoima/firefox-sync-docker-raspbian-arm
```
please attach after running for configuration:
-   **First field** is external URL. It is the url passed by your web server proxy configuration or the url used for direct utilisation.
-   **Second field** is a SQLAlchemy database URI for your database ( pymysql://user:pass@example.com/example_db )


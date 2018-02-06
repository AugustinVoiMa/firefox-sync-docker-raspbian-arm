# Docker container for Sync-1.5 Server (firefox sync) running on raspberry (armv7l) 

# Running:
```docker run -it -p 5000:5000 --net="host" --name fsync augustinvoima/firefox-sync-docker-raspbian-arm```
Don't daemonize on run, we need to set up **configuration:**

Two config fields are asked:
-   **First** is external URL. It is the url in header passed by your web server proxy configuration or the url used for direct access.
-   **Second** is a SQLAlchemy database URI for your database ( pymysql://user:pass@example.com/example_db )

Then sync server should run, you can detach now ```Ctrl+P, Ctrl+Q```

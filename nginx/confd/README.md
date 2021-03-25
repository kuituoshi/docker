# NGINX


* `SET_CONFD_NODE` default 127.0.0.1:2379/0 (ip:port:db)

* `SET_CONFD_NODE_PASSWORD` redis password

* `SET_CONFD_PREFIX` default is /nginx

* `SET_CONFD_INTERVAL` default is 30 , set 0 will startup watch mode


*Usage*

* `/serverList/*` store nginx `server { *** }` list
* `/globalAttributes/*` store nginx global attributes like `http { key value ;}`
* `/locationList/${server_name}/*` store nginx specific ${server_name} locations `location / {} , location /api {}`
* `/serverLocations/${server_name}/${location}/*` store ${location} of ${server_name} attributes , like `pass http://127.0.0.1:8080, proxy_set_header Host $host`
* `/serverAttributes/${server_name}/*` store ${server_name} attributes, like `listen 80;`
# V2RAY

* [`4.23.1`](https://github.com/kuituoshi/docker/blob/master/v2ray/4.23.1/Dockerfile)


## What is changed

* Clone from `v2ray/official`

* Change default cofiguration json file

* Export 4443 port by default

```json
{
  "log": {
    "loglevel": "warning"
  },
  "dns": {},
  "stats": {},
  "inbounds": [
    {
      "port": 4443,
      "protocol": "vmess",
      "settings": {
        "clients": [
          {
            "id": "29f5a1f4-84fa-4bf1-9c75-d0e75ad08018",
            "alterId": 32
          }
        ]
      },
      "tag": "in-0",
      "streamSettings": {
        "network": "tcp",
        "security": "none",
        "tcpSettings": {}
      }
    }
  ],
  "outbounds": [
    {
      "tag": "direct",
      "protocol": "freedom",
      "settings": {}
    },
    {
      "tag": "blocked",
      "protocol": "blackhole",
      "settings": {}
    }
  ],
  "routing": {
    "domainStrategy": "AsIs",
    "rules": [
      {
        "type": "field",
        "ip": [
          "geoip:private"
        ],
        "outboundTag": "blocked"
      }
    ]
  },
  "policy": {},
  "reverse": {},
  "transport": {}
}

```

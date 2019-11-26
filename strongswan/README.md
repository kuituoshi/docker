# STRONGSWAN

* [`5.6.2`](https://github.com/kuituoshi/docker/blob/master/strongswan/5.6.2/Dockerfile)


## What is changed

* Before use it , run command `docker run -it --rm -v /tmp/certs:/data changel/strongswan:5.6.2 generate-certs vpn.example.com` to make certification into /data in docker
* if you want to use it in IOS system, you must purchase Authorified certs and replace `*.crt *.key` in private and certs directory
* default username and password is `admin: 123456`, change ipsec.secrets if you want
* Add all this data to your container path `/etc`
* **IMPORTANT!** in `conn ios_ikev2`->`/etc/ipsec.conf`->`leftid` Make sure this value equal to one of CN in your certification, Example if your certification CN contains `*.example.com example.com www.example.com`, you have to choose in one of them, And uncomment `leftca` which is issuer CN


## How to use it

*windows*

* import strongswan.pem which is in cacerts directory , if you use windows7 ,you should import it with `MMC`
* choose IKEv2 protocol

*android*

* select XAUTH-PSK type 
* remote identifier is `android`

*ios*

* remote identifier is the same with server domain name
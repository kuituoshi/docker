# registry


* [`cleaner`](https://github.com/kuituoshi/docker/blob/master/registry/cleaner/Dockerfile)



## What is changed in cleaner

* Base image is python3.6-buster
* Install `requests` package

## How to use it

* Notice! make sure you tag your image with format `image:describe.%yy.%mm%dd` --> like `tomcat:manager.19.0219`
* Set environments before running in docker `IMAGE_NAME,IMAGE_KEEP_INTERVAL,REGISTRY_URL,REGISTRY_USERNAME,REGISTRY_PASSWORD`
* `IMAGE_NAMES` specify images you want to clean, multiple image split with ','
* `IMAGE_KEEP_INTERVAL` keep interval, expired image will be marked deleted
* `REGISTRY_URL` are privite registry repository url
* `REGISTRY_USERNAME,REGISTRY_PASSWORD` repository username and password
* After tags deleted, your should run command in registry container `"/bin/registry garbage-collect  /etc/docker/registry/config.yml --delete-untagged=true"`
* `--delete-untagged=true` support in version `2.7`
# registry


* [`cleaner`](https://github.com/kuituoshi/docker/blob/master/registry/cleaner/Dockerfile)



## What is changed in cleaner

* Base image is python3.6-buster
* Install `requests` package

## How to use it

* Notice! make sure you tag your image with format `image:describe.%yy.%mm%dd` --> like `tomcat:manager.19.0219`
* Set environments before running in docker `IMAGE_NAME,IMAGE_KEEP_INTERVAL,REGISTRY_URL,REGISTRY_USERNAME,REGISTRY_PASSWORD`
* `IMAGE_NAME` is which image you want to clean, `IMAGE_KEEP_INTERVAL` is to keep interval, expired image will be marked deleted
* `REGISTRY_URL,REGISTRY_USERNAME,REGISTRY_PASSWORD` are privite registry login info
* After you have been deleted tags of image if your registry use local storage driver, Run this command in registry container --> `"/bin/registry garbage-collect  /etc/docker/registry/config.yml"`
# SPRINGBOOT

* [`8`](https://github.com/kuituoshi/docker/blob/master/springboot/8/Dockerfile)
* [`11`](https://github.com/kuituoshi/docker/blob/master/springboot/11/Dockerfile)
* [`8-openjdk`](https://github.com/kuituoshi/docker/blob/master/springboot/8-openjdk/Dockerfile)
* [`8-openj9`](https://github.com/kuituoshi/docker/blob/master/springboot/8-openj9/Dockerfile)
* [`11-openjdk`](https://github.com/kuituoshi/docker/blob/master/springboot/11-openjdk/Dockerfile)
* [`11-openj9`](https://github.com/kuituoshi/docker/blob/master/springboot/11-openj9/Dockerfile)

# What is changed

* SPRINGBOOT_PORT: springboot listen port, default is 8080
* SPRINGBOOT_MEMORY: springboot heap size, default is 1g
* SPRINGBOOT_HOME: springboot home directory, default is /workdir
* SPRINGBOOT_JAR_NAME: springboot entrypoint, default is boot.jar (/workdir/boot.jar)
* SPRINGBOOT_ACTIVE_PROFILE: springboot active profile, default is uat, it is an option config
* SPRINGBOOT_TZDATE: timezone setup to Asia/Shanghai by  default

* Put shell scripts in `/docker-entrypoint-init.d/` will be excuted before Start server
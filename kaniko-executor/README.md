# kaniko-executor

* [`latest`, `2201`](https://github.com/kuituoshi/docker/blob/master/kaniko-executor/2201/Dockerfile)
* [`debug`](https://github.com/kuituoshi/docker/blob/master/kaniko-executor/debug/Dockerfile)


# Usage

* `"--destination=changel/alpine:3.14"`  image name 
* `"--context=dir://workspace"`  workspace default directory
* `"--dockerfile=/workspace/Dockerfile"` Default dockerfile path

# Notice

* When use in k8s , you have to create `Secret` for docker credential first
```
kubectl create secret docker-registry dockercred \
    --docker-server=https://index.docker.io/v1/ \
    --docker-username=changel \
    --docker-password=Password \
    --docker-email=changel@changel.cn
```

* Sample for k8s 

```
apiVersion: v1
kind: Pod
metadata:
  name: kaniko
spec:
  containers:
  - name: kaniko
    image: changel/kaniko-executor
    imagePullPolicy: IfNotPresent
    args: [
      "--destination=changel/alpine:3.14",
    ]
    volumeMounts:
    - name: kaniko-secret
      mountPath: /kaniko/.docker
    - mountPath: /workspace
      name: data
  restartPolicy: Never
  volumes:
  - name: kaniko-secret
    secret:
      secretName: dockercred
      items:
        - key: .dockerconfigjson
          path: config.json
  - name: data
    hostPath:
      path: /Users/changel/workspace
      type: Directory
```
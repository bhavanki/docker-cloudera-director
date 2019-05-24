# docker-cloudera-director

This project defines a [Docker](https://www.docker.com/) image for running the [Cloudera Altus Director](https://www.cloudera.com/products/product-components/cloudera-director.html) server.

Current version: **6.2.1**

## Caveats

Although I'm a developer who works on Altus Director, this is not an official Cloudera project, so do not expect support from Cloudera (or myself, potentially) for this project. Also, I'm not a Docker expert, so as usual, proceed with using this image at your own risk.

## Usage

### Pull from Docker Hub

To get the latest:

```
docker pull havanki4j/cloudera-director
```

Browse the tags available at the [repository](https://hub.docker.com/r/havanki4j/cloudera-director/) to find images for different versions of Altus Director.

### Build Yourself

Assuming an image tag of "cloudera-director", run the Altus Director image:

```
docker build -t cloudera-director .
docker run -p 7189:7189 cloudera-director
```

The image exposes TCP port 7189, so be sure to publish the port when running. Then, point your browser to the published port to use the Altus Director server UI.

To stop the container:

```
docker stop <container-id>
```

### Volumes

The directories /home/director/db and /home/director/logs are declared as volumes in the image for storing the Altus Director database and logs, respectively. Save these volumes across container runs to keep state and log history. See Docker documentation for how to manage them.

## Kubernetes

The simple Kubernetes deployment manifest [director-deployment.yaml](director-deployment.yaml) describes a single Altus Director server pod and a corresponding nodeport service to expose it outside of the Kubernetes cluster.

```
kubectl create -f director-deployment.yaml
minikube service cloudera-director-svc # to reach the server UI, when using minikube
kubectl delete -f director-deployment.yaml
```

## License

[Apache License, Version 2.0](http://www.apache.org/licenses/LICENSE-2.0)

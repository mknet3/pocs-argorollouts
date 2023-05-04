# Argo Rollouts PoC

## Quickstart
```bash
brew install minikube
minikube start
```

## Configuring DNS

You can find more information [here](https://minikube.sigs.k8s.io/docs/handbook/addons/ingress-dns/).

```
minikube addons enable ingress
minikube addons enable ingress-dns
```

To be able to use **ingress-dns** in MacOS is necessary to install **docker-mac-net-connect**. You can find more info about this issue [here](https://github.com/kubernetes/minikube/issues/7332).
```bash
brew install chipmk/tap/docker-mac-net-connect
sudo brew services start chipmk/tap/docker-mac-net-connect
```
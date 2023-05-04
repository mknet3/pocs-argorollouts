resource "helm_release" "argocd" {
  name       = "argocd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = "5.24.1"

  namespace        = "argocd"
  create_namespace = true

  values = [
    "${file("templates/argocd-values.yaml")}"
  ]
}

resource "helm_release" "argocd-rollouts" {
  name       = "argo-rollouts"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-rollouts"
  version    = "2.23.0"
  wait       = true

  namespace        = "argocd"
  create_namespace = true

  values = [
    "${file("templates/argo-rollouts-values.yaml")}"
  ]
}

resource "kubernetes_manifest" "argocd" {
  provider = kubernetes
  depends_on = [
    helm_release.argocd-rollouts
  ]

  manifest = {
        "apiVersion": "argoproj.io/v1alpha1"
        "kind": "ArgoCDExtension"
        "metadata": {
            "name": "argo-rollouts"
            "namespace": "argocd"
            "finalizers": [ "extensions-finalizer.argocd.argoproj.io" ]
        }
        "spec": {
            "sources": [
                { 
                    "web": {
                        "url": "https://github.com/argoproj-labs/rollout-extension/releases/download/v0.1.0/extension.tar"
                    }
                }]
        }
    }
}
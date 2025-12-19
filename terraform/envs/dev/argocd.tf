resource "helm_release" "argocd" {
  name             = "argocd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  namespace        = "argocd"
  create_namespace = true

  values = [
    <<EOF
server:
  service:
    type: ClusterIP

configs:
  params:
    server.insecure: true
EOF
  ]
}

resource "flux_bootstrap_git" "this" {
  path   = "clusters/aws-k3s"

  components_extra = ["image-reflector-controller", "image-automation-controller"]
  kustomization_override = file("${path.module}/flux-kustomization.yaml")
}
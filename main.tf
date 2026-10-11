resource "kubernetes_role_v1" "role_v1s" {
  for_each = var.role_v1s


  metadata {
    annotations   = each.value.metadata.annotations
    generate_name = each.value.metadata.generate_name
    labels        = each.value.metadata.labels
    name          = each.value.metadata.name
    namespace     = each.value.metadata.namespace
  }

  dynamic "rule" {
    for_each = each.value.rule
    content {
      api_groups     = rule.value.api_groups
      resource_names = rule.value.resource_names
      resources      = rule.value.resources
      verbs          = rule.value.verbs
    }
  }
}


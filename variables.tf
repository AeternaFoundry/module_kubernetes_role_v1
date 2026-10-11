variable "role_v1s" {
  description = <<EOT
Map of role_v1s, attributes below
Required:
    - metadata (block):
        - annotations (optional)
        - generate_name (optional)
        - labels (optional)
        - name (optional)
        - namespace (optional)
    - rule (block):
        - api_groups (required)
        - resource_names (optional)
        - resources (required)
        - verbs (required)
EOT

  type = map(object({
    metadata = object({
      annotations   = optional(map(string))
      generate_name = optional(string)
      labels        = optional(map(string))
      name          = optional(string)
      namespace     = optional(string)
    })
    rule = list(object({
      api_groups     = set(string)
      resource_names = optional(set(string))
      resources      = set(string)
      verbs          = set(string)
    }))
  }))
  validation {
    condition = alltrue([
      for k, v in var.role_v1s : (
        length(v.rule) >= 1
      )
    ])
    error_message = "Each rule list must contain at least 1 items"
  }
}


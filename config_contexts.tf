locals {
  context_files = fileset("${path.module}/config-contexts", "*.yaml")

  contexts = { for filename in local.context_files : filename => yamldecode(file("${path.module}/config-contexts/${filename}")) }

  sites = setunion([
    for filename, ctx in local.contexts : [
      for item in ctx._assignment.sites : item
    ] if can(ctx._assignment.sites)
  ]...)

  roles = setunion([
    for filename, ctx in local.contexts : [
      for item in ctx._assignment.roles : item
    ] if can(ctx._assignment.roles)
  ]...)
}

data "netbox_site" "assignments" {
  for_each = local.sites
  slug     = each.value
}

data "netbox_device_role" "assignments" {
  for_each = local.roles
  name     = each.value
}

resource "netbox_config_context" "ctx" {
  for_each = local.contexts

  name = trimsuffix(each.key, ".yaml")
  data = jsonencode({
    for k, v in each.value :
    k => v if k != "_assignment"
  })

  sites = try([
    for site_slug in each.value._assignment.sites :
    data.netbox_site.assignments[site_slug].id
  ], null)
  roles = try([
    for role_name in each.value._assignment.roles :
    data.netbox_device_role.assignments[role_name].id
  ], null)
}

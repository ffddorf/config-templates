locals {
  templates = {
    for filename in fileset("${path.module}/templates", "*.j2") :
    trimsuffix(filename, ".j2") => file("${path.module}/templates/${filename}")
  }

  template_assingments = {
    for filename, template in local.templates :
    filename => regex("{#-? ?assignment: ?platform=([^ #]+) ?#}", template)[0]
  }
}

resource "netbox_config_template" "templates" {
  for_each = local.templates

  name          = try(regex("{# ?name: ?([^#]+?) ?#}", each.value)[0], each.key)
  template_code = trimspace(each.value)
}

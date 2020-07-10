provider "tencentcloud" {
  version = ">=1.29.1"
  region  = "ap-guangzhou" // GAAP doesn't care region
}

resource "tencentcloud_gaap_proxy" "default" {
  count = var.access_region != "" ? 1 : 0

  access_region     = var.access_region
  bandwidth         = var.bandwidth
  concurrent        = var.concurrent
  name              = var.proxy_name
  realserver_region = var.realserver_region
  project_id        = var.project_id
  tags              = var.tags
}

resource "tencentcloud_gaap_security_policy" "default" {
  count = var.policy_id == "" ? 1 : 0

  action   = var.policy_action
  proxy_id = var.proxy_id != "" ? var.proxy_id : tencentcloud_gaap_proxy.default[0].id
}

resource "tencentcloud_gaap_security_rule" "default" {
  count = length(var.policy_rules)

  action    = lookup(var.policy_rules[count.index], "action", null)
  cidr_ip   = lookup(var.policy_rules[count.index], "cidr_ip", null)
  policy_id = var.policy_id != "" ? var.policy_id : tencentcloud_gaap_security_policy.default[0].id
  name      = var.policy_rule_name
  port      = lookup(var.policy_rules[count.index], "port", "ALL")
  protocol  = lookup(var.policy_rules[count.index], "protocol", "ALL")
}

resource "tencentcloud_gaap_certificate" "listener_certificate" {
  count   = var.listener_certificate_content != "" ? 1 : 0
  name    = var.listener_certificate_name
  content = var.listener_certificate_content
  key     = var.listener_certificate_key
  type    = "SERVER"
}

resource "tencentcloud_gaap_certificate" "listener_client_certificate" {
  count   = var.listener_client_certificate_content != "" ? 1 : 0
  name    = var.listener_client_certificate_name
  content = var.listener_client_certificate_content
  type    = "CLIENT"
}

resource "tencentcloud_gaap_layer7_listener" "default" {
  count                  = var.protocol != "" ? 1 : 0
  proxy_id               = length(tencentcloud_gaap_proxy.default) > 0 ? tencentcloud_gaap_proxy.default[0].id : var.proxy_id
  name                   = var.name
  port                   = var.port
  protocol               = var.protocol
  forward_protocol       = var.forward_protocol
  auth_type              = var.auth_type
  certificate_id         = length(tencentcloud_gaap_certificate.listener_certificate) > 0 ? tencentcloud_gaap_certificate.listener_certificate[0].id : var.listener_certificate_id
  client_certificate_ids = length(tencentcloud_gaap_certificate.listener_client_certificate) == 0 && var.listener_client_certificate_id == "" ? null : compact(concat(tencentcloud_gaap_certificate.listener_client_certificate.*.id, [var.listener_client_certificate_id]))
}

resource "tencentcloud_gaap_certificate" "http_domain_certificate" {
  count   = var.http_domain_certificate_content == "" ? 0 : 1
  name    = var.http_domain_certificate_name
  content = var.http_domain_certificate_content
  key     = var.http_domain_certificate_key
  type    = "SERVER"
}

resource "tencentcloud_gaap_certificate" "http_domain_client_certificate" {
  count   = var.http_domain_client_certificate_content != "" ? 1 : 0
  name    = var.http_domain_client_certificate_name
  content = var.http_domain_client_certificate_content
  type    = "CLIENT"
}

resource "tencentcloud_gaap_certificate" "http_domain_basic_certificate" {
  count   = var.basic_auth_content != "" ? 1 : 0
  name    = var.basic_auth_name
  content = var.basic_auth_content
  type    = "BASIC"
}

resource "tencentcloud_gaap_certificate" "http_domain_gaap_certificate" {
  count   = var.gaap_certificate_content != "" ? 1 : 0
  name    = var.gaap_certificate_name
  content = var.gaap_certificate_content
  key     = var.gaap_certificate_key
  type    = "PROXY"
}

resource "tencentcloud_gaap_certificate" "http_domain_realserver_certificate" {
  count   = var.realserver_certificate_content != "" ? 1 : 0
  name    = var.realserver_certificate_name
  content = var.realserver_certificate_content
  type    = "REALSERVER"
}

resource "tencentcloud_gaap_http_domain" "default" {
  count                         = var.http_domain_id == "" && var.http_domain != "" ? 1 : 0
  domain                        = var.http_domain
  listener_id                   = length(tencentcloud_gaap_layer7_listener.default) > 0 ? tencentcloud_gaap_layer7_listener.default[0].id : var.listener_id
  basic_auth                    = var.basic_auth
  basic_auth_id                 = length(tencentcloud_gaap_certificate.http_domain_basic_certificate) > 0 ? tencentcloud_gaap_certificate.http_domain_basic_certificate[0].id : var.basic_auth_id
  certificate_id                = length(tencentcloud_gaap_certificate.http_domain_certificate) > 0 ? tencentcloud_gaap_certificate.http_domain_certificate[0].id : var.http_domain_certificate_id
  client_certificate_ids        = length(tencentcloud_gaap_certificate.http_domain_client_certificate) == 0 && var.http_domain_client_certificate_id == "" ? null : compact(concat(tencentcloud_gaap_certificate.http_domain_client_certificate.*.id, [var.http_domain_client_certificate_id]))
  gaap_auth                     = var.gaap_auth
  gaap_auth_id                  = length(tencentcloud_gaap_certificate.http_domain_gaap_certificate) > 0 ? tencentcloud_gaap_certificate.http_domain_gaap_certificate[0].id : var.gaap_certificate_id
  realserver_auth               = var.realserver_auth
  realserver_certificate_domain = var.realserver_certificate_domain
  realserver_certificate_ids    = length(tencentcloud_gaap_certificate.http_domain_realserver_certificate) == 0 && var.realserver_certificate_id == "" ? null : compact(concat(tencentcloud_gaap_certificate.http_domain_realserver_certificate.*.id, [var.realserver_certificate_id]))
}

resource "tencentcloud_gaap_http_rule" "default" {
  count = (var.http_domain != "" || var.http_rule_domain != "") ? 1 : 0

  domain                    = length(tencentcloud_gaap_http_domain.default) > 0 ? tencentcloud_gaap_http_domain.default[0].domain : coalesce(var.http_rule_domain, var.http_domain)
  health_check              = var.health_check
  listener_id               = length(tencentcloud_gaap_layer7_listener.default) > 0 ? tencentcloud_gaap_layer7_listener.default[0].id : var.listener_id
  path                      = var.path
  realserver_type           = var.realserver_type
  connect_timeout           = var.connect_timeout
  health_check_method       = var.health_check_method
  health_check_path         = var.health_check_path
  health_check_status_codes = var.health_check_status_codes
  interval                  = var.interval
  scheduler                 = var.scheduler
  forward_host              = var.forward_host

  dynamic "realservers" {
    for_each = var.realservers
    content {
      id     = var.create_realserver ? tencentcloud_gaap_realserver.default[index(var.realservers, realservers.value)].id : lookup(realservers.value, "id", "")
      ip     = var.realserver_type == "IP" ? lookup(realservers.value, "ip", "") : lookup(realservers.value, "domain", "")
      port   = lookup(realservers.value, "port", 0)
      weight = lookup(realservers.value, "weight", 1)
    }
  }
}

resource "tencentcloud_gaap_realserver" "default" {
  count = var.create_realserver && length(var.realservers) > 0 ? length(var.realservers) : 0

  project_id = var.project_id
  name       = var.realserver_name
  ip         = var.realserver_type == "IP" ? lookup(var.realservers[count.index], "ip", null) : null
  domain     = var.realserver_type == "DOMAIN" ? lookup(var.realservers[count.index], "domain", null) : null
  tags       = var.tags
}

resource "tencentcloud_gaap_domain_error_page" "default" {
  count = var.domain_error_page_body == "" ? 0 : 1

  body           = var.domain_error_page_body
  domain         = length(tencentcloud_gaap_http_domain.default) > 0 ? tencentcloud_gaap_http_domain.default[0].domain : var.http_domain
  error_codes    = var.domain_error_page_error_codes
  listener_id    = length(tencentcloud_gaap_layer7_listener.default) > 0 ? tencentcloud_gaap_layer7_listener.default[0].id : var.listener_id
  clear_headers  = var.domain_error_page_clear_headers
  new_error_code = var.domain_error_page_new_error_code
  set_headers    = var.domain_error_page_set_headers
}

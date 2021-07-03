output "proxy_id" {
  description = "The list of GAAP proxy ID."
  value       = compact(concat(tencentcloud_gaap_proxy.default.*.id, [var.proxy_id]))
}

output "policy_id" {
  description = "The list of GAAP proxy policy ID."
  value       = compact(concat(tencentcloud_gaap_security_policy.default.*.id, [var.policy_id]))
}

output "policy_rule_ids" {
  description = "The list of GAAP proxy policy rule ID."
  value       = compact(tencentcloud_gaap_security_rule.default.*.id)
}

output "listener_id" {
  description = "The list of GAAP layer7 listener ID."
  value       = var.listener_id != "" ? [var.listener_id] : tencentcloud_gaap_layer7_listener.default.*.id
}

output "http_domain_id" {
  description = "The list of GAAP HTTP domain ID."
  value       = var.http_domain_id != "" ? [var.http_domain_id] : tencentcloud_gaap_http_domain.default.*.id
}

output "http_rule_id" {
  description = "The list of GAAP HTTP rule ID."
  value       = tencentcloud_gaap_http_rule.default.*.id
}

output "listener_certificate_id" {
  description = "The list of GAAP layer7 listener certificate ID."
  value       = var.listener_certificate_id != "" ? [var.listener_certificate_id] : tencentcloud_gaap_certificate.listener_certificate.*.id
}

output "listener_client_certificate_id" {
  description = "The list of GAAP layer7 listener client certificate ID."
  value       = var.listener_client_certificate_id != null ? [var.listener_client_certificate_id] : tencentcloud_gaap_certificate.listener_client_certificate.*.id
}

output "http_domain_certificate_id" {
  description = "The list of GAAP HTTP domain certificate ID."
  value       = var.http_domain_certificate_id != "" ? [var.http_domain_certificate_id] : tencentcloud_gaap_certificate.http_domain_certificate.*.id
}

output "http_domain_client_certificate_id" {
  description = "The list of GAAP HTTP domain client certificate ID."
  value       = var.http_domain_client_certificate_id != null ? [var.http_domain_client_certificate_id] : tencentcloud_gaap_certificate.http_domain_client_certificate.*.id
}

output "http_domain_gaap_certificate_id" {
  description = "The list of GAAP HTTP domain proxy certificate ID."
  value       = var.gaap_certificate_id != "" ? [var.gaap_certificate_id] : tencentcloud_gaap_certificate.http_domain_gaap_certificate.*.id
}

output "http_domain_basic_auth_id" {
  description = "The list of GAAP HTTP domain basic auth ID."
  value       = var.basic_auth_id != "" ? [var.basic_auth_id] : tencentcloud_gaap_certificate.http_domain_basic_certificate.*.id
}

output "http_domain_realserver_certificate_id" {
  description = "The list of GAAP HTTP domain realserver certificate ID."
  value       = var.realserver_certificate_id != null ? [var.realserver_certificate_id] : tencentcloud_gaap_certificate.http_domain_realserver_certificate.*.id
}

output "domain_error_page_id" {
  description = "The list of GAAP domain error page ID."
  value       = tencentcloud_gaap_domain_error_page.default.*.id
}

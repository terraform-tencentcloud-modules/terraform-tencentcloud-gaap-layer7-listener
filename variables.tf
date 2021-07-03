variable "project_id" {
  description = "Specify the project id."
  default     = 0
}

variable "tags" {
  description = "Specify the tags."
  type        = map(string)
  default     = {}
}

variable "proxy_id" {
  description = "Specify the GAAP proxy ID to launch resources."
  default     = ""
}

variable "proxy_name" {
  description = "Specify the GAAP proxy name to launch a GAAP proxy when `proxy_id` is not specified."
  default     = "tf-module-proxy"
}

variable "access_region" {
  description = "Specify the GAAP proxy access region to launch a GAAP proxy when `proxy_id` is not specified."
  default     = ""
}

variable "realserver_region" {
  description = "Specify the GAAP proxy realserver region to launch a GAAP proxy when `proxy_id` is not specified."
  default     = ""
}

variable "bandwidth" {
  description = "Specify the GAAP proxy bandwidth to launch a GAAP proxy when `proxy_id` is not specified."
  type        = number
  default     = null
}

variable "concurrent" {
  description = "Specify the GAAP proxy concurrent to launch a GAAP proxy when `proxy_id` is not specified."
  type        = number
  default     = null
}

variable "policy_id" {
  description = "The GAAP proxy security policy ID use to launch resources."
  default     = ""
}

variable "policy_action" {
  description = "Specify action of the GAAP proxy security policy to launch resources when `policy_id` is not specified, available values: `ACCEPT` and `DROP`."
  default     = "ACCEPT"
}

variable "policy_rule_name" {
  description = "Specify the GAAP proxy security policy rule name to launch resources."
  default     = "tf-modules-policy-rule"
}

variable "policy_rules" {
  description = "Specify the GAAP proxy security policy rule config, each map contains `action`, `cidr_ip`, `port` and `protocol`. If `port` omitted, will use default value `ALL`; if `protocol` is omitted, will use default value `ALL`."
  type        = list(map(string))
  default     = []
}

variable "listener_id" {
  description = "Specify the GAAP layer7 listener ID to launch resources."
  default     = ""
}

variable "name" {
  description = "The GAAP layer7 listener name used to launch a new layer7 listener when `listener_id` is not specified."
  default     = "tf-module-layer7-listener"
}

variable "port" {
  description = "The GAAP layer7 listener port used to launch a new layer7 listener when `listener_id` is not specified."
  type        = number
  default     = null
}

variable "protocol" {
  description = "The GAAP layer7 listener protocol used to launch a new layer7 listener when `listener_id` is not specified, available values: `HTTP` and `HTTPS`."
  default     = ""
}

variable "auth_type" {
  description = "The GAAP layer7 listener auth type used to launch a new layer7 listener when `listener_id` is not specified, available values: `0` and `1`."
  type        = number
  default     = null
}

variable "forward_protocol" {
  description = "The GAAP layer7 listener forward protocol used to launch a new layer7 listener when `listener_id` is not specified, available values: `HTTP` and `HTTPS`."
  type        = string
  default     = null
}

variable "http_domain_id" {
  description = "The GAAP HTTP domain ID to launch resources."
  type        = string
  default     = ""
}

variable "http_domain" {
  description = "Specify GAAP HTTP domain to launch resources when `http_domain_id` is not specified."
  type        = string
  default     = ""
}

variable "basic_auth" {
  description = "Specify if enable the GAAP HTTP domain basic auth or not when `http_domain_id` is not specified."
  default     = false
}

variable "gaap_auth" {
  description = "Specify if enable the GAAP HTTP domain proxy auth or not when `http_domain_id` is not specified."
  default     = false
}

variable "realserver_auth" {
  description = "Specify if enable the GAAP HTTP domain realserver auth or not when `http_domain_id` is not specified."
  default     = false
}

variable "http_rule_domain" {
  description = "Specify the GAAP HTTP rule domain, if empty, will use `http_domain`."
  type        = string
  default     = ""
}

variable "health_check" {
  description = "Specify if enable the GAAP HTTP rule health check or not."
  default     = false
}

variable "path" {
  description = "Specify the GAAP HTTP rule path."
  type        = string
  default     = "/"
}

variable "realserver_type" {
  description = "Specify the GAAP HTTP rule realserver type, available values: `IP` and `DOMAIN`."
  type        = string
  default     = null
}

variable "connect_timeout" {
  description = "Specify the GAAP HTTP rule connect timeout."
  type        = number
  default     = 2
}

variable "forward_host" {
  description = "Specify the GAAP HTTP rule forward host."
  default     = "default"
}

variable "health_check_method" {
  description = "Specify the GAAP HTTP rule health check method, available values: `GET` and `POST`."
  type        = string
  default     = null
}

variable "health_check_path" {
  description = "Specify the GAAP HTTP rule health check path."
  type        = string
  default     = null
}

variable "health_check_status_codes" {
  description = "The list of GAAP HTTP rule health check status code."
  type        = list(number)
  default     = null
}

variable "interval" {
  description = "Specify the GAAP HTTP rule health check interval."
  type        = number
  default     = 5
}

variable "scheduler" {
  description = "Specify the GAAP HTTP rule scheduler, available values: `rr`, `wrr` and `lc`."
  type        = string
  default     = "rr"
}

variable "create_realserver" {
  description = "Specify create new realservers with specified config in `realservers` or not."
  default     = false
}

variable "realserver_name" {
  description = "Specify the realserver name when `create_realserver` is `true`."
  default     = "tf-module-realserver"
}

variable "realservers" {
  description = "The list of GAAP layer4 listener binding realserver config, each map contains `id`, `ip`, `domain` and `port`. If not specify `weight`, will use default value `1`; If `create_realserver` is `true`, `id` will be ignored."
  type        = list(map(string))
  default     = []
}

variable "listener_certificate_id" {
  description = "The GAAP layer7 listener certificate ID use to launch resources."
  default     = ""
}

variable "listener_certificate_name" {
  description = "The GAAP layer7 certificate name when `listener_certificate_id` is not specified."
  default     = "tfmodule-listener-cert"
}

variable "listener_certificate_content" {
  description = "The GAAP layer7 certificate content when `listener_certificate_id` is not specified."
  default     = ""
}

variable "listener_certificate_key" {
  description = "The GAAP layer7 certificate key when `listener_certificate_id` is not specified."
  default     = ""
}

variable "listener_client_certificate_id" {
  description = "The GAAP layer7 listener client certificate ID use to launch resources."
  default     = ""
}

variable "listener_client_certificate_name" {
  description = "The GAAP layer7 listener client certificate name when `listener_client_certificate_id` is not specified."
  default     = "tfmodule-listener-client-cert"
}

variable "listener_client_certificate_content" {
  description = "The GAAP layer7 listener client certificate content when `listener_client_certificate_id` is not specified."
  default     = ""
}

variable "http_domain_certificate_id" {
  description = "The GAAP HTTP domain certificate ID use to launch resources."
  default     = "default"
}

variable "http_domain_certificate_name" {
  description = "The GAAP HTTP domain certificate name when `http_domain_certificate_id` is not specified."
  default     = "tfmodule-hd-cert"
}

variable "http_domain_certificate_content" {
  description = "The GAAP HTTP domain certificate content when `http_domain_certificate_id` is not specified."
  default     = ""
}

variable "http_domain_certificate_key" {
  description = "The GAAP HTTP domain certificate key when `http_domain_certificate_id` is not specified."
  default     = ""
}

variable "http_domain_client_certificate_id" {
  description = "The GAAP HTTP domain certificate ID use to launch resources."
  default     = ""
}

variable "http_domain_client_certificate_name" {
  description = "The GAAP HTTP domain client certificate name when `http_domain_client_certificate_id` is not specified."
  default     = "tfmodule-hd-client-cert"
}

variable "http_domain_client_certificate_content" {
  description = "The GAAP HTTP domain client certificate content when `http_domain_client_certificate_id` is not specified."
  default     = ""
}

variable "basic_auth_id" {
  description = "The GAAP HTTP domain basic auth ID use to launch resources."
  default     = ""
}

variable "basic_auth_name" {
  description = "The GAAP HTTP domain basic auth name when `basic_auth_id` is not specified."
  default     = "tfmodule-hd-basic-cert"
}

variable "basic_auth_content" {
  description = "The GAAP HTTP domain basic auth content when `basic_auth_id` is not specified."
  default     = ""
}

variable "gaap_certificate_id" {
  description = "The GAAP HTTP domain proxy certificate ID use to launch resources."
  default     = ""
}

variable "gaap_certificate_name" {
  description = "The GAAP HTTP domain proxy certificate name when `gaap_certificate_id` is not specified."
  default     = "tfmodule-hd-proxy-cert"
}

variable "gaap_certificate_content" {
  description = "The GAAP HTTP domain proxy certificate content when `gaap_certificate_id` is not specified."
  default     = ""
}

variable "gaap_certificate_key" {
  description = "The GAAP HTTP domain proxy certificate key when `gaap_certificate_id` is not specified."
  default     = ""
}

variable "realserver_certificate_id" {
  description = "The GAAP HTTP domain realserver certificate ID use to launch resources."
  default     = ""
}

variable "realserver_certificate_name" {
  description = "The GAAP HTTP domain realserver certificate name when `realserver_certificate_id` is not specified."
  default     = "tfmodule-hd-proxy-cert"
}

variable "realserver_certificate_content" {
  description = "The GAAP HTTP domain realserver certificate content when `realserver_certificate_id` is not specified."
  default     = ""
}

variable "realserver_certificate_domain" {
  description = "The GAAP HTTP domain realserver certificate domain when `realserver_certificate_id` is not specified."
  default     = ""
}

variable "domain_error_page_body" {
  description = "Specify the GAAP error page body."
  default     = ""
}

variable "domain_error_page_error_codes" {
  description = "Specify the GAAP error page original error codes."
  type        = list(number)
  default     = []
}

variable "domain_error_page_clear_headers" {
  description = "Specify the GAAP error page remove headers."
  type        = list(string)
  default     = []
}

variable "domain_error_page_new_error_code" {
  description = "Specify the GAAP error page new error code."
  type        = number
  default     = null
}

variable "domain_error_page_set_headers" {
  description = "Specify the GAAP error page new response headers."
  type        = map(string)
  default     = {}
}

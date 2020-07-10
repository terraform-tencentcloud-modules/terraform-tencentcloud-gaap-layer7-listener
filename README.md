# TencentCloud GAAP layer7 listener Module for Terraform

## terraform-tencentcloud-gaap-layer7-listener

A terraform module used to create TencentCloud GAAP layer7 resources.

The following resources are included.

* [GAAP proxy](https://www.terraform.io/docs/providers/tencentcloud/r/gaap_proxy.html)
* [GAAP security policy](https://www.terraform.io/docs/providers/tencentcloud/r/gaap_security_policy.html)
* [GAAP security policy rule](https://www.terraform.io/docs/providers/tencentcloud/r/gaap_security_rule.html)
* [GAAP realserver](https://www.terraform.io/docs/providers/tencentcloud/r/gaap_realserver.html)
* [GAAP certificate](https://www.terraform.io/docs/providers/tencentcloud/r/gaap_certificate.html)
* [GAAP layer7 listener](https://www.terraform.io/docs/providers/tencentcloud/r/gaap_layer7_listener.html)
* [GAAP HTTP domain](https://www.terraform.io/docs/providers/tencentcloud/r/gaap_http_domain.html)
* [GAAP HTTP rule](https://www.terraform.io/docs/providers/tencentcloud/r/gaap_http_rule.html)
* [GAAP domain error page](https://www.terraform.io/docs/providers/tencentcloud/r/gaap_domain_error_page.html)

## Usage

```hcl
module "simple-http" {
  source = "terraform-tencentcloud-modules/gaap-layer7-listener/tencentcloud"

  tags = {
    "test" = "test"
  }

  access_region     = "NorthChina"
  realserver_region = "EastChina"
  bandwidth         = 10
  concurrent        = 2

  protocol        = "HTTP"
  port            = 80
  realserver_type = "IP"

  http_domain = "www.qq.com"

  create_realserver = true

  realservers = [
    {
      ip   = "1.1.1.1"
      port = 80
    },
    {
      ip   = "8.8.8.8"
      port = 80
    }
  ]
}
```

## Conditional Creation

This module can create GAAP proxy and GAAP layer7 listener. It is possible to use existing GAAP proxy when specify `proxy_id` parameter.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| forward_protocol | The GAAP layer7 listener forward protocol used to launch a new layer7 listener when `listener_id` is not specified, available values: `HTTP` and `HTTPS`. | string | null | no
| http_domain | Specify GAAP HTTP domain to launch resources when `http_domain_id` is not specified. | string |  | no
| listener_certificate_name | The GAAP layer7 certificate name when `listener_certificate_id` is not specified. | string | tfmodule-listener-cert | no
| realserver_certificate_domain | The GAAP HTTP domain realserver certificate domain when `realserver_certificate_id` is not specified. | string |  | no
| domain_error_page_error_codes | Specify the GAAP error page original error codes. | list(number) | [] | no
| policy_rules | Specify the GAAP proxy security policy rule config, each map contains `action`, `cidr_ip`, `port` and `protocol`. If `port` omitted, will use default value `ALL`; if `protocol` is omitted, will use default value `ALL`. | list(map(string)) | [] | no
| http_rule_domain | Specify the GAAP HTTP rule domain, if empty, will use `http_domain`. | string |  | no
| realservers | The list of GAAP layer4 listener binding realserver config, each map contains `id`, `ip`, `domain` and `port`. If not specify `weight`, will use default value `1`; If `create_realserver` is `true`, `id` will be ignored. | list(map(string)) | [] | no
| realserver_region | Specify the GAAP proxy realserver region to launch a GAAP proxy when `proxy_id` is not specified. | string |  | no
| protocol | The GAAP layer7 listener protocol used to launch a new layer7 listener when `listener_id` is not specified, available values: `HTTP` and `HTTPS`. | string |  | no
| auth_type | The GAAP layer7 listener auth type used to launch a new layer7 listener when `listener_id` is not specified, available values: `0` and `1`. | number | null | no
| basic_auth_name | The GAAP HTTP domain basic auth name when `basic_auth_id` is not specified. | string | tfmodule-hd-basic-cert | no
| proxy_id | Specify the GAAP proxy ID to launch resources. | string |  | no
| proxy_name | Specify the GAAP proxy name to launch a GAAP proxy when `proxy_id` is not specified. | string | tf-module-proxy | no
| bandwidth | Specify the GAAP proxy bandwidth to launch a GAAP proxy when `proxy_id` is not specified. | number | null | no
| concurrent | Specify the GAAP proxy concurrent to launch a GAAP proxy when `proxy_id` is not specified. | number | null | no
| name | The GAAP layer7 listener name used to launch a new layer7 listener when `listener_id` is not specified. | string | tf-module-layer7-listener | no
| port | The GAAP layer7 listener port used to launch a new layer7 listener when `listener_id` is not specified. | number | null | no
| basic_auth | Specify if enable the GAAP HTTP domain basic auth or not when `http_domain_id` is not specified. | string | false | no
| path | Specify the GAAP HTTP rule path. | string | / | no
| health_check_method | Specify the GAAP HTTP rule health check method, available values: `GET` and `POST`. | string | null | no
| health_check_status_codes | The list of GAAP HTTP rule health check status code. | list(number) | null | no
| scheduler | Specify the GAAP HTTP rule scheduler, available values: `rr`, `wrr` and `lc`. | string | rr | no
| realserver_name | Specify the realserver name when `create_realserver` is `true`. | string | tf-module-realserver | no
| http_domain_certificate_name | The GAAP HTTP domain certificate name when `http_domain_certificate_id` is not specified. | string | tfmodule-hd-cert | no
| realserver_certificate_content | The GAAP HTTP domain realserver certificate content when `realserver_certificate_id` is not specified. | string |  | no
| gaap_auth | Specify if enable the GAAP HTTP domain proxy auth or not when `http_domain_id` is not specified. | string | false | no
| listener_certificate_id | The GAAP layer7 listener certificate ID use to launch resources. | string |  | no
| http_domain_certificate_key | The GAAP HTTP domain certificate key when `http_domain_certificate_id` is not specified. | string |  | no
| http_domain_id | The GAAP HTTP domain ID to launch resources. | string |  | no
| realserver_type | Specify the GAAP HTTP rule realserver type, available values: `IP` and `DOMAIN`. | string | null | no
| health_check_path | Specify the GAAP HTTP rule health check path. | string | null | no
| create_realserver | Specify create new realservers with specified config in `realservers` or not. | string | false | no
| domain_error_page_clear_headers | Specify the GAAP error page remove headers. | list(string) | [] | no
| realserver_certificate_name | The GAAP HTTP domain realserver certificate name when `realserver_certificate_id` is not specified. | string | tfmodule-hd-proxy-cert | no
| domain_error_page_set_headers | Specify the GAAP error page new response headers. | map(string) | {} | no
| listener_client_certificate_content | The GAAP layer7 listener client certificate content when `listener_client_certificate_id` is not specified. | string |  | no
| gaap_certificate_name | The GAAP HTTP domain proxy certificate name when `gaap_certificate_id` is not specified. | string | tfmodule-hd-proxy-cert | no
| gaap_certificate_content | The GAAP HTTP domain proxy certificate content when `gaap_certificate_id` is not specified. | string |  | no
| listener_id | Specify the GAAP layer7 listener ID to launch resources. | string |  | no
| health_check | Specify if enable the GAAP HTTP rule health check or not. | string | false | no
| connect_timeout | Specify the GAAP HTTP rule connect timeout. | number | 2 | no
| interval | Specify the GAAP HTTP rule health check interval. | number | 5 | no
| http_domain_client_certificate_content | The GAAP HTTP domain client certificate content when `http_domain_client_certificate_id` is not specified. | string |  | no
| basic_auth_content | The GAAP HTTP domain basic auth content when `basic_auth_id` is not specified. | string |  | no
| gaap_certificate_id | The GAAP HTTP domain proxy certificate ID use to launch resources. | string |  | no
| gaap_certificate_key | The GAAP HTTP domain proxy certificate key when `gaap_certificate_id` is not specified. | string |  | no
| policy_rule_name | Specify the GAAP proxy security policy rule name to launch resources. | string | tf-modules-policy-rule | no
| listener_client_certificate_id | The GAAP layer7 listener client certificate ID use to launch resources. | string |  | no
| http_domain_client_certificate_name | The GAAP HTTP domain client certificate name when `http_domain_client_certificate_id` is not specified. | string | tfmodule-hd-client-cert | no
| domain_error_page_body | Specify the GAAP error page body. | string |  | no
| realserver_auth | Specify if enable the GAAP HTTP domain realserver auth or not when `http_domain_id` is not specified. | string | false | no
| access_region | Specify the GAAP proxy access region to launch a GAAP proxy when `proxy_id` is not specified. | string |  | no
| policy_id | The GAAP proxy security policy ID use to launch resources. | string |  | no
| listener_certificate_content | The GAAP layer7 certificate content when `listener_certificate_id` is not specified. | string |  | no
| http_domain_certificate_id | The GAAP HTTP domain certificate ID use to launch resources. | string | default | no
| http_domain_certificate_content | The GAAP HTTP domain certificate content when `http_domain_certificate_id` is not specified. | string |  | no
| realserver_certificate_id | The GAAP HTTP domain realserver certificate ID use to launch resources. | string |  | no
| listener_certificate_key | The GAAP layer7 certificate key when `listener_certificate_id` is not specified. | string |  | no
| http_domain_client_certificate_id | The GAAP HTTP domain certificate ID use to launch resources. | string |  | no
| project_id | Specify the project id. | string | 0 | no
| tags | Specify the tags. | map(string) | {} | no
| listener_client_certificate_name | The GAAP layer7 listener client certificate name when `listener_client_certificate_id` is not specified. | string | tfmodule-listener-client-cert | no
| policy_action | Specify action of the GAAP proxy security policy to launch resources when `policy_id` is not specified, available values: `ACCEPT` and `DROP`. | string | ACCEPT | no
| forward_host | Specify the GAAP HTTP rule forward host. | string | default | no
| domain_error_page_new_error_code | Specify the GAAP error page new error code. | number | null | no
| basic_auth_id | The GAAP HTTP domain basic auth ID use to launch resources. | string |  | no

## Outputs

| Name | Description |
|------|-------------|
| proxy_id | The list of GAAP proxy ID. |
| listener_id | The list of GAAP layer7 listener ID. |
| http_rule_id | The list of GAAP HTTP rule ID. |
| http_domain_gaap_certificate_id | The list of GAAP HTTP domain proxy certificate ID. |
| http_domain_basic_auth_id | The list of GAAP HTTP domain basic auth ID. |
| domain_error_page_id | The list of GAAP domain error page ID. |
| http_domain_client_certificate_id | The list of GAAP HTTP domain client certificate ID. |
| policy_id | The list of GAAP proxy policy ID. |
| listener_client_certificate_id | The list of GAAP layer7 listener client certificate ID. |
| http_domain_realserver_certificate_id | The list of GAAP HTTP domain realserver certificate ID. |
| policy_rule_ids | The list of GAAP proxy policy rule ID. |
| http_domain_id | The list of GAAP HTTP domain ID. |
| listener_certificate_id | The list of GAAP layer7 listener certificate ID. |
| http_domain_certificate_id | The list of GAAP HTTP domain certificate ID. |

## Authors

Created and maintained by [TencentCloud](https://github.com/terraform-providers/terraform-provider-tencentcloud)

## License

Mozilla Public License Version 2.0.
See LICENSE for full details.

module "https-listener" {
  source = "../../"

  tags = {
    "test" = "test"
  }

  proxy_id = "link-i8fmssl7"

  name                                = "complex-HTTPS-listener"
  protocol                            = "HTTPS"
  port                                = 443
  realserver_type                     = "IP"
  auth_type                           = 1
  forward_protocol                    = "HTTPS"
  listener_certificate_content        = file("public.pem")
  listener_certificate_key            = file("pkey.pem")
  listener_client_certificate_content = file("public.pem")

  http_domain                            = "www.qq.com"
  http_domain_certificate_content        = file("public.pem")
  http_domain_certificate_key            = file("pkey.pem")
  http_domain_client_certificate_content = file("public.pem")
  basic_auth                             = true
  basic_auth_content                     = "root:F2kpW/wDsEtuA"
  realserver_auth                        = true
  realserver_certificate_content         = file("public.pem")
  realserver_certificate_domain          = "www.qq.com"
  gaap_auth                              = true
  gaap_certificate_content               = file("public.pem")
  gaap_certificate_key                   = file("pkey.pem")

  http_rule_domain          = "qq.com"
  path                      = "/module"
  forward_host              = "tencent.com"
  connect_timeout           = 3
  interval                  = 6
  scheduler                 = "wrr"
  health_check              = true
  health_check_method       = "GET"
  health_check_path         = "/check"
  health_check_status_codes = [400, 500]

  create_realserver = true

  realservers = [
    {
      ip     = "1.1.1.1"
      port   = 80
      weight = 10
    },
    {
      ip     = "8.8.8.8"
      port   = 80
      weight = 5
    }
  ]

  domain_error_page_body           = "failed\r\n"
  domain_error_page_error_codes    = [404]
  domain_error_page_new_error_code = 403
  domain_error_page_clear_headers  = ["X-module"]
  domain_error_page_set_headers = {
    "X-HTTPS" : "HTTPS"
  }
}

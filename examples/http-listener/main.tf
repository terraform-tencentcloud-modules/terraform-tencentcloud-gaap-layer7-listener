module "simple-http" {
  source = "../.."

  proxy_id = "link-kzfqgztp"

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

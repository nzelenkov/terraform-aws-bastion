provider "acme" {
    version = "~> 1.0"
    server_url = var.acme_server_url
}
resource "tls_private_key" "private_key" {
    algorithm = "RSA"
}
resource "acme_registration" "reg" {
    account_key_pem = tls_private_key.private_key.private_key_pem
    email_address   = "admin@${var.app_domain}"
}
resource "acme_certificate" "certificate" {
    account_key_pem           = acme_registration.reg.account_key_pem
    common_name               = "${var.app_uri}.${var.app_domain}"
    dns_challenge {
        provider = "digitalocean"
    }
}
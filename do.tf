provider "digitalocean" {
    version = "~> 1.1"
    token   = var.do_token
}

# Add a record to the domain
resource "digitalocean_record" "web" {
    type    = "A"
    name    = var.app_uri
    domain  = var.app_domain
    value   = aws_eip.web.public_ip
    ttl     = 5
    depends_on = [aws_eip.web]
}
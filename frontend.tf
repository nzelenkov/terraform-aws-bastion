data "template_file" "app_uri" {
    template = "${file("config/nginx_ssl.conf.tpl")}"
    vars = {
        app_uri = "${var.app_uri}.${var.app_domain}"
    }
}
data "template_file" "app_dir" {
    template = "${file("config/webuserdata.sh.tpl")}"
    vars = {
        app_dir = "${var.app_uri}.${var.app_domain}"
    }
}
resource "aws_eip" "web" {
    instance = aws_instance.web.id
    tags = {
        Name = "web eip"
    }
}
resource "aws_instance" "web" {
    ami                         = lookup(var.amis, var.region)
    instance_type               = lookup(var.instance_types, "web")
    user_data                   = data.template_file.app_dir.rendered
    key_name                    = aws_key_pair.aws-key.key_name
    subnet_id                   = aws_subnet.subnet-frontend.id
    vpc_security_group_ids      = [aws_security_group.allow_ssh_https.id]
    provisioner "file" {
        content     = acme_certificate.certificate.certificate_pem
        destination = "/tmp/cert.pem"
    }
    provisioner "file" {
        content     = acme_certificate.certificate.private_key_pem
        destination = "/tmp/key.pem"
    }
    provisioner "file" {
        content     = data.template_file.app_uri.rendered
        destination = "/tmp/${var.app_uri}.${var.app_domain}"
    }
    provisioner "remote-exec" {
        inline = [
        "export PATH=$PATH:/usr/bin",
        "sudo apt-get update",
        "sudo apt-get -y install nginx",
        "sudo mv /tmp/${var.app_uri}.${var.app_domain} /etc/nginx/sites-available/",
        "sudo mkdir -p /root/certs/${var.app_uri}.${var.app_domain}",
        "sudo mv /tmp/*.pem /root/certs/${var.app_uri}.${var.app_domain}",
        "sudo ln -s /etc/nginx/sites-available/${var.app_uri}.${var.app_domain} /etc/nginx/sites-enabled/",
        "sudo rm -f /etc/nginx/sites-enabled/default",
        "sudo nginx -s reload"
        ]
    }
    connection {
        type = "ssh"
        user = var.ssh_user
        host = self.private_ip
        bastion_host = aws_eip.bastion.public_ip
        private_key = file(var.pvt_key)
        timeout = "3m"
    }
    tags = {
        Name = "web"
    }
}
output "fqdn" {
  value = digitalocean_record.web.fqdn
}
output "web_eip" {
  value = aws_eip.web.public_ip
}

output "web_private_ip" {
  value = aws_instance.web.private_ip
}
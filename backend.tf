resource "aws_instance" "backend" {
    ami                         = lookup(var.amis, var.region)
    instance_type               = lookup(var.instance_types, "backend")
    key_name                    = aws_key_pair.aws-key.key_name
    subnet_id                   = aws_subnet.subnet-backend.id
    vpc_security_group_ids      = [module.bastion.security_group_id]
    monitoring                  = false
    tags = {
        Name = "backend"
    }
}
output "backend_private_ip" {
    value = aws_instance.backend.private_ip
}

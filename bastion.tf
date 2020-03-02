data "template_file" "eip_bastion" {
    template = "${file("config/bastionuserdata.sh.tpl")}"
    vars = {
        eip_bastion = "${aws_eip.bastion.id}"
    }
}
resource "aws_eip" "bastion" {
    vpc = true
    tags = {
        Name = "bastion eip"
    }
}
module "bastion" {
    source                      = "github.com/terraform-community-modules/tf_aws_bastion_s3_keys"
    instance_type               = "${lookup(var.instance_types, "bastion")}"
    region                      = "${var.region}"
    ami                         = "${lookup(var.amis, var.region)}"
    iam_instance_profile        = "${aws_iam_role.s3_readonly-allow_associateaddress.name}"
    s3_bucket_name              = "${aws_s3_bucket.ssh_public_keys.bucket}"
    vpc_id                      = "${aws_default_vpc.default.id}"
    subnet_ids                  = ["${aws_subnet.subnet-frontend.id}"]
    keys_update_frequency       = "5,20,35,50 * * * *"
    eip                         = "${aws_eip.bastion.public_ip}"
    additional_user_data_script = "${data.template_file.eip_bastion.rendered}"
    enable_monitoring           = "false"
}
output "bastion_eip" {
    value = "${aws_eip.bastion.public_ip}"
}
output "ssh_user" {
    value = "${var.ssh_user}"
}
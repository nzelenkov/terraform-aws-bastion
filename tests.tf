data "template_file" "tests" {
    template = "${file("test/tests.sh.tpl")}"
    vars = {
        app_url = "${var.app_uri}.${var.app_domain}"
        bastion_public_ip = "${aws_eip.bastion.public_ip}"
    }
}
resource "null_resource" "run_tests" {
    provisioner "local-exec" {
        command = data.template_file.tests.rendered
    }
    depends_on = [aws_eip.web]
}
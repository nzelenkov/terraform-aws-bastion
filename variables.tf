#AUTH
variable "pvt_key" {}
variable "pub_key" {default = "public_keys/aws-key.pub"}
variable "ssh_user" {
  default = "ubuntu"
}
#AWS
variable "region" {default = "eu-west-1"}
variable "s3_bucket_name" {default = "s3-ssh-key-bucket"}
variable "amis" {
  type = map(string)
  default = {
    "eu-west-1" = "ami-00035f41c82244dab"
    "eu-west-2" = "ami-0b0a60c0a2bd40612"
    "eu-west-3" = "ami-08182c55a1c188dee"
  }
}
variable "instance_types" {
  type = map(string)
  default = {
    "backend" = "t2.micro"
    "bastion" = "t2.micro"
    "web" = "t2.micro"
    "" = "t2.micro"
  }
}
#DigitalOcean
variable "do_token" {default=""}
#WEB
variable "acme_server_url" {default = "https://acme-v02.api.letsencrypt.org/directory"}
variable "app_domain" {default = "3zinventions.com"}
variable "app_uri" {default = "web01.dev"}
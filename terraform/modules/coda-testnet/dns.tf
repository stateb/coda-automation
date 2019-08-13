data "aws_route53_zone" "selected" {
  name = "${var.r53_dns_zone}"
}

resource "aws_route53_record" "net_name" {
  zone_id = "${data.aws_route53_zone.selected.zone_id}"
  name    = "${var.net_name}.${data.aws_route53_zone.selected.name}"
  type    = "A"
  ttl     = "300"
  records = "${module.seed.public_ip}"
}


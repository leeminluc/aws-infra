resource "aws_route53_zone" "my-app" {
  name = "my-app.com"
}

resource "aws_route53_record" "nginx_dns" {
  zone_id = aws_route53_zone.my-app.zone_id
  name    = "nginx.my-app.com"
  type    = "CNAME"
  ttl     = 300
  records = ["172.31.9.171"]
}

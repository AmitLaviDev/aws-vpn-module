output "vpn_endpoint_arn" {
  value       = local.enabled ? join("", aws_ec2_client_vpn_endpoint.default[*].arn) : null
  description = "The ARN of the Client VPN Endpoint Connection."
}

output "vpn_endpoint_id" {
  value       = local.enabled ? join("", aws_ec2_client_vpn_endpoint.default[*].id) : null
  description = "The ID of the Client VPN Endpoint Connection."
}

output "vpn_endpoint_dns_name" {
  value       = local.enabled ? join("", aws_ec2_client_vpn_endpoint.default[*].dns_name) : null
  description = "The DNS Name of the Client VPN Endpoint Connection."
}

output "full_client_configuration" {
  value = local.export_client_certificate ? templatefile(
    local.client_conf_tmpl_path,
    {
      ca_cert            = module.self_signed_cert_ca.certificate_pem,
      server_common_name = local.server_common_name
      cert               = module.self_signed_cert_root.certificate_pem,
      private_key        = join("", data.aws_ssm_parameter.root_key[*].value)
      dns_name           = join(".", [join(".", slice(split(".", join("", aws_ec2_client_vpn_endpoint.default[*].dns_name)), 1, (length(split(".", join("", aws_ec2_client_vpn_endpoint.default[*].dns_name))))))])
    }
  ) : ""
  description = "Client configuration including client certificate and private key"
  sensitive   = true
}

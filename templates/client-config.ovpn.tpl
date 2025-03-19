client
dev tun
proto udp
remote ${dns_name} 443
remote-random-hostname
resolv-retry infinite
nobind
remote-cert-tls server
cipher AES-256-GCM
verb 3

<ca>
${ca_cert}
</ca>

reneg-sec 0

verify-x509-name ${server_common_name} name

<cert>
${cert}
</cert>

<key>
${private_key}
</key>

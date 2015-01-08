openvpn:
  server_port: 1194
  server_proto: tcp
  server_dev: tun
  server_ca: /etc/openvpn/keys/ca.crt
  server_cert: /etc/openvpn/keys/server.crt
  server_key: /etc/openvpn/keys/server.key
  server_dh: /etc/openvpn/keys/dh2048.pem
  server_server: 10.8.0.0 255.255.255.0
  server_redirect_gateway: true
  server_openvpn_status: /var/run/openvpn/openvpn-status.log
  server_log: /var/log/openvpn.log
  server_use_pam: False

  client_remote: {{ grains['ip_interfaces']['eth0'][0] }}
  client_port: 1194
  client_proto: tcp
  client_dev: tun
  client_ca: keys/ca.crt
  client_cert_client: keys/client.crt
  client_key_client: keys/client.key
  client_use_pam: False
  client_use_tunnel: True

stunnel:
  cert: /etc/stunnel/stunnel.pem
  tunnel:
    openvpn_default:
      accept: 15555
      connect: {{ grains['ip_interfaces']['eth0'][0] }}:1194
    openvpn_fakehttps:
      accept: 443
      connect: {{ grains['ip_interfaces']['eth0'][0] }}:1194
  client_tunnel:
    openvpn_default:
      accept: 1194
      connect: {{ grains['ip_interfaces']['eth0'][0] }}:15555
    openvpn_fakehttps:
      accept: 1194
      connect: {{ grains['ip_interfaces']['eth0'][0] }}:443

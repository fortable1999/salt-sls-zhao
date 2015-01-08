{% for package in 'udev', 'lzop', 'easy-rsa', 'fonts-dejavu-core' %}
{{ package }}:
  pkg:
    - installed
{% endfor %}

openvpn:
  pkg:
    - installed
  service:
    - running
    - watch:
      - pkg: openvpn
      - file: /etc/openvpn/openvpn.conf
      - file: /etc/openvpn/keys/ca.crt
      - file: /etc/openvpn/keys/server.key
      - file: /etc/openvpn/keys/server.crt
      - file: /etc/openvpn/keys/dh2048.pem
  user.present:
      - name: root
  iptables.append:
    - table: nat
    - chain: POSTROUTING
    - jump: MASQUERADE
    - out-interface: eth0
    - source: '10.8.0.0/16'
    - comment: "VPN masquerade"
    - match:
      - comment

/etc/openvpn/openvpn.conf:
  file.managed:
    - source: salt://vpn/conf/server.conf
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - makedirs: True

/etc/openvpn/conf/client.conf:
  file.managed:
    - source: salt://vpn/conf/client.conf
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - makedirs: True

/etc/openvpn/conf/client_tunnel.conf:
  file.managed:
    - source: salt://vpn/conf/client.conf
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - makedirs: True

{% for filename in 'server.key', 'server.crt', 'ca.crt', 'dh2048.pem', 'client.key', 'client.crt' %}
/etc/openvpn/keys/{{ filename }}:
  file.managed:
    - source: salt://vpn/keys/{{ filename }}
    - user: root
    - group: root
    - mode: 600
    - makedirs: True
{% endfor %}

/etc/pam.d/openvpn:
  file.managed:
    - source: salt://vpn/conf/pam_openvpn
    - user: root
    - group: root
    - mode: 644
    - makedirs: True

net.ipv4.ip_forward:
  sysctl.present:
    - value: 1

net.ipv4.conf.all.send_redirects:
  sysctl.present:
    - value: 0

net.ipv4.conf.default.send_redirects:
  sysctl.present:
    - value: 0

net.ipv4.conf.all.accept_redirects:
  sysctl.present:
    - value: 0

net.ipv4.conf.default.accept_redirects:
  sysctl.present:
    - value: 0

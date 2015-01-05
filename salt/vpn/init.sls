{% for package in 'udev', 'lzop', 'easy-rsa' %}
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
    - defaults:
        port: 1194
        proto: tcp
        dev: tun
        ca: keys/ca.crt
        cert: keys/server.crt
        key: keys/server.key
        dh: keys/dh2048.pem
        server: 10.8.0.0 255.255.255.0
        redirect_gateway: true
        openvpn_status: /var/run/openvpn/openvpn-status.log
        log: /var/log/openvpn.log
        client_cert_not_required: False
    - context:
        port: 1194

/etc/openvpn/conf/client.conf:
  file.managed:
    - source: salt://vpn/conf/client.conf
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - makedirs: True
    - defaults:
        host: {{ grains['ip_interfaces']['eth0'][0] }}
        port: 1194
        proto: tcp
        dev: tun
        ca: keys/ca.crt
        cert_client: keys/client.crt
        key_client: keys/client.key
        client_cert_not_required: False

/etc/openvpn/conf/client_tunnel.conf:
  file.managed:
    - source: salt://vpn/conf/client.conf
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - makedirs: True
    - defaults:
        host: 127.0.0.1
        port: 1194
        proto: tcp
        dev: tun
        ca: keys/ca.crt
        cert_client: keys/client.crt
        key_client: keys/client.key

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

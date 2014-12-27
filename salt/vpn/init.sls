udev:
  pkg:
    - installed

lzop:
  pkg:
    - installed

easy-rsa:
  pkg:
    - installed

openvpn:
  pkg:
    - installed
  service:
    - running
    - watch:
      - pkg: openvpn
      - file: /etc/openvpn/openvpn.conf
  user.present:
      - name: root

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
        proto: udp
        dev: tun
        ca: keys/ca.crt
        cert: keys/server.crt
        key: keys/server.key
        dh: keys/dh2048.pem
        server: 10.8.0.0 255.255.255.0
        redirect_gateway: true
        openvpn_status: /var/run/openvpn/openvpn-status.log
        log: /var/log/openvpn.log
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
        port: 1194
        proto: udp
        dev: tun
        ca: keys/ca.crt
        cert_client: keys/server.crt
        key_client: keys/server.key
    - context:
        port: 1194

{% for filename in 'server.key', 'server.crt', 'ca.crt', 'dh2048.pem' %}
/etc/openvpn/keys/{{ filename }}:
  file.managed:
    - source: salt://vpn/keys/{{ filename }}
    - user: root
    - group: root
    - mode: 600
    - makedirs: True
{% endfor %}

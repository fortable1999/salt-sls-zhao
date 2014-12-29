nginx:
  pkg:
    - installed
  service:
    - running
    - watch:
      - pkg: nginx 
      - file: /etc/nginx/nginx.conf
  user.present:
      - name: root

/etc/nginx/nginx.conf:
  file.managed:
    - source: salt://web/conf/nginx.conf
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


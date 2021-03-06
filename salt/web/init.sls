nginx:
  pkg:
    - installed
    - force: True
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
      user: root
      pid: /var/run/nginx.pid
      html_root: /usr/share/nginx/www

/usr/share/nginx/www:
  file.directory:
    - user: root
    - group: root
    - mode: 755
    - makedirs: True

{% for filename in 'ca.crt', 'client.key', 'client.crt'%}
/usr/share/nginx/www/{{ filename }}:
  file.managed:
    - source: salt://vpn/keys/{{ filename }}
    - user: root
    - group: root
    - mode: 755
    - makedirs: True
{% endfor %}

/usr/share/nginx/www/client.ovpn:
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
        use_pam: False

/usr/share/nginx/www/client.conf:
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
        use_pam: False

/usr/share/nginx/www/client_use_stunnel.ovpn:
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
        use_pam: False

/usr/share/nginx/www/client_use_stunnel.conf:
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
        use_pam: False

/usr/share/nginx/www/index.html:
  file.managed:
    - source: salt://web/html/index.html
    - user: root
    - group: root
    - mode: 755
    - makedirs: True
    - template: jinja

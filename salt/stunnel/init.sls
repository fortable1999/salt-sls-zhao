stunnel4:
  pkg:
    - installed
  service:
    - running
    - watch:
      - pkg: stunnel4
      - file: /etc/stunnel/stunnel.conf
      - file: /etc/stunnel/stunnel.pem

/etc/stunnel/stunnel.conf:
  file.managed:
    - source: salt://stunnel/conf/stunnel.conf
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - makedirs: True
    - defaults:
        accept: 15555
        connect: 127.0.0.1:1194
        cert: /etc/stunnel/stunnel.pem

/etc/stunnel/stunnel.pem:
  file.managed:
    - source: salt://stunnel/keys/stunnel.pem
    - user: root
    - group: root
    - mode: 600
    - makedirs: True

/usr/share/nginx/www/stunnel_client.conf:
  file.managed:
    - source: salt://stunnel/conf/stunnel_client.conf
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - makedirs: True
    - defaults:
        accept: 127.0.0.1:1194
        connect: {{ grains['ip_interfaces']['eth0'][0] }}:15555

/usr/share/nginx/www/stunnel.pem:
  file.managed:
    - source: salt://stunnel/keys/stunnel.pem
    - user: root
    - group: root
    - mode: 755
    - makedirs: True

/usr/share/nginx/www/stunnel.conf:
  file.managed:
    - source: salt://stunnel/conf/stunnel.conf
    - user: root
    - group: root
    - mode: 755
    - makedirs: True

/etc/default/stunnel4:
  file.managed:
    - source: salt://stunnel/conf/etc_default_stunnel.conf
    - user: root
    - group: root
    - mode: 755
    - makedirs: True

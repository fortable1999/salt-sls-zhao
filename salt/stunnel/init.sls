stunnel4:
  pkg:
    - installed
  service:
    - running
    - watch:
      - pkg: stunnel4
      - file: /etc/stunnel/stunnel.conf
      - file: /etc/stunnel/stunnel.pem

/etc/stunnel/stunnel.pem:
  file.managed:
    - source: salt://stunnel/keys/stunnel.pem
    - user: root
    - group: root
    - mode: 600
    - makedirs: True

/etc/stunnel/stunnel.conf:
  file.managed:
    - source: salt://stunnel/conf/stunnel.conf
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - makedirs: True

/usr/share/nginx/www/stunnel.conf:
  file.managed:
    - source: salt://stunnel/conf/stunnel_client.conf
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - makedirs: True

/etc/default/stunnel4:
  file.managed:
    - source: salt://stunnel/conf/etc_default_stunnel.conf
    - user: root
    - group: root
    - mode: 755
    - makedirs: True
    - template: jinja

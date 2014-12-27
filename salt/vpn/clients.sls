vpnclientuser:
  user.present:
    - fullname: VPN nologin users
    - shell: /usr/sbin/nologin
    - password: VPNCLIENTUSER

vpnclient:
  user.present:
    - fullname: VPN nologin users
    - shell: /bin/false
    - password: VPNCLIENT

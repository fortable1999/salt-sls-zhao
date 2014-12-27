{% for package in 'openssh-server', 'openssh-client' %}
{{ package }}:
  pkg:
    - installed
{% endfor %}

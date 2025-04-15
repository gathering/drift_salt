sshd:
  pkg.installed:
    - name: openssh-server
  service.running:
    - require:
      - pkg: openssh-server
    - watch:
      - file: /etc/ssh/sshd_config

/etc/ssh/sshd_config:
  file.managed:
    - source: salt://server_lite/templates/sshd_config.j2
    - mode: 644
    - user: root
    - group: root
    - template: jinja

{% if salt['file.file_exists']('/etc/sssd/sssd.conf') %}
/etc/ssh/sshd_config.d/04-ipa.conf:
  file.managed:
    - source: salt://server_lite/templates/04-ipa.conf.j2
    - mode: 644
    - user: root
    - group: root
    - template: jinja
{% endif %}

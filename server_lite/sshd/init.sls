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

{% if grains['os'] == 'Debian' and not grains['nodename'] == '*ntp*' and  not grains['nodename'] == '*ns*' %}
chronyd:
  pkg.installed:
    - name: chrony
  service.running:
    - require:
      - pkg: chrony
    - watch:
      - file: /etc/chrony/chrony.conf
  file.managed:
    - name: /etc/chrony/chrony.conf
    - source: salt://server_lite/files/chrony_debian.conf
    - user: root
    - group: root
    - mode: 644
{% endif %}

{% if grains['os'] == 'Debian' and grains['nodename'] == '*ns*' %}
chronyd_cloud:
  pkg.installed:
    - name: chrony
  service.running:
    - require:
        - pkg: chrony
    - watch:
        - file: /etc/chrony/chrony.conf
  file.managed:
    - name: /etc/chrony/chrony.conf
    - source: salt://server_lite/files/chrony_debian_cloud.conf
    - user: root
    - group: root
    - mode: 644
{% endif %}

{% if grains['os'] == 'Redhat' and not grains['nodename'] == '*ntp*' and  not grains['nodename'] == '*ns*' %}
chronyd_redhat:
  pkg.installed:
    - name: chrony
  service.running:
    - require:
      - pkg: chrony
    - watch:
      - file: /etc/chrony.conf
  file.managed:
    - name: /etc/chrony.conf
    - source: salt://server_lite/files/chrony_rhel.conf
    - user: root
    - group: root
    - mode: 644
{% endif %}

{% if grains['os'] == 'Redhat' and grains['nodename'] == '*ns*' %}
chronyd_cloud:
  pkg.installed:
    - name: chrony
  service.running:
    - require:
        - pkg: chrony
    - watch:
        - file: /etc/chrony.conf
  file.managed:
    - name: /etc/chrony/chrony.conf
    - source: salt://server_lite/files/chrony_rhel_cloud.conf
    - user: root
    - group: root
    - mode: 644
{% endif %}

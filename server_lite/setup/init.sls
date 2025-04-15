Europe/Oslo:
  timezone.system

{% if grains['os'] == 'Debian' and not grains['nodename'] == '*nuc*' %}
/etc/resolv.conf:
  file.managed:
    - source: salt://server_lite/files/resolv.conf
    - user: root
    - group: root
    - mode: 755
{% endif %}

{% if grains['os'] == 'Debian' %}
debian_setup:
  pkg.installed:
    - pkgs:
      - sudo
      - curl
      - wget
      - python3
      - python3-pip
      - python3-venv
      - git
      - vim
      - apt-utils
      - lvm2
      - screen
      - tmux
      - dnsutils
      - monitoring-plugins
      - monitoring-plugins-contrib
{% endif %}

{% if grains['osrelease'] == '12' %}
monitoring_paakges:
  pkg.installed:
    - pkgs:
      - monitoring-plugins-systemd
{% endif %}

{% if grains['os'] == 'Redhat' %}
redhat_setup:
  pkg.installed:
    - pkgs:
      - sudo
      - curl
      - wget
      - python3
      - python3-pip
      - git
      - vim
      - yum-utils
      - device-mapper-persistent-data
      - lvm2
      - sudo
      - bash-completion
      - openssh-server
      - tmux
      - nagios-plugins
{% endif %}

create_ansible_user:
  user.present:
    - name:  ansible
    - shell: /bin/bash
    - home: /home/ansible

ssh_key_ansible_user:
  ssh_auth.present:
    - user: ansible
    - source: salt://server_lite/files/authorized_keys.keys
    - config: '%h/.ssh/authorized_keys2'

create_monitoring_user:
  user.present:
    - name:  nagios
    - shell: /bin/bash
    - home: /home/nagios

ssh_key_monitoring_user:
  ssh_auth.present:
    - user: nagios
    - source: salt://server_lite/files/monitoring_authorized_keys.keys
    - config: '%h/.ssh/authorized_keys2'

sudoers_ansible:
  file.managed:
    - name: /etc/sudoers.d/00_ansible
    - source: salt://server_lite/files/ansible_no_passwd
    - user: root
    - group: root
    - mode: 440

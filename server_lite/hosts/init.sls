{{ grains['host'] }}:
  host.present:
    - name:
      - {{ grains['fqdn'] }}
      - {{ grains['host'] }}
{% set main_ip = grains['ipv4'] %}
    - ip: {{ main_ip[0] }}
    - clean: True

remove_host:
  host.absent:
    - name: {{ grains['host'] }}
    - ip: 127.0.1.1

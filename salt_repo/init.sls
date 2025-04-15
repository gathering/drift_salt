# Make sure repo exist salt.
#
/etc/apt/keyrings:
  file.directory:
    - user: root
    - group: root
    - mode: 755
    - makedirs: True

{% if grains['osrelease'] == '12' %}
  {% if not salt['file.file_exists' ]('/etc/apt/keyrings/salt-archive-keyring.pgp') %}
salt_gpg_bookworm:
  cmd.run:
     - name: "curl -fsSL https://packages.broadcom.com/artifactory/api/security/keypair/SaltProjectKey/public | sudo tee /etc/apt/keyrings/salt-archive-keyring.pgp"
  {% endif %}
{% endif %}

/etc/apt/preferences.d/salt-pin-1001:
  file.managed:
    - name: /etc/apt/preferences.d/salt-pin-1001
    - source: salt://salt_repo/templates/salt-pin-1001
    - user: root
    - group: root
    - mode: 644

{% if grains['osrelease'] == '12' or grains['osrelease'] == '11' %}
salt_apt_config:
  file.managed:
    - name: /etc/apt/sources.list.d/salt.sources
    - source: salt://salt_repo/templates/salt.sources
    - user: root
    - group: root
    - mode: 644
{% endif %}

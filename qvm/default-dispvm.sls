# -*- coding: utf-8 -*-
# vim: set syntax=yaml ts=2 sw=2 sts=2 et :

##
# qvm.default-dispvm
# ========
#
# Installs default DispVM template: fedora-33-dvm AppVM.
#
# Execute:
#   qubesctl state.sls qvm.default-dispvm dom0
##

{% set gui_user = salt['cmd.shell']('groupmems -l -g qubes') %}
{% set default_template = salt['cmd.shell']('qubes-prefs default-template') %}

{{default_template}}-dvm:
  qvm.vm:
   - present:
     - label: red
   - prefs:
     - label: red
     - dispvm-allowed: True
   - features:
     - enable:
       - appmenus-dispvm

echo -e 'firefox.desktop\nxterm.desktop' | qvm-appmenus --set-whitelist=- --update {{default_template}}-dvm:
  cmd.run:
    - runas: {{ gui_user }}
    - requires:
      - qvm: {{default_template}}-dvm

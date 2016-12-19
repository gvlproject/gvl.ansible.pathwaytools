
#!/bin/bash
#####################################################
# script run on target machine to install Pathway Tools
#####################################################

[ -d "/mnt/gvl/apps" ] || mkdir -p /mnt/gvl/apps # ensure /mnt/gvl/apps exists
cd /opt/gvl
if [ -d "/opt/gvl/gvl.ansible.pathwaytools" ]; then
  git pull https://github.com/gvlproject/gvl.ansible.pathwaytools
else
  git clone -b release_GVL_4.1 https://github.com/gvlproject/gvl.ansible.pathwaytools
fi
cd /opt/gvl/gvl.ansible.pathwaytools
ansible-playbook playbook.yml

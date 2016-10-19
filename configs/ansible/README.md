#Ansible config:
- /etc/ansible/hosts
- /etc/ansible/ansible.cfg

#Ansible Examples:
- ansible all -m ping
- ansible all -a "/bin/echo hello"
- ansible hadoop -m apt -a "name=default-jdk state=present"
- More https://www.linode.com/docs/applications/ansible/getting-started-with-ansible

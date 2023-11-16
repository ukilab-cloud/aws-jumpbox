## template: jinja
#cloud-config
hostame: ${lab_username}
packages:
  - iperf3
  - git
  - whois
  - neovim
  - micro
package_update: true
package_upgrade: true
snap:
    commands:
        00: ['snap', 'install', 'terraform', '--classic']
#############################################################
#### SSH password access using instance ID as the password
#### DO NOT USE IN PRODUCTION! This is for Lab exercices only
#############################################################
write_files:
  - path: /etc/ssh/sshd_config
    content: |
      Include /etc/ssh/sshd_config.d/*.conf
      PasswordAuthentication yes
      ChallengeResponseAuthentication no
      UsePAM yes
      X11Forwarding yes
      PrintMotd no
      AcceptEnv LANG LC_*
      Subsystem       sftp    /usr/lib/openssh/sftp-server
  - path: /home/ubuntu/userpass.txt
    content: |
      ${linux_username}:{{v1.instance_id}}
      ubuntu:{{v1.instance_id}}
runcmd:
  - hostname ${lab_username}
    ####### BAD PASSWORD PRACTICE - LAB ONLY ################
  - useradd -m -s /bin/bash -G adm,sudo ${linux_username}
  - chpasswd < /home/ubuntu/userpass.txt
  - update-alternatives --set vi /usr/bin/nvim
  - update-alternatives --set editor /usr/bin/nvim
debug:
   output: /var/log/cloud-init-debug.log
   verbose: true
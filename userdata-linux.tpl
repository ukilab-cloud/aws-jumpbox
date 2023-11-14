#cloud-config
hostame: ${lab_username}
packages:
  - iperf3
  - git
  - whois
package_update: true
package_upgrade: true
snap:
    commands:
        00: ['snap', 'install', 'terraform', '--classic']
write_files:
  - path: /etc/ssh/sshd_config.d/00-cloud-init
    content: |
      Include /etc/ssh/sshd_config.d/*.conf
      PasswordAuthentication yes
      ChallengeResponseAuthentication no
      UsePAM yes
      X11Forwarding yes
      PrintMotd no
      AcceptEnv LANG LC_*
      Subsystem       sftp    /usr/lib/openssh/sftp-server
runcmd:
 - hostname ${lab_username}
 #########################################################
 #DO NOT USE IN PRODUCTION! This is for Lab exercices only
 - useradd -m -s /bin/bash -G adm,sudo ${linux_username}
 - echo "${linux_username}:${linux_password}" | chpasswd
 - echo "ubuntu:${linux_password}" | chpasswd
 #########################################################
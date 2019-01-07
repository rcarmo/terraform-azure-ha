#cloud-config

write_files:
  # Basic configuration
  - path: /etc/ssh/sshd_config
    permissions: 0644
    # strengthen SSH cyphers
    content: |
      Port ${ssh_port}
      Protocol 2
      HostKey /etc/ssh/ssh_host_ed25519_key
      KexAlgorithms curve25519-sha256@libssh.org
      Ciphers chacha20-poly1305@openssh.com,aes256-gcm@openssh.com,aes128-gcm@openssh.com,aes256-ctr,aes192-ctr,aes128-ctr
      MACs hmac-sha2-512-etm@openssh.com,hmac-sha2-256-etm@openssh.com,umac-128-etm@openssh.com
      UsePrivilegeSeparation yes
      KeyRegenerationInterval 3600
      ServerKeyBits 1024
      SyslogFacility AUTH
      LogLevel INFO
      LoginGraceTime 120
      PermitRootLogin prohibit-password
      StrictModes yes
      RSAAuthentication yes
      PubkeyAuthentication yes
      IgnoreRhosts yes
      RhostsRSAAuthentication no
      HostbasedAuthentication no
      PermitEmptyPasswords no
      ChallengeResponseAuthentication no
      PasswordAuthentication no
      X11Forwarding yes
      X11DisplayOffset 10
      PrintMotd no
      PrintLastLog yes
      TCPKeepAlive yes
      AcceptEnv LANG LC_*
      Subsystem sftp /usr/
      UsePAM yes
  - path: /etc/fail2ban/jail.d/override-ssh-port.conf
    permissions: 0644
    content: |
      [sshd]
      enabled = true
      port    = ${ssh_port}
      logpath = %(sshd_log)s
      backend = %(sshd_backend)s
  - path: /etc/waagent.conf
    permissions: 0644
    content: |
      ResourceDisk.Format=y
      ResourceDisk.EnableSwap=y
      ResourceDisk.SwapSizeMB=1024
  
packages:
  - audispd-plugins
  - auditd
  - curl
  - fail2ban
  - docker.io
  - htop
  - language-pack-en-base
  - tmux
  - vim
  - wget

package_update: true
package_upgrade: true
package_reboot_if_required: true

timezone: Europe/Lisbon

runcmd:
  - service walinuxagent restart # enable swap using waagent.conf
  - usermod -G docker ${admin_username}
  - systemctl enable docker
  - docker run --restart always -h `hostname` -p 80:8000 -d rcarmo/demo-frontend-stateless 
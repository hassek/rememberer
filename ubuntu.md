# Ubuntu handy notes

## Finger

finger is a user management application which is very handy

### add user
```bash
sudo adduser <name>
```

### /etc/sudoers.d is where we place the users that can call sudo
```vim
<user_name> ALL=(ALL) NOPASSWD:ALL
```
that will give sudo access to the username

### force <user> to reset password next time it logs in
sudo passwd -e <user>

## systemd (for ubuntu 16.04+)
manages all system related programs pretty much as `service` did.

## Set hostname for good
sudo hostnamectl set-hostname <NEWHOSTNAME>

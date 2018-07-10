# Run a random fabric command on different hosts
http://docs.fabfile.org/en/1.12/usage/fab.html#arbitrary-remote-shell-commands

i.e.:
fab -R qa -- uname -rv
fab -H host1.mysite.com,host2.mysite.com -- service apache2 reload

## Running a playbook on a machine
ansible-playbook -i tests/inventory mongodb_servers.yml --limit mongodb1.local --ask-vault-pass

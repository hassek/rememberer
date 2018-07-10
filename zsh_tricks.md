# History
^foo^bar will replace the last command
i.e. eval $(docker-machine env dev)
     ^dev^staging
     > eval $(docker-machine env staging)

# ZLE (the readline of zsh)
backward kill word
Ctrl-w

paste the last kill command
Ctrl-y

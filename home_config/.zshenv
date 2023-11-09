export EDITOR=/usr/local/bin/vim
export PATH=/usr/local/opt/python/libexec/bin:/usr/local/bin:/usr/local/sbin:/opt/local/bin:/opt/local/sbin:/usr/local/share/npm/bin:/Users/tomas.henriquez/.cargo/bin:/Users/tomas.henriquez/.pyenv/versions/3.6.7/bin:$PATH
export JAVA_HOME="$(/usr/libexec/java_home)"
export AWS_IAM_HOME="/usr/local/opt/aws-iam-tools/jars"
export AWS_CREDENTIAL_FILE=$HOME/.aws-credentials-master
export HOMEBREW_GITHUB_API_TOKEN="bc14e284bf892c21b8c70e203187a47e7c09f5ab"
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export PYENV_ROOT=/Users/tomas.henriquez/.pyenv

export TERM=xterm-256color
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad
export RIPGREP_CONFIG_PATH=~/.ripgreprc

# chruby conf
RUBIES+=(
  /usr/local/Cellar/ruby/2.3.1_2
)

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/tomas.henriquez/Library/google-cloud-sdk/path.zsh.inc' ]; then source '/Users/tomas.henriquez/Library/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/tomas.henriquez/Library/google-cloud-sdk/completion.zsh.inc' ]; then source '/Users/tomas.henriquez/Library/google-cloud-sdk/completion.zsh.inc'; fi

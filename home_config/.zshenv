export EDITOR=/usr/local/bin/vim
export PATH=/usr/local/opt/python/libexec/bin:/usr/local/bin:/usr/local/sbin:/opt/local/bin:/opt/local/sbin:/usr/local/share/npm/bin:/Users/thenriquez/.cargo/bin:/Users/thenriquez/.pyenv/versions/3.6.7/bin:$PATH
export JAVA_HOME="$(/usr/libexec/java_home)"
export AWS_IAM_HOME="/usr/local/opt/aws-iam-tools/jars"
export AWS_CREDENTIAL_FILE=$HOME/.aws-credentials-master
export HOMEBREW_GITHUB_API_TOKEN="bc14e284bf892c21b8c70e203187a47e7c09f5ab"
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export PYENV_ROOT=/Users/thenriquez/.pyenv

export TERM=xterm-256color
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad
export RIPGREP_CONFIG_PATH=~/.ripgreprc

# chruby conf
RUBIES+=(
  /usr/local/Cellar/ruby/2.3.1_2
)

# virtualenv installation
VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python2
export WORKON_HOME=$HOME/.virtualenvs
source /usr/local/bin/virtualenvwrapper.sh

#virtualenv aliases
# http://blog.doughellmann.com/2010/01/virtualenvwrapper-tips-and-tricks.html
export VSITEPACKAGE='`virtualenvwrapper_get_site_packages_dir`'

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/thenriquez/Library/google-cloud-sdk/path.zsh.inc' ]; then source '/Users/thenriquez/Library/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/thenriquez/Library/google-cloud-sdk/completion.zsh.inc' ]; then source '/Users/thenriquez/Library/google-cloud-sdk/completion.zsh.inc'; fi

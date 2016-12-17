# rbenv
# https://github.com/rbenv/rbenv/issues/195
set PATH ~/.rbenv/bin $PATH
set PATH ~/.rbenv/shims $PATH
rbenv rehash >/dev/null ^&1

# Where RabbitMQ lives...
set PATH /usr/local/sbin $PATH

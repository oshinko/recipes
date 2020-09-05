cd `dirname $0`/..
RAILS_ENV=production RAILS_MASTER_KEY=$1 docker-compose build

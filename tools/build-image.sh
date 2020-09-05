docker build -t recipicker:latest --build-arg RAILS_MASTER_KEY=$1 `dirname $0`/..

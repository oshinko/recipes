aws_region=$1
aws_ecr_repo=$2

aws ecr get-login-password --region $aws_region | docker login --username AWS --password-stdin $aws_ecr_repo
docker tag recipicker $aws_ecr_repo
docker push $aws_ecr_repo

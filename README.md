# README

Pick a recipe at random.


## Initialize

```sh
bundle install
yarn install --check-files
```


## Start

```sh
rails s
```


## Deploy

Use Amazon ECS on AWS Fargate. Clusters and services shall be pre-created.

```sh
AWS_REGION=your-region
AWS_ACCOUNT_ID=00000000
AWS_ECS_EXECUTE_TASK_ROLE_NAME=ecsTaskExecutionRole
RAILS_MASTER_KEY=00000000000000000000000000000000
```

```sh
python tools/deploy.py \
  --aws-region $AWS_REGION \
  --aws-ecr-repo $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/recipicker \
  --aws-ecs-execute-task-role-arn arn:aws:iam::$AWS_ACCOUNT_ID:role/$AWS_ECS_EXECUTE_TASK_ROLE_NAME \
  --aws-ecs-cluster-arn arn:aws:ecs:$AWS_REGION:$AWS_ACCOUNT_ID:cluster/recipicker \
  --rails-master-key $RAILS_MASTER_KEY
```

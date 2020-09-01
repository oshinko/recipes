import argparse
import pathlib
import subprocess

import boto3

SCRIPT = pathlib.Path(__file__)
BUILD_IMAGE_SCRIPT = SCRIPT.parent / 'build-image.sh'
PUSH_IMAGE_SCRIPT = SCRIPT.parent / 'push-image.sh'

parser = argparse.ArgumentParser(SCRIPT.name)
parser.add_argument('--aws-region', required=True)
parser.add_argument('--aws-ecr-repo', required=True)
parser.add_argument('--aws-ecs-execute-task-role-arn', required=True)
parser.add_argument('--aws-ecs-cluster-arn', required=True)
parser.add_argument('--rails-master-key', required=True)

args = parser.parse_args()

subprocess.run(f'sh {BUILD_IMAGE_SCRIPT} {args.rails_master_key}', shell=True,
               check=True)

subprocess.run(f'sh {PUSH_IMAGE_SCRIPT} {args.aws_region} {args.aws_ecr_repo}',
               shell=True, check=True)

client = boto3.client('ecs', region_name=args.aws_region)

resp = client.register_task_definition(
    family='recipicker',
    requiresCompatibilities=['FARGATE'],
    networkMode='awsvpc',
    memory='0.5 GB',
    cpu='0.25 vCPU',
    executionRoleArn=args.aws_ecs_execute_task_role_arn,
    containerDefinitions=[
        {
            'name': 'recipicker',
            'image': f'{args.aws_ecr_repo}:latest',
            'portMappings': [
                {
                    'hostPort': 80,
                    'containerPort': 80,
                    'protocol': 'tcp'
                }
            ],
            'environment': [
                {
                    'name': 'PORT',
                    'value': '80'
                },
                {
                    'name': 'RAILS_ENV',
                    'value': 'production'
                },
                {
                    'name': 'RAILS_MASTER_KEY',
                    'value': args.rails_master_key
                },
                {
                    'name': 'RAILS_SERVE_STATIC_FILES',
                    'value': 'true'
                }
            ],
            'logConfiguration': {
                'logDriver': 'awslogs',
                'options': {
                    'awslogs-region': args.aws_region,
                    'awslogs-group': '/ecs/recipicker',
                    'awslogs-stream-prefix': 'ecs'
                }
            }
        },
    ]
)

task_def = resp['taskDefinition']['taskDefinitionArn']

client.update_service(cluster=args.aws_ecs_cluster_arn, service='recipicker',
                      taskDefinition=task_def)

#!/bin/bash 
REGION=us-east-1          #  change to your region
pem="~/pem/mypem.pem"     #  change to your .pem dir
host=$(aws ec2 describe-instances --filters Name=tag:Name,Values=ansible-ec2 Name=instance-state-name,Values=running --query 'Reservations[0].Instances[0].[PublicIpAddress,Tags[?Key==``].Value[]]' --output text)
user="ubuntu"
project="simple-form"
RDS=$(aws rds --region ${REGION} describe-db-instances --db-instance-identifier rds-webserver --query "DBInstances[*].Endpoint.Address" --output text )

echo "stage change RDS"
sed -i -f "s/##/${RDS}/g" app.py

echo "copy db.yaml"
scp -i ${pem} -r db.yaml ${user}@"${host}":${project}/
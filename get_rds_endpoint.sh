#!/bin/bash 
REGION=us-east-1            #  change to your region
PEM="~/.ssh/mypem.pem"      #  change to your .pem
USER="ubuntu"
PROJECT="simple-form"
RDS=$(aws rds --region ${REGION} describe-db-instances --db-instance-identifier rds-webserver --query "DBInstances[*].Endpoint.Address" --output text )

echo "stage change RDS"
sed -i -f "s/##/${RDS}/g" app.py

echo "copy update app.py"
for host in $(aws ec2 describe-instances --filters Name=tag:Name,Values=ansible-ec2 Name=instance-state-name,Values=running --query 'Reservations[0].Instances[*].[PublicIpAddress,Tags[?Key==``].Value[]]' --output text) ; do scp -i ${PEM} -r app.py ${USER}@"${host}":${PROJECT}/app.py ; done

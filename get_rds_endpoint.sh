#!/bin/bash 
REGION=us-east-1            #  change to your region
pem="~/pem/amaro-dev.pem"   #  change to your .pem dir
user="ubuntu"
project="simple-form"
RDS=$(aws rds --region ${REGION} describe-db-instances --db-instance-identifier rds-webserver --query "DBInstances[*].Endpoint.Address" --output text )

echo "stage change RDS"
sed -i -f "s/##/${RDS}/g" app.py

echo "copy update app.py"
for host in $(aws ec2 describe-instances --filters Name=tag:Name,Values=ansible-ec2 Name=instance-state-name,Values=running --query 'Reservations[0].Instances[*].[PublicIpAddress,Tags[?Key==``].Value[]]' --output text) ; do scp -i ${pem} -r app.py ${user}@"${host}":${project}/app.py ; done


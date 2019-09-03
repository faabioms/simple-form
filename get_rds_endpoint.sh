#!/bin/bash 
REGION=us-east-1
RDS=$(aws rds --region ${REGION} describe-db-instances --db-instance-identifier rds-webserver --query "DBInstances[*].Endpoint.Address" --output text )
sed -i -f "s/##/${RDS}/g" db.yaml

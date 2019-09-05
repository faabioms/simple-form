# Simple Form

## Introduction



## Prerequisites:

```
 - a default vpc (inform vpc_id and subnet_id)
 - access_key & secret_key (admin)
 - aws region
 - an existing .pem key
 - create ~/.boto file
```

## Example files

```
# Example ~/.boto file
[Credentials]
aws_access_key_id = foo
aws_secret_access_key = bar

Example ~/.aws/credentials file
[default]
aws_access_key_id = foo
aws_secret_access_key = bar
```

## Ansible Installation

[Installation Guide](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)

## First Steps
```
In order to run the playbook you need to replace certain files
**.hosts:** change ansible_ssh_private_key_file to your dir+pem file
**get_rds_endpoint.sh:** change the variable PEM to your dir+pem file
**get_rds_endpoint.sh:** change the variable REGION of your choice
**infra.yml:** in the vars section, update your region, azones_1a, azones_1c, subnetid, keypair variables
```

## Deploy Infrastructure 
```
1. run the command 'ansible-playbook infra.yml'
   **PS: it is possible to have a failing in the security_group_RDS creation, run the 1 step again.**
2. add the two instances public ip in .hosts files under #xxx.xxx.xx.xxx 
```

## Deploy Application
```
1.  run the commmand 'ansible-playbook deploy.yml'
```

## Get RDS endpoint and replace into webservers

```
1. run the command './get_rds_endpoint.sh'
   **PS: make sure you have the access_key & secret_key configure on ~/.aws/credentials.**
```

## Final Considerations

# Simple Form

## Introduction



## Terraform

Prerequisites:
```
 - a default vpc (inform vpc_id and subnet_id)
 - access_key & secret_key (admin)
 - aws region
 - an existing .pem key
 - create ~/.boto file
```

## Example .boto

```
# Example ~/.boto file
[Credentials]
aws_access_key_id = foo
aws_secret_access_key = bar
```

## Ansible Installation

[Installation Guide](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)

## Deploy Infrastructure 
```
before running:
- add mysql port to default sg to your IpAddress (in order to deploy the databases)
ansible-playbook infra.yml
```

## Deploy Application
```
before running:
- add the two instances public ip in .hosts files under #xxx.xxx.xx.xxx 
ansible-playbook deploy.yml
```

## Get RDS endpoint and replace into webservers

```
./get_rds_endpoint.sh
```


## Final Considerations

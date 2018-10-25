#!/bin/bash
#Turns on disable-api-termination ec2 attribute - instances cannot be terminated

AWS="/usr/bin/aws"

VPC_ID=$1
if [ -z $1 ]; then
  echo "Usage: $0 <VPC_ID>"
  exit -1
fi

for instance in $(${AWS} ec2 describe-instances --filters Name=vpc-id,Values=$VPC_ID | grep -i 'InstanceId' | awk '{ print $2}' | sed -e "s/\"//g" | sed -e "s/,//g"); do
  echo -e "Disabling API termination off\t${instance}"
  ${AWS} ec2 modify-instance-attribute --disable-api-termination --instance-id ${instance} 
done

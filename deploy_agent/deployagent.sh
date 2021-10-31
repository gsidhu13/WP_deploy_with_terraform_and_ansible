#!/bin/bash
aws ssm create-association --name AWS-ConfigureAWSPackage \
--targets Key=tag:Name,Values=codeDeploy --parameters action=Install,name=AWSCodeDeployAgent
# Deploy a WordPress site with Terraform and Ansible 

This tutorial is available in AWS CodeDeploy [documentation](https://docs.aws.amazon.com/codedeploy/latest/userguide/tutorials-wordpress.html) 

Architecture:

![diagram](https://user-images.githubusercontent.com/44376898/143668599-55522dcf-b582-47c6-952e-52bb3e8b04ce.jpeg)

All the steps in the documentation were performed either using console or AWS CLI, But I provisioned and configured the resources with Terraform, Ansible, and bash scripts.

Everything was provisioned or configured from my laptop, I didn't log into EC2 Instance. If you are planning to do the same, make sure you have your AWS profile configured, otherwise, you may experience authentication issues.

## Guide to this repo:


*  Run this Terraform [module](https://github.com/gsidhu13/WP_deploy_with_terraform_and_ansible/tree/master/terraform) to provision resources 
*  Configure the EC2 instance with Ansible. I could setup a different machine but I performed all the steps on the instance that I used to deploy the app. Ansible configs and [playbook](https://github.com/gsidhu13/WP_deploy_with_terraform_and_ansible/tree/master/ansible)
*  Deploy the CodeDeploy agent using bash [script](https://github.com/gsidhu13/WP_deploy_with_terraform_and_ansible/tree/master/deploy_agent)
*  Now deploy your app on [CodeDeploy](https://github.com/gsidhu13/WP_deploy_with_terraform_and_ansible/tree/master/deploy_app)
*  Setup your [site](https://github.com/gsidhu13/WP_deploy_with_terraform_and_ansible/tree/master/setup_site),  perform some [modifications](https://github.com/gsidhu13/WP_deploy_with_terraform_and_ansible/tree/master/modify_with_ansible) with ansible and [redeploy](https://github.com/gsidhu13/WP_deploy_with_terraform_and_ansible/tree/master/deploy_app) your app after the changes.

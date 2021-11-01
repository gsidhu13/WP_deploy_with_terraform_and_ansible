# Deploy a WordPress site with Terraform and Ansible 

This tutorial is available in AWS CodeDeploy [documentation](https://docs.aws.amazon.com/codedeploy/latest/userguide/tutorials-wordpress.html) 

All the steps in documentations were performed either using console or AWS CLI, But I provisioned and configured the resources with Terraform, Ansible, and bash scripts.

Everything was provisioned or configured from my laptop, I didn't log into EC2 Instance. If you are planning to do the same, make sure you have your AWS profile configured, otherwise, you may experience authentication issues.

## Guide to this repo:


*  Run this Terraform [module](https://github.com/gsidhu13/WP_deploy_with_terraforma_and_ansible/blob/2f3df717446d0b62f8ad82be0f7829ae9016ca67/terraform) to provision resources 
*  Configure the EC2 instance with Ansible. I could setup a different machine but I performed all the steps on the instance that I used to deploy the app. Ansible configs and [playbook](https://github.com/gsidhu13/WP_deploy_with_terraforma_and_ansible/blob/2f3df717446d0b62f8ad82be0f7829ae9016ca67/ansible)
*  Deploy the CodeDeploy agent using bash [script](https://github.com/gsidhu13/WP_deploy_with_terraforma_and_ansible/blob/2f3df717446d0b62f8ad82be0f7829ae9016ca67/deploy_agent)
*  Now deploy your app using [CodeDeploy](https://github.com/gsidhu13/WP_deploy_with_terraforma_and_ansible/blob/2f3df717446d0b62f8ad82be0f7829ae9016ca67/deploy_app)
*  Setup your [site](https://github.com/gsidhu13/WP_deploy_with_terraforma_and_ansible/blob/2f3df717446d0b62f8ad82be0f7829ae9016ca67/setup_site),  perform some [modifications](https://github.com/gsidhu13/WP_deploy_with_terraforma_and_ansible/blob/2f3df717446d0b62f8ad82be0f7829ae9016ca67/modify_with_ansible) with ansible and [redeploy](https://github.com/gsidhu13/WP_deploy_with_terraforma_and_ansible/blob/2f3df717446d0b62f8ad82be0f7829ae9016ca67/deploy_app) your app after the changes.






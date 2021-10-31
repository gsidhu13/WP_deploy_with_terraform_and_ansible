output "s3_name" {
  description = "S3 arn of Codedeploy bucket"
  value       = aws_s3_bucket.codeDeploy_bucket.id
}


output "app_name" {
  description = "app_name to use for Ansible"
  value       = aws_codedeploy_app.WordPressApp.name 
}

output "deployment_group_name" {
  description = "app_name to use for Ansible"
  value       = aws_codedeploy_deployment_group.WordPress_deploy_group.id 
}

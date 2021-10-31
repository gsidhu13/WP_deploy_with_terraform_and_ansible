
#!/bin/bash      

aws deploy create-deployment --application-name WordPress_App --s3-location bucket=codedeploy-gsingh,bundleType=zip,key=WordPress.zip \
--deployment-group-name WordPress_app_codedeploy_group --deployment-config-name CodeDeployDefault.OneAtATime
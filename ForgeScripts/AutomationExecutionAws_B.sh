#Run Basic tag nad upload results to S3
sudo /usr/local/bin/testengine -u "#{TestEngineUsername}#" -p "#{TestEnginePassword}#" -H "http://localhost:8080" run project tags Basic environment=#{TenantCode}# reportFileName Basic output=/home/ec2-user/testEngine/reports format pdf /home/ec2-user/testEngine/FusionWebApiAutomationReadyv2.zip
aws s3 cp /home/ec2-user/testEngine/reports/Basic.pdf s3://#{S3BucketName}#/#{TenantCode}#/TestResultsV2/#{Release.ReleaseName}#/Basic.pdf

#Run People tag nad upload results to S3
sudo /usr/local/bin/testengine -u "#{TestEngineUsername}#" -p "#{TestEnginePassword}#" -H "http://localhost:8080" run project tags People environment=#{TenantCode}# reportFileName People output=/home/ec2-user/testEngine/reports format pdf /home/ec2-user/testEngine/FusionWebApiAutomationReadyv2.zip
aws s3 cp /home/ec2-user/testEngine/reports/People.pdf s3://#{S3BucketName}#/#{TenantCode}#/TestResultsV2/#{Release.ReleaseName}#/People.pdf

#Run Delta tag nad upload results to S3
sudo /usr/local/bin/testengine -u "#{TestEngineUsername}#" -p "#{TestEnginePassword}#" -H "http://localhost:8080" run project tags Delta environment=#{TenantCode}# reportFileName Delta output=/home/ec2-user/testEngine/reports format pdf /home/ec2-user/testEngine/FusionWebApiAutomationReadyv2.zip
aws s3 cp /home/ec2-user/testEngine/reports/Delta.pdf s3://#{S3BucketName}#/#{TenantCode}#/TestResultsV2/#{Release.ReleaseName}#/Delta.pdf

#shutdown the license server instance
aws ec2 stop-instances --region "us-east-1" --instance-ids "#{LicenseServerInstanceId}"

#wait for last upload to finish
sleep 300

#shutdown instance
sudo shutdown now
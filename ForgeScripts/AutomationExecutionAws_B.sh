#Run Basic tag and upload results to S3
sudo /usr/local/bin/testengine -u "#{TestEngineUsername}#" -p "#{TestEnginePassword}#" -H "http://localhost:8080" run project tags Basic environment=#{TenantCode}# reportFileName Basic output=/home/ec2-user/testEngine/reports format pdf printReport /home/ec2-user/testEngine/FusionWebApiAutomationReadyv2.zip
aws s3 cp /home/ec2-user/testEngine/reports/Basic.pdf s3://#{S3BucketName}#/#{TenantCode}#/TestResultsV2/#{Release.ReleaseName}#/Basic.pdf

#Run People tag and upload results to S3
sudo /usr/local/bin/testengine -u "#{TestEngineUsername}#" -p "#{TestEnginePassword}#" -H "http://localhost:8080" run project tags People environment=#{TenantCode}# reportFileName People output=/home/ec2-user/testEngine/reports format pdf printReport /home/ec2-user/testEngine/FusionWebApiAutomationReadyv2.zip
aws s3 cp /home/ec2-user/testEngine/reports/People.pdf s3://#{S3BucketName}#/#{TenantCode}#/TestResultsV2/#{Release.ReleaseName}#/People.pdf

#Run Delta tag and upload results to S3
sudo /usr/local/bin/testengine -u "#{TestEngineUsername}#" -p "#{TestEnginePassword}#" -H "http://localhost:8080" run project tags Delta environment=#{TenantCode}# reportFileName Delta output=/home/ec2-user/testEngine/reports format pdf printReport /home/ec2-user/testEngine/FusionWebApiAutomationReadyv2.zip
aws s3 cp /home/ec2-user/testEngine/reports/Delta.pdf s3://#{S3BucketName}#/#{TenantCode}#/TestResultsV2/#{Release.ReleaseName}#/Delta.pdf

sleep 30

sudo shutdown now
#Run Basic tag
sudo /usr/local/bin/testengine -u "admin" -p "Admin@123" -H "http://localhost:8080" run project tags Basic environment=#{TenantCode}#  reportFileName Basic output=/home/ec2-user/testEngine/reports format pdf printReport /home/ec2-user/testEngine/FusionWebApiAutomationReadyv2.zip
aws s3 cp /home/ec2-user/testEngine/reports/Basic.pdf s3://#{S3BucketName}#/#{TenantCode}#/TestResultsV2/#{Release.ReleaseName}#/Basic.pdf




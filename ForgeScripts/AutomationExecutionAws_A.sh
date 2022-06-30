#Run Basic tag
sudo /usr/local/bin/testengine -u "#{TestEngineUsername}#" -p "#{TestEnginePassword}#" -H "http://localhost:8080" run project tags Basic environment=#{TenantCode}# reportFileName Basic output=/home/ec2-user/testEngine/reports format pdf /home/ec2-user/testEngine/FusionWebApiAutomationReadyv2.zip

#Run CrimsonHawks
sudo /usr/local/bin/testengine -u "#{TestEngineUsername}#" -p "#{TestEnginePassword}#" -H "http://localhost:8080" run project tags CrimsonHawks environment=#{TenantCode}# reportFileName CrimsonHawks output=/home/ec2-user/testEngine/reports format pdf /home/ec2-user/testEngine/FusionWebApiAutomationReadyv2.zip

#Run Newton tag
sudo /usr/local/bin/testengine -u "#{TestEngineUsername}#" -p "#{TestEnginePassword}#" -H "http://localhost:8080" run project tags Newton environment=#{TenantCode}# reportFileName Newton output=/home/ec2-user/testEngine/reports format pdf /home/ec2-user/testEngine/FusionWebApiAutomationReadyv2.zip

#Run Synergy tag
sudo /usr/local/bin/testengine -u "#{TestEngineUsername}#" -p "#{TestEnginePassword}#" -H "http://localhost:8080" run project tags Synergy environment=#{TenantCode}# reportFileName Synergy output=/home/ec2-user/testEngine/reports format pdf /home/ec2-user/testEngine/FusionWebApiAutomationReadyv2.zip

#wait for tests to finish running
sleep 2400

#upload results to s3
aws s3 cp /home/ec2-user/testEngine/reports/Basic.pdf s3://#{S3BucketName}#/#{TenantCode}#/TestResultsV2/#{Release.ReleaseName}#/Basic.pdf
aws s3 cp /home/ec2-user/testEngine/reports/CrimsonHawks.pdf s3://#{S3BucketName}#/#{TenantCode}#/TestResultsV2/#{Release.ReleaseName}#/CrimsonHawks.pdf
aws s3 cp /home/ec2-user/testEngine/reports/Newton.pdf s3://#{S3BucketName}#/#{TenantCode}#/TestResultsV2/#{Release.ReleaseName}#/Newton.pdf
aws s3 cp /home/ec2-user/testEngine/reports/Synergy.pdf s3://#{S3BucketName}#/#{TenantCode}#/TestResultsV2/#{Release.ReleaseName}#/Synergy.pdf


#shutdown the license server instance
aws ec2 stop-instances --region "us-east-1" --instance-ids "#{LicenseServerInstanceId}"

#wait for last upload to finish
sleep 300

#shutdown instance
sudo shutdown now
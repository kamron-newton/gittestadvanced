#Run Basic tag and upload results to S3
echo "starting script A `date +%T`" >> /home/ec2-user/testEngine/log.txt
sudo /usr/local/bin/testengine -u "#{TestEngineUsername}#" -p "#{TestEnginePassword}#" -H "http://localhost:8080" run project tags Basic environment=#{TenantCode}# reportFileName Basic output=/home/ec2-user/testEngine/reports format pdf /home/ec2-user/testEngine/FusionWebApiAutomationReadyv2.zip
echo "Finished queueing Basic test, uploading report to S3 `date +%T`" >> /home/ec2-user/testEngine/log.txt
aws s3 cp /home/ec2-user/testEngine/reports/Basic.pdf s3://#{S3BucketName}#/#{TenantCode}#/TestResultsV2/#{Release.ReleaseName}#/Basic.pdf

#Run CrimsonHawks and upload results to S3
echo "Queueing CH test `date +%T`" >> /home/ec2-user/testEngine/log.txt
sudo /usr/local/bin/testengine -u "#{TestEngineUsername}#" -p "#{TestEnginePassword}#" -H "http://localhost:8080" run project tags CrimsonHawks environment=#{TenantCode}# reportFileName CrimsonHawks output=/home/ec2-user/testEngine/reports format pdf /home/ec2-user/testEngine/FusionWebApiAutomationReadyv2.zip
echo "Finished queueing CH test, uploading report to S3 `date +%T`" >> /home/ec2-user/testEngine/log.txt
aws s3 cp /home/ec2-user/testEngine/reports/CrimsonHawks.pdf s3://#{S3BucketName}#/#{TenantCode}#/TestResultsV2/#{Release.ReleaseName}#/CrimsonHawks.pdf

#Run Newton tag and upload results to S3
echo "Queueing Newton test `date +%T`" >> /home/ec2-user/testEngine/log.txt
sudo /usr/local/bin/testengine -u "#{TestEngineUsername}#" -p "#{TestEnginePassword}#" -H "http://localhost:8080" run project tags Newton environment=#{TenantCode}# reportFileName Newton output=/home/ec2-user/testEngine/reports format pdf /home/ec2-user/testEngine/FusionWebApiAutomationReadyv2.zip
echo "Finished queueing Newton test, uploading report to S3 `date +%T`" >> /home/ec2-user/testEngine/log.txt
aws s3 cp /home/ec2-user/testEngine/reports/Newton.pdf s3://#{S3BucketName}#/#{TenantCode}#/TestResultsV2/#{Release.ReleaseName}#/Newton.pdf

#Run Synergy tag and upload results to S3
echo "Queueing Synergy test `date +%T`" >> /home/ec2-user/testEngine/log.txt
sudo /usr/local/bin/testengine -u "#{TestEngineUsername}#" -p "#{TestEnginePassword}#" -H "http://localhost:8080" run project tags Synergy environment=#{TenantCode}# reportFileName Synergy output=/home/ec2-user/testEngine/reports format pdf /home/ec2-user/testEngine/FusionWebApiAutomationReadyv2.zip
echo "Finished queueing Synergy test, uploading report to S3 `date +%T`" >> /home/ec2-user/testEngine/log.txt
aws s3 cp /home/ec2-user/testEngine/reports/Synergy.pdf s3://#{S3BucketName}#/#{TenantCode}#/TestResultsV2/#{Release.ReleaseName}#/Synergy.pdf


#shutdown the license server instance
echo "Shutting down license server `date +%T`" >> /home/ec2-user/testEngine/log.txt
aws ec2 stop-instances --region "us-east-1" --instance-ids "#{LicenseServerInstanceId}"
echo "Shutdown command complete, result of it is `$?` `date +%T`" >> /home/ec2-user/testEngine/log.txt

#wait for last upload to finish
sleep 300
echo "Finished sleeping for 5 mins, shutting down instance `date +%T`" >> /home/ec2-user/testEngine/log.txt

#shutdown instance
sudo shutdown now
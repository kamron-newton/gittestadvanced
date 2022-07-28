#Run Basic tag and upload results to S3
echo "starting script B `date +%T`" >> /home/ec2-user/testEngine/log.txt
sudo /usr/local/bin/testengine -u "#{TestEngineUsername}#" -p "#{TestEnginePassword}#" -H "http://localhost:8080" run project tags Basic environment=#{TenantCode}# reportFileName Basic output=/home/ec2-user/testEngine/reports format pdf /home/ec2-user/testEngine/FusionWebApiAutomationReadyv2.zip
echo "Finished running Basic test, uploading report to S3 and sending email `date +%T`" >> /home/ec2-user/testEngine/log.txt
aws s3 cp /home/ec2-user/testEngine/reports/Basic.pdf s3://#{S3BucketName}#/#{TenantCode}#/TestResultsV2/#{Release.ReleaseName}#/Basic.pdf
sudo python3 /home/ec2-user/testEngine/codeDeploy/send_pdf_mail.py Basic #{TenantCode}# #{FullReleaseVersion}# #{EnvironmentType}# `date +"%m/%d/%Y"` `date +"%r"` `date +"%p"`

#Run People tag and upload results to S3
echo "Queueing People test `date +%T`" >> /home/ec2-user/testEngine/log.txt
sudo /usr/local/bin/testengine -u "#{TestEngineUsername}#" -p "#{TestEnginePassword}#" -H "http://localhost:8080" run project tags People environment=#{TenantCode}# reportFileName People output=/home/ec2-user/testEngine/reports format pdf /home/ec2-user/testEngine/FusionWebApiAutomationReadyv2.zip
echo "Finished running People test, uploading report to S3 and sending email `date +%T`" >> /home/ec2-user/testEngine/log.txt
aws s3 cp /home/ec2-user/testEngine/reports/People.pdf s3://#{S3BucketName}#/#{TenantCode}#/TestResultsV2/#{Release.ReleaseName}#/People.pdf
sudo python3 /home/ec2-user/testEngine/codeDeploy/send_pdf_mail.py People #{TenantCode}# #{FullReleaseVersion}# #{EnvironmentType}# `date +"%m/%d/%Y"` `date +"%r"` `date +"%p"`

#Run Delta tag and upload results to S3
echo "Queueing Delta test `date +%T`" >> /home/ec2-user/testEngine/log.txt
sudo /usr/local/bin/testengine -u "#{TestEngineUsername}#" -p "#{TestEnginePassword}#" -H "http://localhost:8080" run project tags Delta environment=#{TenantCode}# reportFileName Delta output=/home/ec2-user/testEngine/reports format pdf /home/ec2-user/testEngine/FusionWebApiAutomationReadyv2.zip
echo "Finished running Delta test, uploading report to S3 and sending email `date +%T`" >> /home/ec2-user/testEngine/log.txt
aws s3 cp /home/ec2-user/testEngine/reports/Delta.pdf s3://#{S3BucketName}#/#{TenantCode}#/TestResultsV2/#{Release.ReleaseName}#/Delta.pdf
sudo python3 /home/ec2-user/testEngine/codeDeploy/send_pdf_mail.py Delta #{TenantCode}# #{FullReleaseVersion}# #{EnvironmentType}# `date +"%m/%d/%Y"` `date +"%r"` `date +"%p"`

#shutdown the license server instance
echo "Shutting down license server `date +%T`" >> /home/ec2-user/testEngine/log.txt
aws ec2 stop-instances --region "us-east-1" --instance-ids "#{LicenseServerInstanceId}#"

#wait for last upload to finish
echo "Sleeping for 5 minutes to wait for upload to S3 to finish `date +%T`" >> /home/ec2-user/testEngine/log.txt
sleep 300
echo "Finished sleeping for 5 mins, shutting down instance `date +%T`" >> /home/ec2-user/testEngine/log.txt

#shutdown instance
sudo shutdown now
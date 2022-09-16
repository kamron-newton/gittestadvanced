#Run Basic tag and upload results to S3
echo "starting script A `date +%T`" >> /home/ec2-user/testEngine/log.txt
sudo /usr/local/bin/testengine -u "#{TestEngineUsername}#" -p "#{TestEnginePassword}#" -H "http://localhost:8080" run project tags Basic environment=#{TenantCode}# reportFileName #{Release.ReleaseName}#"-"Basic output=/home/ec2-user/testEngine/reports format pdf /home/ec2-user/testEngine/FusionWebApiAutomationReadyv2.zip
echo "Finished running Basic test, uploading report to S3 and sending email `date +%T`" >> /home/ec2-user/testEngine/log.txt
aws s3 cp /home/ec2-user/testEngine/reports/#{Release.ReleaseName}#"-"Basic.pdf s3://#{S3BucketName}#/#{TenantCode}#/TestResultsV2/#{Release.ReleaseName}#/#{Release.ReleaseName}#"-"Basic.pdf
sudo python3 /home/ec2-user/testEngine/codeDeploy/send_pdf_mail.py Basic #{Release.ReleaseName}#"-"Basic

#Run CrimsonHawks and upload results to S3
echo "Queueing CH test `date +%T`" >> /home/ec2-user/testEngine/log.txt
#sudo /usr/local/bin/testengine -u "#{TestEngineUsername}#" -p "#{TestEnginePassword}#" -H "http://localhost:8080" run project tags CrimsonHawks environment=#{TenantCode}# reportFileName #{Release.ReleaseName}#"-"CrimsonHawks output=/home/ec2-user/testEngine/reports format pdf /home/ec2-user/testEngine/FusionWebApiAutomationReadyv2.zip
echo "Finished running CH test, uploading report to S3 and sending email `date +%T`" >> /home/ec2-user/testEngine/log.txt
#aws s3 cp /home/ec2-user/testEngine/reports/#{Release.ReleaseName}#"-"CrimsonHawks.pdf s3://#{S3BucketName}#/#{TenantCode}#/TestResultsV2/#{Release.ReleaseName}#/#{Release.ReleaseName}#"-"CrimsonHawks.pdf
#sudo python3 /home/ec2-user/testEngine/codeDeploy/send_pdf_mail.py CrimsonHawks #{Release.ReleaseName}#"-"CrimsonHawks

#Run Newton tag and upload results to S3
echo "Queueing Newton test `date +%T`" >> /home/ec2-user/testEngine/log.txt
#sudo /usr/local/bin/testengine -u "#{TestEngineUsername}#" -p "#{TestEnginePassword}#" -H "http://localhost:8080" run project tags Newton environment=#{TenantCode}# reportFileName #{Release.ReleaseName}#"-"Newton output=/home/ec2-user/testEngine/reports format pdf /home/ec2-user/testEngine/FusionWebApiAutomationReadyv2.zip
#echo "Finished running Newton test, uploading report to S3 and sending email `date +%T`" >> /home/ec2-user/testEngine/log.txt
#aws s3 cp /home/ec2-user/testEngine/reports/#{Release.ReleaseName}#"-"Newton.pdf s3://#{S3BucketName}#/#{TenantCode}#/TestResultsV2/#{Release.ReleaseName}#/#{Release.ReleaseName}#"-"Newton.pdf
#sudo python3 /home/ec2-user/testEngine/codeDeploy/send_pdf_mail.py Newton #{Release.ReleaseName}#"-"Newton

#Run Synergy tag and upload results to S3
echo "Queueing Synergy test `date +%T`" >> /home/ec2-user/testEngine/log.txt
#sudo /usr/local/bin/testengine -u "#{TestEngineUsername}#" -p "#{TestEnginePassword}#" -H "http://localhost:8080" run project tags Synergy environment=#{TenantCode}# reportFileName #{Release.ReleaseName}#"-"Synergy output=/home/ec2-user/testEngine/reports format pdf /home/ec2-user/testEngine/FusionWebApiAutomationReadyv2.zip
echo "Finished running Synergy test, uploading report to S3 and sending email `date +%T`" >> /home/ec2-user/testEngine/log.txt
#aws s3 cp /home/ec2-user/testEngine/reports/#{Release.ReleaseName}#"-"Synergy.pdf s3://#{S3BucketName}#/#{TenantCode}#/TestResultsV2/#{Release.ReleaseName}#/#{Release.ReleaseName}#"-"Synergy.pdf
#sudo python3 /home/ec2-user/testEngine/codeDeploy/send_pdf_mail.py Synergy #{Release.ReleaseName}#"-"Synergy

cd /home/ec2-user/testEngine/codeDeploy
sudo rm -rf *

#shutdown the license server instance
echo "Shutting down license server `date +%T`" >> /home/ec2-user/testEngine/log.txt
aws ec2 stop-instances --region "us-east-1" --instance-ids "#{LicenseServerInstanceId}#"

#wait for last upload to finish
echo "Sleeping for 5 minutes to wait for upload to S3 to finish `date +%T`" >> /home/ec2-user/testEngine/log.txt
sleep 300
echo "Finished sleeping for 5 mins, shutting down instance `date +%T`" >> /home/ec2-user/testEngine/log.txt

#shutdown instance
sudo shutdown now
#create project zip
cd /home/ec2-user/testEngine/codeDeploy
sudo zip -r FusionWebApiAutomationReadyv2.zip ./*
sudo mv FusionWebApiAutomationReadyv2.zip ..

#execute script that will run tests
sudo systemctl enable atd.service
sudo systemctl start atd.service
at now + 1 minute -f /home/ec2-user/testEngine/codeDeploy/#{ScriptFileToExecute}#
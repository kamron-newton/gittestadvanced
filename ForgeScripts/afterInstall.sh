#create project zip
cd /home/ec2-user/testEngine/codeDeploy
sudo zip -r FusionWebApiAutomationReadyv2.zip ./*
sudo mv FusionWebApiAutomationReadyv2.zip ..

#execute script that will run tests
/home/ec2-user/testEngine/codeDeploy/#{ScriptFileToExecute}#

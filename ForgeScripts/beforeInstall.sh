#clean out code deploy directory 
cd /home/ec2-user/testEngine/codeDeploy
sudo rm -rf *

#clean out the reports directory
cd /home/ec2-user/testEngine/reports
sudo rm -rf *

#clean the log file
truncate -s 0 /home/ec2-user/testEngine/log.txt

#remove and get license from license server
sudo /usr/local/bin/testengine license uninstall type=floating #{LicenseServerIp}#:443 -u "#{TestEngineUsername}#" -p "#{TestEnginePassword}#" -H "http://localhost:8080"
sudo /usr/local/bin/testengine license install type=floating #{LicenseServerIp}#:443 -u "#{TestEngineUsername}#" -p "#{TestEnginePassword}#" -H "http://localhost:8080"

#clean out code deploy directory 
cd /home/ec2-user/testEngine/codeDeploy
rm -rf *

#clean out the reports directory
cd /home/ec2-user/testEngine/reports
rm -rf *

#clean the log file
truncate -s 0 /home/ec2-user/testEngine/log.txt
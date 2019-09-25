# ICONMonitoring

All the documentation of the tools needed for the script to run properly and how to use it can be found here: 
https://docs.google.com/document/d/1WRe2QOWhJdyz9qHSxwXj-kBvxoraV-4ziGsrScWYkvA/edit?usp=sharing

ICON Node Alerting



In this guide you will get all the information you need in order to create your automated alerting system over e-mail and/or sms. In general, in order to monitor nodes is recommended to create a technical email address, which will be used for this purpose. A technical email address is just a regular email address but is called like that because it has no other purpose, than just to monitor and receive alerts. You can later also configure filters and alerts on your phone for certain email addresses and this could help. 
The scripts necessary for monitoring and alerting can be found here: https://github.com/Chainode/ICONMonitoring  

Installation and configuration

Install SSMTP
       Command: sudo apt-get install ssmtp

Configure ssmtp.conf
Command: sudo nano /etc/ssmtp/ssmtp.conf
Copy the configuration below and adapt 
# Config file for SSMTP sendmail
# The person who gets all mail for userids < 1000
# Make this empty to disable rewriting.
root=youremailaddress

# The place where the mail goes. The actual machine name is required no
# MX records are consulted. Commonly mailhosts are named mail.domain.com
mailhub=mailhub from your mail provider

AuthUser=youremailaddress
AuthPass=yourpass
UseTLS=YES
UseSTARTTLS=YES

# Where will the mail seem to come from?
rewriteDomain=mail domain

In the configuration above you will have to change the following parameters:
youremailaddress;
yourpass;
mailhub from mail provider
mail domain

An example of configuration for gmail provider below: 
# Config file for SSMTP sendmail
# The person who gets all mail for userids < 1000
# Make this empty to disable rewriting.
root=MyEmailAddress@gmail.com

# The place where the mail goes. The actual machine name is required no
# MX records are consulted. Commonly mailhosts are named mail.domain.com
mailhub=smtp.gmail.com:587

AuthUser=MyEmailAddress@gmail.com
AuthPass=MyPassword
UseTLS=YES
UseSTARTTLS=YES

# Where will the mail seem to come from?
rewriteDomain=gmail.com

Edit the /etc/ssmtp/revaliases file
Command: sudo nano /etc/ssmtp/revaliases
An example of configuration for gmail provider below: 
# SSMTP aliases
#
# Format:       local_account:outgoing_address:mailhub
#
# Example: root:your_login@your.domain:mailhub.your.domain[:port]
# where [:port] is an optional port number that defaults to 25.
root:youremail@gmail.com:smtp.gmail.com:587
 
Configure the alert
       Command: sudo nano icntestnet.txt
       An example of configuration
 
To: youremail@gmail.com
From: youremail@gmail.com
Subject: ICON Testnet 3 Node is down
 
Your ICON Testnet 3 node is down
 
Simulation command: /usr/sbin/ssmtp youremail@gmail.com < icntestnet.txt
You should then get an email as you previously defined
 
Install expect (optional) - only if you want to have automatic restart implemented
Command:  sudo apt-get install expect

Copy the files on your root folder, where your node.sh file is also located 

Authorize the scripts
Command: chmod u+x iconsurv.sh

 
Start the monitoring script
Create a new tmux window -> Command: tmux new-session -s iconalarm
In this window run the monitoring script - command: sudo ./iconsurv.sh


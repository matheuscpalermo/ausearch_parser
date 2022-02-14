#!/bin/sh

## creating log_file directory and granting permissions
sudo mkdir /usr/local/bin/ausearch_parser/log_file
sudo chmod 750 /usr/local/bin/ausearch_parser/log_file
sudo chmod 750 /usr/local/bin/ausearch_parser/script.sh
sudo chmod 750 /usr/local/bin/ausearch_parser/ausearch_parser.py

## install auditd
sudo apt install auditd -y

## start auditd
sudo service auditd start

## enable auditd
sudo systemctl --now enable auditd

## grub configuration
sudo echo 'GRUB_CMDLINE_LINUX="audit=1"' >> /etc/default/grub
sudo echo 'GRUB_CMDLINE_LINUX="audit_backlog_limit=8192"' >> /etc/default/grub
sudo update-grub

## replace auditd.conf
sudo mv /etc/audit/auditd.conf /etc/audit/original_conf.txt
sudo mv /usr/local/bin/ausearch_parser/auditd.conf /etc/audit/auditd.conf

## replace auditd.rules
sudo mv /etc/audit/rules.d/audit.rules /etc/audit/rules.d/original_rules.txt
sudo mv /usr/local/bin/ausearch_parser/audit.rules /etc/audit/rules.d/audit.rules
sudo service auditd restart

## create config file
echo "LOGS_PATH = './log_files/ausearch-i.txt'" > /usr/local/bin/ausearch_parser/config.py

## scheduling script
sudo echo '15 * * * * root /usr/local/bin/ausearch_parser/script.sh' >> /etc/crontab

#!/bin/sh

## creating log_file folder and granting permissions
mkdir /usr/local/bin/ausearch_parser/log_file
chmod 760 /usr/local/bin/ausearch_parser/log_file
chmod 760 /usr/local/bin/ausearch_parser/script.sh
chmod 760 /usr/local/bin/ausearch_parser/ausearch_parser.py

## install auditd
apt install auditd -y

## start auditd
service auditd start

## enable auditd
systemctl --now enable auditd

## grub configuration
echo 'GRUB_CMDLINE_LINUX="audit=1"' >> /etc/default/grub
echo 'GRUB_CMDLINE_LINUX="audit_backlog_limit=8192"' >> /etc/default/grub
update-grub

## replace auditd.conf
mv /etc/audit/auditd.conf /etc/audit/original_conf.txt
mv /usr/local/bin/ausearch_parser/auditd_files/auditd.conf /etc/audit/auditd.conf

## replace auditd.rules
mv /etc/audit/rules.d/audit.rules /etc/audit/rules.d/original_rules.txt
mv /usr/local/bin/ausearch_parser/auditd_files/audit.rules /etc/audit/rules.d/audit.rules
service auditd restart

## create config file
echo "LOGS_PATH = '/usr/local/bin/ausearch_parser/log_file/ausearch_i.txt'" > /usr/local/bin/ausearch_parser/config.py

## scheduling script
echo '15 * * * * root /usr/local/bin/ausearch_parser/script.sh' >> /etc/crontab

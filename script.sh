#!/bin/sh

ausearch -i --checkpoint /usr/local/bin/ausearch_parser/log_files/checkpoint > ./log_files/ausearch-i.txt;

python3 /usr/local/bin/ausearch_parser/ausearch_parser.py > /var/log/auditd.json

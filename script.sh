#!/bin/sh

sudo ausearch -i --checkpoint /usr/local/bin/ausearch_parser/log_file/checkpoint > /usr/local/bin/ausearch_parser/log_file/ausearch-i.txt;

sudo python3 /usr/local/bin/ausearch_parser/ausearch_parser.py > /var/log/auditd.json

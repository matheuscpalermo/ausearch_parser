#!/bin/sh

ausearch --checkpoint /usr/local/bin/ausearch_parser/log_file/checkpoint -i --input-logs > /usr/local/bin/ausearch_parser/log_file/ausearch_i.txt;

python3 /usr/local/bin/ausearch_parser/ausearch_parser.py > /var/log/auditd.json

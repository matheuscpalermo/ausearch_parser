#!/bin/bash

ausearch -i --checkpoint ./log_files/checkpoint > ausearch-i.txt;

python3 ./ausearch_parser.py > /var/log/secure/auditd_logs.json
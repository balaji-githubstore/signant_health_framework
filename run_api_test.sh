#!/bin/bash

echo Check the result in API_log.txt and py_report.html
echo still running...
python -m pytest --html=py_report.html ./API_Suite/tests/test_api.py > ./API_log.txt

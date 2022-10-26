#!/bin/bash

echo Check the result in API_log.txt
echo still running...
python -m pytest ./API_Suite/tests/test_api.py > ./API_log.txt

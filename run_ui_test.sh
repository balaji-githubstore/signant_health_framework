#!/bin/bash

echo Check the result in UI_log.txt
echo still running...
robot ./UI_Suite/tests/*/*.robot > ./UI_log.txt

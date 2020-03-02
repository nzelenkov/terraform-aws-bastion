#!/bin/bash
sleep 5
echo "*** Starting tests script ***"
SERVER=${app_url}
PORT=22
nc -z -w2 $SERVER $PORT </dev/null
result1=$?
if [  "$result1" = 0 ]; then
  echo  'Web server port 22 is open. Test failed, Exiting!'
  exit 1
else
  echo  'Web server port 22 is closed. Test successful, Continue!'
fi
PORT=80
nc -z -w2 $SERVER $PORT </dev/null
result1=$?
if [  "$result1" != 0 ]; then
  echo  'Web server port 80 is closed. Test failed, Exiting!'
  exit 1
else
  echo  'Web server port 80 is open. Test successful, Continue!'
fi
PORT=443
nc -z -w2 $SERVER $PORT </dev/null
result1=$?
if [  "$result1" != 0 ]; then
  echo  'Web server port 443 is closed. Test failed, Exiting!'
  exit 1
else
  echo  'Web server port 443 is open. Test successful, Continue!'
fi
SERVER=${bastion_public_ip}
PORT=22
nc -z -w2 $SERVER $PORT </dev/null
result1=$?
if [  "$result1" != 0 ]; then
  echo  'Bastion port 22 is closed. Test failed, Exiting!'
  exit 1
else
  echo  'Bastion port 22 is open. Test successful, Continue!'
fi
exit 0
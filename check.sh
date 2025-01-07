 cat check.sh 
#!/usr/bin/bash
# DO NOT MODIFY THIS FILE ("Check My Solution" will fail)

res=$(kubectl get pods -l app=nginx --no-headers -o json | jq -r '.items[] | "\(.status.containerStatuses[0].state.waiting.reason // .status.phase)"')
res=$(echo $res|tr -d '\r')

if [[ "$res" != "Running" ]]
then
  echo -n "NO"
  exit 1
fi

res=$(curl -s 10.43.216.196:80|grep -c Welcome)
if [[ "$res" -eq 2 ]]
then
  echo -n "OK"
else
  echo "NO"
fi

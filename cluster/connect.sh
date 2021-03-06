#!/bin/bash

if [ $# -lt 2 ]; then
  echo "Usage: $0 name {create|pause|resume|delete|status}"
  exit
fi

NAME=$1
shift

OPERATION=$1
shift


CONFIG=./connect_configs/${NAME}.json

if [ ! -f ${CONFIG} ]; then
  echo "Usage: $0 {create|pause|resume|delete|status} name"
  echo ""
  echo "   a configuration file of ./conect_configs/${NAME}.json must exist"
  echo ""
  exit
fi



ACCEPT="Accept:application/json"
CONTENT_TYPE="Content-Type:application/json"

#URL="http://localhost:18083/connectors"
URL="http://localhost:28083/connectors"

POST_DATA=$(cat <<EOF
{
    "name": "${NAME}",
    "config":
    $(cat < ${CONFIG})
}
EOF
)

create() {
  curl -s -H "${ACCEPT}" -H "${CONTENT_TYPE}" -X POST --data "${POST_DATA}" ${URL} | jq
}

pause() {
  curl -i -H "${ACCEPT}" -H "${CONTENT_TYPE}" -X PUT ${URL}/${NAME}/pause 
}

resume() {
  curl -i -H "${ACCEPT}" -H "${CONTENT_TYPE}" -X PUT ${URL}/${NAME}/resume 
}

delete() {
  curl -i -H "${ACCEPT}" -H "${CONTENT_TYPE}" -X DELETE ${URL}/${NAME} 
}

status() {
  curl -s -H "${ACCEPT}" -H "${CONTENT_TYPE}" -X GET ${URL}/${NAME}/status | jq
}

case "${OPERATION}" in
  create)
    create
    ;;
  pause)
    pause
    ;;
  resume)
    resume
    ;;
  delete)
    delete
    ;;
  status)
    status
    ;;
  *)
    echo "Usage: $0 {create|pause|resume|delete|status} name"
esac


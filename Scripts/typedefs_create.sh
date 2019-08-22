#!/bin/bash

#
# Create an entity-def
#

source ../config/config.shlib
inputFileName=$1

function checkUsage() {
  if [ "${inputFileName}" == "" ]
  then
    echo "Usage: $0 input-file"
    exit 1
  fi

  if [ ! -f "${inputFileName}" ]
  then
    echo "${inputFileName}: does not exist"
    exit 1
  fi
}
checkUsage

output=`${CURL_ATLAS} -X POST -H "Accept: application/json" -H "Content-Type: application/json" ${ATLAS_URL}/api/atlas/v2/types/typedefs -d @${inputFileName}`
ret=$?


if [ $ret == 0 ]
then
  echo ${output} | ${JSON_FORMATTER}
else
  echo "failed with error code: ${ret}"
fi

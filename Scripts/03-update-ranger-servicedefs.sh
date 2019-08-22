source config.ini

outputFileName="${DATA_DIR}/ranger-servicedef-hive.3.0.json+"
serviceType="hive"
output=`${CURL_RANGER} -X GET -H "Content-Type: application/json" ${RANGER_SERVICEDEF_API}/${serviceType}`
ret=$?

if [ $ret == 0 ]
then
  echo ${output} | ${JSON_FORMATTER} > ${outputFileName}
  echo "${serviceType}: service-def saved to ${outputFileName}"
else
  echo "failed with error code: ${ret}"
fi

outputFileName="${DATA_DIR}/ranger-servicedef-tag.3.0.json+"
serviceType="tag"
output=`${CURL_RANGER} -X GET -H "Content-Type: application/json" ${RANGER_SERVICEDEF_API}/${serviceType}`
ret=$?

if [ $ret == 0 ]
then
  echo ${output} | ${JSON_FORMATTER} > ${outputFileName}
  echo "${serviceType}: service-def saved to ${outputFileName}"
else
  echo "failed with error code: ${ret}"
fi

#Updating servicedef hive
inputFileName="${SCRIPT_DIR}/hive.json"
${CURL_RANGER} ${RANGER_SERVICEDEF_API}/hive \
  | jq '.options = {"enableDenyAndExceptionsInPolicies":"true"}' \
  | jq '.policyConditions = [
{
       "itemId": 1,
       "name": "resources-accessed-together",
       "evaluator": "org.apache.ranger.plugin.conditionevaluator.RangerHiveResourcesAccessedTogetherCondition",
       "evaluatorOptions": {},
       "label": "Resources Accessed Together?",
       "description": "Resources Accessed Together?"
},{
     "itemId": 2,
     "name": "not-accessed-together",
     "evaluator": "org.apache.ranger.plugin.conditionevaluator.RangerHiveResourcesNotAccessedTogetherCondition",
     "evaluatorOptions": {},
     "label": "Resources Not Accessed Together?",
     "description": "Resources Not Accessed Together?"
}
]' > "${inputFileName}"

output=`${CURL_RANGER} -X PUT -H "Accept: application/json" -H "Content-Type: application/json" -d @"${inputFileName}" "${RANGER_SERVICEDEF_API}/hive"`
ret=$?

print_response ${ret} ${inputFileName} "${RANGER_SERVICEDEF_API}/hive" ${output}


source config.ini

echo "***********************************************"
echo "Running ${SCRIPTS_DIR}/03-update-ranger-policies.sh"
echo "***********************************************"

echo "Importing ranger Tag policies.."
preInputFileName="${DATA_DIR}/ranger-policies-tags.json"
inputFileName="${DATA_DIR}/ranger-policies-tags_apply.json"
< "${preInputFileName}" jq '.policies[].service = "cm_tags"' > "${inputFileName}"
output=`${CURL_RANGER} -X POST -H "Content-Type: multipart/form-data" -H "Content-Type: application/json" -F "file=@${inputFileName}" "${RANGER_IMPORTPOL_API}=tag"`
ret=$?

print_response ${ret} {inputFileName} "${RANGER_IMPORTPOL_API}=tag" "${output}"

echo "Import ranger Hive policies..."
preInputFileName="${DATA_DIR}/ranger-policies-enabled.json"
inputFileName="${DATA_DIR}/ranger-policies-apply.json"
< "${preInputFileName}" jq '.policies[].service = "cm_hive"' > "${inputFileName}"
output=`${CURL_RANGER} -X POST -H "Content-Type: multipart/form-data" -H "Content-Type: application/json" -F "file=@${inputFileName}" "${RANGER_IMPORTPOL_API}=hive"`
ret=$?

print_response ${ret} ${inputFileName} "${RANGER_IMPORTPOL_API}=hive" "${output}"

echo "Import ranger HDFS policies..."
preInputFileName="${DATA_DIR}/ranger-hdfs-policies.json"
inputFileName="${DATA_DIR}/ranger-hdfs-policies-apply.json"
< "${preInputFileName}" jq '.policies[].service = "cm_hdfs"' | jq '.policies[].resources.path.values[] |= "'${SFS_URL}'" + .' > "${inputFileName}"
output=`${CURL_RANGER} -X POST -H "Content-Type: multipart/form-data" -H "Content-Type: application/json" -F "file=@${inputFileName}" "${RANGER_IMPORTPOL_API}=hdfs"`
ret=$?

print_response ${ret} ${inputFileName} "${RANGER_IMPORTPOL_API}=hdfs" "${output}"

echo "Import ranger Kafka policies..."
preInputFileName="${DATA_DIR}/ranger-kafka-policies.json"
inputFileName="${DATA_DIR}/ranger-kafka-policies-apply.json"
< "${preInputFileName}" jq '.policies[].service = "cm_kafka"' > "${inputFileName}"
output=`${CURL_RANGER} -X POST -H "Content-Type: multipart/form-data" -H "Content-Type: application/json" -F "file=@${inputFileName}" "${RANGER_IMPORTPOL_API}=kafka"`
ret=$?

print_response ${ret} ${inputFileName} "${RANGER_IMPORTPOL_API}=kafka" "${output}"

echo "Import ranger HBase policies..."
preInputFileName="${DATA_DIR}/ranger-hbase-policies.json"
inputFileName="${DATA_DIR}/ranger-hbase-policies-apply.json"
< "${preInputFileName}" jq '.policies[].service = "cm_hbase"' > "${inputFileName}"
output=`${CURL_RANGER} -X POST -H "Content-Type: multipart/form-data" -H "Content-Type: application/json" -F "file=@${inputFileName}" "${RANGER_IMPORTPOL_API}=hbase"`
ret=$?

print_response ${ret} ${inputFileName} "${RANGER_IMPORTPOL_API}=hbase" "${output}"

echo "Import ranger Atlas policies..."
preInputFileName="${DATA_DIR}/ranger-atlas-policies.json"
inputFileName="${DATA_DIR}/ranger-atlas-policies-apply.json"
< "${preInputFileName}" jq '.policies[].service = "cm_atlas"' > "${inputFileName}"
output=`${CURL_RANGER} -X POST -H "Content-Type: multipart/form-data" -H "Content-Type: application/json" -F "file=@${inputFileName}" "${RANGER_IMPORTPOL_API}=atlas"`
ret=$?

print_response ${ret} ${inputFileName} "${RANGER_IMPORTPOL_API}=atlas" "${output}"

echo "Import ranger YARN policies..."
preInputFileName="${DATA_DIR}/ranger-yarn-policies.json"
inputFileName="${DATA_DIR}/ranger-yarn-policies-apply.json"
< "${preInputFileName}" jq '.policies[].service = "cm_yarn"' > "${inputFileName}"
output=`${CURL_RANGER} -X POST -H "Content-Type: multipart/form-data" -H "Content-Type: application/json" -F "file=@${inputFileName}" "${RANGER_IMPORTPOL_API}=yarn"`
ret=$?

print_response ${ret} ${inputFileName} "${RANGER_IMPORTPOL_API}=yarn" "${output}"


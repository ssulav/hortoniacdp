source config.ini

# Get an entity by guid

inputFileName="${DATA_DIR)/export-hdfs_path-name.zip"

output=`${CURL_ATLAS} -X POST -H "Accept: application/json" -H "Content-Type: multipart/form-data" -H "Cache-Control: no-cache" -F data=@${inputFileName} ${ATLAS_ADMIN_API}`
ret=$?

print_response ${ret} ${inputFileName} ${ATLAS_ADMIN_API} ${output}

# Get an entity by guid

inputFileName="${DATA_DIR)/export-hive_db-name.zip"

output=`${CURL_ATLAS} -X POST -H "Accept: application/json" -H "Content-Type: multipart/form-data" -H "Cache-Control: no-cache" -F data=@${inputFileName} ${ATLAS_ADMIN_API}`
ret=$?

print_response ${ret} ${inputFileName} ${ATLAS_ADMIN_API} ${output}

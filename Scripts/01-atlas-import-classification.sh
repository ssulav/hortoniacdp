source config.ini

echo "***********************************************"
echo "Running ${SCRIPTS_DIR}/01-atlas-import-classification.sh"
echo "***********************************************"
 
# Create an entity-def
echo "Creating an Entity Definition"

inputFileName="${DATA_DIR}/classifications.json"

output=`${CURL_ATLAS} -X POST -H "Accept: application/json" -H "Content-Type: application/json" ${ATLAS_TYPEDEF_API} -d @${inputFileName}`
ret=$?

print_response ${ret} ${inputFileName} ${ATLAS_TYPEDEF_API} "${output}"

# Get an entity by guid
echo "Getting an Entity by GUID"

inputFileName="${DATA_DIR}/export-glossary.zip"

output=`${CURL_ATLAS} -X POST -H "Accept: application/json" -H "Content-Type: multipart/form-data" -H "Cache-Control: no-cache" -F data=@${inputFileName} ${ATLAS_ADMIN_API}`
ret=$?

print_response ${ret} ${inputFileName} ${ATLAS_ADMIN_API} "${output}"

source config.ini

echo "***********************************************"
echo "Running ${SCRIPTS_DIR}/07-create-hive-schema.sh"
echo "***********************************************"

beeline --hivevar SFS_URL=${SFS_URL} -f ${SCRIPTS_DIR}/HiveSchema.hsql

if [ "${ACID}" = true  ]; then
  beeline --hivevar SFS_URL=${SFS_URL} -f ${SCRIPTS_DIR}/TransSchema.hsql
fi

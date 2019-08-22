source config.ini

beeline --hivevar SFS_URL=${SFS_URL} -f ${DATA_DIR}/HiveSchema.hsql

if [ "${ACID}" = true  ]; then
  beeline iSFS_URL=${SFS_URL} -f ${DATA_DIR}/TransSchema.hsql
fi

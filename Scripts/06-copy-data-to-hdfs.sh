source config.ini

echo "***********************************************"
echo "Running ${SCRIPTS_DIR}/06-copy-data-to-hdfs.sh"
echo "***********************************************"

echo "Making data dir under ${SFS_URL}/hive_data"
hdfs dfs -mkdir -p ${SFS_URL}/hive_data/claim			2>/dev/null
hdfs dfs -mkdir -p ${SFS_URL}/hive_data/cost_savings/		2>/dev/null
hdfs dfs -mkdir -p ${SFS_URL}/hive_data/finance/tax_2009/	2>/dev/null
hdfs dfs -mkdir -p ${SFS_URL}/hive_data/finance/tax_2010/	2>/dev/null
hdfs dfs -mkdir -p ${SFS_URL}/hive_data/finance/tax_2015/	2>/dev/null
hdfs dfs -mkdir -p ${SFS_URL}/hive_data/hortoniabank/eu_countries/	2>/dev/null
hdfs dfs -mkdir -p ${SFS_URL}/hive_data/hortoniabank/us_customers/	2>/dev/null
hdfs dfs -mkdir -p ${SFS_URL}/hive_data/hortoniabank/ww_customers/	2>/dev/null
hdfs dfs -mkdir -p ${SFS_URL}/hive_data/consent/		2>/dev/null
hdfs dfs -mkdir -p ${SFS_URL}/hive_data/eu_countries/		2>/dev/null
hdfs dfs -mkdir -p ${SFS_URL}/hive_data/hr/employees_raw/	2>/dev/null
hdfs dfs -mkdir -p ${SFS_URL}/hive_data/hr/employees/		2>/dev/null

echo "Copying data to ${SFS_URL}/hive_data dir in HDFS..."
hdfs dfs -put ${DATA_DIR}/claims_provider_summary_data.csv ${SFS_URL}/hive_data/claim/			2>/dev/null
hdfs dfs -put ${DATA_DIR}/claim-savings.csv                ${SFS_URL}/hive_data/cost_savings/		2>/dev/null
hdfs dfs -put ${DATA_DIR}/tax_2009.csv                     ${SFS_URL}/hive_data/finance/tax_2009/	2>/dev/null
hdfs dfs -put ${DATA_DIR}/tax_2010.csv                     ${SFS_URL}/hive_data/finance/tax_2010/	2>/dev/null
hdfs dfs -put ${DATA_DIR}/tax_2015.csv                     ${SFS_URL}/hive_data/finance/tax_2015/	2>/dev/null
hdfs dfs -put ${DATA_DIR}/eu_countries.csv                 ${SFS_URL}/hive_data/hortoniabank/eu_countries/	2>/dev/null
hdfs dfs -put ${DATA_DIR}/us_customers_data.csv            ${SFS_URL}/hive_data/hortoniabank/us_customers/	2>/dev/null
hdfs dfs -put ${DATA_DIR}/ww_customers_data.csv            ${SFS_URL}/hive_data/hortoniabank/ww_customers/	2>/dev/null
hdfs dfs -put ${DATA_DIR}/consent_master_data_cleaned.csv	${SFS_URL}/hive_data/consent/		2>/dev/null
hdfs dfs -put ${DATA_DIR}/eu_countries.csv	                ${SFS_URL}/hive_data/eu_countries/	2>/dev/null
hdfs dfs -put ${DATA_DIR}/employees_raw.csv                ${SFS_URL}/hive_data/hr/employees_raw/	2>/dev/null
hdfs dfs -put ${DATA_DIR}/employees.csv                    ${SFS_URL}/hive_data/hr/employees/		2>/dev/null


hdfs dfs -chown -R hive:hive ${SFS_URL}/hive_data/	2>/dev/null


#!/usr/bin/env bash

source config.ini
sed -i 's|enabled=1|enabled=0|g' /etc/yum.repos.d/cloudera-manager.repo
sed -i 's|enabled=1|enabled=0|g' /etc/yum.repos.d/clustermanager.repo
yum clean all;yum makecache fast;
yum -y -q install git epel-release screen mysql-connector-java postgresql-jdbc python-argparse python-configobj ack nc wget jq pssh;

${SCRIPTS_DIR}/03-update-ranger-servicedefs.sh
${SCRIPTS_DIR}/03-update-ranger-policies.sh

#${SCRIPTS_DIR}/05-create-hdfs-user-folders.sh
${SCRIPTS_DIR}/06-copy-data-to-hdfs.sh

${SCRIPTS_DIR}/07-create-hive-schema.sh  

#${SCRIPTS_DIR}/08-create-hbase-kafka.sh

${SCRIPTS_DIR}/01-atlas-import-classification.sh 

${SCRIPTS_DIR}/09-associate-entities-with-tags.sh

if [ false ]; then
echo "Change Hive doAs setting" #DoAs to TRUE
/var/lib/ambari-server/resources/scripts/configs.py -u ${ambari_admin} -p ${ambari_pass} --host ${ambari_host} --port 8080 --cluster ${cluster_name} -a set -c hive-site -k hive.server2.enable.doAs  -v true
if [ "${enable_hive_acid}" = true  ]; then
        /var/lib/ambari-server/resources/scripts/configs.py -u ${ambari_admin} -p ${ambari_pass} --host ${ambari_host} --port 8080 --cluster ${cluster_name} -a set -c hive-env -k hive_txn_acid -v on
        /var/lib/ambari-server/resources/scripts/configs.py -u ${ambari_admin} -p ${ambari_pass} --host ${ambari_host} --port 8080 --cluster ${cluster_name} -a set -c hive-site -k hive.support.concurrency -v true
        /var/lib/ambari-server/resources/scripts/configs.py -u ${ambari_admin} -p ${ambari_pass} --host ${ambari_host} --port 8080 --cluster ${cluster_name} -a set -c hive-site -k hive.compactor.initiator.on -v true
        /var/lib/ambari-server/resources/scripts/configs.py -u ${ambari_admin} -p ${ambari_pass} --host ${ambari_host} --port 8080 --cluster ${cluster_name} -a set -c hive-site -k hive.compactor.worker.threads -v 1
        /var/lib/ambari-server/resources/scripts/configs.py -u ${ambari_admin} -p ${ambari_pass} --host ${ambari_host} --port 8080 --cluster ${cluster_name} -a set -c hive-site -k hive.enforce.bucketing -v true
        /var/lib/ambari-server/resources/scripts/configs.py -u ${ambari_admin} -p ${ambari_pass} --host ${ambari_host} --port 8080 --cluster ${cluster_name} -a set -c hive-site -k hive.exec.dynamic.partition.mode -v nonstrict
        /var/lib/ambari-server/resources/scripts/configs.py -u ${ambari_admin} -p ${ambari_pass} --host ${ambari_host} --port 8080 --cluster ${cluster_name} -a set -c hive-site -k hive.txn.manager -v org.apache.hadoop.hive.ql.lockmgr.DbTxnManager
fi

#If the atlas imports has failed in your setup need to run them manually :
/usr/hdp/current/atlas-server/hook-bin/import-hive.sh --database  consent_master
/usr/hdp/current/atlas-server/hook-bin/import-hive.sh --database  cost_savings
/usr/hdp/current/atlas-server/hook-bin/import-hive.sh --database  erasure_master
/usr/hdp/current/atlas-server/hook-bin/import-hive.sh --database  finance 
/usr/hdp/current/atlas-server/hook-bin/import-hive.sh --database  hr
/usr/hdp/current/atlas-server/hook-bin/import-hive.sh --database  claim
/usr/hdp/current/atlas-server/hook-bin/import-hive.sh --database  hortoniabank
fi

echo "Automated portion of setup is complete"


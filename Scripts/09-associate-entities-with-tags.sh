source config.ini

echo "***********************************************"
echo "Running ${SCRIPTS_DIR}/09-associate-entities-with-tags.sh"
echo "***********************************************"

##Tagging Hive Tables

#fetch guid for table hortoniabank.eu_countries@${CLUSTER_NAME}
guid=$(${CURL_ATLAS} ${ATLAS_API}/v2/entity/uniqueAttribute/type/hive_table?attr:qualifiedName=hortoniabank.eu_countries@${CLUSTER_NAME} | jq '.entity.guid'  | tr -d '"')

#add REFERENCE_DATA tag
${CURL_ATLAS} ${ATLAS_API}/entities/${guid}/traits \
-X POST -H 'Content-Type: application/json' \
--data-binary '{"jsonClass":"org.apache.atlas.typesystem.json.InstanceSerialization$_Struct","typeName":"REFERENCE_DATA","values":{}}'


#fetch guid for table consent_master.eu_countries@${CLUSTER_NAME}
guid=$(${CURL_ATLAS}  ${ATLAS_API}/v2/entity/uniqueAttribute/type/hive_table?attr:qualifiedName=consent_master.eu_countries@${CLUSTER_NAME} | jq '.entity.guid'  | tr -d '"')

#add REFERENCE_DATA tag
${CURL_ATLAS} ${ATLAS_API}/entities/${guid}/traits \
-X POST -H 'Content-Type: application/json' \
--data-binary '{"jsonClass":"org.apache.atlas.typesystem.json.InstanceSerialization$_Struct","typeName":"REFERENCE_DATA","values":{}}'



#fetch guid for table consent_master.consent_data
guid=$(${CURL_ATLAS}  ${ATLAS_API}/v2/entity/uniqueAttribute/type/hive_table?attr:qualifiedName=consent_master.consent_data@${CLUSTER_NAME} | jq '.entity.guid'  | tr -d '"')

#add REFERENCE_DATA tag
${CURL_ATLAS} ${ATLAS_API}/entities/${guid}/traits \
-X POST -H 'Content-Type: application/json' \
--data-binary '{"jsonClass":"org.apache.atlas.typesystem.json.InstanceSerialization$_Struct","typeName":"REFERENCE_DATA","values":{}}'


#fetch guid for table consent_master.consent_data_trans
guid=$(${CURL_ATLAS}  ${ATLAS_API}/v2/entity/uniqueAttribute/type/hive_table?attr:qualifiedName=consent_master.consent_data_trans@${CLUSTER_NAME} | jq '.entity.guid'  | tr -d '"')

#add REFERENCE_DATA tag
${CURL_ATLAS} ${ATLAS_API}/entities/${guid}/traits \
-X POST -H 'Content-Type: application/json' \
--data-binary '{"jsonClass":"org.apache.atlas.typesystem.json.InstanceSerialization$_Struct","typeName":"REFERENCE_DATA","values":{}}'



	
## tag hive tables with attribute


#fetch guid for table cost_savings.claim_savings@${CLUSTER_NAME}
guid=$(${CURL_ATLAS}  ${ATLAS_API}/v2/entity/uniqueAttribute/type/hive_table?attr:qualifiedName=cost_savings.claim_savings@${CLUSTER_NAME} | jq '.entity.guid'  | tr -d '"')

#add DATA_QUALITY tag with score=0.51
${CURL_ATLAS} ${ATLAS_API}/entities/${guid}/traits \
-X POST -H 'Content-Type: application/json' \
--data-binary '{"jsonClass":"org.apache.atlas.typesystem.json.InstanceSerialization$_Struct","typeName":"DATA_QUALITY", "values":{"score": "0.51"}}'



## Tagging Hive columns

#fetch guid for table claim.provider_summary.providername@${CLUSTER_NAME}
guid=$(${CURL_ATLAS}  ${ATLAS_API}/v2/entity/uniqueAttribute/type/hive_column?attr:qualifiedName=claim.provider_summary.providername@${CLUSTER_NAME} | jq '.entity.guid'  | tr -d '"')

#add VENDOR_PII tag with type=vendor
${CURL_ATLAS} ${ATLAS_API}/entities/${guid}/traits \
-X POST -H 'Content-Type: application/json' \
--data-binary '{"jsonClass":"org.apache.atlas.typesystem.json.InstanceSerialization$_Struct","typeName":"VENDOR_PII", "values":{"type": "vendor"}}'


#fetch guid for  finance.tax_2015.ssn
guid=$(${CURL_ATLAS}  ${ATLAS_API}/v2/entity/uniqueAttribute/type/hive_column?attr:qualifiedName=finance.tax_2015.ssn@${CLUSTER_NAME} | jq '.entity.guid'  | tr -d '"')

#add FINANCE_PII tag with type=finance
${CURL_ATLAS} ${ATLAS_API}/entities/${guid}/traits \
-X POST -H 'Content-Type: application/json' \
--data-binary '{"jsonClass":"org.apache.atlas.typesystem.json.InstanceSerialization$_Struct","typeName":"FINANCE_PII", "values":{"type": "finance"}}'


#fetch guid for finance.tax_2015.fed_tax
guid=$(${CURL_ATLAS}  ${ATLAS_API}/v2/entity/uniqueAttribute/type/hive_column?attr:qualifiedName=finance.tax_2015.fed_tax@${CLUSTER_NAME} | jq '.entity.guid'  | tr -d '"')

#add EXPIRES_ON tag with expiry_date=2016
${CURL_ATLAS} ${ATLAS_API}/entities/${guid}/traits \
-X POST -H 'Content-Type: application/json' \
--data-binary '{"jsonClass":"org.apache.atlas.typesystem.json.InstanceSerialization$_Struct","typeName":"EXPIRES_ON", "values":{"expiry_date": "2016-12-31T00:00:00.000Z"}}'


#fetch guid for hortoniabank.us_customers.ccnumber
guid=$(${CURL_ATLAS}  ${ATLAS_API}/v2/entity/uniqueAttribute/type/hive_column?attr:qualifiedName=hortoniabank.us_customers.ccnumber@${CLUSTER_NAME} | jq '.entity.guid'  | tr -d '"')

#add PII tag with type=ccn
${CURL_ATLAS} ${ATLAS_API}/entities/${guid}/traits \
-X POST -H 'Content-Type: application/json' \
--data-binary '{"jsonClass":"org.apache.atlas.typesystem.json.InstanceSerialization$_Struct","typeName":"PII", "values":{"type": "ccn"}}'


#fetch guid for hortoniabank.us_customers.mrn
guid=$(${CURL_ATLAS}  ${ATLAS_API}/v2/entity/uniqueAttribute/type/hive_column?attr:qualifiedName=hortoniabank.us_customers.mrn@${CLUSTER_NAME} | jq '.entity.guid'  | tr -d '"')

#add PII tag with type=MRN
${CURL_ATLAS} ${ATLAS_API}/entities/${guid}/traits \
-X POST -H 'Content-Type: application/json' \
--data-binary '{"jsonClass":"org.apache.atlas.typesystem.json.InstanceSerialization$_Struct","typeName":"PII", "values":{"type": "MRN"}}'


#fetch guid for hortoniabank.us_customers.nationalid
guid=$(${CURL_ATLAS}  ${ATLAS_API}/v2/entity/uniqueAttribute/type/hive_column?attr:qualifiedName=hortoniabank.us_customers.nationalid@${CLUSTER_NAME} | jq '.entity.guid'  | tr -d '"')

#add PII tag with type=MRN
${CURL_ATLAS} ${ATLAS_API}/entities/${guid}/traits \
-X POST -H 'Content-Type: application/json' \
--data-binary '{"jsonClass":"org.apache.atlas.typesystem.json.InstanceSerialization$_Struct","typeName":"PII", "values":{"type": "ssn"}}'



#fetch guid for hortoniabank.us_customers.password
guid=$(${CURL_ATLAS}  ${ATLAS_API}/v2/entity/uniqueAttribute/type/hive_column?attr:qualifiedName=hortoniabank.us_customers.password@${CLUSTER_NAME} | jq '.entity.guid'  | tr -d '"')

#add PII tag with type=Password
${CURL_ATLAS} ${ATLAS_API}/entities/${guid}/traits \
-X POST -H 'Content-Type: application/json' \
--data-binary '{"jsonClass":"org.apache.atlas.typesystem.json.InstanceSerialization$_Struct","typeName":"PII", "values":{"type": "Password"}}'


#fetch guid for hortoniabank.us_customers.emailaddress
guid=$(${CURL_ATLAS}  ${ATLAS_API}/v2/entity/uniqueAttribute/type/hive_column?attr:qualifiedName=hortoniabank.us_customers.emailaddress@${CLUSTER_NAME} | jq '.entity.guid'  | tr -d '"')

#add PII tag with type=Email
${CURL_ATLAS} ${ATLAS_API}/entities/${guid}/traits \
-X POST -H 'Content-Type: application/json' \
--data-binary '{"jsonClass":"org.apache.atlas.typesystem.json.InstanceSerialization$_Struct","typeName":"PII", "values":{"type": "Email"}}'


#fetch guid for table hr.employees_encrypted.phone@${CLUSTER_NAME}
guid=$(${CURL_ATLAS}  ${ATLAS_API}/v2/entity/uniqueAttribute/type/hive_column?attr:qualifiedName=hr.employees_encrypted.phone@${CLUSTER_NAME} | jq '.entity.guid'  | tr -d '"')

#add ENCRYPTED tag with type=phone
${CURL_ATLAS} ${ATLAS_API}/entities/${guid}/traits \
-X POST -H 'Content-Type: application/json' \
--data-binary '{"jsonClass":"org.apache.atlas.typesystem.json.InstanceSerialization$_Struct","typeName":"ENCRYPTED", "values":{"type": "phone"}}'


 
#fetch guid for table hr.employees_encrypted.email@${CLUSTER_NAME}
guid=$(${CURL_ATLAS}  ${ATLAS_API}/v2/entity/uniqueAttribute/type/hive_column?attr:qualifiedName=hr.employees_encrypted.email@${CLUSTER_NAME} | jq '.entity.guid'  | tr -d '"')

#add ENCRYPTED tag with type=phone
${CURL_ATLAS} ${ATLAS_API}/entities/${guid}/traits \
-X POST -H 'Content-Type: application/json' \
--data-binary '{"jsonClass":"org.apache.atlas.typesystem.json.InstanceSerialization$_Struct","typeName":"ENCRYPTED", "values":{"type": "email"}}'


#create entities for kafka topic FOREX
${CURL_ATLAS}  ${ATLAS_API}/v2/entity -X POST -H 'Content-Type: application/json' -d @- <<EOF
{  
   "entity":{  
      "typeName":"kafka_topic",
      "attributes":{  
         "description":null,
         "name":"FOREX",
         "owner":null,
         "qualifiedName":"FOREX@${CLUSTER_NAME}",
         "topic":"FOREX",
         "uri":"none"
      },
      "guid":-1
   },
   "referredEntities":{  
   }
}
EOF

#create entities for kafka topics PRIVATE and associte with SENSITIVE tag
${CURL_ATLAS}  ${ATLAS_API}/v2/entity -X POST -H 'Content-Type: application/json' -d @- <<EOF
{  
   "entity":{  
      "typeName":"kafka_topic",
      "attributes":{  
         "description":null,
         "name":"PRIVATE",
         "owner":null,
         "qualifiedName":"PRIVATE@${CLUSTER_NAME}",
         "topic":"PRIVATE",
         "uri":"none"
      },
      "guid":-1
   },
   "referredEntities":{  
   }
}
EOF

guid=$(${CURL_ATLAS}  ${ATLAS_API}/v2/entity/uniqueAttribute/type/kafka_topic?attr:qualifiedName=PRIVATE@${CLUSTER_NAME} | jq '.entity.guid'  | tr -d '"')

${CURL_ATLAS} ${ATLAS_API}/entities/${guid}/traits \
-X POST -H 'Content-Type: application/json' \
--data-binary '{"jsonClass":"org.apache.atlas.typesystem.json.InstanceSerialization$_Struct","typeName":"SENSITIVE","values":{}}'

#create entities for Hbase table T_FOREX 
${CURL_ATLAS}  ${ATLAS_API}/v2/entity -X POST -H 'Content-Type: application/json' -d @- <<EOF
{  
   "entity":{  
      "typeName":"hbase_table",
      "attributes":{  
         "description":"T_FOREX table",
         "name":"T_FOREX",
         "owner":"hbase",
         "qualifiedName":"T_FOREX@${CLUSTER_NAME}",
         "column_families":[  
         ],
         "uri":"none"
      },
      "guid":-1
   },
   "referredEntities":{  
   }
}
EOF

#create entities for Hbase table T_PRIVATE and associate with SENSITIVE tag
${CURL_ATLAS}  ${ATLAS_API}/v2/entity -X POST -H 'Content-Type: application/json' -d @- <<EOF
{  
   "entity":{  
      "typeName":"hbase_table",
      "attributes":{  
         "description":"T_PRIVATE table",
         "name":"T_PRIVATE",
         "owner":"hbase",
         "qualifiedName":"T_PRIVATE@${CLUSTER_NAME}",
         "column_families":[  
         ],
         "uri":"none"
      },
      "guid":-1
   },
   "referredEntities":{  
   }
}
EOF
 guid=$(${CURL_ATLAS}  ${ATLAS_API}/v2/entity/uniqueAttribute/type/hbase_table?attr:qualifiedName=T_PRIVATE@${CLUSTER_NAME} | jq '.entity.guid'  | tr -d '"')
 ${CURL_ATLAS} ${ATLAS_API}/entities/${guid}/traits \
-X POST -H 'Content-Type: application/json' \
--data-binary '{"jsonClass":"org.apache.atlas.typesystem.json.InstanceSerialization$_Struct","typeName":"SENSITIVE","values":{}}'

hdfs_path="${SFS_URL}/sensitive"

${CURL_ATLAS}  ${ATLAS_API}/v2/entity -X POST -H 'Content-Type: application/json' -d @- <<EOF
{  
   "entity":{  
      "typeName":"hdfs_path",
      "attributes":{  
         "description":null,
         "name":"${hdfs_path}",
         "owner":null,
         "qualifiedName":"${hdfs_prefix}${hdfs_path}",
         "clusterName":"${CLUSTER_NAME}",
         "path":"${hdfs_prefix}${hdfs_path}"
      },
      "guid":-1
   },
   "referredEntities":{  
   }
}
EOF

guid=$(${CURL_ATLAS}  ${ATLAS_API}/v2/entity/uniqueAttribute/type/hdfs_path?attr:qualifiedName=${hdfs_prefix}${hdfs_path} | jq '.entity.guid'  | tr -d '"')

${CURL_ATLAS} ${ATLAS_API}/entities/${guid}/traits \
-X POST -H 'Content-Type: application/json' \
--data-binary '{"jsonClass":"org.apache.atlas.typesystem.json.InstanceSerialization$_Struct","typeName":"SENSITIVE","values":{}}'



# HDP Security/Governance/GDPR Demo kit

## Demo overview

Detailed overview can be found [here](https://community.hortonworks.com/articles/151939/hdp-securitygovernance-demo-kit.html) 

## Versions tested

Tested with:
- [x] HDP 3.1.0 / Ambari 2.7.3.0
- [x] HDP 3.0.1 / Ambari 2.7.1.0
- [x] HDP 3.0.0 / Ambari 2.7.0.0

## Summary
How to quickly setup HDP Security/Governance/GDPR (HortoniaBank) demo for secondary filesystem.

#### Whats included
- HortoniaBank artifacts
- Demo hive tables
- Demo tags/attributes and lineage in Atlas
- Demo Zeppelin notebooks to walk through demo scenario
- Ranger policies across HDFS, Hive, Hbase, Kafka, Atlas to showcase:
- Tag based access policies across HDFS/Hive/HBase/Kafka
- Row level filtering on co-mingled datasets in Hive
- Dynamic tag based masking in Hive columns
- Time bound Ranger policies
- Hive HDF execution authorization
- Classifications (tags) in Atlas
- Tag propagation
- Data lineage in Atlas for HDFS, Hive, NiFi, Hbase
- GDPR Scenarios around consent and data erasure

## Do below steps to setup HortoniaBank tests for Ranger/Atlas :

 1. Password less ssh across all nodes with gateway/ambari/appliance node (also needed password less ssh with self)

 2. Add below components if not present : <br>
    - Ranger    `(Password to be set as Rangerpassword@123)`
    - Atlas		`(Password to be set as admin123)`
    - Hive
    - HBase
    - Kafka		`(One broker on the same node as appliance)`
    - Zeppelin	`(On the same node as appliance)`

 3. Setup a KDC server `(with default REALM as EXAMPLE.COM)` and Enable kerberos in the cluster and have a admin principal created : <br>
    ```kadmin.local -q "addprinc -pw admin admin/admin"
    Principal : 	admin/admin@EXAMPLE.COM
    Password : 	admin
    ```

 4. Enable all the Ranger plugins. This step creates the policy repo for each component. <br>
But before running the setup disable the plugin again (to avoid permission issue enforced by Ranger).

 5. Populate secondary fs url in /grid/0/hadoopqe/conf/suite.conf and do not put a "/" at end of the URI : <br>
`Format : 	[fs-acronym]://[server]:[port]` <br>
E.g: <br>
    ```
    [secondaryfs]
    USE_SECONDARY_FS = True
    SECONDARY_FS_URL = nfs://hdpserver:1228
    ```

 6. Data and Media files needed for the test are hosted in qe-repo bucket and referred again from above suite.conf file : <br>
    ```
    [hortoniabank]
    NOTEBOOK_MEDIA_URL = http://qe-repo.s3.amazonaws.com/partener-test-data/notebook-media.tgz
    RANGER_ATLAS_DATA_URL = http://qe-repo.s3.amazonaws.com/partener-test-data/ranger-atlas-data-csv.tgz
    HORTONIA_MUNICH_DATA_URL = http://qe-repo.s3.amazonaws.com/partener-test-data/HortoniaMunichSetup-data-csv.tgz
    ```

 7. To trigger the script SSH in to Ambari/appliance node as root and run below: <br>
    ```
    cd /grid/0/tools/hortoniabank
    chmod +x setup.sh
    ./setup.sh
    ```

#### _Note : Run setup.sh in nohup or in screen mode._

  ## Accessing Zeppelin
  
- Accessing Zeppelin UI <br>
    _**http://<appliance_host>:9995/**_

User List for zeppelin with default password :
```
    ivanna_eu_hr / admin
    joe_analyst / admin
    etl_user / admin
    scott_intern / admin
```

- Once services are up, login to Zeppelin *(http://<appliance_host>:9995/)* as **ivanna_eu_hr**.
- Find her notebook by searching for **"hortonia"** using the text field under **‘Notebook’** section. <br>
![z1](https://user-images.githubusercontent.com/40571322/58865931-15002d80-86d5-11e9-9b29-7121b9934cff.png)
- Select the notebook called: **“HortoniaBank - Ivana EU HR”**. Once selected it will ask for the interpreters to run the job.
  <br>Select all listed and click on **"Save"**
![z2](https://user-images.githubusercontent.com/40571322/58865932-15002d80-86d5-11e9-8832-28f9f83947b5.png)
- Once you are logged in and the mentioned notebook is selected, below page will be displayed.
![z3](https://user-images.githubusercontent.com/40571322/58865933-15002d80-86d5-11e9-9baf-a96029ae05d6.png)
- These are the list of scenarios to test Data lineage and security. <br> When you run a job (with Play button), the output of the job should adhere to the header statement.
<br>E.g. First Job in above pic says **"Permission Denied"** as the job expect it to throw an *Access Control Violation on accessing US customers*.
- Repeat the job with all the mentioned users and refer to the notebook based on user : 
    ```
    ivanna_eu_hr
    joe_analyst
    etl_user
    scott_intern
    ```

### Подготовка к выполнению

- Скопировал репозиторий, указал в hosts заранее созданные машины, скопировал `id_rsa.pub` ,  запустил `ansible-playbook site.yml -i inventory/cicd/hosts.yml `

<details><summary>Вывод</summary>

```bash
PLAY [Get OpenJDK installed] ******************************************************************************************************************************************************************************

TASK [Gathering Facts] ************************************************************************************************************************************************************************************
ok: [sonar-01]

TASK [install unzip] **************************************************************************************************************************************************************************************
ok: [sonar-01]

TASK [Upload .tar.gz file conaining binaries from remote storage] *****************************************************************************************************************************************
ok: [sonar-01]

TASK [Ensure installation dir exists] *********************************************************************************************************************************************************************
ok: [sonar-01]

TASK [Extract java in the installation directory] *********************************************************************************************************************************************************
skipping: [sonar-01]

TASK [Export environment variables] ***********************************************************************************************************************************************************************
ok: [sonar-01]

PLAY [Get PostgreSQL installed] ***************************************************************************************************************************************************************************

TASK [Gathering Facts] ************************************************************************************************************************************************************************************
ok: [sonar-01]

TASK [Change repo file] ***********************************************************************************************************************************************************************************
ok: [sonar-01]

TASK [Install PostgreSQL repos] ***************************************************************************************************************************************************************************
ok: [sonar-01]

TASK [Install PostgreSQL] *********************************************************************************************************************************************************************************
ok: [sonar-01]

TASK [Init template1 DB] **********************************************************************************************************************************************************************************
changed: [sonar-01]

TASK [Start pgsql service] ********************************************************************************************************************************************************************************
ok: [sonar-01]

TASK [Create user in system] ******************************************************************************************************************************************************************************
ok: [sonar-01]

TASK [Create user for Sonar in PostgreSQL] ****************************************************************************************************************************************************************
changed: [sonar-01]

TASK [Change password for Sonar user in PostgreSQL] *******************************************************************************************************************************************************
changed: [sonar-01]

TASK [Create Sonar DB] ************************************************************************************************************************************************************************************
changed: [sonar-01]

TASK [Copy pg_hba.conf] ***********************************************************************************************************************************************************************************
ok: [sonar-01]

PLAY [Prepare Sonar host] *********************************************************************************************************************************************************************************

TASK [Gathering Facts] ************************************************************************************************************************************************************************************
ok: [sonar-01]

TASK [Create group in system] *****************************************************************************************************************************************************************************
ok: [sonar-01]

TASK [Create user in system] ******************************************************************************************************************************************************************************
ok: [sonar-01]

TASK [Set up ssh key to access for managed node] **********************************************************************************************************************************************************
changed: [sonar-01]

TASK [Allow group to have passwordless sudo] **************************************************************************************************************************************************************
changed: [sonar-01]

TASK [Increase Virtual Memory] ****************************************************************************************************************************************************************************
changed: [sonar-01]

TASK [Reboot VM] ******************************************************************************************************************************************************************************************
changed: [sonar-01]

PLAY [Get Sonarqube installed] ****************************************************************************************************************************************************************************

TASK [Gathering Facts] ************************************************************************************************************************************************************************************
ok: [sonar-01]

TASK [Get distrib ZIP] ************************************************************************************************************************************************************************************
changed: [sonar-01]

TASK [Unzip Sonar] ****************************************************************************************************************************************************************************************
changed: [sonar-01]

TASK [Move Sonar into place.] *****************************************************************************************************************************************************************************
changed: [sonar-01]

TASK [Configure SonarQube JDBC settings for PostgreSQL.] **************************************************************************************************************************************************
changed: [sonar-01] => (item={'regexp': '^sonar.jdbc.username', 'line': 'sonar.jdbc.username=sonar'})
changed: [sonar-01] => (item={'regexp': '^sonar.jdbc.password', 'line': 'sonar.jdbc.password=sonar'})
changed: [sonar-01] => (item={'regexp': '^sonar.jdbc.url', 'line': 'sonar.jdbc.url=jdbc:postgresql://localhost:5432/sonar?useUnicode=true&characterEncoding=utf8&rewriteBatchedStatements=true&useConfigs=maxPerformance'})
changed: [sonar-01] => (item={'regexp': '^sonar.web.context', 'line': 'sonar.web.context='})

TASK [Generate wrapper.conf] ******************************************************************************************************************************************************************************
changed: [sonar-01]

TASK [Symlink sonar bin.] *********************************************************************************************************************************************************************************
changed: [sonar-01]

TASK [Copy SonarQube systemd unit file into place (for systemd systems).] *********************************************************************************************************************************
changed: [sonar-01]

TASK [Ensure Sonar is running and set to start on boot.] **************************************************************************************************************************************************
changed: [sonar-01]

TASK [Allow Sonar time to build on first start.] **********************************************************************************************************************************************************
Pausing for 180 seconds
(ctrl+C then 'C' = continue early, ctrl+C then 'A' = abort)
Press 'C' to continue the play or 'A' to abort 
ok: [sonar-01]

TASK [Make sure Sonar is responding on the configured port.] **********************************************************************************************************************************************
ok: [sonar-01]

PLAY [Get Nexus installed] ********************************************************************************************************************************************************************************

TASK [Gathering Facts] ************************************************************************************************************************************************************************************
The authenticity of host '158.160.99.158 (158.160.99.158)' can't be established.
ED25519 key fingerprint is SHA256:3StAs/VA/WUPNgi+4BUfV32aUTYFlMsXy09OefmkcDw.
This key is not known by any other names
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
ok: [nexus-01]

TASK [Create Nexus group] *********************************************************************************************************************************************************************************
changed: [nexus-01]

TASK [Create Nexus user] **********************************************************************************************************************************************************************************
changed: [nexus-01]

TASK [Install JDK] ****************************************************************************************************************************************************************************************
changed: [nexus-01]

TASK [Create Nexus directories] ***************************************************************************************************************************************************************************
changed: [nexus-01] => (item=/home/nexus/log)
changed: [nexus-01] => (item=/home/nexus/sonatype-work/nexus3)
changed: [nexus-01] => (item=/home/nexus/sonatype-work/nexus3/etc)
changed: [nexus-01] => (item=/home/nexus/pkg)
changed: [nexus-01] => (item=/home/nexus/tmp)

TASK [Download Nexus] *************************************************************************************************************************************************************************************
[WARNING]: Module remote_tmp /home/nexus/.ansible/tmp did not exist and was created with a mode of 0700, this may cause issues when running as another user. To avoid this, create the remote_tmp dir with
the correct permissions manually
changed: [nexus-01]

TASK [Unpack Nexus] ***************************************************************************************************************************************************************************************
changed: [nexus-01]

TASK [Link to Nexus Directory] ****************************************************************************************************************************************************************************
changed: [nexus-01]

TASK [Add NEXUS_HOME for Nexus user] **********************************************************************************************************************************************************************
changed: [nexus-01]

TASK [Add run_as_user to Nexus.rc] ************************************************************************************************************************************************************************
changed: [nexus-01]

TASK [Raise nofile limit for Nexus user] ******************************************************************************************************************************************************************
changed: [nexus-01]

TASK [Create Nexus service for SystemD] *******************************************************************************************************************************************************************
changed: [nexus-01]

TASK [Ensure Nexus service is enabled for SystemD] ********************************************************************************************************************************************************
changed: [nexus-01]

TASK [Create Nexus vmoptions] *****************************************************************************************************************************************************************************
changed: [nexus-01]

TASK [Create Nexus properties] ****************************************************************************************************************************************************************************
changed: [nexus-01]

TASK [Lower Nexus disk space threshold] *******************************************************************************************************************************************************************
skipping: [nexus-01]

TASK [Start Nexus service if enabled] *********************************************************************************************************************************************************************
changed: [nexus-01]

TASK [Ensure Nexus service is restarted] ******************************************************************************************************************************************************************
skipping: [nexus-01]

TASK [Wait for Nexus port if started] *********************************************************************************************************************************************************************
ok: [nexus-01]

PLAY RECAP ************************************************************************************************************************************************************************************************
nexus-01                   : ok=17   changed=15   unreachable=0    failed=0    skipped=2    rescued=0    ignored=0   
sonar-01                   : ok=34   changed=16   unreachable=0    failed=0    skipped=1    rescued=0    ignored=0 
```
</details>

![SonarQube](https://github.com/northsilver/devOPS_tutorial/blob/master/PICtures/Screenshot%20from%202023-07-04%2021-48-27.png)
![Nexus](https://github.com/northsilver/devOPS_tutorial/blob/master/PICtures/Screenshot%20from%202023-07-04%2021-48-12.png)



### Знакомство с SonarQube
1. создал проект netology
2. скачал и установил 
```bash
ivan@ivan-ThinkPad-X395:~/proj/devOPS_tutorial/Files/09-ci-03-cicd/infrastructure/example/sonar-scanner-4.8.0.2856-linux/bin$ export PATH=$(pwd):$PATH
ivan@ivan-ThinkPad-X395:~/proj/devOPS_tutorial/Files/09-ci-03-cicd/example$ sonar-scanner --version
INFO: Scanner configuration file: /home/ivan/proj/devOPS_tutorial/Files/09-ci-03-cicd/infrastructure/example/sonar-scanner-4.8.0.2856-linux/conf/sonar-scanner.properties
INFO: Project root configuration file: NONE
INFO: SonarScanner 4.8.0.2856
INFO: Java 11.0.17 Eclipse Adoptium (64-bit)
INFO: Linux 5.19.0-45-generic amd64
```
3. Команда и вывод
<details><summary>Команда</summary>

```bash
sonar-scanner \
  -Dsonar.projectKey=netology-test \
  -Dsonar.sources=. \
  -Dsonar.host.url=http://84.252.130.211:9000 \
  -Dsonar.login=f028ebd4a7224b290321e51bc944d9a7a0817e2b \
  -Dsonar.coverage.exclusions=fail.py
```
</details>

<details><summary>Вывод</summary>

```bash
INFO: Scanner configuration file: /home/ivan/proj/devOPS_tutorial/Files/09-ci-03-cicd/infrastructure/example/sonar-scanner-4.8.0.2856-linux/conf/sonar-scanner.properties
INFO: Project root configuration file: NONE
INFO: SonarScanner 4.8.0.2856
INFO: Java 11.0.17 Eclipse Adoptium (64-bit)
INFO: Linux 5.19.0-45-generic amd64
INFO: User cache: /home/ivan/.sonar/cache
INFO: Analyzing on SonarQube server 9.1.0
INFO: Default locale: "en_US", source code encoding: "UTF-8" (analysis is platform dependent)
INFO: Load global settings
INFO: Load global settings (done) | time=157ms
INFO: Server id: 9CFC3560-AYkiKRxwxJoU4q8bCLOf
INFO: User cache: /home/ivan/.sonar/cache
INFO: Load/download plugins
INFO: Load plugins index
INFO: Load plugins index (done) | time=69ms
INFO: Load/download plugins (done) | time=13346ms
INFO: Process project properties
INFO: Process project properties (done) | time=8ms
INFO: Execute project builders
INFO: Execute project builders (done) | time=1ms
INFO: Project key: netology-test
INFO: Base dir: /home/ivan/proj/devOPS_tutorial/Files/09-ci-03-cicd/example
INFO: Working dir: /home/ivan/proj/devOPS_tutorial/Files/09-ci-03-cicd/example/.scannerwork
INFO: Load project settings for component key: 'netology-test'
INFO: Load project settings for component key: 'netology-test' (done) | time=58ms
INFO: Load quality profiles
INFO: Load quality profiles (done) | time=132ms
INFO: Load active rules
INFO: Load active rules (done) | time=3304ms
INFO: Indexing files...
INFO: Project configuration:
INFO: 1 file indexed
INFO: 0 files ignored because of scm ignore settings
INFO: Quality profile for py: Sonar way
INFO: ------------- Run sensors on module netology-test
INFO: Load metrics repository
INFO: Load metrics repository (done) | time=46ms
INFO: Sensor Python Sensor [python]
WARN: Your code is analyzed as compatible with python 2 and 3 by default. This will prevent the detection of issues specific to python 2 or python 3. You can get a more precise analysis by setting a python version in your configuration via the parameter "sonar.python.version"
INFO: Starting global symbols computation
INFO: 1 source file to be analyzed
INFO: Load project repositories
INFO: Load project repositories (done) | time=44ms
INFO: 1/1 source file has been analyzed
INFO: Starting rules execution
INFO: 1 source file to be analyzed
INFO: 1/1 source file has been analyzed
INFO: Sensor Python Sensor [python] (done) | time=1125ms
INFO: Sensor Cobertura Sensor for Python coverage [python]
INFO: Sensor Cobertura Sensor for Python coverage [python] (done) | time=15ms
INFO: Sensor PythonXUnitSensor [python]
INFO: Sensor PythonXUnitSensor [python] (done) | time=1ms
INFO: Sensor CSS Rules [cssfamily]
INFO: No CSS, PHP, HTML or VueJS files are found in the project. CSS analysis is skipped.
INFO: Sensor CSS Rules [cssfamily] (done) | time=1ms
INFO: Sensor JaCoCo XML Report Importer [jacoco]
INFO: 'sonar.coverage.jacoco.xmlReportPaths' is not defined. Using default locations: target/site/jacoco/jacoco.xml,target/site/jacoco-it/jacoco.xml,build/reports/jacoco/test/jacocoTestReport.xml
INFO: No report imported, no coverage information will be imported by JaCoCo XML Report Importer
INFO: Sensor JaCoCo XML Report Importer [jacoco] (done) | time=3ms
INFO: Sensor C# Project Type Information [csharp]
INFO: Sensor C# Project Type Information [csharp] (done) | time=1ms
INFO: Sensor C# Analysis Log [csharp]
INFO: Sensor C# Analysis Log [csharp] (done) | time=23ms
INFO: Sensor C# Properties [csharp]
INFO: Sensor C# Properties [csharp] (done) | time=1ms
INFO: Sensor JavaXmlSensor [java]
INFO: Sensor JavaXmlSensor [java] (done) | time=1ms
INFO: Sensor HTML [web]
INFO: Sensor HTML [web] (done) | time=4ms
INFO: Sensor VB.NET Project Type Information [vbnet]
INFO: Sensor VB.NET Project Type Information [vbnet] (done) | time=1ms
INFO: Sensor VB.NET Analysis Log [vbnet]
INFO: Sensor VB.NET Analysis Log [vbnet] (done) | time=25ms
INFO: Sensor VB.NET Properties [vbnet]
INFO: Sensor VB.NET Properties [vbnet] (done) | time=0ms
INFO: ------------- Run sensors on project
INFO: Sensor Zero Coverage Sensor
INFO: Sensor Zero Coverage Sensor (done) | time=10ms
INFO: SCM Publisher SCM provider for this project is: git
INFO: SCM Publisher 1 source file to be analyzed
INFO: SCM Publisher 0/1 source files have been analyzed (done) | time=135ms
WARN: Missing blame information for the following files:
WARN:   * fail.py
WARN: This may lead to missing/broken features in SonarQube
INFO: CPD Executor Calculating CPD for 1 file
INFO: CPD Executor CPD calculation finished (done) | time=9ms
INFO: Analysis report generated in 86ms, dir size=103.2 kB
INFO: Analysis report compressed in 12ms, zip size=14.5 kB
INFO: Analysis report uploaded in 64ms
INFO: ANALYSIS SUCCESSFUL, you can browse http://84.252.130.211:9000/dashboard?id=netology-test
INFO: Note that you will be able to access the updated dashboard once the server has processed the submitted analysis report
INFO: More about the report processing at http://84.252.130.211:9000/api/ce/task?id=AYkiQXJ0xJoU4q8bCQTm
INFO: Analysis total time: 7.097 s
INFO: ------------------------------------------------------------------------
INFO: EXECUTION SUCCESS
INFO: ------------------------------------------------------------------------
INFO: Total time: 25.353s
INFO: Final Memory: 8M/34M
INFO: ------------------------------------------------------------------------
```
</details>

4. В интерфейсе

![Bug](https://github.com/northsilver/devOPS_tutorial/blob/master/PICtures/Screenshot%20from%202023-07-04%2021-58-00.png)

5. Исправил

![Fixed](https://github.com/northsilver/devOPS_tutorial/blob/master/PICtures/Screenshot%20from%202023-07-04%2022-00-10.png)

### Знакомство с Nexus

[maven-metadata](https://github.com/northsilver/devOPS_tutorial/blob/master/Files/09-ci-03-cicd/example/maven-metadata.xml)

### Знакомство с Maven

#### Подготовка к выполнению

- скачал и установил 
```bash
ivan@ivan-ThinkPad-X395:~/proj/devOPS_tutorial/Files/09-ci-03-cicd/mvn$ mvn --version
Apache Maven 3.6.3
Maven home: /usr/share/maven
Java version: 11.0.19, vendor: Ubuntu, runtime: /usr/lib/jvm/java-11-openjdk-amd64
Default locale: en_US, platform encoding: UTF-8
OS name: "linux", version: "5.19.0-45-generic", arch: "amd64", family: "unix"
```

#### Основная часть

[pom](https://github.com/northsilver/devOPS_tutorial/blob/master/Files/09-ci-03-cicd/mvn/pom.xml)



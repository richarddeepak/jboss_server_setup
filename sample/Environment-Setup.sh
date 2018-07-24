#!/bin/sh

echo "==============================================================================================================================="
echo "BPI GTN_Installation Process"
echo "==============================================================================================================================="

echo "========================================================="
# source the properties:
do_Properties_file=./Envi.properties

if [ -f "$do_Properties_file" ]
then
  echo "$do_Properties_file found."
  while IFS='=' read -r key value
  do
    key=$(echo $key | tr '.' '_')
    eval "${key}='${value}'"
  done < "$do_Properties_file"
else
  echo "$do_Properties_file not found."
fi
  echo ${Server_Name}
  echo ${Base_Path}
  echo ${War_Jar_Backup_Path}
  echo ${Backup_Path}
  echo ${Owner}
  echo ${Group}
  echo ${DB_IP}
  echo ${DB_User_Name}
  echo ${DB_Password}
  echo ${DB_APP_TST_Name}
  echo ${DB_SYS_TST_Name}
  echo ${DB_BPM_TST_Name}
  echo ${DB_STG_TST_Name}
  echo ${DB_ETL_PASSPHRASE}
  echo ${ETL_port_Num}
echo "========================================================="

do_Initial_Config(){

echo "==============================================================================================================================="
echo "Service Account creation process has been started"
echo "==============================================================================================================================="
mkdir ${Base_Path}/${Server_Name}
echo "Server folder has been created in opt folder"
echo "====================================================================================="
mkdir ${Base_Path}/${Server_Name}/etl
echo "etl folder has been created in ${Server_Name} folder"
echo "====================================================================================="
mkdir ${Base_Path}/${Server_Name}/etl/staging
echo "staging folder has been created in etl folder"
echo "====================================================================================="
echo "==============================================================================================================================="
echo "Service Account creation process has been Completed"
echo "==============================================================================================================================="

}

do_Environment_Config(){

echo "==============================================================================================================================="
echo "Environment Config creation process has been started"
echo "==============================================================================================================================="
mkdir ${Base_Path}/${Server_Name}/conf
echo "conf folder has been created in ${Server_Name} folder"
echo "====================================================================================="
cp ${Backup_Path}/GTN_JBoss_EnvConfiguration.tar.gz ${Base_Path}/${Server_Name}/conf
echo "GTN_JBoss_EnvConfiguration.tar.gz file has been copied from backup folder"
echo "====================================================================================="
tar -zxvf ${Base_Path}/${Server_Name}/conf/GTN_JBoss_EnvConfiguration.tar.gz -C ${Base_Path}/${Server_Name}/conf
echo "GTN_JBoss_EnvConfiguration.tar.gz file has been extract from conf folder"
echo "====================================================================================="
echo "Permission process for jboss-as2 file"
chown -R ${Owner}:${Group} ${Base_Path}/${Server_Name}/conf/jboss-as2
echo "${Owner}:${Group} permission has been provided to jboss-as2 file"
echo "====================================================================================="
rm -f ${Base_Path}/${Server_Name}/conf/GTN_JBoss_EnvConfiguration.tar.gz
echo "GTN_JBoss_EnvConfiguration.tar.gz file has been deleted from conf folder"
echo "====================================================================================="
touch ${Base_Path}/${Server_Name}/conf/jboss-as2/jboss-as-standalone.pid
chown -R ${Owner}:${Group} ${Base_Path}/${Server_Name}/conf/jboss-as2
echo "jboss-as-standalone.pid file has been created from jboss-as2 folder"
echo "====================================================================================="
cp ${Backup_Path}/GTN_BPI_Configuration.tar.gz ${Base_Path}/${Server_Name}/conf
echo "GTN_BPI_Configuration.tar.gz file has been copied from backup folder"
echo "====================================================================================="
tar -zxvf ${Base_Path}/${Server_Name}/conf/GTN_BPI_Configuration.tar.gz -C ${Base_Path}/${Server_Name}/conf
echo "GTN_BPI_Configuration.tar.gz file has been extract from conf folder"
echo "====================================================================================="
rm -f ${Base_Path}/${Server_Name}/conf/GTN_BPI_Configuration.tar.gz
echo "GTN_BPI_Configuration.tar.gz file has been deleted from conf folder"
echo "====================================================================================="
echo "==============================================================================================================================="
echo "Environment Config creation process has been Completed"
echo "==============================================================================================================================="

}

do_JBoss_Config(){

echo "==============================================================================================================================="
echo "JBoss AS 7.1.1 Configure & Installation process has been started"
echo "==============================================================================================================================="
mkdir ${Base_Path}/${Server_Name}/logs
echo "Log folder has been created in Server folder"
echo "====================================================================================="
cp ${Backup_Path}/jboss-7.1.1.tar.gz ${Base_Path}/${Server_Name}
echo "jboss-7.1.1.tar.gz file has been copied from backup folder"
echo "====================================================================================="
tar -zxvf ${Base_Path}/${Server_Name}/jboss-7.1.1.tar.gz -C ${Base_Path}/${Server_Name}/
echo "jboss-7.1.1.tar.gz file has been extract from Server folder"
echo "====================================================================================="
rm -f ${Base_Path}/${Server_Name}/jboss-7.1.1.tar.gz
echo "jboss-7.1.1.tar.gz file has been deleted from Server folder"
echo "====================================================================================="

cp ${Backup_Path}/GTN_BPM_Build.tar.gz ${Base_Path}/${Server_Name}
echo "GTN_BPM_Build.tar.gz file has been copied from backup folder"
echo "====================================================================================="
tar -zxvf ${Base_Path}/${Server_Name}/GTN_BPM_Build.tar.gz -C ${Base_Path}/${Server_Name}/
echo "GTN_BPM_Build.tar.gz file has been extract from Server folder"
echo "====================================================================================="
rm -f ${Base_Path}/${Server_Name}/GTN_BPM_Build.tar.gz
echo "GTN_BPM_Build.tar.gz file has been deleted from Server folder"
echo "====================================================================================="

cp ${Backup_Path}/GTN_JBoss_Configuration.tar.gz ${Base_Path}/${Server_Name}/jboss-7.1.1
echo "GTN_JBoss_Configuration.tar.gz file has been copied from backup folder"
echo "====================================================================================="
tar -zxvf ${Base_Path}/${Server_Name}/jboss-7.1.1/GTN_JBoss_Configuration.tar.gz -C ${Base_Path}/${Server_Name}/jboss-7.1.1
echo "GTN_JBoss_Configuration.tar.gz file has been extract from jboss-7.1.1 folder"
echo "====================================================================================="
rm -f ${Base_Path}/${Server_Name}/jboss-7.1.1/GTN_JBoss_Configuration.tar.gz
echo "GTN_JBoss_Configuration.tar.gz file has been deleted from jboss-7.1.1 folder"
echo "====================================================================================="

echo "====================================================================================="
chown -R ${Owner}:${Group} ${Base_Path}/${Server_Name}/
chmod 777 ${Base_Path}/${Server_Name}/jboss-7.1.1/bin/standalone.sh
echo "==============================================================================================================================="
echo "JBoss AS 7.1.1 Configure & Installation process has been completed"
echo "==============================================================================================================================="

}

do_Database_Config(){

echo "==============================================================================================================================="
echo "Database Config updation process has been started"
echo "==============================================================================================================================="
cp ${Backup_Path}/standalone.xml ${Base_Path}/${Server_Name}/jboss-7.1.1/standalone/configuration
echo "standalone.xml file has been copied from standalone.xml backup path"
echo "====================================================================================="
echo "==============================================================================================================================="
echo "Database Config updation process has been completed"
echo "==============================================================================================================================="

}

do_BPI_GTN_App_installation(){

echo "==============================================================================================================================="
echo "BPI GTN App installation process has been started"
echo "==============================================================================================================================="

echo "=================================================================="

  for file in ${War_Jar_Backup_Path}/*; do
  extension="${file##*.}"
  if [ "$extension" == "gz" ]; then
   echo "tar file is going to extract"
  tar -zxvf ${War_Jar_Backup_Path}/${file##*/} -C ${War_Jar_Backup_Path}
  echo ${file##*/}
  echo "file in process"
  echo "tar file extraction completed successfully"
  echo "=================================================================="
  fi
  done
  
  for file in ${War_Jar_Backup_Path}/*; do
  extension="${file##*.}"
  if [ "$extension" == "tar" ]; then
   echo "tar file is going to extract"
  tar -zxvf ${War_Jar_Backup_Path}/${file##*/} -C ${War_Jar_Backup_Path}
  echo ${file##*/}
  echo "file in process"
  echo "tar file extraction completed successfully"
  echo "=================================================================="
  echo "=================================================================="
  fi
  done

echo "=================================================================="


for file in ${War_Jar_Backup_Path}/*; do
  extension="${file##*.}"
 
  if [ "$extension" == "jar" ]; then
  if [ "gtnServicePartI-1.0.jar" == "${file##*/}" ];then
  cp ${War_Jar_Backup_Path}/${file##*/} ${Base_Path}/${Server_Name}/jboss-7.1.1/modules/common/service/partone/main
  chmod -R 777 ${Base_Path}/${Server_Name}/jboss-7.1.1/modules/common/service/partone/main/${file##*/}
  echo "file in process"
  fi
  if [ "gtnServicePartII-1.0.jar" == "${file##*/}" ];then
  cp ${War_Jar_Backup_Path}/${file##*/} ${Base_Path}/${Server_Name}/jboss-7.1.1/modules/common/service/parttwo/main
  chmod -R 777 ${Base_Path}/${Server_Name}/jboss-7.1.1/modules/common/service/parttwo/main/${file##*/}
  echo "file in process"
  fi
  if [ "gtnProperties.jar" == "${file##*/}" ];then
  cp ${War_Jar_Backup_Path}/${file##*/} ${Base_Path}/${Server_Name}/jboss-7.1.1/applicationProperties
  chmod -R 777 ${Base_Path}/${Server_Name}/jboss-7.1.1/applicationProperties/${file##*/}
  echo "file in process"
  fi
  echo "Jar files have been processed"
  echo "==============${file##*/}================="
  fi
done

echo "==============================================================================================================================="
echo "BPI GTN App installation process has been Completed"
echo "==============================================================================================================================="

}

do_ETL_installation(){

echo "==============================================================================================================================="
echo "ETL installation process has been Started"
echo "==============================================================================================================================="

cp ${Backup_Path}/GTN_ETL_Build.tar.gz ${Base_Path}/${Server_Name}/etl
echo "GTN_ETL_Build.tar.gz file has been copied from backup folder"
echo "====================================================================================="
tar -zxvf ${Base_Path}/${Server_Name}/etl/GTN_ETL_Build.tar.gz -C ${Base_Path}/${Server_Name}/etl
echo "GTN_ETL_Build.tar.gz file has been extract from etl folder"
echo "====================================================================================="
rm -f ${Base_Path}/${Server_Name}/etl/GTN_ETL_Build.tar.gz
echo "GTN_ETL_Build.tar.gz file has been deleted from etl folder"
echo "====================================================================================="

echo "==============================================================================================================================="
echo "ETL installation process has been completed"
echo "==============================================================================================================================="

}

do_Service_Startup_installation(){

echo "==============================================================================================================================="
echo "Service Startup installation process has been Started"
echo "==============================================================================================================================="

cp ${Backup_Path}/GTN_Service_Script.tar.gz /etc/"init.d"
echo "GTN_Service_Script.tar.gz file has been copied from backup folder"
echo "====================================================================================="
tar -zxvf /etc/"init.d"/GTN_Service_Script.tar.gz -C /etc/"init.d"
echo "GTN_Service_Script.tar.gz file has been extract from init.d folder"
echo "====================================================================================="
rm -f /etc/"init.d"/GTN_Service_Script.tar.gz
echo "GTN_Service_Script.tar.gz file has been deleted from init.d folder"
echo "====================================================================================="
mv /etc/"init.d"/bpigtn /etc/"init.d"/${Server_Name}
echo "bpigtn of service name has been changed to ${Server_Name}"
echo "====================================================================================="

echo "==============================================================================================================================="
echo "Service Startup installation process has been completed"
echo "==============================================================================================================================="

}

do_Standalone_xml_Config(){

echo "==============================================================================================================================="
echo "standalone.xml file configuration process has been Started"
echo "==============================================================================================================================="
chmod 777 ${Base_Path}/${Server_Name}/jboss-7.1.1/standalone/configuration/standalone.xml
FILE="${Base_Path}/${Server_Name}/jboss-7.1.1/standalone/configuration/standalone.xml"
echo "*** File - $FILE contents ***"
echo "====================================================================================="
$FILE | sed -i 's@Base_Path@'"$Base_Path"'@g' $FILE
echo "Base_Path string has been changed to ${Base_Path} in standalone-1.xml"
echo "====================================================================================="
$FILE | sed -i 's/Server_Name/'${Server_Name}'/g' $FILE
echo "Server_Name string has been changed to ${Server_Name} in standalone-1.xml"
echo "====================================================================================="
$FILE | sed -i 's/DB_IP/'${DB_IP}'/g' $FILE
echo "DB_IP IP has been changed to ${DB_IP} in standalone-1.xml"
echo "====================================================================================="
$FILE | sed -i 's/DB_User_Name/'${DB_User_Name}'/g' $FILE
echo "DB_User_Name string has been changed to ${DB_User_Name} in standalone-1.xml"
echo "====================================================================================="
$FILE | sed -i 's/DB_Password/'${DB_Password}'/g' $FILE
echo "DB_Password string has been changed to ${DB_Password} in standalone-1.xml"
echo "====================================================================================="
$FILE | sed -i 's/DB_APP_TST_Name/'${DB_APP_TST_Name}'/g' $FILE
echo "DB_APP_TST_Name string has been changed to ${DB_APP_TST_Name} in standalone-1.xml"
echo "====================================================================================="
$FILE | sed -i 's/DB_SYS_TST_Name/'${DB_SYS_TST_Name}'/g' $FILE
echo "DB_SYS_TST_Name string has been changed to ${DB_SYS_TST_Name} in standalone-1.xml"
echo "====================================================================================="
$FILE | sed -i 's/DB_BPM_TST_Name/'${DB_BPM_TST_Name}'/g' $FILE
echo "DB_BPM_TST_Name string has been changed to $DB_BPM_TST_Name in standalone-1.xml"
echo "====================================================================================="

echo "==============================================================================================================================="
echo "standalone.xml file configuration process has been completed"
echo "==============================================================================================================================="

}

do_Service_file_Config(){

echo "==============================================================================================================================="
echo "Service file configuration process has been Started"
echo "==============================================================================================================================="
chmod 777 /etc/"init.d"/${Server_Name}
Service_FILE="/etc/"init.d"/${Server_Name}"
echo "*** Service_FILE - $Service_FILE contents ***"
echo "====================================================================================="
$Service_FILE | sed -i 's/Server_Name/'${Server_Name}'/g' $Service_FILE
echo "Server_Name string has been changed to ${Server_Name} in ${Server_Name} of service file"
echo "====================================================================================="
$Service_FILE | sed -i 's@Base_Path@'"$Base_Path"'@g' $Service_FILE
echo "Base_Path string has been changed to ${Base_Path} in ${Server_Name} of service file"
echo "====================================================================================="

chmod 777 ${Base_Path}/${Server_Name}/conf/jboss-as2/jboss-as.conf
Jboss_FILE="${Base_Path}/${Server_Name}/conf/jboss-as2/jboss-as.conf"
echo "*** Jboss_FILE - $Jboss_FILE contents ***"
echo "====================================================================================="
$Jboss_FILE | sed -i 's/Server_Name/'${Server_Name}'/g' $Jboss_FILE
echo "Server_Name string has been changed to ${Base_Path}/${Server_Name} in jboss-as.conf"
echo "====================================================================================="
$Jboss_FILE | sed -i 's@Base_Path@'"$Base_Path"'@g' $Jboss_FILE
echo "Base_Path string has been changed to ${Base_Path} in jboss-as.conf"
echo "====================================================================================="

echo "==============================================================================================================================="
echo "Service file configuration process has been completed"
echo "==============================================================================================================================="

}

do_BPI_ETL_conf(){

echo "==============================================================================================================================="
echo "ETL Configuration process has been Started"
echo "==============================================================================================================================="
chmod 777 ${Base_Path}/${Server_Name}/conf/"BPI Configuration"/FTPConfiguration.properties
DB_FILE="${Base_Path}/${Server_Name}/conf/"BPI Configuration"/FTPConfiguration.properties"
echo "*** DB_FILE - $DB_FILE contents ***"
echo "====================================================================================="
${Base_Path}/${Server_Name}/conf/BPI\ Configuration/FTPConfiguration.properties | sed -i 's/Server_Name/'${Server_Name}'/g' ${Base_Path}/${Server_Name}/conf/BPI\ Configuration/FTPConfiguration.properties
echo "Server_Name string has been changed to ${Base_Path}/${Server_Name} in FTPConfiguration.properties"
echo "====================================================================================="
${Base_Path}/${Server_Name}/conf/BPI\ Configuration/FTPConfiguration.properties | sed -i 's@Base_Path@'"$Base_Path"'@g' ${Base_Path}/${Server_Name}/conf/BPI\ Configuration/FTPConfiguration.properties
echo "Base_Path string has been changed to ${Base_Path} in FTPConfiguration.properties"
echo "====================================================================================="

chmod 777 ${Base_Path}/${Server_Name}/etl/Interface_Job/EtlConfiguration.properties
DB_etl_FILE="${Base_Path}/${Server_Name}/etl/Interface_Job/EtlConfiguration.properties"
echo "*** DB_etl_FILE - $DB_etl_FILE contents ***"
echo "====================================================================================="
$DB_etl_FILE | sed -i 's@Base_Path@'"$Base_Path"'@g' $DB_etl_FILE
echo "Base_Path string has been changed to ${Base_Path} in EtlConfiguration.properties"
echo "====================================================================================="
$DB_etl_FILE | sed -i 's/Server_Name/'${Server_Name}'/g' $DB_etl_FILE
echo "Server_Name string has been changed to ${Server_Name} in EtlConfiguration.properties"
echo "====================================================================================="
$DB_etl_FILE | sed -i 's/DB_IP/'${DB_IP}'/g' $DB_etl_FILE
echo "DB_IP IP has been changed to ${DB_IP} in EtlConfiguration.properties"
echo "====================================================================================="
$DB_etl_FILE | sed -i 's/DB_User_Name/'${DB_User_Name}'/g' $DB_etl_FILE
echo "DB_User_Name string has been changed to ${DB_User_Name} in EtlConfiguration.properties"
echo "====================================================================================="
$DB_etl_FILE | sed -i 's/DB_Password/'${DB_Password}'/g' $DB_etl_FILE
echo "DB_Password string has been changed to ${DB_Password} in EtlConfiguration.properties"
echo "====================================================================================="
$DB_etl_FILE | sed -i 's/DB_APP_TST_Name/'${DB_APP_TST_Name}'/g' $DB_etl_FILE
echo "DB_APP_TST_Name string has been changed to ${DB_APP_TST_Name} in EtlConfiguration.properties"
echo "====================================================================================="
$DB_etl_FILE | sed -i 's/DB_SYS_TST_Name/'${DB_SYS_TST_Name}'/g' $DB_etl_FILE
echo "DB_SYS_TST_Name string has been changed to ${DB_SYS_TST_Name} in EtlConfiguration.properties"
echo "====================================================================================="
$DB_etl_FILE | sed -i 's/DB_STG_TST_Name/'${DB_STG_TST_Name}'/g' $DB_etl_FILE
echo "DB_STG_TST_Name string has been changed to ${DB_STG_TST_Name} in EtlConfiguration.properties"
echo "====================================================================================="
$DB_etl_FILE | sed -i 's/DB_BPI_PASSPHRASE/'${DB_BPI_PASSPHRASE}'/g' $DB_etl_FILE
echo "DB_BPI_PASSPHRASE string has been changed to ${DB_BPI_PASSPHRASE} in EtlConfiguration.properties"
echo "====================================================================================="
$DB_etl_FILE | sed -i 's/ETL_port_Num/'${ETL_port_Num}'/g' $DB_etl_FILE
echo "ETL_port_Num string has been changed to ${ETL_port_Num} in EtlConfiguration.properties"
echo "====================================================================================="


echo "==============================================================================================================================="
echo "ETL configuration process has been completed"
echo "==============================================================================================================================="

}

do_BPI_DB_App_Schema(){

Schema_name=App_Schema
fold=Sql_Script

#echo "${DB_Backup_Path}"
if [ -d "${DB_Backup_Path}" ]; then
  echo "${DB_Backup_Path} path exists"
  else
  echo "${DB_Backup_Path} path does not exists"
  exit 1
fi

#echo ${BPI_PASSWORD}
pass="$(echo ${BPI_PASSWORD} | openssl enc -base64 -d)"

x=$(find ${DB_Backup_Path}/$Schema_name/$fold/ -type f -name "*.sql" -o -name "*.sh" |sort)
for  filename in $x
do
DATE=`date +%Y-%m-%d:%H:%M:%S`
LOGDATE=`date +%Y-%m-%d`
log_file="${DB_Backup_Path}/$Schema_name/$fold/Log_"$fold"_$LOGDATE.log"
#echo $DATE
echo "$filename.."
echo "INFO $DATE Executing file $filename...">>$log_file
sqlcmd  -b -I -U ${BPI_USER} -P $pass -S ${BPI_HOST} -d ${BPI_DB} -i $filename  -b -m-1 1>>$log_file 
if [ $? -eq 1 ]
then
echo "ERROR $DATE Error in Executing file $filename...">>$log_file
else 
echo "INFO $DATE Successfully Executed file $filename...">>$log_file
fi
done

}

do_BPI_DB_Staging_Schema(){

Schema_name=Staging_Schema
fold=Sql_Script

#echo "${DB_Backup_Path}"
if [ -d "${DB_Backup_Path}" ]; then
  echo "${DB_Backup_Path} path exists"
  else
  echo "${DB_Backup_Path} path does not exists"
  exit 1
fi

#echo ${BPI_PASSWORD}
pass="$(echo ${BPI_PASSWORD} | openssl enc -base64 -d)"

x=$(find ${DB_Backup_Path}/$Schema_name/$fold/ -type f -name "*.sql" -o -name "*.sh" |sort)
for  filename in $x
do
DATE=`date +%Y-%m-%d:%H:%M:%S`
LOGDATE=`date +%Y-%m-%d`
log_file="${DB_Backup_Path}/$Schema_name/$fold/Log_"$fold"_$LOGDATE.log"
#echo $DATE
echo "$filename.."
echo "INFO $DATE Executing file $filename...">>$log_file
sqlcmd  -b -I -U ${BPI_USER} -P $pass -S ${BPI_HOST} -d ${BPI_STAGING_DB} -i $filename  -b -m-1 1>>$log_file 
if [ $? -eq 1 ]
then
echo "ERROR $DATE Error in Executing file $filename...">>$log_file
else 
echo "INFO $DATE Successfully Executed file $filename...">>$log_file
fi
done

}


do_Initial_Config
do_Environment_Config
do_JBoss_Config
do_Database_Config
do_BPI_GTN_App_installation
do_ETL_installation
do_Service_Startup_installation
do_Standalone_xml_Config
do_Service_file_Config
do_BPI_ETL_conf
do_BPI_DB_Staging_Schema
do_BPI_DB_App_Schema
exit

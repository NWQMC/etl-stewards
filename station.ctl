load data
infile *
into table ars_raw_station
truncate
(file_name char(100)
,load_timestamp expression "current_timestamp"
,raw_xml LOBFILE (file_name characterset UTF8) TERMINATED BY EOF
)
begindata
/opt/tomcat/.jenkins/ars_stewards/station.xml
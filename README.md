# etl\-stewards

[![Codacy Badge](https://api.codacy.com/project/badge/Grade/92fd891cf75846cda0a5a817e2d7ebc7)](https://app.codacy.com/app/usgs_wma_dev/etl-stewards?utm_source=github.com&utm_medium=referral&utm_content=NWQMC/etl-stewards&utm_campaign=Badge_Grade_Settings)

[![Build Status](https://travis-ci.org/NWQMC/etl-stewards.svg?branch=master)](https://travis-ci.org/NWQMC/etl-stewards)

ETL Water Quality Data from the ARS Stewards (USDA) System

## Development
This is a Spring Batch/Boot project. All of the normal caveats relating to a Spring Batch/Boot application apply.

### Dependencies
This application utilizes a PostgreSQL database. The Docker Hub image usgswma/wqp_db:etl can be used for testing.

### Environment variables
Create an application.yml file in the project directory containing the following (shown are example values - they should match the values you used in creating the etlDB):

```yml
WQP_DATABASE_ADDRESS: localhost
WQP_DATABASE_PORT: 5437
WQP_DATABASE_NAME: wqp_db
WQP_SCHEMA_NAME: wqp
WQP_SCHEMA_OWNER_USERNAME: wqp_core
WQP_SCHEMA_OWNER_PASSWORD: changeMe

ARS_DATABASE_ADDRESS: localhost
ARS_DATABASE_PORT: 5437
ARS_DATABASE_NAME: wqp_db
ARS_SCHEMA_NAME: ars
ARS_SCHEMA_OWNER_USERNAME: ars_owner
ARS_SCHEMA_OWNER_PASSWORD: changeMe

NWIS_DATABASE_ADDRESS: localhost
NWIS_DATABASE_PORT: 5437
NWIS_DATABASE_NAME: wqp_db
NWIS_SCHEMA_OWNER_USERNAME: nwis_ws_star
NWIS_SCHEMA_OWNER_PASSWORD: changeMe

ETL_OWNER_USERNAME: ars_owner
GEO_SCHEMA_NAME: nwis
ETL_DATA_SOURCE_ID: 1
ETL_DATA_SOURCE: STEWARDS
QWPORTAL_SUMMARY_ETL: false
NWIS_OR_EPA:
```

#### Environment variable definitions
##### WQP Schema
*   **WQP_DATABASE_ADDRESS** - Host name or IP address of the PostgreSQL database.
*   **WQP_DATABASE_PORT** - Port the PostgreSQL Database is listening on.
*   **WQP_DATABASE_NAME** - Name of the PostgreSQL database containing the schema.
*   **WQP_SCHEMA_NAME** - Name of the schema holding database objects.
*   **WQP_SCHEMA_OWNER_USERNAME** - Role which owns the database objects.
*   **WQP_SCHEMA_OWNER_PASSWORD** - Password for the **WQP_SCHEMA_OWNER_USERNAME** role.

##### ARS Schema
*   **ARS_DATABASE_ADDRESS** - Host name or IP address of the PostgreSQL database.
*   **ARS_DATABASE_PORT** - Port the PostgreSQL Database is listening on.
*   **ARS_DATABASE_NAME** - Name of the PostgreSQL database containing the schema.
*   **ARS_SCHEMA_OWNER_USERNAME** - Role which owns the **ARS_SCHEMA_NAME** database objects.
*   **ARS_SCHEMA_OWNER_PASSWORD** - Password for the **ARS_SCHEMA_OWNER_USERNAME** role.

##### NWIS Schema
*   **NWIS_DATABASE_ADDRESS** - Host name or IP address of the PostgreSQL database.
*   **NWIS_DATABASE_PORT** - Port the PostgreSQL Database is listening on.
*   **NWIS_DATABASE_NAME** - Name of the PostgreSQL database containing the schema.
*   **NWIS_SCHEMA_OWNER_USERNAME** - Role which owns the **NWIS_SCHEMA_NAME** database objects.
*   **NWIS_SCHEMA_OWNER_PASSWORD** - Password for the **NWIS_SCHEMA_OWNER_USERNAME** role.

##### Result Table Partitioning
This group of parameters is used to configure how the DateRangePartitionStrategy creates partitions - All values optional.
Currently this is only used by the Result table.  This strategy creates sets of partitions in these groups:
* From antiquity to the startDate
* From the startDate to oneYearBreak in partition tables containing five years each
* From oneYearBreak to quarterBreak in one year partitions
* From quarterBreak to endDate (and beyond) in quarter (three month) partitions.

The 'breaks' between those partition groups are based on the optional params, below, with DATE using ISO format: 'YYYY-MM-DD':
*   **ETL_RESULT_PARTITION_START_DATE** - The start date of partitions (earlier dates are included in the first partition via 'minvalue').
    If null, set to 65 years before the calculated end date.  Always adjusted to Jan 1 of a year divisible by 5.
*   **ETL_RESULT_PARTITION_ONE_YEAR_BREAK** - From start date to 'one_year' is partitioned into 5 year partitions.
    From 'one_year' to 'quarter' is partition into one year tables.  If null, set to 1/3 the way from 'start' to 'quarter'.
    Always adjusted to Jan 1 of a year divisible by 5.
*   **ETL_RESULT_PARTITION_QUARTER_BREAK** - From 'quarter' to 'end', tables are partitioned as 3 month quarters.
    If null, it is set to Jan 1 of the year before the calculated end date.  Always adjusted to Jan 1.
*   **ETL_RESULT_PARTITION_END_DATE** - Dates from this date and into the future are thrown into the last 'quarter'
    partition via 'maxvalue'.  If null, the run time of the job is used (or ETL_RUN_TIME).
*   **ETL_RUN_TIME** - The run time of the ETL job.  Don't specify this unless running tests.
    Partition tables are assigned a unique name based on the run time of the ETL, thus, for repeatable testing this param
    allows a known time to create known table names.  Don't use in production or table names will collide.
    ISO format:  'YYYY-MM-DDTHH-MM-SS'.

See DateRangePartitionStrategy.calcRuntimeConfig for how missing values are filled in and details on the default strategy.

##### Miscellaneous
*   **ETL_OWNER_USERNAME** - Role which owns the source schema database objects.
*   **GEO_SCHEMA_NAME** - Name of the schema holding geospatial lookup database objects.
*   **ETL_DATA_SOURCE_ID** - Database ID of the data_source (data_source_id from the **WQP_SCHEMA_NAME**.data_source table).
*   **ETL_DATA_SOURCE** - Data Source name (text from the **WQP_SCHEMA_NAME**.data_source table).
*   **QWPORTAL_SUMMARY_ETL** - Does the ETL populate the qwportal_summary table? true or false.
*   **NWIS_OR_EPA** - If **QWPORTAL_SUMMARY_ETL** is true, is this an NIWS (N) or STORET WQX (E) ETL.
*   **DB_OPERATION_CONCURRENCY** - Some operations against the db have been parallelized to have SpringBatch
    run multiple concurrent operations against the db, e.g. creating multiple indexes at the same time.  This controls
    the number of paralle operations.  Ensure there are enough db connections to support at least as many. Defaults to 3.
### Testing
This project contains JUnit tests. Maven can be used to run them (in addition to the capabilities of your IDE).

To run the unit tests of the application use:

```shell
mvn package
```

To additionally start up a Docker database and run the integration tests of the application use:

```shell
mvn verify -DTESTING_DATABASE_PORT=5437 -DTESTING_DATABASE_ADDRESS=localhost -DTESTING_DATABASE_NETWORK=wqpEtlCore
```

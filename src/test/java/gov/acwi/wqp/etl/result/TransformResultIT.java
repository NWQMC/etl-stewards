package gov.acwi.wqp.etl.result;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.fail;

import org.junit.jupiter.api.Disabled;
import org.junit.jupiter.api.Test;
import org.springframework.batch.core.ExitStatus;
import org.springframework.batch.core.Job;
import org.springframework.batch.core.JobExecution;
import org.springframework.batch.core.job.flow.Flow;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;

import com.github.springtestdbunit.annotation.DatabaseSetup;
import com.github.springtestdbunit.annotation.ExpectedDatabase;
import com.github.springtestdbunit.assertion.DatabaseAssertionMode;

import gov.acwi.wqp.etl.ArsBaseFlowIT;
import org.springframework.test.context.TestPropertySource;

//See ConfigurationService:
//Env. Config params to control how result partitions are created, ensuring the partition structure is known & repeatable.
//ETL_RUN_TIME is used to construct unique partition names and overrides the actual runTime of the ETL job.
@TestPropertySource(properties = {"ETL_RESULT_PARTITION_START_DATE=1995-01-01",
                                  "ETL_RESULT_PARTITION_ONE_YEAR_BREAK=2020-01-01",
                                  "ETL_RESULT_PARTITION_QUARTER_BREAK=2020-01-01",
                                  "ETL_RESULT_PARTITION_END_DATE=2020-01-01",
                                  "ETL_RUN_TIME=2021-01-01T10:15:30"})
public class TransformResultIT extends ArsBaseFlowIT {

	public static final String TABLE_NAME = "'result_swap_stewards'";
	public static final String EXPECTED_DATABASE_QUERY_ANALYZE = BASE_EXPECTED_DATABASE_QUERY_ANALYZE + TABLE_NAME;
	public static final String EXPECTED_DATABASE_QUERY_PRIMARY_KEY = BASE_EXPECTED_DATABASE_QUERY_PRIMARY_KEY
			+ EQUALS_QUERY + TABLE_NAME;
	public static final String EXPECTED_DATABASE_QUERY_FOREIGN_KEY = BASE_EXPECTED_DATABASE_QUERY_FOREIGN_KEY
			+ EQUALS_QUERY + TABLE_NAME;

	@Autowired
	@Qualifier("resultFlow")
	private Flow resultFlow;

	private Job setupFlowTestJob() {
		return jobBuilderFactory.get("resultFlowTest").start(resultFlow).build().build();
	}

	@Test
	@DatabaseSetup(value="classpath:/testResult/stewards/result/empty.xml")
	@DatabaseSetup(value="classpath:/testResult/stewards/activity/activity.xml")
	@DatabaseSetup(connection=CONNECTION_ARS, value="classpath:/testResult/ars/arsResult/arsResult.xml")
	@DatabaseSetup(connection=CONNECTION_ARS, value="classpath:/testData/ars/charNameToType.xml")
	@ExpectedDatabase(value="classpath:/testResult/stewards/result/result.xml", assertionMode=DatabaseAssertionMode.NON_STRICT_UNORDERED)
	public void transformResultStepTest() {
		jobLauncherTestUtils.setJob(setupFlowTestJob());
		try {
			JobExecution jobExecution = jobLauncherTestUtils.launchStep("transformResultStep", testJobParameters);
			assertEquals(ExitStatus.COMPLETED, jobExecution.getExitStatus());
		} catch (Exception e) {
			e.printStackTrace();
			fail(e.getLocalizedMessage());
		}
	}

	/* EE:  Due to how indexing works on PG11 vs PG12, this test fails w/ the newly partitioned result table. */
	@Disabled
	@Test
	@DatabaseSetup(value="classpath:/testData/stewards/result/resultOld.xml")
	@DatabaseSetup(value="classpath:/testResult/stewards/activity/activity.xml")
	@DatabaseSetup(value="classpath:/testResult/stewards/monitoringLocation/monitoringLocation.xml")
	@DatabaseSetup(connection=CONNECTION_ARS, value="classpath:/testResult/ars/arsResult/arsResult.xml")
	@DatabaseSetup(connection=CONNECTION_ARS, value="classpath:/testData/ars/charNameToType.xml")
	@ExpectedDatabase(value="classpath:/testResult/stewards/result/result.xml", assertionMode=DatabaseAssertionMode.NON_STRICT_UNORDERED)
	@ExpectedDatabase(
			connection=CONNECTION_INFORMATION_SCHEMA,
			value="classpath:/testResult/stewards/result/create.xml",
			assertionMode=DatabaseAssertionMode.NON_STRICT_UNORDERED,
			table=EXPECTED_DATABASE_TABLE_CHECK_TABLE,
			query=BASE_EXPECTED_DATABASE_QUERY_CHECK_TABLE + TABLE_NAME)
	@ExpectedDatabase(
			value="classpath:/testResult/stewards/result/indexes/all.xml",
			assertionMode=DatabaseAssertionMode.NON_STRICT_UNORDERED,
			table=EXPECTED_DATABASE_TABLE_CHECK_INDEX
			, query=BASE_EXPECTED_DATABASE_QUERY_CHECK_INDEX + TABLE_NAME)
	@ExpectedDatabase(value="classpath:/testResult/stewards/result/result.xml", assertionMode=DatabaseAssertionMode.NON_STRICT_UNORDERED)
	@ExpectedDatabase(
			value="classpath:/testResult/stewards/analyze/result.xml",
			assertionMode=DatabaseAssertionMode.NON_STRICT_UNORDERED,
			table=EXPECTED_DATABASE_TABLE_CHECK_ANALYZE,
			query=EXPECTED_DATABASE_QUERY_ANALYZE)
	@ExpectedDatabase(
			value="classpath:/testResult/stewards/result/primaryKey.xml",
			assertionMode=DatabaseAssertionMode.NON_STRICT_UNORDERED,
			table=EXPECTED_DATABASE_TABLE_CHECK_PRIMARY_KEY,
			query=EXPECTED_DATABASE_QUERY_PRIMARY_KEY)
	@ExpectedDatabase(
			value="classpath:/testResult/stewards/result/foreignKey.xml",
			assertionMode=DatabaseAssertionMode.NON_STRICT_UNORDERED,
			table=EXPECTED_DATABASE_TABLE_CHECK_FOREIGN_KEY,
			query=EXPECTED_DATABASE_QUERY_FOREIGN_KEY)
	public void resultFlowTest() {
		jobLauncherTestUtils.setJob(setupFlowTestJob());
		jdbcTemplate.execute("select add_monitoring_location_primary_key('stewards', 'wqp', 'station')");
		try {
			JobExecution jobExecution = jobLauncherTestUtils.launchJob(testJobParameters);
			assertEquals(ExitStatus.COMPLETED, jobExecution.getExitStatus());
			Thread.sleep(1000);
		} catch (Exception e) {
			e.printStackTrace();
			fail(e.getLocalizedMessage());
		}
	}

}

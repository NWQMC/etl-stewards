package gov.acwi.wqp.etl;

import org.junit.runner.RunWith;
import org.springframework.batch.test.StepScopeTestExecutionListener;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase.Replace;
import org.springframework.test.context.TestExecutionListeners;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.test.context.support.DependencyInjectionTestExecutionListener;

@RunWith(SpringRunner.class)
//@ActiveProfiles({"default", "it", "batchtest"})
@TestExecutionListeners({ DependencyInjectionTestExecutionListener.class,
	StepScopeTestExecutionListener.class
//	DirtiesContextTestExecutionListener.class,
//	TransactionalTestExecutionListener.class,
//	TransactionDbUnitTestExecutionListener.class
	})
//@DbUnitConfiguration(dataSetLoader=ColumnSensingFlatXMLDataSetLoader.class)
@AutoConfigureTestDatabase(replace=Replace.AUTO_CONFIGURED)
public abstract class BaseIT {

}

package gov.acwi.wqp.etl;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.ClassPathResource;
import org.springframework.jdbc.datasource.init.DatabasePopulator;
import org.springframework.jdbc.datasource.init.ResourceDatabasePopulator;

@Configuration
public class DBTestConfig {
//	@Autowired
//	ResourcelessTransactionManager transactionManager;

//	@Bean
//	public DataSource dataSource() {
//	    EmbeddedDatabaseBuilder embeddedDatabaseBuilder = new EmbeddedDatabaseBuilder();
//	    return embeddedDatabaseBuilder.addScript("classpath:org/springframework/batch/core/schema-drop-h2.sql")
//	            .addScript("classpath:org/springframework/batch/core/schema-h2.sql")
//	            .setType(EmbeddedDatabaseType.HSQL)
//	            .build();
//	}
//	@Bean
//	EmbeddedDatabaseFactory embeddedDatabaseFactory(EmbeddedDatabaseFactory embeddedDatabaseFactory) {
//		DatabasePopulator x = new ResourceDatabasePopulator(new ClassPathResource("classpath:org/springframework/batch/core/schema-h2.sql"));
//		embeddedDatabaseFactory.setDatabasePopulator(x);
//		return embeddedDatabaseFactory;
//	}

//	@Bean
//	DatabasePopulator databasePopulator() {
//		return new ResourceDatabasePopulator(new ClassPathResource("classpath:org/springframework/batch/core/schema-h2.sql"));
//	}

//	@Bean
//	public ResourcelessTransactionManager transactionManager() {
//	    return new ResourcelessTransactionManager();
//	}

//	@Bean
//	public JobRepository jobRepository() throws Exception {
//	    JobRepositoryFactoryBean factory = new JobRepositoryFactoryBean();
//	    factory.setDatabaseType(DatabaseType.H2.getProductName());
//	    factory.setDataSource(dataSource());
//	    factory.setTransactionManager(transactionManager);
//	    return factory.getObject();
//	}

}

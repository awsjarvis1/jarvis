package com.jarvis.remedy;

import java.sql.Types;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;

import com.jarvis.model.remedy.Issues;
import com.jarvis.model.remedy.ServiceRequest;

@Component
public class BugTracker {

	@Autowired
	private JdbcTemplate jdbcTemplate;

	public Issues viewServiceRequests(String userName) {
		Issues issues = new Issues();
		issues.setServiceRequest(getServiceRequests(userName));
		return issues;
	}

	public String createServiceRequest(String reportedBy, String problemType, String product, String date) {
		String serviceRequestNumber = getSRCount().toString();
		insertServiceRequest(serviceRequestNumber, reportedBy, problemType, product, date);
		return serviceRequestNumber;
	}

	private Integer getSRCount() {

		String sql = "SELECT COUNT(sr_no) FROM JARVIS_SCHEMA.SERVICE_REQUEST";
		// String sql = "SELECT COUNT(sr_no) FROM SERVICE_REQUEST";
		Integer row = jdbcTemplate.queryForObject(sql, Integer.class);
		return row + 1;
	}

	private List<ServiceRequest> getServiceRequests(String userName) {

		List<ServiceRequest> result = jdbcTemplate.query(
				"SELECT SR_NO, PRODUCT, PROBLEM_TYPE, DATE FROM JARVIS_SCHEMA.SERVICE_REQUEST WHERE REPORTED_BY = ?",
				new Object[] { userName }, (rs, rowNum) -> new ServiceRequest(userName, rs.getString("SR_NO"),
						rs.getString("PROBLEM_TYPE"), rs.getString("PRODUCT"), rs.getString("DATE")));

		return result;
	}

	private int insertServiceRequest(String sr_no, String reported_by, String problem_type, String product,
			String date) {
		String sql = "INSERT INTO JARVIS_SCHEMA.SERVICE_REQUEST VALUES(?,?,?,?,?)";
		// String sql = "INSERT INTO SERVICE_REQUEST VALUES(?,?,?,?,?)";
		Object[] obj = new Object[] { sr_no, reported_by, problem_type, product, date };
		int[] types = new int[] { Types.VARCHAR, Types.VARCHAR, Types.VARCHAR, Types.VARCHAR, Types.VARCHAR };
		int row = jdbcTemplate.update(sql, obj, types);
		return row;
	}
}

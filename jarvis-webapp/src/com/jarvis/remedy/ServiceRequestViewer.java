package com.jarvis.remedy;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebInitParam;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.jarvis.model.ServiceRequest;

/**
 * Servlet implementation class ServiceRequestViewer
 */

@WebServlet(urlPatterns = "/viewSR", initParams = { @WebInitParam(name = "db_url", value = "jdbc:mysql://jarvisdb.cc6xxahk0j9u.us-east-2.rds.amazonaws.com:3306/JARVIS_SCHEMA"),
		@WebInitParam(name = "db_username", value = "jarvisdb"), @WebInitParam(name = "db_password", value = "password123"),
		@WebInitParam(name = "db_drivername", value = "com.mysql.jdbc.Driver") })
public class ServiceRequestViewer extends HttpServlet {

	private static final long serialVersionUID = 1L;

	private String dbUrl;
	private String dbUserName;
	private String dbPassword;
	private String dbDriverName;

	public void init() throws ServletException {
		ServletConfig servletConfig = getServletConfig();
		dbUrl = servletConfig.getInitParameter("db_url");
		dbUserName = servletConfig.getInitParameter("db_username");
		dbPassword = servletConfig.getInitParameter("db_password");
		dbDriverName = servletConfig.getInitParameter("db_drivername");
	}

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ServiceRequestViewer() {
		super();
		// TODO Auto-generated constructor stub
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		Connection connection = null;
		Statement statment = null;
		ResultSet resultSet = null;

		try {
			Class.forName(dbDriverName);
			connection = DriverManager.getConnection(dbUrl, dbUserName, dbPassword);
			statment = connection.createStatement();

			HttpSession session = request.getSession();
			String userName = (String) session.getAttribute("user");

			resultSet = statment.executeQuery("select * from JARVIS_SCHEMA.service_request where reported_by = '" + userName + "'");

			ArrayList<ServiceRequest> serviceRequestList = new ArrayList<>();

			while (resultSet.next()) {
				ServiceRequest serviceRequest = new ServiceRequest();
				serviceRequest.setServiceReqNo(resultSet.getString("SR_NO"));
				serviceRequest.setReportedBy(resultSet.getString("REPORTED_BY"));
				serviceRequest.setProblemType(resultSet.getString("PROBLEM_TYPE"));
				serviceRequest.setProduct(resultSet.getString("PRODUCT"));
				serviceRequest.setDate(resultSet.getString("DATE"));

				serviceRequestList.add(serviceRequest);
			}

			session.setAttribute("sr-details", serviceRequestList);
			System.out.println("SR Details: " + serviceRequestList);

		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {

			try {
				if (resultSet != null) {
					resultSet.close();
				}

				if (statment != null) {
					statment.close();
				}

				if (connection != null) {
					connection.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
}

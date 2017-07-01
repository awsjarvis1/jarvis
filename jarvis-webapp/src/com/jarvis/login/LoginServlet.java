package com.jarvis.login;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebInitParam;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.Properties;
import com.jarvis.model.Account;

/**
 * Servlet implementation class LoginServlet
 */

@WebServlet(urlPatterns = "/login", initParams = { @WebInitParam(name = "db_url", value = "jdbc:mysql://jarvisdb.cc6xxahk0j9u.us-east-2.rds.amazonaws.com:3306/JARVIS_SCHEMA"),
		@WebInitParam(name = "db_username", value = "jarvisdb"), @WebInitParam(name = "db_password", value = "password123"),
		@WebInitParam(name = "db_drivername", value = "com.mysql.jdbc.Driver") })

public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private String dbUrl;
	private String dbUserName;
	private String dbPassword;
	private String dbDriverName;
	private String logUrl;
	private String imageUrl;

	public void init() throws ServletException {
		ServletConfig servletConfig = getServletConfig();
		dbUrl = servletConfig.getInitParameter("db_url");
		dbUserName = servletConfig.getInitParameter("db_username");
		dbPassword = servletConfig.getInitParameter("db_password");
		dbDriverName = servletConfig.getInitParameter("db_drivername");
		
		Connection connection = null;
		Statement statment = null;
		ResultSet resultSet = null;
		
		try{
			Class.forName(dbDriverName);
			connection = DriverManager.getConnection(dbUrl, dbUserName, dbPassword);
			statment = connection.createStatement();
			resultSet = statment.executeQuery("select * from JARVIS_SCHEMA.EUREKA");

			while (resultSet.next()) {
			  logUrl = resultSet.getString("LOG_URL");
			  imageUrl = resultSet.getString("IMAGE_URL");
			}
		
	
		} catch(Exception e) {
			e.printStackTrace();
			
		}finally {
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

	private Account getAccountFromCredentials(String username) {

		Account account = new Account();
		Connection connection = null;
		Statement statment = null;
		ResultSet resultSet = null;

		try {
			Class.forName(dbDriverName);
			connection = DriverManager.getConnection(dbUrl, dbUserName, dbPassword);
			statment = connection.createStatement();
			resultSet = statment.executeQuery("select * from JARVIS_SCHEMA.ACCOUNT where user = '" + username + "'");

			while (resultSet.next()) {
				account.setPassword(resultSet.getString("password"));
			}

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

		return account;
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
				
		System.out.println("image : " + imageUrl);
		System.out.println("log : " + logUrl);
		
		String userName = request.getParameter("userName");
		String password = request.getParameter("password");

		System.out.println("user name is: " + userName);

		Account account = getAccountFromCredentials(userName);
		System.out.println("password: " + account.getPassword());

		if (password.equals(account.getPassword())) {
			System.out.println("authenticated");
			HttpSession session = request.getSession();
			session.setAttribute("user", userName);
			
			session.setAttribute("image_url", imageUrl);
			session.setAttribute("log_url", logUrl);
			
			System.out.println("Image : " + imageUrl);
			System.out.println("log : " + logUrl);
			response.sendRedirect("home.jsp");
		} else {
			System.out.println("wrong credentials");
			response.sendRedirect("login.html");
		}
	}

}

package br.com.socimee.factory;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class ConnectionFactory {
	
	private String URL_MYSQL;
	private String DRIVER;
	
	public Connection createConnection() {
		
		URL_MYSQL = "jdbc:mysql://localhost:3306/socimee?useTimezone=true&serverTimezone=UTC";
		DRIVER = "com.mysql.cj.jdbc.Driver";
		
		Connection connection = null;
		
		try {
			Class.forName(DRIVER);
			connection = DriverManager.getConnection(URL_MYSQL, "root", "675244");
			System.out.println("Connected");
		} catch (Exception e) {
			System.out.println("Error trying to connect to the database: ");
			e.printStackTrace();
		}		
		return connection;
	}
	
	public void closeConnection(Connection connection, PreparedStatement pstmt, ResultSet rs) {
		
		try {
			
			if(connection != null)
				connection.close();
			if(pstmt != null)
				pstmt.close();
			if(rs != null)
				rs.close();
			System.out.println("Connection closed");
			
		} catch (Exception e) {
			System.out.println("Error trying to close the connection to the database: ");
		}
	}
}

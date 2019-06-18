package dbPractice.Connect;
import java.sql.*;

public class DBConnect {
    public static Connection getConnection() {
    	
    	  Connection conn = null;

    		  String url = "jdbc:mysql://localhost:3306/UNIVERSITY?characterEncoding=UTF-8&serverTimezone=UTC"; // DB �ּ� (DB �̸� UNIVERSITY)
    		  String user = "root"; // DB user �̸�
    		  String password = ""; // DB password

    		  try {
    		  Class.forName("com.mysql.cj.jdbc.Driver");
    	  } catch (ClassNotFoundException e) {
    		  System.out.println("����̹� �ε� ����");
    	  }
    	  try {
    		  conn = DriverManager.getConnection(url, user, password);
    		  //stmt = conn.createStatement();
    	  }
    	  catch(Exception e){
    	    System.out.println("DB connection error! : " + e.getMessage());
    	  }
    	  return conn;
    }
    
    public static void close(Statement stmt) {
    	try {
    		if(stmt!=null) stmt.close();
    	} catch(SQLException e) {
    		e.printStackTrace();
    	}
    }
    public static void close(ResultSet rs) {
    	try {
    		if(rs!=null) rs.close();
    	} catch(SQLException e) {
    		e.printStackTrace();
    	}
    }
    public static void close(Connection conn) {
    	try {
    		if(conn!=null) conn.rollback();
    	} catch(SQLException e) {
    		e.printStackTrace();
    	}
    }
}

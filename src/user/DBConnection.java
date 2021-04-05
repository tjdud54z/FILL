package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;


public class DBConnection {

	static {
		 try {
			 Class.forName("com.mysql.jdbc.Driver");
		 } catch(ClassNotFoundException e) {
			 e.printStackTrace();
		 }
	 }

	
public static Connection openConnection() {
	
	Connection con = null;
	
	try {

		String URL = "jdbc:mysql://localhost:3306/bbs?characterEncoding=UTF-8&serverTimezone=UTC";
		String ID = "root";
		String Password = "root";

		con = DriverManager.getConnection(URL, ID, Password);
		
		if(con !=null)
		{
			System.out.println("Database Connection 연결 : [ " + " <b>success</b> ]<br>");
		}else{
			System.out.println("Database Connection 연결 : [ " + " <b>false</b> ]<br>");
		};

	}catch (SQLException e) {
		 e.printStackTrace();
		
	}
	
	 return con;
	
}

public static void closeConnection(Connection con) {
	 if(con!= null) {
		 try {
			 con.close();
			 System.out.println("DB Disconnection");
		 }catch(SQLException e) {
			 e.printStackTrace();
		 }
	 }
}

}
	 

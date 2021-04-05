package chat;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import exchange.ExchangeDTO;

public class ChatDAO {
	
	private Connection conn; // connection:db에접근하게 해주는 객체
	//private PreparedStatement pstmt;
	private ResultSet rs;
    // mysql 처리부분


public ChatDAO() {
    // 생성자를 만들어준다.

try {
	
	String dbURL = "jdbc:mysql://localhost:3306/BBS?&useSSL=false&useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC";
	String dbID = "root";
	String dbPassword = "root";
	Class.forName("com.mysql.jdbc.Driver");
	conn = DriverManager.getConnection(dbURL, dbID, dbPassword);

} catch (Exception e) {

	e.printStackTrace();

}

}

//실제로 글을 작성하는 함수

public int ChatWrite(String userID, String chatContent) { 

	String SQL = "INSERT INTO CHAT VALUES(?, ?)";

	try {

		PreparedStatement pstmt = conn.prepareStatement(SQL);			
		pstmt.setString(1, userID);	
		pstmt.setString(2, chatContent);

		return pstmt.executeUpdate();

		

	} catch (Exception e) {

		e.printStackTrace();

	}

	return -1; //데이터베이스 오류
	
	

}

    public ChatDTO getChat() {

	String SQL = "SELECT * FROM CHAT";

	try {

		PreparedStatement pstmt = conn.prepareStatement(SQL);
		rs = pstmt.executeQuery();

		if (rs.next()) {

			ChatDTO bbs = new ChatDTO();
			
			bbs.setUserID(rs.getString(1));
			bbs.setChatContent(rs.getString(2));


			return bbs;

		}

	} catch (Exception e) {

		e.printStackTrace();

	}

	return null;

}

}

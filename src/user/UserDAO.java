package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.sql.DataSource;

public class UserDAO {
	
	private Connection con;
	public UserDAO (Connection con) {
		this.con = con;

	}
	
	public int login(String userID, String userPassword) {

		String SQL = "SELECT userPassword FROM user WHERE userID = ?";

		try {

			PreparedStatement pstmt = con.prepareStatement(SQL);
			pstmt.setString(1, userID);
			ResultSet rs = pstmt.executeQuery();

			// 결과가 존재한다면 실행

			if (rs.next()) {

				// 패스워드 일치한다면 실행

				
				if (rs.getString(1).equals(userPassword)) {
					return 1; // 로그인 성공

				} else

					return 0; // 비밀번호 불일치

			}

			return -1; // 아이디가 없음 오류



		} catch (Exception e) {
			e.printStackTrace();

		}

		return -2; // 데이터베이스 오류를 의미
}
	
	public int join(UserDTO user) {

		String SQL = "INSERT INTO USER VALUES (?,?,?,?,?,?,?)";

		try {

			PreparedStatement pstmt = con.prepareStatement(SQL);

			pstmt.setString(1, user.getUserID());
			pstmt.setString(2, user.getUserNickname());
			pstmt.setString(3, user.getUserPassword());
			pstmt.setString(4, user.getUserRePassword());
			pstmt.setString(5, user.getUserEmail());			
			pstmt.setString(6, user.getUserPhone());			
			pstmt.setString(7, user.getUserAddress());
			

			return pstmt.executeUpdate();

		} catch (Exception e) {

			e.printStackTrace();

		}

		return -1; // DB 오류

	}

    public int update(UserDTO user) {

	String SQL = "UPDATE USER SET userNickname = ?, userPassword = ?, userRepassword = ?, userEmail = ?, userPhone = ?, userAddress= ? WHERE userID = ?";

	try {

		PreparedStatement pstmt = con.prepareStatement(SQL);
		
		pstmt.setString(1, user.getUserNickname());
		pstmt.setString(2, user.getUserPassword());
		pstmt.setString(3, user.getUserRePassword());
		pstmt.setString(4, user.getUserEmail());	
		pstmt.setString(5, user.getUserPhone());		
		pstmt.setString(6, user.getUserAddress());		
		pstmt.setString(7, user.getUserID());
		

		return pstmt.executeUpdate();

	} catch (Exception e) {
		e.printStackTrace();

	}

	return -1; // DB 오류

}

	
}

		 
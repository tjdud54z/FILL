package mypage;

import java.sql.*;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

public class MypageDAO {
	

	private Connection conn; // connection:db에접근하게 해주는 객체
	//private PreparedStatement pstmt;
	private ResultSet rs;
    // mysql 처리부분

	public MypageDAO() {
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

	//현재의 시간을 가져오는 함수

	public String getDate() { 

		String SQL = "SELECT NOW()";

		try {

			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {

				return rs.getString(1);

			}

		} catch (Exception e) {

			e.printStackTrace();

		}

		return ""; //데이터베이스 오류

	}

	

	//bbsNo 게시글 번호 가져오는 함수

		public int getNext() { 

			String SQL = "SELECT my_bbsNo FROM MYPAGE ORDER BY my_bbsNo DESC";

			try {

				PreparedStatement pstmt = conn.prepareStatement(SQL);
				rs = pstmt.executeQuery();

				if(rs.next()) {

					return rs.getInt(1) + 1;

				}

				return 1;//첫 번째 게시물인 경우

			} catch (Exception e) {

				e.printStackTrace();

			}

			return -1; //데이터베이스 오류

		}

		

		//실제로 글을 작성하는 함수

		public int write(String my_bbsTitle, String userID, String my_bbsContent) { 

			String SQL = "INSERT INTO MYPAGE VALUES(?, ?, ?, ?, ?, ?)";

			try {

				PreparedStatement pstmt = conn.prepareStatement(SQL);
				pstmt.setInt(1, getNext());
				pstmt.setString(2, my_bbsTitle);				
				pstmt.setString(3, userID);	
				pstmt.setString(4, getDate());
				pstmt.setString(5, my_bbsContent);
				pstmt.setInt(6,1);

				return pstmt.executeUpdate();

				

			} catch (Exception e) {

				e.printStackTrace();

			}

			return -1; //데이터베이스 오류

		}
		

		public ArrayList<MypageDTO> getList(int pageNumber){ 

			String SQL = "SELECT * FROM MYPAGE WHERE my_bbsNo < ? AND my_bbsAvailable = 1 ORDER BY my_bbsNo DESC LIMIT 10";
			ArrayList<MypageDTO> list = new ArrayList<MypageDTO>();

			try {

				PreparedStatement pstmt = conn.prepareStatement(SQL);

				pstmt.setInt(1, getNext() - (pageNumber -1) * 10);
				rs = pstmt.executeQuery();

				while (rs.next()) {

					MypageDTO bbs = new MypageDTO();

					bbs.setMy_bbsNo(rs.getInt(1));
					bbs.setMy_bbsTitle(rs.getString(2));
					bbs.setUserID(rs.getString(3));
					bbs.setMy_bbsDate(rs.getString(4));
					bbs.setMy_bbsContent(rs.getString(5));
					bbs.setMy_bbsAvailable(rs.getInt(6));
					list.add(bbs);

				}

			} catch (Exception e) {

				e.printStackTrace();

			}

			return list; 

		}

		//10 단위 페이징 처리를 위한 함수

				public boolean nextPage (int pageNumber) {

					String SQL = "SELECT * FROM EXCHANGE WHERE ex_bbsNo < ? AND ex_bbsAvailable = 1 ORDER BY ex_bbsNo DESC LIMIT 10";

					ArrayList<MypageDTO> list = new ArrayList<MypageDTO>();

					try {

						PreparedStatement pstmt = conn.prepareStatement(SQL);
						pstmt.setInt(1, getNext() - (pageNumber -1) * 10);
						rs = pstmt.executeQuery();

						if (rs.next()) {

							return true;

						}

					} catch (Exception e) {

						e.printStackTrace();

					}

					return false; 
				}
					
					public MypageDTO getBbs(int ex_bbsNo) {

						String SQL = "SELECT * FROM MYPAGE WHERE my_bbsNo = ?";

						try {

							PreparedStatement pstmt = conn.prepareStatement(SQL);
							pstmt.setInt(1, ex_bbsNo);
							rs = pstmt.executeQuery();

							if (rs.next()) {

								MypageDTO bbs = new MypageDTO();

								bbs.setMy_bbsNo(rs.getInt(1));
        						bbs.setMy_bbsTitle(rs.getString(2));
								bbs.setUserID(rs.getString(3));
								bbs.setMy_bbsDate(rs.getString(4));
								bbs.setMy_bbsContent(rs.getString(5));
								bbs.setMy_bbsAvailable(rs.getInt(6));

								return bbs;

							}

						} catch (Exception e) {

							e.printStackTrace();

						}

						return null;

					}
					
					public int update(int ex_bbsNo, String ex_bbsTitle, String ex_bbsContent) {

						String SQL = "UPDATE EXCHANGE SET ex_bbsTitle = ?, ex_bbsContent = ? WHERE ex_bbsNo = ?";

						try {

							PreparedStatement pstmt = conn.prepareStatement(SQL);

							pstmt.setString(1, ex_bbsTitle);
							pstmt.setString(2, ex_bbsContent);
							pstmt.setInt(3, ex_bbsNo);

							return pstmt.executeUpdate();



						} catch (Exception e) {

							e.printStackTrace();

						}

						return -1; // 데이터베이스 오류

					}
					
					//삭제 함수

					public int delete(int ex_bbsNo) {

						String SQL = "UPDATE EXCHANGE SET ex_bbsAvailable = 0 WHERE ex_bbsNo = ?";

						try {

							PreparedStatement pstmt = conn.prepareStatement(SQL);   

							pstmt.setInt(1, ex_bbsNo);
							return pstmt.executeUpdate();

						} catch (Exception e) {

							e.printStackTrace();

						}

						return -1; // 데이터베이스 오류

					}
					

				}
					




<%@page import="user.DBConnection"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"

    pageEncoding="UTF-8"%>

<%@ page import="user.UserDAO" %> <!-- userdao의 클래스 가져옴 -->

<%@ page import="java.io.PrintWriter" %> <!-- 자바 클래스 사용 -->

<% request.setCharacterEncoding("UTF-8"); %>



<!-- 한명의 회원정보를 담는 user클래스를 자바 빈즈로 사용 / scope:페이지 현재의 페이지에서만 사용-->

<jsp:useBean id="user" class="user.UserDTO" scope="page" />
<jsp:setProperty name="user" property="userID" />
<jsp:setProperty name="user" property="userNickname" />
<jsp:setProperty name="user" property="userPassword" /> 
<jsp:setProperty name="user" property="userRePassword" /> 
<jsp:setProperty name="user" property="userEmail" />
<jsp:setProperty name="user" property="userPhone" />
<jsp:setProperty name="user" property="userAddress" />


<!DOCTYPE html>

<html>

<head>



<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>jsp 게시판 웹사이트</title>

</head>

<body>

	<%
	
	
	String userID = null;
    if(session.getAttribute("userID") != null ){
    userID = (String) session.getAttribute("userID");

    }
    
    if(userID != null){

		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('이미 로그인 되어있습니다.')");
		script.println("location.href = 'bbs_exchange.jsp'");
		script.println("</script>");	

	}

		if (user.getUserID() == null || user.getUserNickname() == null || user.getUserPassword() == null
			|| user.getUserRePassword() == null || user.getUserEmail() == null ||		
			   user.getUserPhone() == null || user.getUserAddress() == null ) {

				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력이 안 된 사항이 있습니다.')");
				script.println("history.back()");
				script.println("</script>");

			} else{
				
				 Connection con1 = DBConnection.openConnection();				 
			     UserDAO userDAO = new UserDAO(con1);
		        		
				 int result = userDAO.join(user);				

				

				if(result == -1){ // 아이디가 기본키기. 중복되면 오류.

					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('이미 존재하는 아이디 입니다.')");
					script.println("history.back()");
					script.println("</script>");

				}

				//가입성공

				else {
					
					session.setAttribute("userID", user.getUserID());//
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("location.href = 'bbs_exchange.jsp'");
					script.println("</script>");

				}

			}

			%>

</body>

</body>

</html>


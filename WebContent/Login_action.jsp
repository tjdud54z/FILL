<%@page import="java.sql.Connection"%>
<%@page import="user.DBConnection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %> 
<%@ page import="user.UserDTO" %>
<%@ page import="java.io.PrintWriter" %> 
<%request.setCharacterEncoding("UTF-8");%>

<jsp:useBean id="user" class="user.UserDTO" scope="page" />
<jsp:setProperty name="user" property="userID" />
<jsp:setProperty name="user" property="userPassword" /> 

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>필요해U</title>
</head>
<body>

<%
        String userID = null;
        if(session.getAttribute("userID") != null) {
        	userID =  (String) session.getAttribute("userID");
        	
        }
        if (userID != null) {
        	PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이미 로그인이 되어있습니다.')");
			script.println("location.href = 'bbs_exchange.jsp'"); /*로그인이 성공하면 넘어가는 화면  */
			script.println("</script>");

        }
        
        Connection con1 = DBConnection.openConnection();
        UserDAO userDAO = new UserDAO(con1);
        		
		int result = userDAO.login(user.getUserID(), user.getUserPassword());

		
		if(result == 1){
		
			session.setAttribute("userID", user.getUserID()); //
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href = 'bbs_exchange.jsp'"); /*로그인이 성공하면 넘어가는 화면  */
			script.println("</script>");

		}

		//로그인 실패

		else if(result == 0){
			
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('비밀번호가 틀립니다.')");
			script.println("history.back()");
			script.println("</script>");

		}

		//아이디 없음

		else if(result == -1){

		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('존재하지 않는 아이디 입니다.')");
		script.println("history.back()");
		script.println("</script>");

		}

		//DB오류

		else if(result == -2){

		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('DB오류가 발생했습니다.')");
		script.println("history.back()");
		script.println("</script>");

		}			

	%>


</body>
</html>
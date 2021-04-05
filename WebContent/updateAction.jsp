<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="exchange.*"%>
<%@ page import="java.io.PrintWriter"%>

<%
	request.setCharacterEncoding("UTF-8");
	//sresponse.setContentType("text/html; charset=UTF-8");
%>

<!DOCTYPE html>

<html>

<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>jsp 게시판 웹사이트</title>

</head>

<body>

	<%

		String userID = null;

		if (session.getAttribute("userID") != null) {//유저아이디이름으로 세션이 존재하는 회원들은 
			userID = (String) session.getAttribute("userID");//유저아이디에 해당 세션값을 넣어준다.

		}

		if (userID == null) {

			PrintWriter script = response.getWriter();

			script.println("<script>");
			script.println("alert('로그인을 하세요.')");
			script.println("location.href = 'Login.jsp'");
			script.println("</script>");

		} 

		
		//글이 유효한지 판별

		int ex_bbsNo = 0;

		if (request.getParameter("ex_bbsNo") != null) {

			ex_bbsNo = Integer.parseInt(request.getParameter("ex_bbsNo"));

		}

		if (ex_bbsNo == 0) {

			PrintWriter script = response.getWriter();

			script.println("<script>");
			script.println("alert('유효하지 않은 글 입니다.')");
			script.println("location.href = 'bbs_exchange.jsp'");
		    script.println("</script>");

		}

		ExchangeDTO bbs = new ExchangeDAO().getBbs(ex_bbsNo);

		if (!userID.equals(bbs.getUserID())) {

			PrintWriter script = response.getWriter();

			script.println("<script>");
			script.println("alert('권한이 없습니다.')");
			script.println("location.href = 'bbs_exchange.jsp'");
			script.println("</script>");				

		} else {

			if (request.getParameter("ex_bbsTitle") == null || request.getParameter("ex_bbsContent") == null

					|| request.getParameter("ex_bbsTitle").equals("") || request.getParameter("ex_bbsContent").equals("") ) {

				PrintWriter script = response.getWriter();

				script.println("<script>");
				script.println("alert('입력이 안된 사항이 있습니다')");
				script.println("history.back()");
				script.println("</script>");

			} else {

	            ExchangeDAO bbsDAO = new ExchangeDAO();
				
				int result = bbsDAO.update(ex_bbsNo, request.getParameter("ex_bbsTitle"),request.getParameter("ex_bbsContent"));
				
				if (result == -1) {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글쓰기에 실패했습니다')");
					script.println("history.back()");
					script.println("</script>");
				} else {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("location.href='bbs_exchange.jsp'");
					//script.println("history.back()");
					script.println("</script>");

				}



			}



		}

	%>

</body>

</html>

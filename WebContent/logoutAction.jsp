<%@page import="user.DBConnection"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %> 

<% request.setCharacterEncoding("UTF-8"); %>

<!DOCTYPE html>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>필요해U 웹사이트</title>

</head>

<body>

	<%
	 session.invalidate();
			%>
			
			<script> //메인화면으로 이동
			
			location.href = 'index.jsp';
			
			</script>



</body>

</html>

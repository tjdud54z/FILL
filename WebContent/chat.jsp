<%@page import="user.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="chat.*"%>
<%@ page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>

<script	src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
<script	src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	

<head>
 <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <!-- Bootstrap Core CSS -->
    <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <!-- Theme CSS -->
    <link href="css/freelancer.min.css" rel="stylesheet">
    <!-- Custom Fonts -->
    <link href="vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css">
    <link href="https://fonts.googleapis.com/css?family=Lato:400,700,400italic,700italic" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">

<title>Insert title here</title>

<%
		//로긴한사람이라면	 userID라는 변수에 해당 아이디가 담기고 그렇지 않으면 null값
		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
			
		}
			
			%>

</head>

<body>
			
	<div class="container bootstrap snippet">
	  <form method="post" action="chatAction.jsp">
		<div class="row">
			<div class="col-xs-12">
				<div class="portlet portlet-default">
					<div class="portlet-heading">
						<div class="portlet-title">
							<h4>
								<i class="text-green"></i>신청 댓글창
							</h4>
						</div>
						<div class="clearfix"></div>
					</div>
					  <div id="chat" class="panel-collapse collapse in">
					    <div  id="chatContent" class="portlet-body chat-widget" style="overflow-y: auto; width: auto; height: 600px;">
                   
                        </div>
                         <div class="portlet-footer">
                          <div class="row">
                          <!--  <div class="form-group col-xs-4">
                            <input style="height: 40px;" type="text" id="chatName" class="form-control" placeholder="이름" maxlength="8">
                            </div> --> 
                           </div>
                           <div class="row" style="height: 90px;">
                            <div class="form-group col-xs-10">
                             <textarea style="height: 80px;" id="" class="form-control"  name="chatContent" placeholder="메세지를 입력하세요" maxlength="100"></textarea>
                            </div>
                         <br><br><div class="form-group col-xs-2">
                             <input type="submit" class="btn btn-primary pull-right" value="전송"/>                             	
                            <div class="clearfix"></div>
				</div>
			</div>
		</div>
	</div>
	</div>
	</div>
	</form>
	</div>

	<!-- jQuery -->
	<script src="vendor/jquery/jquery.min.js"></script>

	<!-- Bootstrap Core JavaScript -->
	<script src="vendor/bootstrap/js/bootstrap.min.js"></script>

	<!-- Plugin JavaScript -->
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/jquery-easing/1.3/jquery.easing.min.js"></script>

	<!-- Contact Form JavaScript -->
	<script src="js/jqBootstrapValidation.js"></script>
	<script src="js/contact_me.js"></script>

	<!-- Theme JavaScript -->
	<script src="js/freelancer.min.js"></script>

</body>
</html>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="dao.JDBConnection"%>
<%@page import="dto.User"%>
<%@page import="java.util.Enumeration"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="static/css/style.css">  
	<title>마이페이지</title>
	<link rel="stylesheet" href="static/css/login.css">
</head>
<body>

	<jsp:include page ="layout/header.jsp"></jsp:include>
	
	<div class="container">
	
		<c:if test="${sessionScope.loginId == null}">
			<%
				response.sendRedirect("login.jsp");
			%>
		</c:if>
		
		
		<form action="user_delete.jsp" method="post">
		
			<div class="login-wrap">
			
				<div id="login" class="box">
				
					<div class="login-logo">
                        <img src="static/img/apple_register.png" alt="로고">
                    </div>
					<div class="box1">
						<p class="login" >마이페이지</p>
					</div>
				    
				    <%
				    	String id = (String) session.getAttribute("loginId");
				    	User user = (User) session.getAttribute("loginUser");
				    	if(user != null){
				        out.println("ID : " + id + "<br><br>");
				        out.println("이름 : " + user.getName() + "<br><br>");
				        out.println("전화번호 : " + user.getPhone() + "<br><br>");
				        out.println("이메일 : " + user.getEmail() + "<br><br>");
				        out.println("지역 : " + user.getArea() + "<br>");
				    	}
		    		%>
		    		
		    		<br>
		    		<br>
					<div class="submit_con">
					<a href="mypage_update.jsp" id="submit">회 원 수 정</a>
					<a href="mypage_passwd.jsp" id="submit">비밀번호 수정</a>
						<input id="submit" type="submit" value="회 원 탈 퇴" />
					</div>
				</div>
			
			</div>
		
	</form>
		
	</div>
	
	<jsp:include page = "layout/footer.jsp"></jsp:include>
	
</body>
</html>
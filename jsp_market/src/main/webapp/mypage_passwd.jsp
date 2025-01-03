<%@page import="dto.User"%>
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
	<meta charset="UTF-8">
	<title>비밀번호 수정</title>
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
		
		
		<form action="mypage_passwd_pro.jsp" method="post">
		
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
				    %>
				    	<label>반드시 바꿀 비밀번호를 잊지마시오</label>
				    	<label>비밀번호 : <input type="text" name="psss" required="required"/></label>
				    	<br>
					<%
						}
					%>
		    		<br>
		    		<br>
					<div class="submit_con">
						<input id="submit" type="submit" value="확인" />
					</div>
				</div>
			
			</div>
		
	</form>
		
	</div>
	
	<jsp:include page = "layout/footer.jsp"></jsp:include>
</body>
</html>
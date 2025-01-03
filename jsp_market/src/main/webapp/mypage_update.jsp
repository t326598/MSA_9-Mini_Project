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
	<title>회원정보 수정</title>
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
		
		
		<form action="mypage_update_pro.jsp" method="post">
		
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
				    	<label>이름 : <input type="text" name="name" value="<%=user.getName()%>"/></label>
				    	<br>
				    	<label>전화번호 : <input type="text" name="phone" value="<%=user.getPhone()%>"/></label>
				    	<br>
				    	<label>이메일 : <input type="text" name="email" value="<%=user.getEmail()%>"/></label>
		    			<br>
		    			<label>지역 : 
		    			<select name="area" id="area" value="<%=user.getArea()%>">
									<option value="서울">서울</option>
									<option value="경기">경기</option>
									<option value="인천">인천</option>
									<option value="강원">강원</option>
									<option value="전북">전북</option>
									<option value="전남">전남</option>
									<option value="경북">경북</option>
									<option value="경남">경남</option>
									<option value="대전">대전</option>
									<option value="광주">광주</option>
									<option value="대구">대구</option>
									<option value="부산">부산</option>
									<option value="울산">울산</option>
									<option value="제주">제주</option>
								</select></label>
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
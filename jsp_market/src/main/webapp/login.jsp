<%@ include file="layout/jstl.jsp" %>
<%@page import="service.UserServiceImpl"%>
<%@page import="service.UserService"%>
<%@page import="dto.User"%>
<%@page import="java.net.URLDecoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="static/css/style.css"> 
	<title>로그인</title>
	<link rel="stylesheet" href="static/css/login.css">
	
<body>

	<jsp:include page ="layout/header.jsp"></jsp:include>

	<%
		//아이디 저장 쿠키 확인
		String rememberId = "";
		String username = "";
		Cookie[] cookies = request.getCookies();
		if(cookies != null){
			for(Cookie cookie : cookies){
				String cookieName = cookie.getName();
				String cookieValue = URLDecoder.decode(cookie.getValue());
				switch(cookieName){
					case "username" : username = cookieValue; break;
					case "rememberId" : rememberId = cookieValue; break;
				}
			}
		}
		pageContext.setAttribute("username",username);
		pageContext.setAttribute("rememberId",rememberId);		
	%>
	<div class="container">
	
		<form action="login_pro.jsp" method="post">
		
			<div class="login-wrap">
			
				<div id="login" class="box">
					
					<div class="login-logo">
                        <img src="static/img/apple_register.png" alt="로고">
                    </div>
					<div class="box1">
						<p class="login" >로   그   인</p>
					</div>
					<div  class="box2">
						<p> 아 이 디 &nbsp;: <input class="id_input" type="text" name="username" id="username" value="${username}"></p>
					</div>
					<div class="box2">
						<p>비밀번호 : <input class="id_input" type="password" name="password" id="password"></p>
					</div>
					<div class="box3">
						<p>
							<!-- 아이디 저장 -->
							<input class="check" type="checkbox" name="remember-id" id="remember-id"
							<% if(rememberId.equals("on")){ 
							%>
							checked	 />
							<%
								}
							else{
							%>
								/>
							<%
							}
							%>
							<label for="remember-id">&nbsp;아이디 저장</label>
					    </p>
					    <p>
						<!-- 자동 로그인 -->
						<input class="check" type="checkbox" name="remember-me" id="remember-me"/>
						<label for="remember-me">&nbsp;자동 로그인</label>
						</p>
					</div>
					<div>
						<p><input id="submit" type="submit" value="로그인"></p>
					</div>
				</div>
			</div>
			
		</form>
	
	</div>
	
	<jsp:include page = "layout/footer.jsp"></jsp:include>
	
</body>
</html>
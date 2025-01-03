<%@ include file="layout/jstl.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="static/css/style.css">  
	<title>회원 가입</title>
	<link rel="stylesheet" href="static/css/signup.css">
</head>

<body>
	
	<jsp:include page ="layout/header.jsp"></jsp:include>
	
	<div class="container">
	
		<c:if test="${ param.error == 0 }">
			<p style="color: red;">회원가입에 실패하였습니다.</p>
		</c:if>
		
		<form action="signup_pro.jsp" method="post">
			<div class="login-wrap">
				<div id="login" class="box">
					<div class="login-logo">
                        <img src="static/img/apple_register.png" alt="로고">
                    </div>
					<div class="box1">
						<p class="login" >회 원 가 입</p>
					</div>
					<div class="box1">
						<div class="box2">
							<p><label for="username">아이디</label></p>
							<p><label for="password">비밀번호</label></p>
							<p><label for="name">이름</label></p>
							<p><label for="phone">전화번호</label></p>
							<p><label for="email">이메일</label></p>
							<p><label for="area">지역</label></p>
						</div>
						<div class="box3">
							<p>
								<input class="input" type="text" name="username" id="username" />
							</p>
										
							<p>
								<input class="input" type="password" name="password" id="password" />
							</p>
							<p>
								<input class="input" type="text" name="name" id="name" />
							</p>
							<p>
								<input class="input" type="text" name="phone" id="phone" />
							</p>
							<p>
								<input class="input" type="text" name="email" id="email" />
							</p>
							<p>
								<select name="area" id="area">
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
								</select>
							</p>
						</div>
					</div>	
					<div>
						<input id="submit" type="submit" value="회 원 가 입" />
					</div>
					
				</div>
			</div>
		
		</form>
	
	</div>
	
	<jsp:include page = "layout/footer.jsp"></jsp:include>

</body>
</html>
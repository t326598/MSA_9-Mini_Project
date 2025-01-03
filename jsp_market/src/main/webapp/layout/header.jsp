<%@page import="dto.User"%>
<%@ include file="jstl.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
</head>
<body>
	
	<input type="checkbox" name="bars" id="bars">
	
	<!-- 사이드바 -->
    <div class="sidebar">
        <ul class="sidemenu">
            <li>
                <a href="boardList.jsp">
                    <h3>거래</h3>
                    <p>중고 물품</p>
                </a>
            </li>
             <li>
                <a href="myBoard.jsp">
                    <h3>판매 조회</h3>
                    <p>나의 판매글 목록 조회</p>
                </a>
            </li>
            <li>
                <a href="chatRoom_list.jsp">
                    <h3>채팅</h3>
                    <p>채팅룸 리스트</p>
                </a>
            </li>
            <li>
                <a href="myPage.jsp">
                    <h3>마이페이지</h3>
                    <p>회원탈퇴</p>
                </a>
            </li>
        </ul>
    </div>
	
	<!-- 플로팅 버튼 -->
    <div class="floating">
        <a href="#top"><i class="fa fa-arrow-circle-up"></i></a>
    </div>
	
    <!-- 헤더 -->
    <header>
        <!-- menu -->
        <div class="menu">
            <div class="menu-left">
                <!-- <a href=""><i class="fa fa-user"></i></a> -->
                <a href="main.jsp"><img class="menu-left-img" src="static/img/apple.png" alt="로고"/></a>
            </div>
            <div class="menu-center">
                <nav class="pc">
						<ul>
						<c:if test="${sessionScope.loginId == null}">
							<li><a href="signup.jsp">회원가입</a></li>
							<li><a href="login.jsp">로그인</a></li>
							</c:if>
							<%
							
								if(session.getAttribute("loginUser") != null){
							    // 아이디가 "admin"인지 확인
							    User loggedUser = null;
								loggedUser = (User) session.getAttribute("loginUser");
							    if(loggedUser != null){
							    	if ("admin".equals(loggedUser.getId())) { // 로그인된 아이디가 "admin"이 아닌 경우
							    %>
							    	<li><a href="adminPage_main.jsp">관리자페이지</a><li>
	
							    <%
							    		}
							    	}
								%>
							<li>${sessionScope.loginUser.getId()}님<li>
							<li><a href="logout.jsp">로그아웃</a></li>
						<%
								}
						%>
						</ul>
                </nav>
            </div>
            <div class="menu-right">
                <a href="javascript:;">
                    <label for="bars" class="bars">
                        <span class="bar top"></span>
                        <span class="bar mid"></span>
                        <span class="bar bottom"></span>
                    </label>
                </a>
            </div>
        </div>

    </header>
    <div class="main_img">
		<div class="main_img_content">
            APPLE MARKET
        </div>
	</div>
</body>
</html>
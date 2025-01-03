<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // 로그인 여부 확인
    if (session.getAttribute("loginUser") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    // 아이디가 "admin"인지 확인
    dto.User loggedUser = (dto.User) session.getAttribute("loginUser");
    if (!"admin".equals(loggedUser.getId())) { // 로그인된 아이디가 "admin"이 아닌 경우
        response.sendRedirect("main.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>관리자 메인 페이지</title>    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/adminPage_style.css"> <!-- CSS 파일 연결 -->
</head>
<body>
    <div id="wrapper">
        <aside>
            <ul>
                <li><a href="adminPage_userList.jsp">회원 관리</a></li>
                <li><a href="adminPage_postList.jsp">게시글 관리</a></li>
                <li><a href="adminPage_commentList.jsp">채팅 관리</a></li>
                <li><a href="adminPage_fileList.jsp">파일 관리</a></li>
				<li><a href="adminPage_declarationList.jsp">신고 관리</a></li>                
            </ul>
            <div class="main-button">
       			<a href="main.jsp" class="button">메인으로</a>
   			</div>
        </aside>
        <section id="main-content">
            <h1>관리자 메인 페이지</h1>
            <p>관리자 전용 페이지입니다.</p>
        </section>
    </div>
</body>
</html>

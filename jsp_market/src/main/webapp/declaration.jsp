<%@page import="dto.User"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page language="java" %>
<%@page import="java.sql.*, javax.sql.*"%>

<link rel="stylesheet" type="text/css" href="static/css/declaration.css">

<%
    int boardNo = Integer.parseInt(request.getParameter("no")); // 게시글 번호를 받아옴
    User user = (User) session.getAttribute("loginUser");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>신고 페이지</title>
</head>
<body>
    <h1>신고하기</h1>

    <!-- 신고 내용을 입력하는 폼 -->
    <form action="declaration_pro.jsp" method="post">
        <!-- 게시글 번호 hidden field로 전달 -->
        <input type="hidden" name="boardNo" value="<%= boardNo %>" />

        <label for="writer">작성자 (신고자): ${sessionScope.loginUser.getId()} </label>
        <input type="hidden" name="writer" id="writer" value="<%= user.getUuid() %>" required />
        <br><br>

        <label for="content">신고 내용: </label>
        <div>
        <textarea name="content" id="content" required></textarea>
        </div>
        <br><br>

        <input type="submit" value="신고 제출">
    </form>
</body>
</html>
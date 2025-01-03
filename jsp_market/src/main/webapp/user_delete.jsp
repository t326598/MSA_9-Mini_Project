<%@page import="dto.User"%>
<%@page import="service.UserService"%>
<%@page import="service.UserServiceImpl"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="dao.JDBConnection"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원 삭제</title>
    <script>
/*         function showAlertAndRedirect(message) {
            alert(message);
            window.location.href = 'main.jsp'; // 메인 페이지로 이동
        } */
    </script>
</head>
<body>

<%
	UserService userService = new UserServiceImpl();
    User user = (User) session.getAttribute("loginUser");
    userService.delete(user.getUuid());
    response.sendRedirect("logout.jsp");
%>

</body>
</html>

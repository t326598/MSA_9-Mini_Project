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
<title></title>
</head>
<body>
	<c:if test="${sessionScope.loginId == null}">
		<%
			response.sendRedirect("login.jsp");
		%>
	</c:if>
	<c:if test="${sessionScope.loginId != null}">
		<div class="container">
			<div>
				<a href="myPage.jsp">화살표</a>
			</div>
			<div>
				이미지 원형
				asdf.jpg
				<div>이미지 업로드</div>
				<div>확인</div>
			</div>
		</div>
	</c:if>
</body>
</html>
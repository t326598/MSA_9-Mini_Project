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
				<a href="">화살표</a>
			</div>
			<div>
				정말로 탈퇴하시겠습니까?
				당신의 게시글은 삭제되지 않습니다
				후회하지 않으시다면 다음글을 입력해주세요
			</div>
			<div>
				회원탈퇴
			</div>
			<div>
				text
				<div>summit</div>
			</div>
		</div>
	</c:if>
</body>
</html>
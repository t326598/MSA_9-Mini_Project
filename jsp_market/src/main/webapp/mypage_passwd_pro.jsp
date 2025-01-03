<%@page import="utils.PasswordUtils"%>
<%@page import="service.UserServiceImpl"%>
<%@page import="service.UserService"%>
<%@page import="dto.User"%>
<%@ include file="layout/jstl.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	response.setCharacterEncoding("UTF-8");
	String passwd = request.getParameter("psss");
	
	// 회원 가입 요청
	UserService userService = new UserServiceImpl();
	String pewd = PasswordUtils.encoded(passwd);
	
	String loginid = (String) session.getAttribute("loginId");
	User user = userService.select(loginid);
	
	// User
	user.setPasswd(pewd);
	

	boolean result = userService.update(user);
	session.setAttribute("loginUser",user);
	
	// 회원가입 성공
	if( result ) {
		response.sendRedirect("myPage.jsp");				// 메인화면으로 이동
	}
	// 회원가입 실패
	else {
		response.sendRedirect("mypage_passwd.jsp?error=0");	// 다시 회원가입페이지로 (에러포함)
	}
%>
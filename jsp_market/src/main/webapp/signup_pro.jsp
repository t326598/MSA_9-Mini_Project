<%@ page import="service.UserService"%>
<%@ page import="service.UserServiceImpl"%>
<%@ page import="dto.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	response.setCharacterEncoding("UTF-8");
	String id = request.getParameter("username");
	String passwd = request.getParameter("password");
	String name = request.getParameter("name");
	String phone = request.getParameter("phone");
	String email = request.getParameter("email");
	String area = request.getParameter("area");
	
	// User 객체 생성
	User user = User.builder()
						.id(id)
						.passwd(passwd)
						.name(name)
						.phone(phone)
						.email(email)
						.area(area)
						.enabled(true)
						.build();
	
	// 회원 가입 요청
	UserService userService = new UserServiceImpl();
	int result = userService.signup(user);
	
	// 회원가입 성공
	if( result>0 ) {
		response.sendRedirect("main.jsp");				// 메인화면으로 이동
	}
	// 회원가입 실패
	else {
		response.sendRedirect("signup.jsp?error=0");	// 다시 회원가입페이지로 (에러포함)
	}
%>
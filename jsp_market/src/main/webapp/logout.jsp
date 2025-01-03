<%@page import="service.PersistenceLoginsServiceImpl"%>
<%@page import="service.PersistenceLoginsService"%>
<%@page import="dto.PersistenceLogins"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//자동로그인
	// - 인증 토큰 삭제
	Cookie cookieRememberMe = new Cookie("rememberMe","");
	Cookie cookieToken = new Cookie("token","");
	cookieRememberMe.setPath("/");
	cookieToken.setPath("/");
	cookieRememberMe.setMaxAge(0);
	cookieToken.setMaxAge(0);
	response.addCookie(cookieRememberMe);
	response.addCookie(cookieToken);
	
	PersistenceLoginsService persistenceLoginsService = new PersistenceLoginsServiceImpl();
	String loginId = (String) session.getAttribute("loginId");
	if(loginId != null){
		boolean deleted= persistenceLoginsService.delete(loginId);
		if(deleted) System.out.println("인증 토큰 데이터 삭제 성공!");
		else System.out.println("인증 토큰 데이터 삭제 실패!");
	}
	
	// 세션 무효화
	session.invalidate();
	
	response.sendRedirect("main.jsp");
	//response.sendRedirect(request.getContextPath()+"/");
%>
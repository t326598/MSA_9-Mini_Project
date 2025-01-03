<%@page import="service.CommentServiceImpl"%>
<%@page import="service.CommentService"%>
<%@page import="dto.Comment_room"%>
<%@page import="dto.Comment"%>
<%@page import="dto.User"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
response.setCharacterEncoding("UTF-8");


String content = request.getParameter("chat");
User user = (User) session.getAttribute("loginUser");
int room_no = Integer.parseInt(request.getParameter("room_No"));
Comment_room cmR = new Comment_room();
Comment cm = new Comment();
CommentService commentService = new CommentServiceImpl();
//Comment 객체 생성 및 데이터 설정
System.out.println("room_no:"+room_no);
System.out.println("content:"+content);
System.out.println("getUuid:"+user.getUuid());
cm.setRoom_no(room_no);
cm.setContent(content);
cm.setUuid(user.getUuid());

// CommentService 객체 생성 및 데이터 삽입
commentService.insert(cm);


response.sendRedirect("chatRoom.jsp?no="+room_no);
%>
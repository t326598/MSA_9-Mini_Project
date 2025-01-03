<%@page import="dto.User"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="dto.Comment_room"%>
<%@page import="service.Comment_roomServiceImpl"%>
<%@page import="service.Comment_roomService"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
	<%
		Comment_room cr = new Comment_room();
		Comment_roomService crs = new Comment_roomServiceImpl();
	    int board_no = Integer.parseInt(request.getParameter("Board_no"));
		int main_no = Integer.parseInt(request.getParameter("Main_no"));
		int sub_no = Integer.parseInt(request.getParameter("Sub_no"));
		int room_no=-1;
		List<Comment_room> crsList = new ArrayList();
		crsList = crs.list(board_no);
		User user = (User) session.getAttribute("loginUser");
		int res=0;
		if(crsList.size()==0){
			cr.setBoard_no(board_no);
			cr.setMain_no(main_no);
			cr.setSub_no(sub_no);
			crs.insert(cr);
		}
		for(int i=0 ; i<crsList.size();i++){
			if(crsList.get(i).getSub_no()!=user.getUuid()){
				res=1;
			}
			else{
				res=0;
				break;
			}
		}
		if(res==1){
			cr.setBoard_no(board_no);
			cr.setMain_no(main_no);
			cr.setSub_no(sub_no);
			crs.insert(cr);
		}
		crsList = crs.list(board_no);
		//System.out.println("sadfdsafsd"+crsList.get(0));
		for(int i=0 ; i<crsList.size();i++){
			if(crsList.get(i).getSub_no()==user.getUuid()){
				room_no=crsList.get(i).getNo();
				break;
			}
		}
		response.sendRedirect("chatRoom.jsp?no="+room_no);
	%>
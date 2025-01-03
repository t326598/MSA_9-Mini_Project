<%@page import="java.io.File"%>
<%@page import="dto.Files"%>
<%@page import="dto.Board"%>
<%@page import="service.FilesServiceImpl"%>
<%@page import="service.FilesService"%>
<%@page import="service.BoardServiceImpl"%>
<%@page import="service.BoardService"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
String boardNo = request.getParameter("no");
BoardService bd = new BoardServiceImpl();
FilesService fs = new FilesServiceImpl();

Board board = bd.select(Integer.parseInt(boardNo));
Files fff = fs.select(Integer.parseInt(boardNo));



// 이미지 파일 경로
 String filePath = fff.getFile_path();
if (filePath != null) {
	// 파일 삭제
	File file = new File(filePath);
	if (file.exists()) {
		boolean deleted = file.delete();
		if (!deleted) {
	out.println("파일 삭제 실패: " + filePath);
		}
	}
} 

// 데이터베이스에서 파일 정보 삭제
fs.delete(fff.getTable_no()); // 파일 정보 삭제
// 게시글 삭제
bd.delete(Integer.parseInt(boardNo)); // 게시글 삭제

response.sendRedirect("main.jsp");
%>

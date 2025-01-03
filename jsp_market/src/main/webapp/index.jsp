<%@page import="dto.User"%>
<%@page import="service.FilesServiceImpl"%>
<%@page import="service.FilesService"%>
<%@page import="dto.Files"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="service.BoardServiceImpl"%>
<%@page import="service.BoardService"%>
<%@page import="dto.Board"%>
<%@ include file="layout/jstl.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP-마켓</title>
<link rel="stylesheet" href="static/css/style.css">
</head>
<body>
	<%
		BoardService boardService = new BoardServiceImpl();
		FilesService fileService = new FilesServiceImpl();
	%>
	<!-- <div id="header"></div> -->
	<jsp:include page="layout/header.jsp"></jsp:include>
	
	<main>
		<!-- 슬라이드 -->
		<section id="section1">
			<div class="slide">
				<div class="item">
					<img src="static/img/1.PNG" width="100%" alt="이미지">
				</div>
				<div class="item">
					<img src="static/img/2.PNG" width="100%" alt="이미지">
				</div>
				<div class="item">
					<img src="static/img/3.jpg" width="100%" alt="이미지">
				</div>
				<div class="item">
					<img src="static/img/1.PNG" width="100%" alt="이미지">
				</div>
			</div>
		</section>
	 	<section id="section2">
			<div class="shop_cotainer">
				<div class="shop">
					<div class="shop-title">최신 판매글</div>
					<%
						List<Board> boardList = new ArrayList();
						Files file = new Files();
						boardList = boardService.list();
						int maxCount = boardList.size();
						int count = 0;
						System.out.println(count);
						if(maxCount > 6){
							count=maxCount-6;
						}
					%>
					<div class="card-box">
						<!-- 카드 -->
						<%
							for(int i=maxCount-1 ; i>count-1;i--){
						%>	
						<div class="card">
							<div class="card-img">
								<a href="viewPage.jsp?no=<%= + boardList.get(i).getNo() %>">
									<%
										file = fileService.select(boardList.get(i).getNo(),"board");
										
									if(file == null){
									%>
										<img src="static/img/default_apple.png"width="100%" alt="" onerror="this.onerror=null; this.src='static/img/default_apple.png';">
									<%
									}else{
									%>
										<img src="/04_jsp_market/img?no=<%= file.getTable_no() %>" width="100%" height="200px" alt="" onerror="this.onerror=null; this.src='static/img/default_apple.png';">
									<%
									}
									%>
								
								</a>
							</div>
							<div class="card-title">
								<h2>
									<a href="viewPage.jsp?no=<%= + boardList.get(i).getNo() %>">
										<%= boardList.get(i).getTitle() %>
									</a>
								</h2>
							</div>
							<div class="card-content">
								<p>가격 : <%= boardList.get(i).getPrice() %></p>
							</div>
							<div class="card-bottom">
								<div class="item">
									<span>분류/<%=boardList.get(i).getCategory() %></span>
								</div>
							</div>
						</div>
						<%
							}
						%>
					</div>
					<div class="shoplus">
						<a href="boardList.jsp">더보기..</a>
					</div>
				</div>
			</div>
		</section>
	</main>
	<!-- <div id="footer"></div> -->
	<jsp:include page="layout/footer.jsp"></jsp:include>
</body>
</html>
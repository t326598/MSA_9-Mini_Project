<%@page import="dto.User"%>
<%@page import="dto.Comment_room"%>
<%@page import="service.Comment_roomServiceImpl"%>
<%@page import="service.Comment_roomService"%>
<%@page import="service.BoardService"%>
<%@page import="service.BoardServiceImpl"%>
<%@page import="dto.Files"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dto.Board"%>
<%@page import="java.util.List"%>
<%@page import="service.FilesServiceImpl"%>

<%@page import="service.FilesService"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>




<!DOCTYPE html>
<html>
<%
BoardService boardService = new BoardServiceImpl();
FilesService fileService = new FilesServiceImpl();

Comment_roomService crs = new Comment_roomServiceImpl();



int pageSize = 10;
int pages = request.getParameter("page") == null ? 1 : Integer.parseInt(request.getParameter("page"));
List<Comment_room> crList_before = new ArrayList();
List<Comment_room> crList = new ArrayList();
Comment_room cr = new Comment_room();
/* int totalBoardCount = boardService.getTotalBoardCount(); */

User loggedUser = null;
if(session.getAttribute("loginUser") != null){
   // 아이디가 "admin"인지 확인
	loggedUser = (User) session.getAttribute("loginUser");
}
else{
	response.sendRedirect("login.jsp");
}
crList_before = crs.list();
int totalCrCount = crList_before.size();
for(int iss=0;iss<totalCrCount;iss++){
	if(session.getAttribute("loginUser") != null){
		if(crList_before.get(iss).getSub_no()==loggedUser.getUuid()){
			crList.add(crList_before.get(iss));
		}
	}
}

totalCrCount = crList.size();



int totalPages = (int) Math.ceil((double) totalCrCount / pageSize); // 총 페이지 수



%>


<head>
<meta charset="UTF-8">
<title>채팅 방 목록</title>
<link rel="stylesheet" href="static/css/chatRoom_list.css">
</head>
<body>

	
<jsp:include page="layout/header.jsp"></jsp:include>


	<div class="container">
	
	<div class="container-title">
		<h1>채팅 방 목록</h1>
	</div>

	
		<%
	
	Files file = new Files();
	Board board = new Board();
	%>
	

		<div class="card-box">
			<!-- 카드 -->
			<%
			int plusPage = pageSize*(pages-1);
    	for (int i = 0; i < pageSize; i++) {
        // 5개씩 줄 바꿈
        if (i % 5 == 0) {
    %>
			<div class="card-row">
				<%
        }
        
        if (plusPage < totalCrCount) {
        	cr = crList.get(plusPage);
        	board = boardService.select(cr.getBoard_no());
    %>
				<div class="card">
					<div class="card-img">
					<a href="javascript:void(0);" onclick="openPopup2(<%=crList.get(plusPage).getNo()%>)"> 
					<%
                file = fileService.select(board.getNo(), "board");
                if (file == null) {
                %> <img src="static/img/default_apple.png" width="100%"
							alt=""
							onerror="this.onerror=null; this.src='static/img/default_apple.png';">
							<%
                } else {
                %> <img src="/jsp_market/img?no=<%= file.getTable_no() %>" width="100%" height="200px"
							alt=""
							onerror="this.onerror=null; this.src='static/img/default_apple.png';">
							<%
                }
                %>
				</a>
					</div>
					<div class="card-title">
						<h2>
							<a href="javascript:void(0);" onclick="openPopup2(<%=crList.get(plusPage).getNo()%>)">
							<%=board.getTitle()%>
							</a>
						</h2>
					</div>
					<div class="card-content">
						<p>
							가격 :
							<%=board.getPrice()%></p>
					</div>
					<div class="card-bottom">
						<div class="item">
							<span>분류/<%=board.getCategory()%></span>
						</div>
					</div>
				</div>
				<%
        // 5개의 카드가 출력된 후 행을 닫음
        }
        if (i % 5 == 4 || i == crList.size() - 1) {
    %>
			</div>
			<%
        }
		plusPage++;
    }
    %>
		</div>
		 <div class="pagination">
            <%
                int blockSize = 5; // 한 번에 표시할 페이지 버튼 수
                int blockStart = ((pages - 1) / blockSize) * blockSize + 1; // 현재 블록의 시작 페이지
                int blockEnd = Math.min(blockStart + blockSize - 1, totalPages); // 현재 블록의 끝 페이지

                // 이전 버튼
                if (blockStart > 1) {
            %>
                <a href="?page=<%= blockStart - 1 %>">이전</a>
            <%
                }

                // 페이지 번호
                for (int i = blockStart; i <= blockEnd; i++) {
                    if (i == pages) {
            %>
                <strong><%= i %></strong>
            <%
                    } else {
            %>
                <a href="?page=<%= i %>"><%= i %></a>
            <%
                    }
                }

                // 다음 버튼
                if (blockEnd < totalPages) {
            %>
                <a href="?page=<%= blockEnd + 1 %>">다음</a>
            <%
                }
            %>


	</div>
</div>
<jsp:include page = "layout/footer.jsp"></jsp:include>
<script>
        function openPopup2(Board_no2) {
/*         var Board_no2 = document.getElementById('Board_no2').value; */
        // 정수로 변환
        Board_no2 = parseInt(Board_no2, 10);
        
        if (isNaN(Board_no2)) {
            alert("유효한 숫자를 입력하세요.");
            return;
        }
        
        // 팝업창을 열면서 파라미터를 URL로 전달
        var popupUrl = "chatRoom.jsp?no=" + encodeURIComponent(Board_no2);
        window.open(popupUrl, "PopupWindow", "width=1200,height=700");
        }
</script>
</body>
</html>
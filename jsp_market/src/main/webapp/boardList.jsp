<%@page import="java.util.Collections"%>
<%@page import="java.util.stream.Collectors"%>
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
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<%
BoardService boardService = new BoardServiceImpl();
FilesService fileService = new FilesServiceImpl();

int pageSize = 10;
int pages = request.getParameter("page") == null ? 1 : Integer.parseInt(request.getParameter("page"));
String keyword = request.getParameter("keyword") != null ? request.getParameter("keyword") : ""; // 검색어 초기화
List<Board> boardList = boardService.list(); // 전체 게시글 목록 가져오기

// 최신 글 순으로 정렬
/* boardList = boardList.stream()
    .sorted((b1, b2) -> b2.getReg_date().compareTo(b1.getReg_date()))
    .collect(Collectors.toList()); */
Collections.reverse(boardList);

// 검색어로 필터링
if (!keyword.isEmpty()) {
    boardList = boardList.stream()
        .filter(board -> board.getTitle().toLowerCase().contains(keyword.toLowerCase()))
        .collect(Collectors.toList());
}

int totalBoardCount = boardList.size();
int totalPages = (int) Math.ceil((double) totalBoardCount / pageSize); // 총 페이지 수

// 페이지네이션을 위한 시작과 끝 인덱스 계산
int startIndex = (pages - 1) * pageSize;
int endIndex = Math.min(startIndex + pageSize, totalBoardCount);
List<Board> paginatedList = boardList.subList(startIndex, endIndex); // 현재 페이지에 해당하는 게시글 목록
%>

<head>
<meta charset="UTF-8">
<title>게시판 목록</title>
<link rel="stylesheet" href="static/css/boardList.css">
<style>
    .card-row {
        display: flex;
        flex-wrap: wrap;
        width: 100%;
        margin-bottom: 20px;
    }
    .card {
        flex: 1 1 18%; /* 5개씩 나열되도록 설정 (5 * 18% = 90%, 약간의 여백을 위해 18%) */
        margin: 10px;
        box-sizing: border-box;
    }
</style>
</head>
<body>
    <jsp:include page="layout/header.jsp"></jsp:include>
<div class="container1">
<h1 class="manin-list">게시판 목록</h1>
<c:if test="${sessionScope.loginId != null}">
	
<div class="creates">
    <input type="button" class="createbtn" onclick="location.href='create.jsp'" value="게시글 등록" />
</div>
</c:if>

<div class="container">
    <div class="card-box">
        <!-- 카드 -->
       <%
Files file;
for (int i = 0; i < paginatedList.size(); i++) {
    if (i % 5 == 0) { %>
        <div class="card-row">
    <% }
    Board board = paginatedList.get(i);
%>
    <div class="card">
        <div class="card-img">
            <a href="viewPage.jsp?no=<%= board.getNo() %>"> 
                <%
                file = fileService.select(board.getNo(), "board");
                if (file == null) {
                %>
                    <img src="static/img/default_apple.png" width="100%" alt="" onerror="this.onerror=null; this.src='static/img/default_apple.png';">
                <%
                } else {
                %>
                    <img src="/jsp_market/img?no=<%= file.getTable_no() %>" width="100%" height="200px" alt="" onerror="this.onerror=null; this.src='static/img/default_apple.png';">
                <%
                }
                %>
            </a>
        </div>
        <div class="card-title">
            <h2><a href="viewPage.jsp?no=<%= board.getNo() %>"><%= board.getTitle() %></a></h2>
        </div>
        <div class="card-content">
            <p>가격 : <%= board.getPrice() %></p>
        </div>
        <div class="card-bottom">
            <div class="item">
                <span>분류/<%= board.getCategory() %></span>
            </div>
        </div>
    </div>
<%
    // 5개의 카드가 출력된 후 행을 닫음
    if ((i + 1) % 5 == 0 || i == paginatedList.size() - 1) { %>
        </div>
    <% }
} %>
    </div>

    <!-- 검색 폼 -->
    <div>
        <form class="search-button" action="" method="get">
            <input class="search-button" type="text" placeholder="검색어를 입력하세요" name="keyword" class="search-input" value="<%= keyword %>">
            <input type="submit" class="search-button" value="검색">
        </form>
    </div>

    <!-- 페이지네이션 -->
    <div class="pagination">
        <%
        int blockSize = 5; // 한 번에 표시할 페이지 버튼 수
        int blockStart = ((pages - 1) / blockSize) * blockSize + 1; // 현재 블록의 시작 페이지
        int blockEnd = Math.min(blockStart + blockSize - 1, totalPages); // 현재 블록의 끝 페이지

        // 이전 버튼
        if (blockStart > 1) {
        %>
            <a href="?page=<%= blockStart - 1 %>&keyword=<%= keyword %>">이전</a>
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
                <a href="?page=<%= i %>&keyword=<%= keyword %>"><%= i %></a>
        <%
            }
        }

        // 다음 버튼
        if (blockEnd < totalPages) {
        %>
            <a href="?page=<%= blockEnd + 1 %>&keyword=<%= keyword %>">다음</a>
        <%
        }
        %>
    </div>
</div>
</div>

<jsp:include page="layout/footer.jsp"></jsp:include>

</body>
</html>

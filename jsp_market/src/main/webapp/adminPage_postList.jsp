<%@ page import="dao.JDBConnection" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // 로그인 여부 확인
    if (session.getAttribute("loginUser") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // 아이디 확인
    dto.User loggedUser = (dto.User) session.getAttribute("loginUser");
    if (!"admin".equals(loggedUser.getId())) { // 아이디가 "admin"이 아닌 경우
        response.sendRedirect("main.jsp");
        return;
    }

    // 검색 조건 처리
    String searchField = request.getParameter("searchField");
    String searchQuery = request.getParameter("searchQuery");
    boolean hasSearchCondition = (searchField != null && searchQuery != null && !searchQuery.trim().isEmpty());

    int pageSize = 10; // 한 페이지에 보여줄 게시글 수
    int currentPage = 1; // 현재 페이지
    if (request.getParameter("page") != null) {
        currentPage = Integer.parseInt(request.getParameter("page"));
    }
    int offset = (currentPage - 1) * pageSize; // OFFSET 계산

    JDBConnection jdbc = new JDBConnection();
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    int totalPosts = 0;

    try {
        // 게시글 수 쿼리 작성
        String countQuery = "SELECT COUNT(*) AS total FROM board";
        String query = "SELECT * FROM board";

        // 검색 조건이 있을 경우 WHERE 절 추가
        if (hasSearchCondition) {
            countQuery += " WHERE " + searchField + " LIKE ?";
            query += " WHERE " + searchField + " LIKE ? ORDER BY reg_date DESC LIMIT ? OFFSET ?";
        } else {
            query += " ORDER BY reg_date DESC LIMIT ? OFFSET ?";
        }

        // 총 게시글 수 가져오기
        pstmt = jdbc.con.prepareStatement(countQuery);
        if (hasSearchCondition) {
            pstmt.setString(1, "%" + searchQuery + "%");
        }
        rs = pstmt.executeQuery();
        if (rs.next()) {
            totalPosts = rs.getInt("total");
        }
        rs.close();
        pstmt.close();

        // 페이지에 맞는 게시글 데이터 가져오기
        pstmt = jdbc.con.prepareStatement(query);
        int paramIndex = 1;
        if (hasSearchCondition) {
            pstmt.setString(paramIndex++, "%" + searchQuery + "%");
        }
        pstmt.setInt(paramIndex++, pageSize);
        pstmt.setInt(paramIndex, offset);
        rs = pstmt.executeQuery();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>게시글 관리</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/adminPage_style.css"> <!-- CSS 파일 연결 -->
</head>
<body>
    <div id="wrapper">
        <aside>
            <ul>
                <li><a href="adminPage_userList.jsp" <%= "adminPage_userList.jsp".equals(request.getRequestURI()) ? "class='active'" : "" %>>회원 관리</a></li>
                <li><a href="adminPage_postList.jsp" class="active">게시글 관리</a></li>
                <li><a href="adminPage_commentList.jsp">채팅 관리</a></li>
                <li><a href="adminPage_fileList.jsp">파일 관리</a></li>                
                <li><a href="adminPage_declarationList.jsp">신고 관리</a></li>                
            </ul>
            <div class="main-button">
       			<a href="main.jsp" class="button">메인으로</a>
   			</div>
        </aside>
        <section id="main-content">
            <h2>게시글 목록</h2>
            <div class="search-container">
                <form id="search-form" method="get" action="adminPage_postList.jsp">
                    <label for="searchField"></label>
                    <select name="searchField" id="searchField">
                        <option value="no" <%= "no".equals(searchField) ? "selected" : "" %>>게시글 번호</option>
                        <option value="title" <%= "title".equals(searchField) ? "selected" : "" %>>제목</option>
                        <option value="category" <%= "category".equals(searchField) ? "selected" : "" %>>카테고리</option>
                        <option value="content" <%= "content".equals(searchField) ? "selected" : "" %>>내용</option>
                    </select>
                    <input type="text" name="searchQuery" value="<%= (searchQuery != null) ? searchQuery : "" %>" placeholder="검색어를 입력하세요">
                    <button type="submit">검색</button>
                </form>
            </div>
            <div id="postList">
                <table border="1">
                    <thead>
                        <tr>
                            <th>게시글 번호</th>
                            <th>제목</th>
                            <th>카테고리</th>
                            <th>가격</th>
                            <th>상태</th>
                            <th>내용</th> <!-- 내용 항목을 수정일자 앞에 배치 -->
                            <th>등록일자</th>
                            <th>수정일자</th> <!-- 수정일자 추가 -->
                            <th>수정</th>
                            <th>삭제</th>
                        </tr>
                    </thead>
					<tbody>
					    <% while (rs.next()) { %>
					        <tr>
					            <td>
					                <a href="viewPage.jsp?no=<%= rs.getInt("no") %>" target="_blank">
					                    <%= rs.getInt("no") %>
					                </a>
					            </td>
					            <td><%= rs.getString("title") %></td>
					            <td><%= rs.getString("category") %></td>
					            <td><%= rs.getInt("price") %></td>
					            <td><%= rs.getInt("status") %></td>
					            <td><%= rs.getString("content") %></td> <!-- 내용 표시 -->
					            <td><%= rs.getTimestamp("reg_date") %></td>
					            <td><%= rs.getTimestamp("upd_date") %></td> <!-- 수정일자 표시 -->
					            <td><a href="adminPage_updatePost.jsp?no=<%= rs.getInt("no") %>">수정</a></td>
					            <td><a href="adminPage_deletePost.jsp?no=<%= rs.getInt("no") %>" onclick="return confirm('정말 삭제하시겠습니까?');">삭제</a></td>
					        </tr>
					    <% } %>
					</tbody>
                </table>

                <%
                // 페이지네이션 링크 생성
                int totalPages = (int) Math.ceil((double) totalPosts / pageSize);
                %>
                <div class="pagination">
                    <% for (int i = 1; i <= totalPages; i++) { %>
                        <a href="adminPage_postList.jsp?page=<%= i %>&searchField=<%= searchField %>&searchQuery=<%= searchQuery != null ? searchQuery : "" %>" <%= (i == currentPage) ? "class='active'" : "" %>><%= i %></a>
                    <% } %>
                </div>
            </div>
        </section>
    </div>
<%
    } catch (Exception e) {
        out.println("데이터베이스 오류: " + e.getMessage());
    } finally {
        if (rs != null) try { rs.close(); } catch (Exception e) {}
        if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
        if (jdbc.con != null) try { jdbc.con.close(); } catch (Exception e) {}
    }
%>
</body>
</html>

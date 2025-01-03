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
%>

<%   
    request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("UTF-8");

    int pageSize = 20; // 한 페이지에 보여줄 채팅 수
    int currentPage = 1; // 현재 페이지
    if (request.getParameter("page") != null) {
        currentPage = Integer.parseInt(request.getParameter("page"));
    }
    int offset = (currentPage - 1) * pageSize; // OFFSET 계산

    // 검색 관련 변수
    String searchType = request.getParameter("searchType");
    String searchKeyword = request.getParameter("searchKeyword");
    
    JDBConnection jdbc = new JDBConnection();
    Statement stmt = null;
    ResultSet rs = null;
    int totalComments = 0;

    try {
        // 전체 채팅 수를 가져옵니다.
        String countQuery = "SELECT COUNT(*) AS total FROM comment";
        if (searchType != null && searchKeyword != null && !searchKeyword.isEmpty()) {
            countQuery += " WHERE " + searchType + " LIKE ?";
        }
        PreparedStatement countStmt = jdbc.con.prepareStatement(countQuery);
        if (searchType != null && searchKeyword != null && !searchKeyword.isEmpty()) {
            countStmt.setString(1, "%" + searchKeyword + "%");
        }
        rs = countStmt.executeQuery();
        if (rs.next()) {
            totalComments = rs.getInt("total");
        }

        // 페이지에 맞는 채팅 데이터를 가져옵니다.
        String query = "SELECT * FROM comment";
        if (searchType != null && searchKeyword != null && !searchKeyword.isEmpty()) {
            query += " WHERE " + searchType + " LIKE ?";
        }
        query += " LIMIT ? OFFSET ?";
        
        PreparedStatement pstmt = jdbc.con.prepareStatement(query);
        if (searchType != null && searchKeyword != null && !searchKeyword.isEmpty()) {
            pstmt.setString(1, "%" + searchKeyword + "%");
            pstmt.setInt(2, pageSize);
            pstmt.setInt(3, offset);
        } else {
            pstmt.setInt(1, pageSize);
            pstmt.setInt(2, offset);
        }
        rs = pstmt.executeQuery();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>채팅 목록</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/adminPage_style.css">
</head>
<body>
    <div id="wrapper">
        <aside>
            <ul>
                <li><a href="adminPage_userList.jsp" >회원 관리</a></li>
                <li><a href="adminPage_postList.jsp">게시글 관리</a></li>
                <li><a href="adminPage_commentList.jsp" class="active">채팅 관리</a></li>
				<li><a href="adminPage_fileList.jsp">파일 관리</a></li>                
				<li><a href="adminPage_declarationList.jsp">신고 관리</a></li>                
            </ul>
            <div class="main-button">
       			<a href="main.jsp" class="button">메인으로</a>
   			</div>
        </aside>
        <section id="main-content">
            <h2>채팅 목록</h2>

            <div class="search-container">
                <form method="get" action="adminPage_commentList.jsp" id="search-form">
                    <select name="searchType">
                        <option value="room_no">게시글 번호</option>
                        <option value="content">내용</option>
                        <option value="uuid">작성자 ID</option>
                    </select>
                    <input type="text" name="searchKeyword" placeholder="검색어 입력" value="<%= searchKeyword != null ? searchKeyword : "" %>">
                    <button type="submit">검색</button>
                </form>
            </div>

            <div id="commentList">
                <table border="1">
                    <thead>
                        <tr>
                            <th>채팅 번호</th>
                            <th>게시글 번호</th>
                            <th>작성자 ID</th>
                            <th>내용</th>
                            <th>등록일자</th>
                            <th>수정일자</th>
                            <th>수정</th>
                            <th>삭제</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% while (rs.next()) { %>
                            <tr>
                                <td><%= rs.getInt("no") %></td>
                                <td><%= rs.getInt("room_no") %></td>
                                <td><%= rs.getInt("uuid") %></td>
                                <td><%= rs.getString("content") %></td>
                                <td><%= rs.getTimestamp("reg_date") %></td>
                                <td><%= rs.getTimestamp("upd_date") %></td>
                                <td>
                                    <a href="adminPage_updateComment.jsp?no=<%= rs.getInt("no") %>">수정</a>
                                </td>
                                <td>
                                    <a href="adminPage_deleteComment.jsp?no=<%= rs.getInt("no") %>" onclick="return confirm('정말 삭제하시겠습니까?');">삭제</a>
                                </td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>

                <%
                // 페이지네이션 링크 생성
                int totalPages = (int) Math.ceil((double) totalComments / pageSize);
                %>
                <div class="pagination">
                    <% for (int i = 1; i <= totalPages; i++) { %>
                        <a href="adminPage_commentList.jsp?page=<%= i %>&searchType=<%= searchType != null ? searchType : "" %>&searchKeyword=<%= searchKeyword != null ? searchKeyword : "" %>" <%= (i == currentPage) ? "class='active'" : "" %>><%= i %></a>
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
        if (stmt != null) try { stmt.close(); } catch (Exception e) {}
        if (jdbc.con != null) try { jdbc.con.close(); } catch (Exception e) {}
    }
%>
</body>
</html>

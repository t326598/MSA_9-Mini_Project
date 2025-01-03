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
    String searchColumn = request.getParameter("search-column");
    String searchKeyword = request.getParameter("search-keyword");
    boolean hasSearchCondition = (searchColumn != null && searchKeyword != null && !searchKeyword.trim().isEmpty());

    int pageSize = 20; // 한 페이지에 보여줄 유저 수
    int currentPage = 1; // 현재 페이지
    if (request.getParameter("page") != null) {
        currentPage = Integer.parseInt(request.getParameter("page"));
    }
    int offset = (currentPage - 1) * pageSize; // OFFSET 계산

    JDBConnection jdbc = new JDBConnection();
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    int totalUsers = 0;

    try {
        // 유저 수 쿼리 작성
        String countQuery = "SELECT COUNT(*) AS total FROM user";
        String query = "SELECT * FROM user";

        // 검색 조건이 있을 경우 WHERE 절 추가
        if (hasSearchCondition) {
            countQuery += " WHERE " + searchColumn + " LIKE ?";
            query += " WHERE " + searchColumn + " LIKE ? LIMIT ? OFFSET ?";
        } else {
            query += " LIMIT ? OFFSET ?";
        }

        // 총 유저 수 가져오기
        pstmt = jdbc.con.prepareStatement(countQuery);
        if (hasSearchCondition) {
            pstmt.setString(1, "%" + searchKeyword + "%");
        }
        rs = pstmt.executeQuery();
        if (rs.next()) {
            totalUsers = rs.getInt("total");
        }
        rs.close();
        pstmt.close();

        // 페이지에 맞는 유저 데이터 가져오기
        pstmt = jdbc.con.prepareStatement(query);
        int paramIndex = 1;
        if (hasSearchCondition) {
            pstmt.setString(paramIndex++, "%" + searchKeyword + "%");
        }
        pstmt.setInt(paramIndex++, pageSize);
        pstmt.setInt(paramIndex, offset);
        rs = pstmt.executeQuery();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>회원 목록</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/adminPage_style.css"> <!-- CSS 파일 연결 -->
</head>
<body>
    <div id="wrapper">
        <aside>
            <ul>
                <li><a href="adminPage_userList.jsp" class="active">회원 관리</a></li>
                <li><a href="adminPage_postList.jsp">게시글 관리</a></li>
                <li><a href="adminPage_commentList.jsp">채팅 관리</a></li>
                <li><a href="adminPage_fileList.jsp">파일 관리</a></li>
				<li><a href="adminPage_declarationList.jsp">신고 관리</a></li>                
            </ul>
            <div class="main-button">
       			<a href="main.jsp" class="button">메인으로</a>
   			</div>
        </aside>
        <section id="main-content">
            <h2>회원 목록</h2>
            <div class="search-container">
                <form id="search-form" action="adminPage_userList.jsp" method="get">
                    <label for="searchField"></label>
                    <select name="search-column" id="searchField">
                        <option value="uuid" <%= "uuid".equals(searchColumn) ? "selected" : "" %>>유저 번호</option>
                        <option value="id" <%= "id".equals(searchColumn) ? "selected" : "" %>>아이디</option>
                        <option value="name" <%= "name".equals(searchColumn) ? "selected" : "" %>>이름</option>
                        <option value="phone" <%= "phone".equals(searchColumn) ? "selected" : "" %>>전화번호</option>
                        <option value="email" <%= "email".equals(searchColumn) ? "selected" : "" %>>이메일</option>
                        <option value="area" <%= "area".equals(searchColumn) ? "selected" : "" %>>지역</option>
                    </select>
                    <input type="text" name="search-keyword" placeholder="검색어 입력" value="<%= searchKeyword != null ? searchKeyword : "" %>"/>
                    <button type="submit">검색</button>
                </form>
            </div>
            <div id="userList">
                <table border="1">
                    <thead>
                        <tr>
                            <th>유저 번호</th>
                            <th>아이디</th>
                            <th>이름</th>
                            <th>전화번호</th>
                            <th>이메일</th>
                            <th>지역</th>
                            <th>등록일자</th>
                            <th>수정</th>
                            <th>삭제</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% while (rs.next()) { %>
                            <tr>
                                <td><%= rs.getInt("uuid") %></td>
                                <td><%= rs.getString("id") %></td>
                                <td><%= rs.getString("name") %></td>
                                <td><%= rs.getString("phone") %></td>
                                <td><%= rs.getString("email") %></td>
                                <td><%= rs.getString("area") %></td>
                                <td><%= rs.getTimestamp("reg_date") %></td>
                                <td><a href="adminPage_updateUser.jsp?uuid=<%= rs.getInt("uuid") %>">수정</a></td>
                                <td><a href="adminPage_deleteUser.jsp?uuid=<%= rs.getInt("uuid") %>" onclick="return confirm('정말 삭제하시겠습니까?');">삭제</a></td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>

                <%
                // 페이지네이션 링크 생성
                int totalPages = (int) Math.ceil((double) totalUsers / pageSize);
                %>
                <div class="pagination">
                    <% for (int i = 1; i <= totalPages; i++) { %>
                        <a href="adminPage_userList.jsp?page=<%= i %>&search-column=<%= searchColumn %>&search-keyword=<%= searchKeyword != null ? searchKeyword : "" %>" <%= (i == currentPage) ? "class='active'" : "" %>><%= i %></a>
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

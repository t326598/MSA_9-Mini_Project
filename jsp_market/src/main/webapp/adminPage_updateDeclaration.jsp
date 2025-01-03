<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="dao.JDBConnection" %>
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
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>신고 게시글 수정</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/adminPage_style.css"> <!-- CSS 파일 연결 -->
    <style>
        #main-content {
            margin: 0 auto; /* 중앙 정렬 */
            width: 400px; /* 원하는 너비 설정 */
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 8px;
            background-color: #f9f9f9;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        form {
            width: 100%; /* 부모 요소의 너비에 맞춤 */
            margin-top: 20px;
        }

        label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
        }

        input[type="text"] {
            width: 100%;
            padding: 8px;
            margin-bottom: 12px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }

        input[type="submit"] {
            width: 100%;
            padding: 10px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
        }

        input[type="submit"]:hover {
            background-color: #0056b3;
        }

        h1 {
            text-align: center;
            color: #333;
            font-family: Arial, sans-serif;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>

<div id="wrapper">
    <aside>
        <ul>
            <li><a href="adminPage_userList.jsp">회원 관리</a></li>
            <li><a href="adminPage_postList.jsp">게시글 관리</a></li>
            <li><a href="adminPage_commentList.jsp">채팅 관리</a></li>
            <li><a href="adminPage_fileList.jsp">파일 관리</a></li>
            <li><a href="adminPage_declarationList.jsp" class="active">신고 관리</a></li>
        </ul>
            <div class="main-button">
       			<a href="main.jsp" class="button">메인으로</a>
   			</div>
    </aside>
    <section id="main-content">
        <h1>신고 게시글 수정</h1>

        <%
            String no = request.getParameter("no");
            if (no == null || no.isEmpty()) {
                out.println("<p>잘못된 접근입니다.</p>");
                return;
            }

            // 정상적으로 no가 있으면 처리
            JDBConnection jdbc = new JDBConnection();
            PreparedStatement psmt = null;
            ResultSet rs = null;

            try {
                String query = "SELECT * FROM declaration WHERE no=?";
                psmt = jdbc.con.prepareStatement(query);
                psmt.setInt(1, Integer.parseInt(no));
                rs = psmt.executeQuery();

                if (rs.next()) {
        %>
            <form action="adminPage_updateDeclaration_pro.jsp" method="post">
                <input type="hidden" name="no" value="<%= rs.getInt("no") %>">
                <label>작성자 번호:</label><input type="text" name="writer_no" value="<%= rs.getInt("writer_no") %>" readonly><br>
                <label>게시글 번호:</label><input type="text" name="board_no" value="<%= rs.getInt("board_no") %>" readonly><br>
                <label>내용:</label><input type="text" name="content" value="<%= rs.getString("content") %>"><br>
                <input type="submit" value="수정">
            </form>
        <%
                } else {
                    out.println("<p>신고 정보를 찾을 수 없습니다.</p>");
                }
            } catch (Exception e) {
                out.println("오류 발생: " + e.getMessage());
            } finally {
                if (rs != null) try { rs.close(); } catch (Exception e) {}
                if (psmt != null) try { psmt.close(); } catch (Exception e) {}
                if (jdbc.con != null) try { jdbc.con.close(); } catch (Exception e) {}
            }
        %>
    </section>
</div>

</body>
</html>

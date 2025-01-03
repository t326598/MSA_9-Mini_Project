<%@ page import="dao.JDBConnection" %>
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
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시글 정보 수정</title>
    <script>
        function showAlertAndRedirect(message) {
            alert(message);
            window.location.href = 'adminPage_postList.jsp'; // 메인 페이지로 이동
        }
    </script>
</head>
<body>

<%
    String no = request.getParameter("no");
    String title = request.getParameter("title");
    String category = request.getParameter("category");
    String price = request.getParameter("price");
    String status = request.getParameter("status");
    String content = request.getParameter("content");

    JDBConnection jdbc = new JDBConnection();
    PreparedStatement psmt = null;

    if (no != null && title != null && category != null && price != null && status != null && content != null) {
        try {
            String query = "UPDATE board SET title=?, category=?, price=?, status=?, content=? WHERE no=?";
            psmt = jdbc.con.prepareStatement(query);
            psmt.setString(1, title);
            psmt.setString(2, category);
            psmt.setInt(3, Integer.parseInt(price));
            psmt.setInt(4, Integer.parseInt(status));
            psmt.setString(5, content);
            psmt.setInt(6, Integer.parseInt(no));
            int result = psmt.executeUpdate();

            if (result > 0) {
                out.println("<script>showAlertAndRedirect('게시글 정보 수정 성공!');</script>");
            } else {
                out.println("<script>showAlertAndRedirect('게시글 정보 수정 실패!');</script>");
            }
        } catch (Exception e) {
            out.println("<script>showAlertAndRedirect('오류 발생: " + e.getMessage() + "');</script>");
            } finally {
            if (psmt != null) try { psmt.close(); } catch (Exception e) {}
            if (jdbc.con != null) try { jdbc.con.close(); } catch (Exception e) {}
        }
    } else {
        out.println("<script>showAlertAndRedirect('잘못된 접근입니다.');</script>");
    }
%>

</body>
</html>

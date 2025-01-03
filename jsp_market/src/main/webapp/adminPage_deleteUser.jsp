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
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>회원 삭제</title>
    <script>
        function showAlertAndRedirect(message) {
            alert(message);
            window.location.href = 'adminPage_userList.jsp'; 
        }
    </script>
</head>
<body>

<%
    String uuid = request.getParameter("uuid");
    JDBConnection jdbc = new JDBConnection();
    PreparedStatement psmt = null;

    if (uuid != null) {
        try {
            String query = "DELETE FROM user WHERE uuid=?";
            psmt = jdbc.con.prepareStatement(query);
            psmt.setInt(1, Integer.parseInt(uuid));
            int result = psmt.executeUpdate();

            if (result > 0) {
                out.println("<script>showAlertAndRedirect('회원 삭제 성공!');</script>");
            } else {
                out.println("<script>showAlertAndRedirect('회원 삭제 실패!');</script>");
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

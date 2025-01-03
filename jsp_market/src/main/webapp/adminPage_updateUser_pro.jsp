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
    <title>회원 정보 수정</title>
    <script>
        function showAlertAndRedirect(message) {
            alert(message);
            window.location.href = 'adminPage_updateUser.jsp'; // 메인 페이지로 이동
        }
    </script>
</head>
<body>

<%
    String uuid = request.getParameter("uuid");
    String id = request.getParameter("id");
    String name = request.getParameter("name");
    String phone = request.getParameter("phone");
    String email = request.getParameter("email");
    String area = request.getParameter("area");

    JDBConnection jdbc = new JDBConnection();
    PreparedStatement psmt = null;

    if (uuid != null && id != null && name != null && phone != null && email != null && area != null) {
        try {
            String query = "UPDATE user SET id=?, name=?, phone=?, email=?, area=? WHERE uuid=?";
            psmt = jdbc.con.prepareStatement(query);
            psmt.setString(1, id);
            psmt.setString(2, name);
            psmt.setString(3, phone);
            psmt.setString(4, email);
            psmt.setString(5, area);
            psmt.setInt(6, Integer.parseInt(uuid));
            int result = psmt.executeUpdate();

            if (result > 0) {
                out.println("<script>showAlertAndRedirect('회원 정보 수정 성공!');</script>");
            } else {
                out.println("<script>showAlertAndRedirect('회원 정보 수정 실패!');</script>");
            }
        } catch (Exception e) {
            out.println("<script>showAlertAndRedirect('오류 발생: " + e.getMessage() + "');</script>");
        } finally {
            if (psmt != null) try { psmt.close(); } catch (Exception e) {}
            if (jdbc.con != null) try { jdbc.con.close(); } catch (Exception e) {}
        }
    } else {
       /*  out.println("<script>showAlertAndRedirect('잘못된 접근입니다.');</script>"); */
    }
%>

</body>
</html>

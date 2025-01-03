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
    <title>신고 게시글 수정</title>
    <script>
        function showAlertAndRedirect(message) {
            alert(message);
            window.location.href = 'adminPage_declarationList.jsp'; // 신고 게시글 목록 페이지로 이동
        }
    </script>
</head>
<body>

<%
    String no = request.getParameter("no");
    String writer_no = request.getParameter("writer_no");
    String board_no = request.getParameter("board_no");
    String content = request.getParameter("content");

    JDBConnection jdbc = new JDBConnection();
    PreparedStatement psmt = null;

    if (no != null && writer_no != null && board_no != null && content != null) {
        try {
            String query = "UPDATE declaration SET writer_no=?, board_no=?, content=? WHERE no=?";
            psmt = jdbc.con.prepareStatement(query);
            psmt.setInt(1, Integer.parseInt(writer_no));
            psmt.setInt(2, Integer.parseInt(board_no));
            psmt.setString(3, content);
            psmt.setInt(4, Integer.parseInt(no));
            int result = psmt.executeUpdate();

            if (result > 0) {
                out.println("<script>showAlertAndRedirect('신고 게시글 수정 성공!');</script>");
            } else {
                out.println("<script>showAlertAndRedirect('신고 게시글 수정 실패!');</script>");
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

<%@page import="dto.User"%>
<%@page import="service.DeclarationServiceImpl"%>
<%@page import="service.DeclarationService"%>
<%@page import="dto.Declaration"%>
<%@ page contentType="text/html; charset=UTF-8" %>


<%
    request.setCharacterEncoding("UTF-8");

    // 폼 데이터 받기
    int boardNo = Integer.parseInt(request.getParameter("boardNo"));
    int writer = Integer.parseInt(request.getParameter("writer"));
    String content = request.getParameter("content");
    User user = (User) session.getAttribute("loginUser");
	
    // DTO 객체에 신고 데이터 설정
    Declaration de = new Declaration();
    
    de.setBoard_no(boardNo);
    de.setContent(content);
    de.setWriter_no(user.getUuid());
  
	
    
    
    // Service 호출하여 신고 내용 저장
    DeclarationService report = new DeclarationServiceImpl();
  
    int result = report.insert(de);
    

    if (result > 0) {
    	  out.println("<script>");
          out.println("alert('신고가 성공적으로 접수되었습니다.');");
          out.println("window.close();"); // 현재 팝업 창 닫기
          out.println("</script>");
    } else {
        out.println("<script>alert('신고 접수에 실패했습니다. 다시 시도해주세요.'); history.back();</script>");
    }
%>
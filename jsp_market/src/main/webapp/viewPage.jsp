<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dto.Comment_room"%>
<%@page import="service.Comment_roomServiceImpl"%>
<%@page import="service.Comment_roomService"%>
<%@page import="service.UserService"%>
<%@page import="service.UserServiceImpl"%>
<%@page import="java.util.List"%>
<%@page import="service.FilesServiceImpl"%>
<%@page import="service.FilesService"%>
<%@page import="dto.Files"%>
<%@page import="service.BoardServiceImpl"%>
<%@page import="dto.Board"%>
<%@page import="dto.User"%>
<%@page import="service.BoardService"%>
<%@page import="lombok.EqualsAndHashCode.Include"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="layout/jstl.jsp"%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%
	
	int boardNo = Integer.parseInt(request.getParameter("no"));
	
	// BoardService를 통해 게시글의 상세 내용을 가져옴
	Comment_roomService crs = new Comment_roomServiceImpl();
	
	BoardService boardService = new BoardServiceImpl();
	Board board = boardService.select(boardNo);
	
	FilesService filesService = new FilesServiceImpl();
	Files file = filesService.select(boardNo); // 단일 파일 객체 가져오기
 
    UserService user1 = new UserServiceImpl();
    User sellerUser = user1.select(board.getUuid());
    if(sellerUser == null){
    	sellerUser = new User();
    	sellerUser.setId("회원 탈퇴된 계정");
    }
    
	List<Board> boardList = new ArrayList();
	boardList = boardService.list();
	int maxCount = boardList.size();
	int count = 0;
	System.out.println(count);
	if(maxCount > 4){
		count=maxCount-4;
	}
    
	
%>

<script>
function openPopupdec() {
    window.open("declaration.jsp?no=<%=board.getNo()%>", "팝업창", "width=600,height=400,resizable=yes");
}
</script>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>판매글</title>
    <script src="js/jquery-3.7.1.min.js"></script>
    <script src="js/insert.js"></script>
    <script src="hf.js"></script>
    <link rel="stylesheet" href="static/css/viewPage.css">
</head>
<body>

	<jsp:include page="layout/header.jsp"></jsp:include>
	
	<div class="maincontainer">
    <div class="container">
        <div class="title-box">
    
            <h1 class="main-title" style="margin-top: 20px; font-size: 50px">판매글</h1>
            <br>
         
          <%
          User user=null;
          if(session.getAttribute("loginUser")!=null){
        	  user = (User) session.getAttribute("loginUser");
          
          if( user.getUuid() == board.getUuid()){
        		   %>
						<div class="button">
                       <input  value="수정하기" type="button" id="update" onclick="location.href='updatePage.jsp?no=<%=board.getNo() %>'" />
               <input type="button" id="delete" value="삭제하기" onclick="confirmDelete(<%= board.getNo() %>)" />
            </div>  
		<%
          }
          }
          Date regDate = board.getReg_date();
          Date updDate = board.getUpd_date();
          SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy년 MM월 dd일 HH시 mm분");
          String formattedRegDate = dateFormat.format(regDate);
          String formattedUpdDate = dateFormat.format(updDate);
          
		%>

				
    		
    	<label class="sellUser" >판매자: <%= sellerUser.getId() %></label>
    	<br>
   
<br>
            <!-- 폼 액션을 서블릿으로 설정, enctype 추가 -->
      
       
            <div class="inputed">
           <img class="bgImg" src="static/img/default_apple.png" alt="">
                    <div class="input-group">
                         
                        <div class="title-box">
                        <h2 class="title" ><%= board.getTitle() %></h2>
                    </div>
                <br>
                	
                    
              <div class="content-box"  id="input_title">
                  
                        <label for="category">카테고리: <%= board.getCategory() %> &nbsp; &nbsp;&nbsp;&nbsp; </label>
                        

                        <label for="status"> <%= board.getStatus() == 1 ? "판매 중" : "판매 완료" %>  &nbsp; &nbsp;&nbsp;&nbsp;</label>
                        
						 <label>가격: <%= board.getPrice() %>원 &nbsp;&nbsp;&nbsp;&nbsp;</label>

                         </div>
                 
                        </div>
                        <br><br>
                      
                   <%if (file != null && file.getFile_path() != null) {  %>
        				<img class="img_input" id="uploadedImage" src="/jsp_market/img?no=<%= file.getTable_no() %>" style="max-width: 400px; height: auto;" 
        				onerror="this.onerror=null; this.src='static/img/default_apple.png';"/>
				  	<%
				    } else {
				    %>
				        <p>이미지가 없습니다.</p>
				    <%
				    } 
				    %>
                    <br><br>
                    
                    <div class="input-group">
                        <pre for="content" id="content" style="font-size: 25px; font-weight: bold;"><%= board.getContent() %> </pre>
                        </div>
                        
                          <!-- 신고버튼 생성 -->
                    </div>
			<c:if test="${sessionScope.loginId != null}">

				<div class="btn">
					<input type="button" id="Declaration" class="dec"
						onclick="openPopupdec()"
						value="게시글신고" />
				</div>
			</c:if>
        
                <div class="button">
                <input type="button" id="main" onclick="window.location.href='boardList.jsp';" value="목록으로" />
                <!--  복붙해야됨 -->
                <input type="hidden" id="Board_no" value="<%=board.getNo() %>" />
                <input type="hidden" id="Main_no" value="<%=board.getUuid() %>" />
                <%
                	if(user!=null){
                %>
                <input type="hidden" id="Sub_no" value="<%=user.getUuid() %>" />
                <input type="submit" id="insert" onclick="openPopup()" value="채팅하기" />
                <%
                	}
                %>
                   <!--  복붙해야됨 -->
            </div>      
        </div>  
        </div>
        <%
        	if( (user!=null) && (user.getUuid()==sellerUser.getUuid())){
        %>
        <div class="container2">
        	<div class="container2-title">
				<h1>구매자 리스트</h1>        	
        	</div>
        	<div class="container2-link">
        		<%	
        			List<Comment_room> crList = new ArrayList();
        			crList = crs.list(boardNo);
        			int buyerCount = crList.size();
        			for(int iasdf=0;iasdf<buyerCount;iasdf++){
        				int sub_no = crList.get(iasdf).getSub_no();
        				User sub_user = new User();
        				sub_user = user1.select(sub_no);
        		%>
<%--         			<input type="hidden" id="Board_no2" value="<%=crList.get(iasdf).getNo() %>" /> --%>
        			<input class="vkqslek" type="submit" onclick="openPopup2(<%=crList.get(iasdf).getNo()%>)" value="<%=sub_user.getName()%>" />
        		<%
        			}
        		%>
        	</div>
        </div>
        <%
        	}
        %>
      
        </div>
       <div class="cardcontainer">
              <label style="text-align: center;">최근에 올라온 판매글 보기</label>

<div class="card-box">
	<!-- 카드 -->
	<%
		for(int i = maxCount - 1; i > count - 1; i--) {
			int boardNo1 = boardList.get(i).getNo(); // 각 게시글의 번호를 가져옵니다.
	%>	
		<div class="card">
			<div class="card-img">
				<a href="viewPage.jsp?no=<%= boardNo1 %>">
					<%
						file = filesService.select(boardNo1, "board");

						if (file == null) {
					%>
							<img class="img_input" src="static/img/default_apple.png" width="100%" alt="" onerror="this.onerror=null; this.src='static/img/default_apple.png';">
					<%
						} else {
					%>
							<img class="img_input" src="/jsp_market/img?no=<%= file.getTable_no() %>" width="100%" height="200px" alt="" onerror="this.onerror=null; this.src='static/img/default_apple.png';">
					<%
						}
					%>
				</a>
			</div>
			<div class="card-title">
				<h2>
					<a href="viewPage.jsp?no=<%= boardNo1 %>">
						<%= boardList.get(i).getTitle() %>
					</a>
				</h2>
			</div>
			<div class="card-content">
				<p>가격 : <%= boardList.get(i).getPrice() %></p>
			</div>
			<div class="card-bottom">
				<div class="item">
					<span>분류/<%= boardList.get(i).getCategory() %></span>
				</div>
			</div>
		</div>
	<%
		}
	%>
</div>
					<a href="boardList.jsp">더보기..</a>
        </div>
        
        
			<!--  복붙해야됨 -->
	<script>
        function openPopup() {
            var Board_no = document.getElementById('Board_no').value;
            var Main_no = document.getElementById('Main_no').value;
            var Sub_no = document.getElementById('Sub_no').value;

            // 팝업창을 열면서 파라미터를 URL로 전달
            var popupUrl = "chatRoom_insert.jsp?Board_no=" + encodeURIComponent(Board_no) + 
                           "&Main_no=" + encodeURIComponent(Main_no) + 
                           "&Sub_no=" + encodeURIComponent(Sub_no);
            window.open(popupUrl, "PopupWindow", "width=1200,height=700");
        }
        function openPopup2(Board_no2) {
/*         var Board_no2 = document.getElementById('Board_no2').value; */
        // 정수로 변환
        Board_no2 = parseInt(Board_no2, 10);
        
        if (isNaN(Board_no2)) {
            alert("유효한 숫자를 입력하세요.");
            return;
        }
        
        // 팝업창을 열면서 파라미터를 URL로 전달
        var popupUrl = "chatRoom.jsp?no=" + encodeURIComponent(Board_no2);
        window.open(popupUrl, "PopupWindow", "width=1200,height=700");
        }
        
     
    </script>
       <script type="text/javascript">
        function confirmDelete(no) {
            if (confirm("삭제하시겠습니까?")) {
                location.href = 'delete_pro.jsp?no=' + no;
            }
        }
    </script>
   <!--  복붙해야됨 -->


    <jsp:include page="layout/footer.jsp"></jsp:include>
</body>
</html>
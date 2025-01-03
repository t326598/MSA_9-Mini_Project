<%@page import="service.UserServiceImpl"%>
<%@page import="service.UserService"%>
<%@page import="dto.User"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dto.Comment"%>
<%@page import="java.util.List"%>
<%@page import="dto.Comment_room"%>
<%@page import="service.Comment_roomServiceImpl"%>
<%@page import="service.Comment_roomService"%>
<%@page import="service.CommentServiceImpl"%>
<%@page import="service.CommentService"%>
<%@page import="service.BoardServiceImpl"%>
<%@page import="service.BoardService"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link rel="stylesheet" href="static/css/reset.css">
	<link rel="stylesheet" href="static/css/chatRoom.css">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" />
	<title>채팅룸</title>
</head>
<body>

	<span id="top"></span>
	<%	
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		BoardService boardService = new BoardServiceImpl();
		UserService userService = new UserServiceImpl();
		Comment_roomService comment_roomService = new Comment_roomServiceImpl();
		CommentService commentService = new CommentServiceImpl();
		Comment_room cmR = new Comment_room();
		Comment cm = new Comment();
		int room_no = Integer.parseInt(request.getParameter("no"));
		cmR = comment_roomService.select(room_no);
	%>
	<header>
		<div class="header">
			<button type="button" class="refreshButton" id="refreshButton">새로고침</button>
			<% 
				User user1= userService.select(cmR.getMain_no());
				User user2= userService.select(cmR.getSub_no()); 
			if((user1 == null) || (user2==null)){
				try {
		            // 2초 동안 일시 정지
		            Thread.sleep(2000);
		        } catch (InterruptedException e) {
		            e.printStackTrace();
		        }
				response.sendRedirect("chatRoom.jsp?no="+room_no);
			}
			User loginuser = new User();
			loginuser=(User) session.getAttribute("loginUser");
			if(loginuser != null){
				if((loginuser.getUuid()!= user1.getUuid()) && (loginuser.getUuid()!=user2.getUuid())){
					response.sendRedirect("test.jsp");
				}
			}
			else{
				response.sendRedirect("test.jsp");
			}
			%>
			<h6 class="header-title"><%=user1.getName() %>님, <%=user2.getName() %>님</h6>
		</div>
	</header>
	<div class="container">
		<img class="bgImg" src="static/img/default_apple.png" alt="">
		<%
			List<Comment> commentList = new ArrayList();
			commentList = commentService.list(cmR.getNo());
			int CMcount = commentList.size();
			User user = null;
			for(int i=0;i<CMcount;i++){
		%>
		<%
			user = null;
			user= userService.select(commentList.get(i).getUuid());
			if(commentList.get(i).getUuid()!=loginuser.getUuid()){
		%>
			<div class="chat">
			<div class="human">
				<div class="chatImg">
					<img src="static/img/default_apple.png" alt="">
				</div>
				
				<div class="human-name">
					<H6><%=user.getName()%>님</H6>
				</div>
				
			</div>
			<div class="chat_comment"><%=commentList.get(i).getContent()%></div>
			</div>
		<%
			}else{
		%>
		<div class="chat1">
			<div class="human">
				<div class="chatImg">
					<img src="static/img/default_apple.png" alt="">
				</div>
				
				<div class="human-name">
					<H6><%=user.getName()%>님</H6>
				</div>
				
			</div>
			<div class="chat_comment"><%=commentList.get(i).getContent()%></div>
		</div>
		
		<%
				}
		%>
		<%
			}
		%>
	</div>
	<!-- 플로팅 버튼 -->
    <div class="floating">
        <a href="#top"><i class="fa fa-arrow-circle-up"></i></a>
    </div>
    <div class="floating_down">
        <a href="#bottom"><i class="fa fa-arrow-circle-down"></i></a>
    </div>
	<footer>
	<div class="chat_input">
		<form id="chatForm" action="chatRoom_chat.jsp" method="post">
				<input type="text" class="chat_input-text" id="chat" name="chat" placeholder="채팅을 입력해주세요" required autofocus />
				<input type="hidden" name="room_No" value="<%=room_no%>"/>
				<button type="submit" class="chat_input-butten" id="transferBtn"><i class="fa fa-arrow-circle-left"></i></button>
		</form>
	</div>
	</footer>
	<span id="bottom"></span>
	<script>
	
		let isScrolling = false;
		let intervalId;
		let scrollTimeout;
		
		document.getElementById('refreshButton').addEventListener('click', function() {
			location.reload(); // 페이지 새로 고침
   		 });
		
		function checkForUpdates() {
		    if (!isScrolling) {
		        window.location.reload(); // 페이지 새로 고침
		    }
		}
		function startInterval() {
		    intervalId = setInterval(checkForUpdates, 2000); // 5초마다 확인
		}

		function stopInterval() {
		    clearInterval(intervalId);
		}
        
		window.addEventListener('scroll', () => {
		    isScrolling = true;
		    stopInterval(); // 스크롤 중지 시 인터벌 중단

		    // 스크롤이 멈춘 후 인터벌 재개
		    clearTimeout(scrollTimeout);
		    scrollTimeout = setTimeout(() => {
		        isScrolling = false;
		        startInterval(); // 스크롤이 멈추면 인터벌 재개
		    }, 3500); // 100ms 후에 스크롤이 멈췄다고 간주
		});

		// 초기 인터벌 시작
		startInterval();
        
        
        window.onload = function() {
            // 페이지가 로드된 후 스크롤을 가장 아래로 이동
            window.scrollTo(0, document.body.scrollHeight);
            
            // 로컬 스토리지에서 저장된 값 불러오기
            const savedChat = localStorage.getItem('chatingInput');
            if (savedChat) {
                document.getElementById('chat').value = savedChat;
            }
            
        };
        
     	// 입력 필드의 값 변경 시 로컬 스토리지에 저장
        document.getElementById('chat').addEventListener('input', function() {
            localStorage.setItem('chatingInput', this.value);
        });
        
     	// 폼 제출 시 로컬 스토리지 초기화
        document.getElementById('chatForm').addEventListener('submit', function() {
            localStorage.removeItem('chatingInput');
        });
        
	</script>
</body>
</html>





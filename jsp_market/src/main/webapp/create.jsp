<%@page import="lombok.EqualsAndHashCode.Include"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>판매글 등록하기</title>
    <script src="js/jquery-3.7.1.min.js"></script>
    <script src="js/insert.js"></script>
    <script src="hf.js"></script>
    <link rel="stylesheet" href="static/css/CreatePost.css">
</head>
<body>
	<jsp:include page="layout/header.jsp"></jsp:include>

    <div class="container">
        <div class="title-box">
            <h1 class="main-title" style="margin: 10px; font-size: 50px">상품 등록하기</h1>

            <!-- 폼 액션을 서블릿으로 설정, enctype 추가 -->
            <form action="create_pro.jsp" method="post" enctype="multipart/form-data">
                <div class="inputed">
                    <div class="input-group" id="input_title">
                        <label for="title" style="font-size: 25px;">제목 :&nbsp;
                        <input type="text" name="title" placeholder="제목을 입력하세요" id="title" style=" padding: 10px;" required /></label>
                         
                        <label for="category">주제 :&nbsp;
                        <select name="category" id="category">
                            <option value="전자/게임">전자/게임</option>
                            <option value="운동">운동</option>
                            <option value="의류">의류</option>
                            <option value="가구">가구</option>
                            <option value="기타">기타</option>
                        </select>
                        </label>

                        <label for="status"> 판매상태 :&nbsp;
                        <select name="status" id="status">
                            <option value="1">판매중</option>
                            <option value="2">판매완료</option>
                        </select>
                        </label>

                        <label>가격: <input type="number" id="price" name="price" required /> &nbsp;원</label>
                    </div>
                
                    <div class="input-group" id="img_input">
                        <img id="uploadedImage" src="" style=" max-width: 400px; height: auto;" />
                    </div>

                    <div class="input-group">
                        <label for="content">내용</label><p></p>
                        <textarea name="content" id="content" cols="30" rows="10" style="width: 100%; height:300px; resize: none; text-align: center;"></textarea>
                    </div>

                    <div class="button">
                        <div class="input-group">
                            <label>상품 이미지 첨부: </label>
                            <input type="file" name="image" id="image" accept="image/*" multiple>
                        </div>
                           
                        <input type="button" id="main" onclick="window.location.href='boardList.jsp';" value="목록으로" />
                        <input type="submit" id="insert" value="등록하기" />
                    </div>
                </div>
            </form>
        </div>
    </div>
    
    <jsp:include page="layout/footer.jsp"></jsp:include>

    <script>
        document.getElementById('image').addEventListener('change', function(event) {
            const file = event.target.files[0];
            if (file) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    document.getElementById('uploadedImage').src = e.target.result;
                }
                reader.readAsDataURL(file); // 파일을 읽어 미리보기로 표시
            }
        });
    </script>
</body>
</html>
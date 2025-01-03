<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="dto.Board" %>
<%@ page import="dto.Comment_room" %>
<%@ page import="dto.Comment" %>
<%@ page import="service.Comment_roomService" %>
<%@ page import="service.Comment_roomServiceImpl" %>
<%@ page import="service.CommentService" %>
<%@ page import="service.CommentServiceImpl" %>
<%@ page import="service.DeclarationService" %>
<%@ page import="service.DeclarationServiceImpl" %>
<%@ page import="service.FilesService" %>
<%@ page import="service.FilesServiceImpl" %>
<%@ page import="service.UserService"%>
<%@ page import="service.UserServiceImpl"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>권한 부족</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<!-- 헤더 섹션 -->
<div class="container">
    <header class="d-flex flex-wrap justify-content-center py-3 mb-4 border-bottom">
        <a href="" class="d-flex align-items-center mb-3 mb-md-0 me-md-auto text-dark text-decoration-none">
          <svg class="bi me-2" width="40" height="32"><use xlink:href="#bootstrap"></use></svg>
          <span class="fs-4">경고</span>
        </a>
      </header>
</div>

<!-- Heroes 섹션 -->
<section class="bg-light py-5">
    <div class="px-4 py-5 my-5 text-center">
        <img class="d-block mx-auto mb-4" src="static/img/apple_register.png" alt="" width="100" height="100">
        <h1 class="display-5 fw-bold">권한 부족</h1>
        <div class="col-lg-6 mx-auto">
            <p class="lead mb-4"></p>
            <div class="d-grid gap-2 d-sm-flex justify-content-sm-center">
            </div>
        </div>
    </div>
</section>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

<%@page import="dto.Board"%>
<%@page import="dao.BoardDAO"%>
<%@page import="dto.Files"%>
<%@page import="service.BoardServiceImpl"%>
<%@page import="service.BoardService"%>
<%@page import="service.FilesServiceImpl"%>
<%@page import="service.FilesService"%>
<%@page import="java.io.File"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="org.apache.commons.fileupload.DiskFileUpload"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    String boardId = request.getParameter("no");
    BoardService bd = new BoardServiceImpl();
    FilesService fs = new FilesServiceImpl();
    DiskFileUpload upload = new DiskFileUpload();
    String path = "C:\\UPLOAD";

    // 파일 업로드 처리
    List<FileItem> items = upload.parseRequest(request);
    Iterator<FileItem> params = items.iterator();
    
    Board board = bd.select(Integer.parseInt(boardId)); // 기존 게시글 정보 가져오기
    Files fff = fs.select(Integer.parseInt(boardId), "board");

    
    while (params.hasNext()) {
        FileItem item = params.next();

        if (item.isFormField()) {
            String name = item.getFieldName();
            String value = item.getString("utf-8");
            switch (name) {
                case "title":
                    board.setTitle(value);
                    break;
                case "content":
                    board.setContent(value);
                    break;
                case "category":
                    board.setCategory(value);
                    break;
                case "status":
                    board.setStatus(Integer.parseInt(value));
                    break;
                case "price":
                    board.setPrice(Integer.parseInt(value));
                    break;
            }
        } else {
            String fileName = item.getName();
            if (fileName != null && !fileName.isEmpty()) {
                fileName = fileName.substring(fileName.lastIndexOf("\\") + 1);
                fff.setFile_path(path + "\\" + fileName);
                File uploadedFile = new File(path + "\\" + fileName);
                item.write(uploadedFile); // 파일 저장
            }
        }
    }
    board.setUpd_date(new java.util.Date());
    
    // 게시글 업데이트
    bd.update(board);
    fs.update(fff);

    response.sendRedirect("viewPage.jsp?no=" + boardId);
%>

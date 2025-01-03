<%@page import="dao.BoardDAO"%>
<%@page import="dto.Files"%>
<%@page import="service.BoardServiceImpl"%>
<%@page import="service.BoardService"%>
<%@page import="service.FilesServiceImpl"%>
<%@page import="service.FilesService"%>
<%@page import="dto.User"%>
<%@page import="dto.Board"%>
<%@page import="java.io.File"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="org.apache.commons.fileupload.DiskFileUpload"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
DiskFileUpload upload = new DiskFileUpload();
/* String path = application.getRealPath("/userImg"); // 실제 경로 확인 */
/* String path = "C:\\UPLOAD"; */
String path = application.getRealPath("/webapp/static/fimg");

upload.setSizeMax(10 * 1000 * 1000); // 10MB - 파일 최대 크기
upload.setSizeThreshold(4 * 1024); // 4MB - 메모리상의 최대 크기

List<FileItem> items = upload.parseRequest(request);
Iterator<FileItem> params = items.iterator();
BoardService bd = new BoardServiceImpl();
FilesService fs = new FilesServiceImpl();

String paramTitle = "";
String paramContent = "";
String paramCategory = "";
int paramStatus = 0;
int paramPrice = 0;

User user = (User) session.getAttribute("loginUser");
Board board = new Board();
Files fff = new Files();

fff.setCode(10);
fff.setTable_name("board");

while (params.hasNext()) {
	FileItem item = params.next();

	// 일반 데이터
	if (item.isFormField()) {
		String name = item.getFieldName();
		String value = item.getString("utf-8");

		if (name.equals("title")) {
	paramTitle = value;
		} else if (name.equals("content")) {
	paramContent = value;
		} else if (name.equals("category")) {
	paramCategory = value;
		} else if (name.equals("status")) {
	paramStatus = Integer.parseInt(value);
		} else if (name.equals("price")) {
	paramPrice = Integer.parseInt(value);
		}
	}
	// 파일 데이터
	else {
		String fileName = item.getName();
		fileName = fileName.substring(fileName.lastIndexOf("\\") + 1);

		// 경로 확인 및 디렉토리 생성
		File dir = new File(path);
		if (!dir.exists()) {
	boolean created = dir.mkdirs();
	if (!created) {
		out.println("디렉토리 생성 실패: " + path);
		return; // 오류 발생 시 종료
	}
		}

		File file = new File(dir, fileName);
		/*         fff.setFile_path("userImg/" + fileName); // DB에 저장할 경로 */
		fff.setFile_path(path + "/" + fileName);
		try {
	item.write(file); // 파일 저장
		} catch (Exception e) {
	//out.println("파일 저장 실패: " + e.getMessage());
	//return; // 오류 발생 시 종료
		}
	}
}

board.setTitle(paramTitle);
board.setContent(paramContent);
board.setPrice(paramPrice);
board.setStatus(paramStatus);
board.setCategory(paramCategory);
board.setUuid(user.getUuid());

int boardId = bd.insert(board);

fff.setTable_no(boardId);

fs.insert(fff);

response.sendRedirect("main.jsp");
%>
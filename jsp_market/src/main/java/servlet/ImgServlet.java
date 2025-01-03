package servlet;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.Files;
import service.FilesService;
import service.FilesServiceImpl;

@WebServlet("/img")
public class ImgServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private FilesService filesService = null;

	public ImgServlet() {
		super();
		this.filesService = new FilesServiceImpl();
	}

	// /img?no=파일번호
	// <img src="/img?no=파일번호" />
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 파일 번호 : no
		String no = request.getParameter("no");
		// 파일명 유효성 검사
		if (no == null || no.isEmpty()) {
			response.getWriter().println("파일명이 저장되지 않았습니다.");
			return; // 메소드 종료
		}
		
		// 이미지 조회
		int fileNo = Integer.parseInt(no);
		Files uploadedFile = filesService.select(fileNo);
		// 파일 경로
		String filePath = uploadedFile.getFile_path();
		String ext = filePath.substring(filePath.lastIndexOf(".") +1).toLowerCase();
		// 이미지 컨텐츠 타입: image/jpeg, image/png, image/gif, /image/webp
		String contentType;
		switch (ext) {
			case "jpg": 
			case "jpeg":
					contentType = "image/jpeg";
					break;
			case "png":
					contentType = "image/png";
					break;
			case "gif": 
				contentType = "image/gif";
				break;
			case "webp":
				contentType = "image/webp";
				break;
			default:
				response.getWriter().println("이미지 형식이 아닙니다.");
				return;
		}
		// 응답 헤더 컨텐츠 타입 지정
		response.setContentType(contentType);
		File file = new File(filePath);

		// 파일 존재 여부
		if (!file.exists()) {
			response.getWriter().println("파일이 존재하지 않습니다.");
			return;
		}
		// 이미지 파일을 서버에서 파일 입력 : FileInputStream
		// 입력받은 이미지 파일을 클라이언트로 출력 : ServletOutputStream
		// try-withresource (Auto Close)
		try(FileInputStream fis = new FileInputStream(file); 
				ServletOutputStream sos = response.getOutputStream()) {
			byte[] buffer = new byte[4096];
			int data = -1;
			while((data = fis.read(buffer)) != -1) {
				sos.write(buffer, 0, data);
			}
		}  catch(Exception e) {
			System.err.println("이미지 파일 전송 중 에러발생");
			e.printStackTrace();
		}
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doGet(request, response);
	}

}

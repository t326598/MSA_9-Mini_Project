package dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.alohaclass.jdbc.dao.BaseDAOImpl;

import dto.Files;

public class FilesDAO extends BaseDAOImpl<Files> {

	@Override
	public Files map(ResultSet rs) throws Exception {
		Files file = new Files();
		file.setNo( rs.getInt("no") );
		file.setFile_path( rs.getString("file_path") );
		file.setTable_no( rs.getInt("table_no") );
		file.setTable_name( rs.getString("table_name") );
		file.setCode( rs.getInt("code") );
		file.setReg_date( rs.getTimestamp("reg_date") );
		file.setUpd_date( rs.getTimestamp("upd_date") );
		return file;
	}

	@Override
	public String pk() {
		return "no";
	}

	@Override
	public String table() {
		return "files";
	}

	public Files select(int table_no, String table_name) {
		String sql="SELECT * "
				+ " FROM files"
				+ " WHERE table_no = ? AND table_name = ? ";
		Files index = null;
		try {
		psmt = con.prepareStatement(sql);
		psmt.setInt(1, table_no);
		psmt.setString(2, table_name);
		rs=psmt.executeQuery();
		if(rs.next()) {
			index = new Files();
			index.setNo(rs.getInt("no"));
			index.setFile_path(rs.getString("file_path"));
			index.setTable_no(rs.getInt("table_no"));
			index.setTable_name(rs.getString("table_name"));
			index.setCode(rs.getInt("code"));
			index.setReg_date(rs.getTimestamp("reg_date"));
			index.setUpd_date(rs.getTimestamp("upd_date"));
		}
	} catch (Exception e) {
		System.err.println("FilesDAO : 테이블명,테이블 번호로 조회 시 예외 발생");
	}
	return index;
	}	
	
	public List<Files> list(int code) {
		// 게시글 목록을 담을 컬렉션 객체 생성
		List<Files> List = new ArrayList<Files>();

		// SQL 작성
		String sql = "SELECT * " 
					+ " FROM files"
					+ " WHERE code = ?";

		try {
			// 1. SQL 실행 객체 생성 - Statement (stmt)
			psmt = con.prepareStatement(sql);
			psmt.setInt(1, code);
			// 2. SQL 실행 요청 -> 결과 ResultSet (rs)
			rs = psmt.executeQuery();
			// 3. 조회된 결과를 리스트(boardList)에 추가
			while (rs.next()) {
				Files file = new Files();
				// 결과 데이터 가져오기
				// rs.getXXX("컬럼명") : 해당 컬럼의 데이터를 반환
				file.setNo(rs.getInt("no"));
				file.setFile_path(rs.getString("file_path"));
				file.setTable_no(rs.getInt("table_no"));
				file.setTable_name(rs.getString("table_name"));
				file.setCode(rs.getInt("code"));
				file.setReg_date(rs.getTimestamp("reg_date"));
				file.setUpd_date(rs.getTimestamp("upd_date"));
				// 게시글 목록 추가
				List.add(file);
			}
			// 4. 게시글 목록 반환

		} catch (SQLException e) {
			System.err.println("FilesDAO : 코드 별 list 예외발생");
			e.printStackTrace();
		}
		return List;
	}	
}

package dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.alohaclass.jdbc.dao.BaseDAOImpl;

import dto.Board;

public class BoardDAO extends BaseDAOImpl<Board>  {

	public int insert(Board index) {
	int insertedId=0;
	
	String sql = " INSERT INTO board(title,category,price,status,content,uuid)"
			+ " VALUES( ?,?,?,?,?,?)";
	
	try {
		psmt = con.prepareStatement(sql);
		psmt.setString(1, index.getTitle());
		psmt.setString(2, index.getCategory());
		psmt.setInt(3, index.getPrice());
		psmt.setInt(4, index.getStatus());
		psmt.setString(5, index.getContent());
		psmt.setInt(6, index.getUuid());
		psmt.executeUpdate();
	    // 마지막으로 삽입된 ID 가져오기
	    try (Statement stmt = con.createStatement()) {
	        ResultSet rs = stmt.executeQuery("SELECT LAST_INSERT_ID();");
	        if (rs.next()) {
	            insertedId = rs.getInt(1);
	        }
	    }
	} catch (Exception e) {
		System.err.println("BoardDAO : insert 시,예외 발생");
		e.printStackTrace();
	}
	return insertedId;
}
	
	@Override
	public Board map(ResultSet rs) throws Exception {
		Board board = new Board();
		board.setNo( rs.getInt("no") );
		board.setTitle( rs.getString("title") );
		board.setCategory(rs.getString("category"));
		board.setPrice( rs.getInt("price") );
		board.setStatus( rs.getInt("status") );
		board.setContent( rs.getString("content") );
		board.setReg_date( rs.getTimestamp("reg_date") );
		board.setUpd_date( rs.getTimestamp("upd_date") );
		board.setUuid( rs.getInt("uuid") );
		return board;
	}

	@Override
	public String pk() {
		return "no";
	}

	@Override
	public String table() {
		return "board";
	}
	
	public List<Board> list(int uuid) {
	// 게시글 목록을 담을 컬렉션 객체 생성
	List<Board> boardList = new ArrayList<Board>();

	// SQL 작성
	String sql = "SELECT * " 
			+ " FROM board"
			+ " WHERE uuid = ?";

	try {
		// 1. SQL 실행 객체 생성 - Statement (stmt)
		psmt = con.prepareStatement(sql);
		psmt.setInt(1, uuid);
		// 2. SQL 실행 요청 -> 결과 ResultSet (rs)
		rs = psmt.executeQuery();
		// 3. 조회된 결과를 리스트(boardList)에 추가
		while (rs.next()) {
			Board board = new Board();
			// 결과 데이터 가져오기
			// rs.getXXX("컬럼명") : 해당 컬럼의 데이터를 반환
			board.setNo(rs.getInt("no"));
			board.setTitle(rs.getString("title"));
			board.setCategory(rs.getString("category"));
			board.setPrice(rs.getInt("price"));
			board.setStatus(rs.getInt("status"));
			board.setContent(rs.getString("content"));
			board.setReg_date(rs.getTimestamp("reg_date"));
			board.setUpd_date(rs.getTimestamp("upd_date"));
			board.setUuid(rs.getInt("uuid"));
			// 게시글 목록 추가
			boardList.add(board);
		}
		// 4. 게시글 목록 반환

	} catch (SQLException e) {
		System.err.println("BoardDAO : list(uuid) 예외발생");
		e.printStackTrace();
	}
	return boardList;
}

	public int lastIndex() {
		// TODO Auto-generated method stub
		return 0;
	}
	
//	public int insert(Board index) {
//		int result = 0;
//		
//		String sql = " INSERT INTO board(title,category,price,status,content,uuid)"
//				+ " VALUES( ?,?,?,?,?,?)";
//		
//		try {
//			psmt = con.prepareStatement(sql);
//			psmt.setString(1, index.getTitle());
//			psmt.setString(2, index.getCategory());
//			psmt.setInt(3, index.getPrice());
//			psmt.setInt(4, index.getStatus());
//			psmt.setString(5, index.getContent());
//			psmt.setInt(6, index.getUuid());
//			result = psmt.executeUpdate();
//		} catch (Exception e) {
//			System.err.println("BoardDAO : insert 시,예외 발생");
//			e.printStackTrace();
//		}
//		return result;
//	}
//	
//	public List<Board> list() {
//		// 게시글 목록을 담을 컬렉션 객체 생성
//		List<Board> boardList = new ArrayList<Board>();
//
//		// SQL 작성
//		String sql = "SELECT * " + "FROM board";
//
//		try {
//			// 1. SQL 실행 객체 생성 - Statement (stmt)
//			stmt = con.createStatement();
//			// 2. SQL 실행 요청 -> 결과 ResultSet (rs)
//			rs = stmt.executeQuery(sql);
//			// 3. 조회된 결과를 리스트(boardList)에 추가
//			while (rs.next()) {
//				Board board = new Board();
//				// 결과 데이터 가져오기
//				// rs.getXXX("컬럼명") : 해당 컬럼의 데이터를 반환
//				board.setNo(rs.getInt("no"));
//				board.setTitle(rs.getString("title"));
//				board.setCategory(rs.getString("category"));
//				board.setPrice(rs.getInt("price"));
//				board.setStatus(rs.getInt("status"));
//				board.setContent(rs.getString("content"));
//				board.setReg_date(rs.getTimestamp("reg_date"));
//				board.setUpd_date(rs.getTimestamp("upd_date"));
//				board.setUuid(rs.getInt("uuid"));
//				// 게시글 목록 추가
//				boardList.add(board);
//			}
//			// 4. 게시글 목록 반환
//
//		} catch (SQLException e) {
//			System.err.println("BoardDAO : list 예외발생");
//			e.printStackTrace();
//		}
//		return boardList;
//	}
//	

//	
//	/**
//	 * 해당 번호 보드 조회
//	 * @param no
//	 * @return
//	 */
//	public Board select(int no) {
//		String sql="SELECT * "
//				+ " FROM board"
//				+ " WHERE no = ?";
//		Board index = null;
//		try {
//			psmt = con.prepareStatement(sql);
//			psmt.setInt(1, no);
//			rs=psmt.executeQuery();
//			if(rs.next()) {
//				index = new Board();
//				index.setNo(rs.getInt("no"));
//				index.setTitle(rs.getString("title"));
//				index.setCategory(rs.getString("category"));
//				index.setPrice(rs.getInt("price"));
//				index.setStatus(rs.getInt("status"));
//				index.setContent(rs.getString("content"));
//				index.setReg_date(rs.getTimestamp("reg_date"));
//				index.setUpd_date(rs.getTimestamp("upd_date"));
//				index.setUuid(rs.getInt("uuid"));
//			}
//		} catch (Exception e) {
//			System.err.println("BoardDAO : 보드 번호로 조회 시 예외 발생");
//		}
//		return index;
//	}	
//	
//	public boolean update(Board index) {
//		boolean result = false;
//		String sql="UPDATE board"
//				+ " SET title = ?,"
//				+ " category = ?,"
//				+ " price = ?,"
//				+ " status = ?"
//				+ " WHERE uuid = ?";
//		try {
//			psmt = con.prepareStatement(sql);
//			psmt.setString(1,index.getTitle());
//			psmt.setString(2, index.getCategory());
//			psmt.setInt(3, index.getPrice());
//			psmt.setInt(4, index.getStatus());
//			psmt.setInt(5,index.getUuid());
//			result = psmt.executeUpdate() == 0 ? false:true;
//		} catch (Exception e) {
//			System.err.println("BoardDAO :  update 시 예외 발생");
//		}
//		return result;
//	}	
//	
//	public boolean delete(int no) {
//		boolean result = false;
//		String sql="DELETE "
//				+ " FROM board"
//				+ " WHERE no = ?";
//		try {
//			psmt = con.prepareStatement(sql);
//			psmt.setInt(1, no);
//			result = psmt.executeUpdate() == 0 ? false:true;
//		} catch (Exception e) {
//			System.err.println("BoardDAO : delete시 예외 발생");
//		}
//		return result;
//	}	
	
	
}

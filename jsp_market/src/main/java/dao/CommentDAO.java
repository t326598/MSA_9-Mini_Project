package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import dto.Board;
import dto.Comment;

public class CommentDAO extends JDBConnection {
	public int insert(Comment index) {
		int result = 0;
		
		String sql = " INSERT INTO comment(room_no,content,uuid)"
				+ " VALUES( ?,?,?)";
		
		try(Connection conn = DataSource.getInstance().getConnection();
				PreparedStatement psmt = conn.prepareStatement(sql);) {
			psmt.setInt(1, index.getRoom_no());
			psmt.setString(2, index.getContent());
			psmt.setInt(3, index.getUuid());
			result = psmt.executeUpdate();
		} catch (Exception e) {
			System.err.println("CommentDAO : insert 시,예외 발생");
			e.printStackTrace();
		}
		return result;
	}
	
	public List<Comment> list() {
		// 게시글 목록을 담을 컬렉션 객체 생성
		List<Comment> cmList = new ArrayList<Comment>();

		// SQL 작성
		String sql = "SELECT * " + "FROM comment";

		try(Connection conn = DataSource.getInstance().getConnection();
				Statement stmt = conn.createStatement();) {
			// 1. SQL 실행 객체 생성 - Statement (stmt)
			
			// 2. SQL 실행 요청 -> 결과 ResultSet (rs)
			try(ResultSet rs = stmt.executeQuery(sql);){
				// 3. 조회된 결과를 리스트(boardList)에 추가
				while (rs.next()) {
					Comment cm = new Comment();
					// 결과 데이터 가져오기
					// rs.getXXX("컬럼명") : 해당 컬럼의 데이터를 반환
					cm.setNo(rs.getInt("no"));
					cm.setRoom_no(rs.getInt("room_no"));
					cm.setContent(rs.getString("content"));
					cm.setReg_date(rs.getTimestamp("reg_date"));
					cm.setUpd_date(rs.getTimestamp("upd_date"));
					cm.setUuid(rs.getInt("uuid"));
					// 게시글 목록 추가
					cmList.add(cm);
				}
			}
			

			// 4. 게시글 목록 반환

		} catch (SQLException e) {
			System.err.println("CommentDAO : list 예외발생");
			e.printStackTrace();
		}
		return cmList;
	}
	
	public List<Comment> list(int room_no) {
		// 게시글 목록을 담을 컬렉션 객체 생성
		List<Comment> cmList = new ArrayList<Comment>();

		// SQL 작성
		String sql = "SELECT * " 
				+ " FROM comment"
				+ " WHERE room_no = ?";

		try(Connection conn = DataSource.getInstance().getConnection();
				PreparedStatement psmt = conn.prepareStatement(sql);) {
			// 1. SQL 실행 객체 생성 - Statement (stmt)
			
			psmt.setInt(1, room_no);
			// 2. SQL 실행 요청 -> 결과 ResultSet (rs)
			try(ResultSet rs = psmt.executeQuery();){
				// 3. 조회된 결과를 리스트(boardList)에 추가
				while (rs.next()) {
					Comment cm = new Comment();
					// 결과 데이터 가져오기
					// rs.getXXX("컬럼명") : 해당 컬럼의 데이터를 반환
					cm.setNo(rs.getInt("no"));
					cm.setRoom_no(rs.getInt("room_no"));
					cm.setContent(rs.getString("content"));
					cm.setReg_date(rs.getTimestamp("reg_date"));
					cm.setUpd_date(rs.getTimestamp("upd_date"));
					cm.setUuid(rs.getInt("uuid"));
					// 게시글 목록 추가
					cmList.add(cm);
				}
			}
			// 4. 게시글 목록 반환

		} catch (SQLException e) {
			System.err.println("CommentDAO : list(uuid) 예외발생");
			e.printStackTrace();
		}
		return cmList;
	}
	
	/**
	 * 해당 번호 보드 조회
	 * @param no
	 * @return
	 */
	public Comment select(int no) {
		String sql="SELECT * "
				+ " FROM board"
				+ " WHERE no = ?";
		Comment index = null;
		try(Connection conn = DataSource.getInstance().getConnection();
				PreparedStatement psmt = conn.prepareStatement(sql);) {
			
			psmt.setInt(1, no);
			try(ResultSet rs=psmt.executeQuery();){
				if(rs.next()) {
					index = new Comment();
					index.setNo(rs.getInt("no"));
					index.setRoom_no(rs.getInt("room_no"));
					index.setContent(rs.getString("content"));
					index.setReg_date(rs.getTimestamp("reg_date"));
					index.setUpd_date(rs.getTimestamp("upd_date"));
					index.setUuid(rs.getInt("uuid"));
				}
			}
		} catch (Exception e) {
			System.err.println("CommentDAO : 보드 번호로 조회 시 예외 발생");
		}
		return index;
	}	
	
	public boolean update(Comment index) {
		boolean result = false;
		String sql="UPDATE comment"
				+ " set content = ?"
				+ " WHERE uuid = ?";
		try(Connection conn = DataSource.getInstance().getConnection();
				PreparedStatement psmt = conn.prepareStatement(sql);) {
			psmt.setString(1,index.getContent());
			psmt.setInt(2,index.getUuid());
			result = psmt.executeUpdate() == 0 ? false:true;
		} catch (Exception e) {
			System.err.println("CommentDAO :  update 시 예외 발생");
		}
		return result;
	}	
	
	public boolean delete(int no) {
		boolean result = false;
		String sql="DELETE "
				+ " FROM comment"
				+ " WHERE no = ?";
		try (Connection conn = DataSource.getInstance().getConnection();
				PreparedStatement psmt = conn.prepareStatement(sql);){
			psmt.setInt(1, no);
			result = psmt.executeUpdate() == 0 ? false:true;
		} catch (Exception e) {
			System.err.println("CommentDAO : delete시 예외 발생");
		}
		return result;
	}	
}

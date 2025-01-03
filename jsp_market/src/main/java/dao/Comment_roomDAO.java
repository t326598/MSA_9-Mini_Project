package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import dto.Comment_room;

public class Comment_roomDAO extends JDBConnection {
	public int insert(Comment_room index) {
		int result = 0;
		
		String sql = " INSERT INTO comment_room(board_no,main_no,sub_no)"
				+ " VALUES( ?,?,?)";
		
		try(Connection conn = DataSource.getInstance().getConnection();
			PreparedStatement psmt = conn.prepareStatement(sql);) {
			psmt.setInt(1, index.getBoard_no());
			psmt.setInt(2, index.getMain_no());
			psmt.setInt(3, index.getSub_no());
			result = psmt.executeUpdate();
		} catch (Exception e) {
			System.err.println("Comment_roomDAO : insert 시,예외 발생");
			e.printStackTrace();
		}
		return result;
	}
	
	public List<Comment_room> list() {
		// 게시글 목록을 담을 컬렉션 객체 생성
		List<Comment_room> cmList = new ArrayList<Comment_room>();

		// SQL 작성
		String sql = "SELECT * " 
				+ " FROM comment_room";

		try(Connection conn = DataSource.getInstance().getConnection();
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(sql);) {
			// 1. SQL 실행 객체 생성 - Statement (stmt)
			
			// 2. SQL 실행 요청 -> 결과 ResultSet (rs)
			
			// 3. 조회된 결과를 리스트(boardList)에 추가
			while (rs.next()) {
				Comment_room cr = new Comment_room();
				// 결과 데이터 가져오기
				// rs.getXXX("컬럼명") : 해당 컬럼의 데이터를 반환
				cr.setNo(rs.getInt("no"));
				cr.setBoard_no(rs.getInt("board_no"));
				cr.setMain_no(rs.getInt("main_no"));
				cr.setSub_no(rs.getInt("sub_no"));
				cr.setReg_date(rs.getTimestamp("reg_date"));
				cr.setUpd_date(rs.getTimestamp("upd_date"));
				// 게시글 목록 추가
				cmList.add(cr);
			}
			// 4. 게시글 목록 반환

		} catch (SQLException e) {
			System.err.println("Comment_roomDAO : list 예외발생");
			e.printStackTrace();
		}
		return cmList;
	}
	
	public List<Comment_room> list(int board_no) {
		// 게시글 목록을 담을 컬렉션 객체 생성
		List<Comment_room> crList = new ArrayList<Comment_room>();

		// SQL 작성
		String sql = "SELECT * " 
				+ " FROM comment_room"
				+ " WHERE board_no = ?";

		try(Connection conn = DataSource.getInstance().getConnection();
				PreparedStatement psmt = conn.prepareStatement(sql);) {
			// 1. SQL 실행 객체 생성 - Statement (stmt)
			psmt.setInt(1, board_no);
			// 2. SQL 실행 요청 -> 결과 ResultSet (rs)
			try(ResultSet rs = psmt.executeQuery();){
				// 3. 조회된 결과를 리스트(boardList)에 추가
				while (rs.next()) {
					Comment_room cr = new Comment_room();
					// 결과 데이터 가져오기
					// rs.getXXX("컬럼명") : 해당 컬럼의 데이터를 반환
					cr.setNo(rs.getInt("no"));
					cr.setBoard_no(rs.getInt("board_no"));
					cr.setMain_no(rs.getInt("main_no"));
					cr.setSub_no(rs.getInt("sub_no"));
					cr.setReg_date(rs.getTimestamp("reg_date"));
					cr.setUpd_date(rs.getTimestamp("upd_date"));
					// 게시글 목록 추가
					crList.add(cr);
				}
			}
			// 4. 게시글 목록 반환

		} catch (SQLException e) {
			System.err.println("Comment_roomDAO : list(uuid) 예외발생");
			e.printStackTrace();
		}
		return crList;
	}
	
	/**
	 * 해당 번호 보드 조회
	 * @param no
	 * @return
	 */
	public Comment_room select(int no) {
		String sql="SELECT * "
				+ " FROM comment_room"
				+ " WHERE no = ?";
		Comment_room index = new Comment_room();
		try(Connection conn = DataSource.getInstance().getConnection();
				PreparedStatement psmt = conn.prepareStatement(sql);
				) {
			psmt.setInt(1, no);
			try(ResultSet rs=psmt.executeQuery()){
				if(rs.next()) {
					index = new Comment_room();
					index.setNo(rs.getInt("no"));
					index.setBoard_no(rs.getInt("board_no"));
					index.setMain_no(rs.getInt("main_no"));
					index.setSub_no(rs.getInt("sub_no"));
					index.setReg_date(rs.getTimestamp("reg_date"));
					index.setUpd_date(rs.getTimestamp("upd_date"));
				}
			}
		} catch (Exception e) {
			System.err.println("Comment_roomDAO : 보드 번호로 조회 시 예외 발생");
		}
		return index;
	}
	
	public Comment_room select_boardNo(int boardno) {
		String sql="SELECT * "
				+ " FROM comment_room"
				+ " WHERE board_no = ?";
		Comment_room index = null;
		try(Connection conn = DataSource.getInstance().getConnection();
				PreparedStatement psmt = conn.prepareStatement(sql);) {
			
			psmt.setInt(1, boardno);
			try(ResultSet rs=psmt.executeQuery()){
				if(rs.next()) {
					index = new Comment_room();
					index.setNo(rs.getInt("no"));
					index.setBoard_no(rs.getInt("board_no"));
					index.setMain_no(rs.getInt("main_no"));
					index.setSub_no(rs.getInt("sub_no"));
					index.setReg_date(rs.getTimestamp("reg_date"));
					index.setUpd_date(rs.getTimestamp("upd_date"));
				}
			}
		} catch (Exception e) {
			System.err.println("Comment_roomDAO : 보드 번호로 조회 시 예외 발생");
		}
		return index;
	}
	
	public boolean update(Comment_room index) {
		boolean result = false;
		String sql="UPDATE comment_room"
				+ " SET board_no = ?,"
				+ " main_no = ?,"
				+ " sub_no = ?,"
				+ " WHERE no = ?";
		try(Connection conn = DataSource.getInstance().getConnection();
				PreparedStatement psmt = conn.prepareStatement(sql);) {
			
			psmt.setInt(1,index.getBoard_no());
			psmt.setInt(2, index.getMain_no());
			psmt.setInt(3, index.getSub_no());
			result = psmt.executeUpdate() == 0 ? false:true;
		} catch (Exception e) {
			System.err.println("Comment_roomDAO :  update 시 예외 발생");
		}
		return result;
	}	
	
	public boolean delete(int no) {
		boolean result = false;
		String sql="DELETE "
				+ " FROM comment_room"
				+ " WHERE no = ?";
		try(Connection conn = DataSource.getInstance().getConnection();
				PreparedStatement psmt = conn.prepareStatement(sql);) {
			
			psmt.setInt(1, no);
			result = psmt.executeUpdate() == 0 ? false:true;
		} catch (Exception e) {
			System.err.println("Comment_roomDAO : delete시 예외 발생");
		}
		return result;
	}	
}

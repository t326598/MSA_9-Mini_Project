package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import dto.User;

public class UserDAO extends JDBConnection {
	
	
	public int insert(User user) {
		int result = 0;
		
		String sql = " INSERT INTO user(id,passwd,name,phone,email,area,permit,enabled)"
				+ " VALUES( ?,?,?,?,?,?,?,?)";
		
		try(Connection conn = DataSource.getInstance().getConnection();
				PreparedStatement psmt = conn.prepareStatement(sql);) {
			psmt.setString(1, user.getId());
			psmt.setString(2, user.getPasswd());
			psmt.setString(3, user.getName());
			psmt.setString(4, user.getPhone());
			psmt.setString(5, user.getEmail());
			psmt.setString(6, user.getArea());
			psmt.setInt(7, 0);
			psmt.setBoolean(8, user.getEnabled());
			result = psmt.executeUpdate();
		} catch (Exception e) {
			System.err.println("UserDAO : 회원 등록 시,예외 발생");
			e.printStackTrace();
		}
		return result;
	}
	
	/**
	 * 회원 번호로 조회
	 * @param no
	 * @return
	 */
	public User select(int uuid) {
		
		String sql="SELECT * "
				+ " FROM user"
				+ " WHERE uuid = ?";
		User user = null;
		try (Connection conn = DataSource.getInstance().getConnection();
				PreparedStatement psmt = conn.prepareStatement(sql);){
			psmt.setInt(1, uuid);
			try(ResultSet rs=psmt.executeQuery();){
				if(rs.next()) {
					user = new User();
					user.setUuid(rs.getInt("uuid"));
					user.setId(rs.getString("id"));
					user.setPasswd(rs.getString("passwd"));
					user.setName(rs.getString("name"));
					user.setPhone(rs.getString("phone"));
					user.setEmail(rs.getString("email"));
					user.setArea(rs.getString("area"));
					user.setPermit(rs.getInt("permit"));
					user.setEnabled(rs.getBoolean("enabled"));
					user.setRegDate(rs.getTimestamp("reg_date"));
					user.setUpdDate(rs.getTimestamp("upd_date"));
				}
			}
		} catch (Exception e) {
			System.err.println("UserDAO : 회원 정보 번호로 조회 시 예외 발생");
		}
		return user;
	}	
	
	/**
	 * 회원 아이디로 조회
	 * @param username
	 * @return
	 */
	public User select(String id) {
		
		String sql="SELECT * "
				+ " FROM user"
				+ " WHERE id = ?";
		User user = null;
		try(Connection conn = DataSource.getInstance().getConnection();
				PreparedStatement psmt = conn.prepareStatement(sql);) {
			
			psmt.setString(1, id);
			try(ResultSet rs=psmt.executeQuery();){
				if(rs.next()) {
					user = new User(); // User 객체 생성
					user.setUuid(rs.getInt("uuid"));
					user.setId(rs.getString("id"));
					user.setPasswd(rs.getString("passwd"));
					user.setName(rs.getString("name"));
					user.setPhone(rs.getString("phone"));
					user.setEmail(rs.getString("email"));
					user.setArea(rs.getString("area"));
					user.setPermit(rs.getInt("permit"));
					user.setEnabled(rs.getBoolean("enabled"));
					user.setRegDate(rs.getTimestamp("reg_date"));
					user.setUpdDate(rs.getTimestamp("upd_date"));
				}
			}
		} catch (Exception e) {
			System.err.println("UserDAO : 회원 aaa정보 번호로 조회 시 예외 발생");
		}
		return user;
	}
	
	public boolean update(User user) {
		boolean result = false;
		String sql="UPDATE user"
				+ " SET name = ?,"
				+ " passwd = ?,"
				+ " phone = ?,"
				+ " email = ?,"
				+ " area = ?"
				+ " WHERE uuid = ?";
		try(Connection conn = DataSource.getInstance().getConnection();
				PreparedStatement psmt = conn.prepareStatement(sql);) {
			psmt.setString(1,user.getName());
			psmt.setString(2, user.getPasswd());
			psmt.setString(3, user.getPhone());
			psmt.setString(4, user.getEmail());
			psmt.setString(5, user.getArea());
			psmt.setInt(6,user.getUuid());
			result = psmt.executeUpdate() == 0 ? false:true;
		} catch (Exception e) {
			System.err.println("UserDAO : 회원 정보 업데이트 시 예외 발생");
		}
		return result;
	}	
	
	public boolean delete(int uuid) {
		boolean result = false;
		String sql="DELETE "
				+ " FROM user"
				+ " WHERE uuid = ?";
		try(PreparedStatement psmt = con.prepareStatement(sql);) {
			psmt.setInt(1, uuid);
			result = psmt.executeUpdate() == 0 ? false:true;
		} catch (Exception e) {
			System.err.println("UserDAO : 회원 id로 삭제 시 예외 발생");
		}
		return result;
	}	
	
}

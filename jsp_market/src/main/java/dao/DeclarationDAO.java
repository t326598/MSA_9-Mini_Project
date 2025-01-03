package dao;

import java.sql.ResultSet;

import com.alohaclass.jdbc.dao.BaseDAOImpl;

import dto.Declaration;

public class DeclarationDAO extends BaseDAOImpl<Declaration> {

	@Override
	public Declaration map(ResultSet rs) throws Exception {
		Declaration dec = new Declaration();
		dec.setNo( rs.getInt("no") );
		dec.setWriter_no( rs.getInt("writer_no") );
		dec.setBoard_no( rs.getInt("board_no") );
		dec.setContent( rs.getString("content") );
		dec.setReg_date( rs.getTimestamp("reg_date") );
		dec.setUpd_date( rs.getTimestamp("upd_date") );
		return dec;
	}

	@Override
	public String pk() {
		return "no";
	}

	@Override
	public String table() {
		return "declaration";
	}
	
}

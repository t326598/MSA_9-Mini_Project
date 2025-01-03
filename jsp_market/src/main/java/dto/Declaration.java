package dto;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Declaration {
	int no;
	int writer_no;
	int board_no;
	String content;
	Date reg_date;
	Date upd_date;
}

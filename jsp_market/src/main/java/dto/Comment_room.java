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
public class Comment_room {
	int no;
	int board_no;
	int main_no;
	int sub_no;
	Date reg_date;
	Date upd_date;
}

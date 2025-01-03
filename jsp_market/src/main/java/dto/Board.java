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
public class Board {
	int no;
	String title;
	String category;
	int price;
	int status;
	String content;
	Date reg_date;
	Date upd_date;
	int uuid;
}

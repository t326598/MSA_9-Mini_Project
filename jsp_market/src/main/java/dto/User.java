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
public class User {
	private int uuid;
	private String id;
	private String passwd;
	private String name;
	private String phone;
	private String email;
	private String area;
	private int permit;
	private Boolean enabled;
	private Date regDate;
	private Date updDate;
}

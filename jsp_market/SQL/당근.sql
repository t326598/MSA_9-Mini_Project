drop table `user`;
drop table `board`;
drop table `comment`;
drop table `comment_room`;
drop table `files`;
drop table `declaration`;
drop table `persistence_logins`;
-- 스키마 이름 jsp_market
CREATE TABLE `user` (
  `uuid` INT NOT NULL AUTO_INCREMENT COMMENT '유저번호',
  `id` VARCHAR(45) not null UNIQUE COMMENT '유저id',
  `passwd` VARCHAR(60) NOT NULL COMMENT '비밀번호',
`name` VARCHAR(500) NOT NULL UNIQUE COMMENT '유저이름',
  `phone` varchar(60) null COMMENT '전화번호',
  `email` varchar(60) NULL COMMENT '이메일',
  `area` varchar(40) null COMMENT '지역',
  `permit` int null comment '권한',
  `enabled` boolean null,
  `reg_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '등록시간',
  `upd_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정일자',
  PRIMARY KEY (`uuid`))
COMMENT = '유저';

CREATE TABLE `board` (
  `no` INT NOT NULL AUTO_INCREMENT COMMENT '보드번호',
  `title` VARCHAR(45) NOT NULL COMMENT '타이틀',
  `category` VARCHAR(45) NOT NULL COMMENT '카테고리',
  `price` int null comment '가격',
  `status` int not null comment '판매상태',
  `content` TEXT NULL COMMENT '내용',
  `reg_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '등록시간',
  `upd_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정일자',
  `uuid` INT NOT NULL COMMENT '유저번호',
  PRIMARY KEY (`no`))
COMMENT = '게시판';

CREATE TABLE `comment_room` (
  `no` INT NOT NULL AUTO_INCREMENT COMMENT '댓글번호',
  `board_no` INT NOT NULL COMMENT '보드번호',
  `main_no` int NOT NULL COMMENT '글쓴이',
  `sub_no`  int not null comment '손님',
  `reg_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '수정일자',
  `upd_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정일자',
  FOREIGN KEY (`board_no`) REFERENCES `board`(`no`) ON DELETE CASCADE,
  PRIMARY KEY (`no`))
COMMENT = '댓글창';

CREATE TABLE `comment` (
  `no` INT NOT NULL AUTO_INCREMENT COMMENT '댓글번호',
  `room_no` INT NOT NULL COMMENT '보드번호',
  `content` TEXT NULL COMMENT '내용',
  `reg_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '수정일자',
  `upd_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정일자',
  `uuid` INT NOT NULL COMMENT '유저번호',
  FOREIGN KEY (`room_no`) REFERENCES `comment_room`(`no`) ON DELETE CASCADE,
  PRIMARY KEY (`no`))
COMMENT = '댓글';



CREATE TABLE `files` (
  `no` INT NOT NULL AUTO_INCREMENT,
  `file_path` VARCHAR(1000) NOT NULL,
  `table_no` INT NULL,
  `table_name` VARCHAR(45) NOT NULL,
  `code` INT not null, -- 0:메인이미지 1:이벤트 2:프로필 3:보드
  `reg_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '등록시간',
  `upd_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정일자',
  PRIMARY KEY (`no`))
COMMENT = '파일';

CREATE TABLE `declaration` (
  `no` INT NOT NULL AUTO_INCREMENT,
  `writer_no` INT NOT NULL,
  `board_no` INT NOT NULL,
  `content` TEXT NULL COMMENT '내용',
  `reg_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '등록시간',
  `upd_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정일자',
  FOREIGN KEY (`board_no`) REFERENCES `board`(`no`) ON DELETE CASCADE,
  PRIMARY KEY (`no`))
COMMENT = '신고게시글';



CREATE TABLE `persistence_logins` (
    `no` int NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT '번호',
    `username` varchar(100) NULL COMMENT '회원 아이디',
    `token` varchar(255) NULL COMMENT '인증 토큰',
    `expiry_date` timestamp NULL COMMENT '만료시간',
    `reg_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '등록시간',
    `upd_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정일자'
);

-- 추가기능
CREATE TABLE `tempo` (
  `no` INT NOT NULL AUTO_INCREMENT,
  `tempo` int not null,
  `main_no` INT NOT NULL,
  `sub_no` int not null,
  `status` int not null,
  `reg_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '등록시간',
  `upd_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정일자',
  PRIMARY KEY (`no`))
COMMENT = '온도';
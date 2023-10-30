DROP DATABASE IF EXISTS FUTSAL;

CREATE DATABASE FUTSAL;

USE FUTSAL;

DROP TABLE IF EXISTS `member`;

CREATE TABLE `member` (
	`me_num`	int AUTO_INCREMENT PRIMARY KEY	NOT NULL,
	`me_id`	varchar(10) UNIQUE	NULL	COMMENT '중복 불가',
	`me_pw`	varchar(255)	NULL,
	`me_name`	varchar(10)	NULL,
	`me_nickname`	varchar(15) UNIQUE	NULL	COMMENT '중복 불가',
	`me_rg_num`	int	NOT NULL,
	`me_phone`	varchar(13)	NULL,
	`me_email`	varchar(40)	NULL,
	`me_gender`	varchar(1)	NULL,
	`me_birthday`	date	NULL,
	`me_authority`	varchar(10)	NOT NULL	DEFAULT 'USER'	COMMENT 'USER, ADMIN, MANAGER, BUSINESS',
	`me_rating`	int	NULL,
	`me_profile`	varchar(255)	NULL	COMMENT '이미지',
	`me_tr_name`	varchar(10)	NULL,
	`me_point`	int	NOT NULL	DEFAULT 0,
	`me_state1`	int	NOT NULL	DEFAULT 0	COMMENT '0 : 없음, 1 : 정지',
	`me_state2`	int	NOT NULL	DEFAULT 0	COMMENT '0 : 없음, 1 : 정지',
    `me_session_id`	varchar(255)	NULL,
	`me_session_limit`	datetime	NULL
);

DROP TABLE IF EXISTS `region`;

CREATE TABLE `region` (
	`rg_num`	int AUTO_INCREMENT PRIMARY KEY	NOT NULL,
	`rg_main`	varchar(7)	NULL	COMMENT '서울,경기,강원,충북,충남,경북,경남,전븍,전남,제주',
	`rg_sub`	varchar(7)	NULL	COMMENT '구 혹은 시'
);

DROP TABLE IF EXISTS `time`;

CREATE TABLE `time` (
	`ti_num`	int AUTO_INCREMENT PRIMARY KEY	NOT NULL,
	`ti_day`	varchar(1)	NOT NULL,
	`ti_time`	time	NOT NULL	COMMENT '1시간 간격'
);

DROP TABLE IF EXISTS `preferred_region`;

CREATE TABLE `preferred_region` (
	`pr_num`	int AUTO_INCREMENT PRIMARY KEY	NOT NULL,
	`pr_me_num`	int	NOT NULL,
	`pr_rg_num`	int	NOT NULL
);

DROP TABLE IF EXISTS `preferred_time`;

CREATE TABLE `preferred_time` (
	`pt_num`	int AUTO_INCREMENT PRIMARY KEY	NOT NULL,
	`pt_ti_num`	int	NOT NULL,
	`pt_me_num`	int	NOT NULL
);

DROP TABLE IF EXISTS `stadium`;

CREATE TABLE `stadium` (
	`st_num`	int AUTO_INCREMENT PRIMARY KEY	NOT NULL,
	`st_name`	varchar(15)	NOT NULL,
	`st_locate`	varchar(50)	NOT NULL,
	`st_door`	int	NOT NULL	DEFAULT 0	COMMENT '0 : 실외, 1 : 실내',
	`st_floortype`	int	NOT NULL	DEFAULT 0	COMMENT '0 : 인조 잔디, 1 : 천연 잔디, 2 : 모래, 3 : 인도어',
	`st_width`	int	NOT NULL,
	`st_height`	int	NOT NULL,
	`st_max`	int	NOT NULL,
	`st_available`	int	NOT NULL	DEFAULT 0	COMMENT '0 : 가능, 1 : 불가능',
	`st_note`	varchar(255)	NULL,
	`st_fa_num`	int	NOT NULL
);

DROP TABLE IF EXISTS `match`;

CREATE TABLE `match` (
	`mt_num`	int AUTO_INCREMENT PRIMARY KEY	NOT NULL,
	`mt_date`	date	NOT NULL,
	`mt_st_num`	int	NOT NULL,
	`mt_ti_num`	int	NOT NULL,
	`mt_type`	int	NOT NULL	DEFAULT 0	COMMENT '0 : 미확정, 1 : 개인 매치, 2 : 팀 매치',
	`mt_rule`	int	NOT NULL	DEFAULT 0	COMMENT '0 : 친선전, 1: 경쟁전',
	`mt_personnel`	int	NOT NULL	COMMENT 'N : N vs N',
	`mt_state1`	int	NOT NULL	DEFAULT 0	COMMENT '0 : 등록, 1 : 삭제 (조회에서 보여줄지)',
	`mt_state2`	int	NOT NULL	DEFAULT 0	COMMENT '0 : 신청 없음, 1 : 신청 있음 (날짜가 지난 후 삭제할지)',
	`mt_memo`	longtext	NULL
);

DROP TABLE IF EXISTS `club`;

CREATE TABLE `club` (
	`cl_num`	int AUTO_INCREMENT PRIMARY KEY	NOT NULL,
	`cl_name`	varchar(15)	NOT NULL,
	`cl_emblem`	varchar(255)	NULL	COMMENT '이미지',
	`cl_price`	int	NULL,
	`cl_rule`	longtext	NULL,
	`cl_introduction`	longtext	NULL,
	`cl_rg_num`	int	NOT NULL,
	`cl_url`	varchar(225)	NULL
);

DROP TABLE IF EXISTS `team`;

CREATE TABLE `team` (
	`te_num`	int AUTO_INCREMENT PRIMARY KEY	NOT NULL,
	`te_mt_num`	int	NOT NULL,
	`te_type`	int	NOT NULL	DEFAULT 0	COMMENT '0 : 참가자 리스트, 1 : 팀 리스트'
);

DROP TABLE IF EXISTS `buisnessman`;

CREATE TABLE `buisnessman` (
	`bu_num`	int AUTO_INCREMENT PRIMARY KEY	NOT NULL,
	`bu_registration_number`	varchar(20)	NULL,
	`bu_registration`	varchar(255)	NULL	COMMENT '이미지',
	`bu_phone`	varchar(13)	NULL,
	`bu_name`	varchar(5)	NULL,
	`bu_price`	int	NULL,
	`bu_email`	varchar(30)	NULL,
	`bu_me_num`	int	NOT NULL,
	`bu_state`	int	NOT NULL	DEFAULT 0	COMMENT '0 : 신청, 1 : 승인'
);

DROP TABLE IF EXISTS `entry`;

CREATE TABLE `entry` (
	`en_num`	int AUTO_INCREMENT PRIMARY KEY	NOT NULL,
	`en_me_num`	int	NOT NULL,
	`en_te_num`	int	NULL
);

DROP TABLE IF EXISTS `club_member`;

CREATE TABLE `club_member` (
	`cm_num`	int AUTO_INCREMENT PRIMARY KEY	NOT NULL,
	`cm_me_num`	int	NOT NULL,
	`cm_cl_num`	int	NOT NULL,
	`cm_authority`	varchar(10)	NOT NULL	DEFAULT 'ROOKIE'	COMMENT 'ROOKIE, MEMBER, LEADER'
);

DROP TABLE IF EXISTS `coupon`;

CREATE TABLE `coupon` (
	`cp_num`	int PRIMARY KEY	NOT NULL,
	`cp_sale`	int	NOT NULL,
	`cp_source`	varchar(10)	NOT NULL
);

DROP TABLE IF EXISTS `point_history`;

CREATE TABLE `point_history` (
	`ph_num`	int AUTO_INCREMENT PRIMARY KEY	NOT NULL,
	`ph_price`	int	NOT NULL	DEFAULT 0,
	`ph_source`	int	NOT NULL	COMMENT '0 : 충전, 1: 경기 신청, 2 : 경기 취소, 3 : 환불, 4 : 환급 대기, 5 : 환급 완료',
	`ph_mt_num`	int	NULL,
	`ph_me_num`	int	NOT NULL
);

DROP TABLE IF EXISTS `board`;

CREATE TABLE `board` (
	`bo_num`	int AUTO_INCREMENT PRIMARY KEY	NOT NULL,
	`bo_bt_num`	int	NOT NULL,
	`bo_rg_num`	int	NOT NULL,
	`bo_title`	varchar(50)	NOT NULL,
	`bo_me_num`	int	NOT NULL,
	`bo_reg_date`	datetime	NOT NULL,
	`bo_up_date`	datetime	NULL,
	`bo_contents`	longtext	NULL,
	`bo_count`	int	NOT NULL	DEFAULT 0,
	`bo_comment`	int	NOT NULL	DEFAULT 0
);

DROP TABLE IF EXISTS `board_type`;

CREATE TABLE `board_type` (
	`bt_num`	int AUTO_INCREMENT PRIMARY KEY	NOT NULL,
	`bt_name`	varchar(10)	NOT NULL	DEFAULT '자유게시판'	COMMENT '공지,자유게시판, 개인 매칭, 팀 매칭,문의, 매니저/사업자 신청',
	`bt_form`	longtext	NULL
);

DROP TABLE IF EXISTS `schedule`;

CREATE TABLE `schedule` (
	`sc_num`	int AUTO_INCREMENT PRIMARY KEY	NOT NULL,
	`sc_st_num`	int	NOT NULL,
	`sc_ti_num`	int	NOT NULL,
	`sc_personnel`	int	NOT NULL	COMMENT 'N:N'
);

DROP TABLE IF EXISTS `club_team`;

CREATE TABLE `club_team` (
	`ct_te_num`	int PRIMARY KEY	NOT NULL,
	`ct_cl_num`	int	NOT NULL
);

DROP TABLE IF EXISTS `facility`;

CREATE TABLE `facility` (
	`fa_num`	int AUTO_INCREMENT PRIMARY KEY	NOT NULL,
	`fa_bu_num`	int	NOT NULL,
	`fa_rg_num`	int	NOT NULL,
	`fa_name`	varchar(50)	NULL,
	`fa_add`	varchar(255)	NULL,
	`fa_add_detail`	varchar(50)	NULL,
	`fa_phone`	varchar(20)	NULL,
	`fa_pay`	int	NOT NULL	DEFAULT 0	COMMENT '0:없음. 1:무료, 2:유료',
	`fa_locker`	int	NOT NULL	DEFAULT 0	COMMENT '0 : 없음, 1 : 있음',
	`fa_toilet`	int	NOT NULL	DEFAULT 0	COMMENT '0 : 없음, 1 : 있음',
	`fa_shower`	int	NOT NULL	DEFAULT 0	COMMENT '0 : 없음, 1 : 있음',
	`fa_smoking`	int	NOT NULL	DEFAULT 0	COMMENT '0 : 없음, 1 : 있음',
	`fa_machine`	int	NOT NULL	DEFAULT 0	COMMENT '0 : 없음, 1 : 있음',
	`fa_note`	varchar(255)	NULL
);

DROP TABLE IF EXISTS `availability`;

CREATE TABLE `availability` (
	`av_st_num`	int PRIMARY KEY	NOT NULL,
	`av_notdate`	date	NULL,
	`av_reason`	varchar(255)	NULL
);

DROP TABLE IF EXISTS `tier`;

CREATE TABLE `tier` (
	`tr_name`	varchar(10)  PRIMARY KEY	NOT NULL	COMMENT '브론즈, 실버, 골드, 플래티넘, 다이아',
	`tr_min_rating`	int	NOT NULL	COMMENT '0, 1000, 2000, 3000, 4000'
);

DROP TABLE IF EXISTS `mark`;

CREATE TABLE `mark` (
	`ma_num`	int  AUTO_INCREMENT PRIMARY KEY	NOT NULL,
	`ma_me_num`	int	NOT NULL,
	`ma_marked_num`	int	NOT NULL
);

DROP TABLE IF EXISTS `record`;

CREATE TABLE `record` (
	`re_me_num`	int  PRIMARY KEY	NOT NULL,
	`re_win`	int	NULL	DEFAULT 0,
	`re_draw`	int	NULL	DEFAULT 0,
	`re_lose`	int	NULL	DEFAULT 0
);

DROP TABLE IF EXISTS `account`;

CREATE TABLE `account` (
	`ac_me_num`	int PRIMARY KEY	NOT NULL,
	`ac_ba_name`	varchar(10)	NOT NULL,
	`ac_me_name`	varchar(5)	NOT NULL,
	`ac_num`	varchar(20)	NOT NULL
);

DROP TABLE IF EXISTS `bank`;

CREATE TABLE `bank` (
	`ba_name`	varchar(10) PRIMARY KEY	NOT NULL
);

DROP TABLE IF EXISTS `quarter`;

CREATE TABLE `quarter` (
	`qu_num`	int AUTO_INCREMENT PRIMARY KEY	NOT NULL,
	`qu_mt_num`	int	NOT NULL,
	`qu_te_num1`	int	NOT NULL,
	`qu_goal`	int	NOT NULL	DEFAULT 0,
	`qu_te_num2`	int	NOT NULL,
	`qu_goal2`	int	NOT NULL	DEFAULT 0
);

DROP TABLE IF EXISTS `manager`;

CREATE TABLE `manager` (
	`mn_mt_num`	int PRIMARY KEY	NOT NULL,
	`mn_me_num`	int	NOT NULL
);

DROP TABLE IF EXISTS `expense`;

CREATE TABLE `expense` (
	`ex_num`	int PRIMARY KEY	NOT NULL,
	`ex_price`	int	NOT NULL,
	`ex_pre`	int	NULL,
	`ex_date`	date	NULL
);

DROP TABLE IF EXISTS `comment`;

CREATE TABLE `comment` (
	`co_num`	int AUTO_INCREMENT PRIMARY KEY	NOT NULL,
	`co_comments`	longtext	NOT NULL,
	`co_bo_num`	int	NOT NULL,
	`co_me_num`	int	NOT NULL,
	`co_ori_num`	int	NULL,
	`co_date`	datetime	NULL,
	`co_up_date`	datetime	NULL,
	`co_delete`	varchar(5)	NULL	COMMENT 'Y, N'
);

DROP TABLE IF EXISTS `report`;

CREATE TABLE `report` (
	`rp_num`	int AUTO_INCREMENT PRIMARY KEY	NOT NULL,
	`rp_rc_num`	int	NOT NULL,
	`rp_content`	longtext	NULL,
	`rp_me_num`	int	NOT NULL,
	`rp_me_num2`	int	NOT NULL,
	`rp_state`	varchar(5)	NULL	COMMENT '처리, 확인, 신규',
	`bo_num`	int	NULL	COMMENT '게시글 신고가 아니라면 NULL'
);

DROP TABLE IF EXISTS `report_category`;

CREATE TABLE `report_category` (
	`rc_num`	int AUTO_INCREMENT PRIMARY KEY	NOT NULL,
	`rc_name`	varchar(10)	NULL	COMMENT '경기, 커뮤니티,매니저, 사업자',
	`rc_detail`	varchar(10)	NULL	COMMENT '음주,폭행,등등...'
);

DROP TABLE IF EXISTS `preferred_age`;

CREATE TABLE `preferred_age` (
	`pa_num`	int AUTO_INCREMENT PRIMARY KEY	NOT NULL,
	`pa_cl_num`	int	NOT NULL,
	`pa_age_range`	int	NOT NULL	COMMENT '0, 10, 20, 30, 40, 50, 60'
);

DROP TABLE IF EXISTS `file`;

CREATE TABLE `file` (
	`fi_num`	int AUTO_INCREMENT PRIMARY KEY	NOT NULL,
	`fi_bo_num`	int	NOT NULL,
	`fi_ori_name`	varchar(255)	NOT NULL,
	`fi_name`	varchar(255)	NOT NULL
);

DROP TABLE IF EXISTS `team_preferred_time`;

CREATE TABLE `team_preferred_time` (
	`tt_num`	int AUTO_INCREMENT PRIMARY KEY	NOT NULL,
	`tt_ti_num`	int	NOT NULL,
	`tt_cl_num`	int	NOT NULL
);

DROP TABLE IF EXISTS `block`;

CREATE TABLE `block` (
	`bl_num`	int  AUTO_INCREMENT PRIMARY KEY	NOT NULL,
	`bl_me_num`	int	NOT NULL,
	`bl_blocked_num`	int	NOT NULL
);

DROP TABLE IF EXISTS `references`;

CREATE TABLE `references` (
	`rf_num`	int PRIMARY KEY	NOT NULL,
	`rf_data`	longtext	NOT NULL
);

DROP TABLE IF EXISTS `penalty`;

CREATE TABLE `penalty` (
	`pn_num`	int AUTO_INCREMENT PRIMARY KEY	NOT NULL,
	`pn_type`	varchar(10)	NULL	COMMENT '경기, 커뮤니티',
	`pn_warning`	int	NOT NULL	DEFAULT 0	COMMENT '경고 2회시 정지+1',
	`pn_stop`	int	NOT NULL	DEFAULT 0	COMMENT '정지 1 : 7일, 2 : 14일, 3 : 28, 4 : 영구',
	`pn_end`	date	NULL,
	`pn_me_num`	int	NOT NULL
);

DROP TABLE IF EXISTS `operating`;

CREATE TABLE `operating` (
	`op_num`	int AUTO_INCREMENT PRIMARY KEY	NOT NULL,
	`op_day`	varchar(1)	NOT NULL,
	`op_open`	int	NOT NULL,
	`op_close`	int	NOT NULL,
	`op_fa_num`	int	NOT NULL
);

DROP TABLE IF EXISTS `holding coupon`;

CREATE TABLE `holding coupon` (
	`hp_num`	int AUTO_INCREMENT PRIMARY KEY	NOT NULL,
	`hp_me_num`	int	NOT NULL,
	`hp_cp_num`	int	NOT NULL,
	`hp_invited_num`	int	NULL,
	`hp_state`	int	NOT NULL	DEFAULT 0	COMMENT '0 : 활성, 1 : 비활성'
);

ALTER TABLE `member` ADD CONSTRAINT `FK_region_TO_member_1` FOREIGN KEY (
	`me_rg_num`
)
REFERENCES `region` (
	`rg_num`
);

ALTER TABLE `member` ADD CONSTRAINT `FK_tier_TO_member_1` FOREIGN KEY (
	`me_tr_name`
)
REFERENCES `tier` (
	`tr_name`
);

ALTER TABLE `preferred_region` ADD CONSTRAINT `FK_member_TO_preferred_region_1` FOREIGN KEY (
	`pr_me_num`
)
REFERENCES `member` (
	`me_num`
);

ALTER TABLE `preferred_region` ADD CONSTRAINT `FK_region_TO_preferred_region_1` FOREIGN KEY (
	`pr_rg_num`
)
REFERENCES `region` (
	`rg_num`
);

ALTER TABLE `preferred_time` ADD CONSTRAINT `FK_time_TO_preferred_time_1` FOREIGN KEY (
	`pt_ti_num`
)
REFERENCES `time` (
	`ti_num`
);

ALTER TABLE `preferred_time` ADD CONSTRAINT `FK_member_TO_preferred_time_1` FOREIGN KEY (
	`pt_me_num`
)
REFERENCES `member` (
	`me_num`
);

ALTER TABLE `stadium` ADD CONSTRAINT `FK_facility_TO_stadium_1` FOREIGN KEY (
	`st_fa_num`
)
REFERENCES `facility` (
	`fa_num`
);

ALTER TABLE `match` ADD CONSTRAINT `FK_stadium_TO_match_1` FOREIGN KEY (
	`mt_st_num`
)
REFERENCES `stadium` (
	`st_num`
);

ALTER TABLE `match` ADD CONSTRAINT `FK_time_TO_match_1` FOREIGN KEY (
	`mt_ti_num`
)
REFERENCES `time` (
	`ti_num`
);

ALTER TABLE `club` ADD CONSTRAINT `FK_region_TO_club_1` FOREIGN KEY (
	`cl_rg_num`
)
REFERENCES `region` (
	`rg_num`
);

ALTER TABLE `team` ADD CONSTRAINT `FK_match_TO_team_1` FOREIGN KEY (
	`te_mt_num`
)
REFERENCES `match` (
	`mt_num`
);

ALTER TABLE `buisnessman` ADD CONSTRAINT `FK_member_TO_buisnessman_1` FOREIGN KEY (
	`bu_me_num`
)
REFERENCES `member` (
	`me_num`
);

ALTER TABLE `entry` ADD CONSTRAINT `FK_member_TO_entry_1` FOREIGN KEY (
	`en_me_num`
)
REFERENCES `member` (
	`me_num`
);

ALTER TABLE `entry` ADD CONSTRAINT `FK_team_TO_entry_1` FOREIGN KEY (
	`en_te_num`
)
REFERENCES `team` (
	`te_num`
);

ALTER TABLE `club_member` ADD CONSTRAINT `FK_member_TO_club_member_1` FOREIGN KEY (
	`cm_me_num`
)
REFERENCES `member` (
	`me_num`
);

ALTER TABLE `club_member` ADD CONSTRAINT `FK_club_TO_club_member_1` FOREIGN KEY (
	`cm_cl_num`
)
REFERENCES `club` (
	`cl_num`
);

ALTER TABLE `point_history` ADD CONSTRAINT `FK_match_TO_point_history_1` FOREIGN KEY (
	`ph_mt_num`
)
REFERENCES `match` (
	`mt_num`
);

ALTER TABLE `point_history` ADD CONSTRAINT `FK_member_TO_point_history_1` FOREIGN KEY (
	`ph_me_num`
)
REFERENCES `member` (
	`me_num`
);

ALTER TABLE `board` ADD CONSTRAINT `FK_board_type_TO_board_1` FOREIGN KEY (
	`bo_bt_num`
)
REFERENCES `board_type` (
	`bt_num`
);

ALTER TABLE `board` ADD CONSTRAINT `FK_region_TO_board_1` FOREIGN KEY (
	`bo_rg_num`
)
REFERENCES `region` (
	`rg_num`
);

ALTER TABLE `board` ADD CONSTRAINT `FK_member_TO_board_1` FOREIGN KEY (
	`bo_me_num`
)
REFERENCES `member` (
	`me_num`
);

ALTER TABLE `schedule` ADD CONSTRAINT `FK_stadium_TO_schedule_1` FOREIGN KEY (
	`sc_st_num`
)
REFERENCES `stadium` (
	`st_num`
);

ALTER TABLE `schedule` ADD CONSTRAINT `FK_time_TO_schedule_1` FOREIGN KEY (
	`sc_ti_num`
)
REFERENCES `time` (
	`ti_num`
);

ALTER TABLE `club_team` ADD CONSTRAINT `FK_team_TO_club_team_1` FOREIGN KEY (
	`ct_te_num`
)
REFERENCES `team` (
	`te_num`
);

ALTER TABLE `club_team` ADD CONSTRAINT `FK_club_TO_club_team_1` FOREIGN KEY (
	`ct_cl_num`
)
REFERENCES `club` (
	`cl_num`
);

ALTER TABLE `facility` ADD CONSTRAINT `FK_buisnessman_TO_facility_1` FOREIGN KEY (
	`fa_bu_num`
)
REFERENCES `buisnessman` (
	`bu_num`
);

ALTER TABLE `facility` ADD CONSTRAINT `FK_region_TO_facility_1` FOREIGN KEY (
	`fa_rg_num`
)
REFERENCES `region` (
	`rg_num`
);

ALTER TABLE `availability` ADD CONSTRAINT `FK_stadium_TO_availability_1` FOREIGN KEY (
	`av_st_num`
)
REFERENCES `stadium` (
	`st_num`
);

ALTER TABLE `mark` ADD CONSTRAINT `FK_member_TO_mark_1` FOREIGN KEY (
	`ma_me_num`
)
REFERENCES `member` (
	`me_num`
);

ALTER TABLE `mark` ADD CONSTRAINT `FK_member_TO_mark_2` FOREIGN KEY (
	`ma_marked_num`
)
REFERENCES `member` (
	`me_num`
);

ALTER TABLE `record` ADD CONSTRAINT `FK_member_TO_record_1` FOREIGN KEY (
	`re_me_num`
)
REFERENCES `member` (
	`me_num`
);

ALTER TABLE `account` ADD CONSTRAINT `FK_member_TO_account_1` FOREIGN KEY (
	`ac_me_num`
)
REFERENCES `member` (
	`me_num`
);

ALTER TABLE `account` ADD CONSTRAINT `FK_bank_TO_account_1` FOREIGN KEY (
	`ac_ba_name`
)
REFERENCES `bank` (
	`ba_name`
);

ALTER TABLE `quarter` ADD CONSTRAINT `FK_match_TO_quarter_1` FOREIGN KEY (
	`qu_mt_num`
)
REFERENCES `match` (
	`mt_num`
);

ALTER TABLE `quarter` ADD CONSTRAINT `FK_team_TO_quarter_1` FOREIGN KEY (
	`qu_te_num1`
)
REFERENCES `team` (
	`te_num`
);

ALTER TABLE `quarter` ADD CONSTRAINT `FK_team_TO_quarter_2` FOREIGN KEY (
	`qu_te_num2`
)
REFERENCES `team` (
	`te_num`
);

ALTER TABLE `manager` ADD CONSTRAINT `FK_match_TO_manager_1` FOREIGN KEY (
	`mn_mt_num`
)
REFERENCES `match` (
	`mt_num`
);

ALTER TABLE `manager` ADD CONSTRAINT `FK_member_TO_manager_1` FOREIGN KEY (
	`mn_me_num`
)
REFERENCES `member` (
	`me_num`
);

ALTER TABLE `comment` ADD CONSTRAINT `FK_board_TO_comment_1` FOREIGN KEY (
	`co_bo_num`
)
REFERENCES `board` (
	`bo_num`
);

ALTER TABLE `comment` ADD CONSTRAINT `FK_member_TO_comment_1` FOREIGN KEY (
	`co_me_num`
)
REFERENCES `member` (
	`me_num`
);

ALTER TABLE `report` ADD CONSTRAINT `FK_report_category_TO_report_1` FOREIGN KEY (
	`rp_rc_num`
)
REFERENCES `report_category` (
	`rc_num`
);

ALTER TABLE `report` ADD CONSTRAINT `FK_member_TO_report_1` FOREIGN KEY (
	`rp_me_num`
)
REFERENCES `member` (
	`me_num`
);

ALTER TABLE `report` ADD CONSTRAINT `FK_member_TO_report_2` FOREIGN KEY (
	`rp_me_num2`
)
REFERENCES `member` (
	`me_num`
);

ALTER TABLE `report` ADD CONSTRAINT `FK_board_TO_report_1` FOREIGN KEY (
	`bo_num`
)
REFERENCES `board` (
	`bo_num`
);

ALTER TABLE `preferred_age` ADD CONSTRAINT `FK_club_TO_preferred_age_1` FOREIGN KEY (
	`pa_cl_num`
)
REFERENCES `club` (
	`cl_num`
);

ALTER TABLE `file` ADD CONSTRAINT `FK_board_TO_file_1` FOREIGN KEY (
	`fi_bo_num`
)
REFERENCES `board` (
	`bo_num`
);

ALTER TABLE `team_preferred_time` ADD CONSTRAINT `FK_time_TO_team_preferred_time_1` FOREIGN KEY (
	`tt_ti_num`
)
REFERENCES `time` (
	`ti_num`
);

ALTER TABLE `team_preferred_time` ADD CONSTRAINT `FK_club_TO_team_preferred_time_1` FOREIGN KEY (
	`tt_cl_num`
)
REFERENCES `club` (
	`cl_num`
);

ALTER TABLE `block` ADD CONSTRAINT `FK_member_TO_block_1` FOREIGN KEY (
	`bl_me_num`
)
REFERENCES `member` (
	`me_num`
);

ALTER TABLE `block` ADD CONSTRAINT `FK_member_TO_block_2` FOREIGN KEY (
	`bl_blocked_num`
)
REFERENCES `member` (
	`me_num`
);

ALTER TABLE `penalty` ADD CONSTRAINT `FK_member_TO_penalty_1` FOREIGN KEY (
	`pn_me_num`
)
REFERENCES `member` (
	`me_num`
);

ALTER TABLE `operating` ADD CONSTRAINT `FK_facility_TO_operating_1` FOREIGN KEY (
	`op_fa_num`
)
REFERENCES `facility` (
	`fa_num`
);

ALTER TABLE `holding coupon` ADD CONSTRAINT `FK_member_TO_holding coupon_1` FOREIGN KEY (
	`hp_me_num`
)
REFERENCES `member` (
	`me_num`
);

ALTER TABLE `holding coupon` ADD CONSTRAINT `FK_coupon_TO_holding coupon_1` FOREIGN KEY (
	`hp_cp_num`
)
REFERENCES `coupon` (
	`cp_num`
);



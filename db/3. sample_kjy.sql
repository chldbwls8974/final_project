DROP TRIGGER IF EXISTS INSERT_MANAGER;
-- 매니저 등록시 경쟁전 매치로 변경
DELIMITER //
CREATE TRIGGER INSERT_MANAGER AFTER INSERT ON MANAGER
FOR EACH ROW
BEGIN
	UPDATE FUTSAL.`MATCH`
    SET
		MT_RULE = 1
	WHERE
		MT_NUM = NEW.MN_MT_NUM;
END //
DELIMITER ;

DROP TRIGGER IF EXISTS DELETE_MANAGER;
-- 매니저 삭제시 친선전 매치로 변경
DELIMITER //
CREATE TRIGGER DELETE_MANAGER AFTER DELETE ON MANAGER
FOR EACH ROW
BEGIN
	UPDATE FUTSAL.`MATCH`
    SET
		MT_RULE = 0
	WHERE
		MT_NUM = OLD.MN_MT_NUM;
END //
DELIMITER ;

DROP TRIGGER IF EXISTS INSERT_TEAM;
-- TE_TYPE = 0 인 팀 생성시 개인 매치로(MT_TYPE = 1) 변경
DELIMITER //
CREATE TRIGGER INSERT_TEAM AFTER INSERT ON TEAM
FOR EACH ROW
BEGIN
	IF NEW.TE_TYPE = 0 THEN
		UPDATE FUTSAL.`MATCH`
		SET
			MT_TYPE = 1
		WHERE
			MT_NUM = NEW.TE_MT_NUM;
	END IF;
END //
DELIMITER ;

DROP TRIGGER IF EXISTS DELETE_TEAM;
-- 팀 제거시 속해있던 매치에 등록된 팀이 0개이면 미확정 매치로(MT_TYPE = 0) 변경
DELIMITER //
CREATE TRIGGER DELETE_TEAM AFTER DELETE ON TEAM
FOR EACH ROW
BEGIN
	IF (SELECT COUNT(TE_NUM) FROM `MATCH` JOIN TEAM ON TE_MT_NUM = MT_NUM WHERE MT_NUM = OLD.TE_MT_NUM) = 0 THEN
		UPDATE FUTSAL.`MATCH`
		SET
			MT_TYPE = 0
		WHERE
			MT_NUM = OLD.TE_MT_NUM;
    END IF;
END //
DELIMITER ;

DROP TRIGGER IF EXISTS INSERT_CLUB_TEAM;
-- CLUB_TEAM 생성시 클럽 매치로(MT_TYPE = 2) 변경
DELIMITER //
CREATE TRIGGER INSERT_CLUB_TEAM AFTER INSERT ON CLUB_TEAM
FOR EACH ROW
BEGIN
	UPDATE FUTSAL.`MATCH`
    SET
		MT_TYPE = 2,
        MT_STATE2 = 1
	WHERE
		MT_NUM = (SELECT TE_MT_NUM FROM TEAM WHERE TE_NUM = NEW.CT_TE_NUM);
END //
DELIMITER ;

DROP TRIGGER IF EXISTS INSERT_ENTRY;
-- CLUB_TEAM 생성시 클럽 매치로(MT_TYPE = 2) 변경
DELIMITER //
CREATE TRIGGER INSERT_ENTRY AFTER INSERT ON ENTRY
FOR EACH ROW
BEGIN
	IF IFNULL((SELECT CT_CL_NUM FROM TEAM JOIN CLUB_TEAM ON CT_TE_NUM = TE_NUM WHERE TE_NUM = NEW.EN_TE_NUM), 0) = 0 THEN
		UPDATE FUTSAL.`MATCH`
		SET
			MT_STATE2 = 1
		WHERE
			MT_NUM = (SELECT TE_MT_NUM FROM TEAM WHERE TE_NUM = NEW.EN_TE_NUM);
    END IF;
END //
DELIMITER ;

INSERT INTO MEMBER(ME_ID, ME_PW, ME_RG_NUM, ME_NICKNAME, ME_AUTHORITY, ME_POINT, ME_RATING, ME_TR_NAME)
VALUES
('user1', 'user1', 2, 'B-1', 'BUSINESS', 300000, 900, '브론즈'), ('user2', 'user2', 2, 'B-2', 'BUSINESS', 30000, 1900, '실버'), ('user3', 'user3', 2, 'M-1', 'MANAGER', 30000, 2900, '골드'),
('user4', 'user4', 2, 'M-2', 'MANAGER', 30000, 3900, '플래티넘'), ('user5', 'user5', 2, 'U-1', 'USER', 30000, 4900, '다이아'), ('user6', 'user6', 2, 'U-2', 'USER', 30000, null, '스타터'),
('user7', 'user7', 2, 'U-3', 'USER', 30000, 900, '브론즈'), ('user8', 'user8', 2, 'U-4', 'USER', 30000, 1900, '실버'), ('user9', 'user9', 2, 'U-5', 'USER', 30000, 2900, '골드'),
('user10', 'user10', 2, 'U-6', 'USER', 30000, 3900, '플래티넘'), ('user11', 'user11', 2, 'U-7', 'USER', 300000, 4900, '다이아'), ('user12', 'user12', 2, 'U-8', 'USER', 30000, null, '스타터'),
('user13', 'user13', 2, 'U-9', 'USER', 30000, 900, '브론즈'), ('user14', 'user14', 2, 'U-10', 'USER', 30000, 1900, '실버'), ('user15', 'user15', 2, 'U-11', 'USER', 30000, 2900, '골드'),
('user16', 'user16', 2, 'U-12', 'USER', 30000, 3900, '플래티넘'), ('user17', 'user17', 2, 'U-13', 'USER', 30000, 4900, '다이아'), ('user18', 'user18', 2, 'U-14', 'USER', 30000, null, '스타터'),
('user19', 'user19', 2, 'U-15', 'USER', 30000, 900, '브론즈'), ('user20', 'user20', 2, 'U-16', 'USER', 30000, 1900, '실버'),('user21', 'user21', 3, 'U-17', 'USER', 300000, 2900, '골드'),
('user22', 'user22', 3, 'U-18', 'USER', 30000, 3900, '플래티넘'), ('user23', 'user23', 3, 'U-19', 'USER', 30000, 4900, '다이아'), ('user24', 'user24', 4, 'U-20', 'USER', 30000, null, '스타터'),
('user25', 'user25', 4, 'U-21', 'USER', 30000, 900, '브론즈'), ('user26', 'user26', 4, 'U-22', 'USER', 30000, 1900, '실버'), ('user27', 'user27', 5, 'U-23', 'USER', 30000, 2900, '골드'),
('user28', 'user28', 6, 'U-24', 'USER', 30000, 3900, '플래티넘'), ('user29', 'user29', 7, 'U-25', 'USER', 30000, 4900, '다이아'), ('user30', 'user30', 8, 'B-30', 'BUSINESS', 30000, null, '스타터'),
('user31', 'user31', 2, 'test1', 'ADMIN', 300000, null, '스타터'),('user32', 'user32', 2, 'test2', 'USER', 300000, null, '스타터'),('user33', 'user33', 2, 'test3', 'USER', 300000, null, '스타터');

update member
set me_name = '테스트'
where me_num = 1;

INSERT INTO BUSINESSMAN(BU_ME_NUM)
VALUES
(1), (2), (30);

INSERT INTO FACILITY(FA_BU_NUM, FA_RG_NUM, FA_NAME, FA_ADD, FA_ADD_DETAIL, FA_PHONE)
VALUES
(1, 2, '시설1', '주소1', '상세주소1', '010-1234-5678'),
(2, 3, '시설2', '주소2', '상세주소2', '010-1111-1111'),
(3, 8, '시설3', '주소3', '상세주소3', '010-1234-1234'),
(3, 9, '시설4', '주소4', '상세주소4', '010-1234-1235');

INSERT INTO STADIUM(ST_NAME, ST_LOCATE, ST_DOOR, ST_FLOORTYPE, ST_WIDTH, ST_HEIGHT, ST_MAX, ST_AVAILABLE, ST_FA_NUM) 
VALUES
('경기장 1-1', '위치1', 0, 0, 25, 16, 5, 1, 1),
('경기장 1-2', '위치2', 1, 3, 25, 16, 5, 0, 1),
('경기장 1-3', '위치3', 0, 0, 42, 25, 8, 0, 1),
('경기장 2-1', '위치4', 0, 2, 25, 16, 5, 0, 2),
('경기장 3-1', '위치5', 0, 1, 32, 19, 6, 0, 3),
('경기장 3-2', '위치6', 1, 3, 38, 22, 7, 0, 3),
('경기장 4-1', '위치7', 0, 2, 25, 16, 5, 0, 4),
('경기장 4-2', '위치8', 0, 1, 32, 19, 6, 0, 4);

INSERT INTO AVAILABILITY(AV_ST_NUM, AV_NOTDATE, AV_REASON) 
VALUES
(1, '2023-10-30', '잔디 교체'),
(4, '2023-11-15', '잔디 교체');

INSERT INTO OPERATING(OP_DAY, OP_OPEN, OP_CLOSE, OP_FA_NUM)
VALUES
('월', 09, 21, 1),
('화', 09, 21, 1),
('수', 09, 21, 1),
('목', 09, 21, 1),
('금', 09, 26, 1),
('토', 09, 26, 1),
('일', 09, 26, 1),
('월', 08, 21, 2),
('화', 08, 21, 2),
('수', 08, 21, 2),
('목', 08, 21, 2),
('금', 08, 21, 2),
('토', 06, 23, 2),
('일', 06, 23, 2),
('월', 09, 21, 3),
('화', 09, 21, 3),
('수', 09, 21, 3),
('목', 09, 21, 3),
('금', 09, 21, 3),
('토', 09, 21, 3),
('일', 09, 21, 3),
('월', 09, 27, 4),
('화', 09, 27, 4),
('수', 09, 27, 4),
('목', 09, 27, 4),
('금', 09, 29, 4),
('토', 09, 29, 4),
('일', 09, 29, 4);

INSERT INTO SCHEDULE(SC_ST_NUM, SC_TI_NUM, SC_PERSONNEL)
VALUES
(1, 1, 3), (1, 10, 4), (1, 12, 5), (1, 14, 5), (1, 16, 5),
(1, 18, 5), (1, 20, 5), (1, 34, 4), (1, 36, 5), (1, 38, 5),
(1, 40, 5), (1, 42, 5), (1, 44, 5), (1, 58, 4), (1, 60, 5),
(1, 62, 5), (1, 64, 5), (1, 66, 5), (1, 68, 5), (1, 82, 4),
(1, 84, 5), (1, 86, 5), (1, 88, 5), (1, 90, 5), (1, 92, 5),
(1, 106, 4), (1, 108, 5), (1, 119, 3), (1, 117, 5), (1, 115, 5),
(1, 113, 5), (1, 111, 5), (1, 130, 4), (1, 132, 5), (1, 135, 5),
(1, 137, 5), (1, 139, 5), (1, 141, 5), (1, 143, 3), (1, 154, 4),
(1, 156, 5), (1, 159, 5), (1, 161, 5), (1, 163, 5), (1, 165, 5),
(1, 167, 3), (1, 121, 3), (1, 145, 3), (2, 1, 5), (2, 11, 5),
(2, 13, 5), (2, 15, 5), (2, 17, 5), (2, 19, 5), (2, 34, 5),
(2, 36, 5), (2, 38, 5), (2, 40, 5), (2, 42, 5), (2, 44, 5),
(2, 58, 5), (2, 60, 5), (2, 62, 5), (2, 64, 5), (2, 66, 5),
(2, 68, 5), (2, 82, 5), (2, 84, 5), (2, 86, 5), (2, 88, 5),
(2, 90, 5), (2, 92, 5), (2, 106, 5), (2, 108, 5), (2, 111, 5),
(2, 113, 5), (2, 115, 5), (2, 117, 5), (2, 119, 3), (2, 130, 5),
(2, 132, 5), (2, 135, 5), (2, 137, 5), (2, 139, 5), (2, 141, 5),
(2, 143, 3), (2, 154, 5), (2, 156, 5), (2, 159, 5), (2, 161, 5),
(2, 163, 5), (2, 165, 5), (2, 167, 3), (2, 121, 3), (2, 145, 3),
(3, 1, 3), (3, 10, 6), (3, 12, 6), (3, 14, 8), (3, 16, 8),
(3, 18, 8), (3, 20, 8), (3, 34, 6), (3, 36, 6), (3, 38, 8),
(3, 40, 8), (3, 42, 8), (3, 44, 8), (3, 58, 6), (3, 60, 6),
(3, 62, 8), (3, 64, 8), (3, 66, 8), (3, 68, 8), (3, 82, 6),
(3, 84, 6), (3, 86, 8), (3, 88, 8), (3, 90, 8), (3, 92, 8),
(3, 106, 6), (3, 108, 6), (3, 111, 8), (3, 113, 8), (3, 115, 8),
(3, 117, 8), (3, 119, 4), (3, 121, 3), (3, 130, 8), (3, 132, 6),
(3, 135, 8), (3, 137, 8), (3, 139, 8), (3, 141, 8), (3, 143, 4),
(3, 145, 3), (3, 154, 6), (3, 156, 6), (3, 159, 8), (3, 161, 8),
(3, 163, 8), (3, 165, 8), (3, 167, 4), (4, 9, 5), (4, 11, 5),
(4, 14, 5), (4, 16, 5), (4, 18, 5), (4, 20, 3), (4, 33, 5),
(4, 35, 5), (4, 38, 5), (4, 40, 5), (4, 42, 5), (4, 44, 3),
(4, 57, 5), (4, 59, 5), (4, 62, 5), (4, 64, 5), (4, 66, 5),
(4, 68, 3), (4, 81, 5), (4, 83, 5), (4, 86, 5), (4, 88, 5),
(4, 90, 5), (4, 92, 3), (4, 105, 5), (4, 107, 5), (4, 110, 3),
(4, 112, 5), (4, 114, 5), (4, 116, 3), (4, 127, 4), (4, 129, 5),
(4, 131, 5), (4, 134, 5), (4, 136, 5), (4, 138, 5), (4, 140, 3),
(4, 142, 3), (4, 151, 4), (4, 153, 5), (4, 155, 5), (4, 158, 5),
(4, 160, 5), (4, 162, 5), (4, 164, 3), (4, 166, 3), (5, 10, 5),
(5, 12, 6), (5, 14, 6), (5, 16, 6), (5, 18, 6), (5, 20, 5),
(5, 34, 5), (5, 36, 6), (5, 38, 6), (5, 40, 6), (5, 42, 6),
(5, 44, 5), (5, 58, 5), (5, 60, 6), (5, 62, 6), (5, 64, 6),
(5, 66, 6), (5, 68, 5), (5, 82, 5), (5, 84, 6), (5, 86, 6),
(5, 88, 6), (5, 90, 6), (5, 92, 5), (5, 106, 5), (5, 108, 6),
(5, 110, 6), (5, 112, 6), (5, 114, 6), (5, 116, 5), (5, 130, 5),
(5, 132, 6), (5, 134, 6), (5, 136, 6), (5, 138, 6), (5, 140, 5),
(5, 154, 5), (5, 156, 6), (5, 158, 6), (5, 160, 6), (5, 162, 6),
(5, 164, 5), (6, 10, 5), (6, 12, 7), (6, 14, 7), (6, 16, 7),
(6, 18, 7), (6, 20, 4), (6, 34, 5), (6, 36, 7), (6, 38, 7),
(6, 40, 7), (6, 42, 7), (6, 44, 4), (6, 58, 5), (6, 60, 7),
(6, 62, 7), (6, 64, 7), (6, 66, 7), (6, 68, 4), (6, 82, 5),
(6, 85, 7), (6, 87, 7), (6, 89, 7), (6, 91, 7), (6, 106, 5),
(6, 108, 7), (6, 110, 7), (6, 112, 7), (6, 114, 7), (6, 116, 4),
(6, 130, 5), (6, 132, 7), (6, 134, 7), (6, 136, 7), (6, 138, 7),
(6, 140, 4), (6, 154, 5), (6, 156, 7), (6, 158, 7), (6, 160, 7),
(6, 162, 7), (6, 164, 4), (7, 10, 5), (7, 12, 5), (7, 14, 5),
(7, 16, 5), (7, 18, 5), (7, 20, 5), (7, 22, 5), (7, 24, 5),
(7, 26, 5), (7, 34, 5), (7, 36, 5), (7, 38, 5), (7, 40, 5),
(7, 42, 5), (7, 44, 5), (7, 46, 5), (7, 48, 5), (7, 50, 5),
(7, 58, 5), (7, 60, 5), (7, 62, 5), (7, 64, 5), (7, 66, 5),
(7, 68, 5), (7, 70, 5), (7, 72, 5), (7, 74, 5), (7, 82, 5),
(7, 84, 5), (7, 86, 5), (7, 88, 5), (7, 90, 5), (7, 92, 5),
(7, 94, 5), (7, 96, 5), (7, 98, 5), (7, 106, 5), (7, 108, 5),
(7, 110, 5), (7, 112, 5), (7, 114, 5), (7, 116, 5), (7, 118, 5),
(7, 120, 5), (7, 122, 5), (7, 124, 5), (7, 130, 5), (7, 134, 5),
(7, 132, 5), (7, 136, 5), (7, 138, 5), (7, 140, 5), (7, 142, 5),
(7, 144, 5), (7, 146, 5), (7, 148, 5), (7, 154, 5), (7, 156, 5),
(7, 158, 5), (7, 160, 5), (7, 162, 5), (7, 164, 5), (7, 166, 5),
(7, 168, 5), (7, 2, 5), (7, 4, 5), (8, 11, 6), (8, 13, 6),
(8, 15, 6), (8, 17, 6), (8, 19, 6), (8, 21, 6), (8, 23, 6),
(8, 1, 6), (8, 3, 6), (8, 25, 6), (8, 35, 6), (8, 37, 6),
(8, 39, 6), (8, 41, 6), (8, 43, 6), (8, 45, 6), (8, 47, 6),
(8, 59, 6), (8, 61, 6), (8, 63, 6), (8, 65, 6), (8, 67, 6),
(8, 69, 6), (8, 71, 6), (8, 83, 6), (8, 107, 6), (8, 131, 6),
(8, 155, 6), (8, 157, 6), (8, 159, 6), (8, 161, 6), (8, 163, 6),
(8, 165, 6), (8, 167, 6), (8, 143, 6), (8, 119, 6), (8, 95, 6),
(8, 93, 6), (8, 117, 6), (8, 141, 6), (8, 139, 6), (8, 115, 6),
(8, 91, 6), (8, 89, 6), (8, 113, 6), (8, 137, 6), (8, 135, 6),
(8, 111, 6), (8, 87, 6), (8, 85, 6), (8, 109, 6), (8, 133, 6),
(8, 145, 6), (8, 147, 6), (8, 121, 6), (8, 123, 6), (8, 97, 6),
(8, 73, 6), (8, 49, 6);
INSERT INTO futsal.match (mt_date, mt_st_num, mt_ti_num, mt_personnel, mt_state1)
SELECT
	date(adddate(adddate(now(), INTERVAL 0 DAY), INTERVAL -7 DAY)),
	sc_st_num,
	sc_ti_num,
	sc_personnel,
	if(st_available = 0, 0, if(date(adddate(now(), INTERVAL -7 DAY)) >= av_notdate, 1, 0))
FROM
	futsal.schedule
	join
futsal.time on sc_ti_num = ti_num
	join
futsal.stadium on sc_st_num = st_num
	left join
futsal.availability on av_st_num = st_num
WHERE ti_day = (SELECT SUBSTR('일월화수목금토', DAYOFWEEK(adddate(now(), INTERVAL 0 DAY)), 1));
INSERT INTO futsal.match (mt_date, mt_st_num, mt_ti_num, mt_personnel, mt_state1)
SELECT
	date(adddate(adddate(now(), INTERVAL 1 DAY), INTERVAL -7 DAY)),
	sc_st_num,
	sc_ti_num,
	sc_personnel,
	if(st_available = 0, 0, if(date(adddate(now(), INTERVAL -7 DAY)) >= av_notdate, 1, 0))
FROM
	futsal.schedule
	join
futsal.time on sc_ti_num = ti_num
	join
futsal.stadium on sc_st_num = st_num
	left join
futsal.availability on av_st_num = st_num
WHERE ti_day = (SELECT SUBSTR('일월화수목금토', DAYOFWEEK(adddate(now(), INTERVAL 1 DAY)), 1));
INSERT INTO futsal.match (mt_date, mt_st_num, mt_ti_num, mt_personnel, mt_state1)
SELECT
	date(adddate(adddate(now(), INTERVAL 2 DAY), INTERVAL -7 DAY)),
	sc_st_num,
	sc_ti_num,
	sc_personnel,
	if(st_available = 0, 0, if(date(adddate(now(), INTERVAL -7 DAY)) >= av_notdate, 1, 0))
FROM
	futsal.schedule
	join
futsal.time on sc_ti_num = ti_num
	join
futsal.stadium on sc_st_num = st_num
	left join
futsal.availability on av_st_num = st_num
WHERE ti_day = (SELECT SUBSTR('일월화수목금토', DAYOFWEEK(adddate(now(), INTERVAL 2 DAY)), 1));
INSERT INTO futsal.match (mt_date, mt_st_num, mt_ti_num, mt_personnel, mt_state1)
SELECT
	date(adddate(adddate(now(), INTERVAL 3 DAY), INTERVAL -7 DAY)),
	sc_st_num,
	sc_ti_num,
	sc_personnel,
	if(st_available = 0, 0, if(date(adddate(now(), INTERVAL -7 DAY)) >= av_notdate, 1, 0))
FROM
	futsal.schedule
	join
futsal.time on sc_ti_num = ti_num
	join
futsal.stadium on sc_st_num = st_num
	left join
futsal.availability on av_st_num = st_num
WHERE ti_day = (SELECT SUBSTR('일월화수목금토', DAYOFWEEK(adddate(now(), INTERVAL 3 DAY)), 1));
INSERT INTO futsal.match (mt_date, mt_st_num, mt_ti_num, mt_personnel, mt_state1)
SELECT
	date(adddate(adddate(now(), INTERVAL 4 DAY), INTERVAL -7 DAY)),
	sc_st_num,
	sc_ti_num,
	sc_personnel,
	if(st_available = 0, 0, if(date(adddate(now(), INTERVAL -7 DAY)) >= av_notdate, 1, 0))
FROM
	futsal.schedule
	join
futsal.time on sc_ti_num = ti_num
	join
futsal.stadium on sc_st_num = st_num
	left join
futsal.availability on av_st_num = st_num
WHERE ti_day = (SELECT SUBSTR('일월화수목금토', DAYOFWEEK(adddate(now(), INTERVAL 4 DAY)), 1));
INSERT INTO futsal.match (mt_date, mt_st_num, mt_ti_num, mt_personnel, mt_state1)
SELECT
	date(adddate(adddate(now(), INTERVAL 5 DAY), INTERVAL -7 DAY)),
	sc_st_num,
	sc_ti_num,
	sc_personnel,
	if(st_available = 0, 0, if(date(adddate(now(), INTERVAL -7 DAY)) >= av_notdate, 1, 0))
FROM
	futsal.schedule
	join
futsal.time on sc_ti_num = ti_num
	join
futsal.stadium on sc_st_num = st_num
	left join
futsal.availability on av_st_num = st_num
WHERE ti_day = (SELECT SUBSTR('일월화수목금토', DAYOFWEEK(adddate(now(), INTERVAL 5 DAY)), 1));
INSERT INTO futsal.match (mt_date, mt_st_num, mt_ti_num, mt_personnel, mt_state1)
SELECT
	date(adddate(adddate(now(), INTERVAL 6 DAY), INTERVAL -7 DAY)),
	sc_st_num,
	sc_ti_num,
	sc_personnel,
	if(st_available = 0, 0, if(date(adddate(now(), INTERVAL -7 DAY)) >= av_notdate, 1, 0))
FROM
	futsal.schedule
	join
futsal.time on sc_ti_num = ti_num
	join
futsal.stadium on sc_st_num = st_num
	left join
futsal.availability on av_st_num = st_num
WHERE ti_day = (SELECT SUBSTR('일월화수목금토', DAYOFWEEK(adddate(now(), INTERVAL 6 DAY)), 1));
INSERT INTO futsal.match (mt_date, mt_st_num, mt_ti_num, mt_personnel, mt_state1)
SELECT
	date(adddate(adddate(now(), INTERVAL 0 DAY), INTERVAL 0 DAY)),
	sc_st_num,
	sc_ti_num,
	sc_personnel,
	if(st_available = 0, 0, if(date(adddate(now(), INTERVAL 0 DAY)) >= av_notdate, 1, 0))
FROM
	futsal.schedule
	join
futsal.time on sc_ti_num = ti_num
	join
futsal.stadium on sc_st_num = st_num
	left join
futsal.availability on av_st_num = st_num
WHERE ti_day = (SELECT SUBSTR('일월화수목금토', DAYOFWEEK(adddate(now(), INTERVAL 0 DAY)), 1));
INSERT INTO futsal.match (mt_date, mt_st_num, mt_ti_num, mt_personnel, mt_state1)
SELECT
	date(adddate(adddate(now(), INTERVAL 1 DAY), INTERVAL 0 DAY)),
	sc_st_num,
	sc_ti_num,
	sc_personnel,
	if(st_available = 0, 0, if(date(adddate(now(), INTERVAL 0 DAY)) >= av_notdate, 1, 0))
FROM
	futsal.schedule
	join
futsal.time on sc_ti_num = ti_num
	join
futsal.stadium on sc_st_num = st_num
	left join
futsal.availability on av_st_num = st_num
WHERE ti_day = (SELECT SUBSTR('일월화수목금토', DAYOFWEEK(adddate(now(), INTERVAL 1 DAY)), 1));
INSERT INTO futsal.match (mt_date, mt_st_num, mt_ti_num, mt_personnel, mt_state1)
SELECT
	date(adddate(adddate(now(), INTERVAL 2 DAY), INTERVAL 0 DAY)),
	sc_st_num,
	sc_ti_num,
	sc_personnel,
	if(st_available = 0, 0, if(date(adddate(now(), INTERVAL 0 DAY)) >= av_notdate, 1, 0))
FROM
	futsal.schedule
	join
futsal.time on sc_ti_num = ti_num
	join
futsal.stadium on sc_st_num = st_num
	left join
futsal.availability on av_st_num = st_num
WHERE ti_day = (SELECT SUBSTR('일월화수목금토', DAYOFWEEK(adddate(now(), INTERVAL 2 DAY)), 1));
INSERT INTO futsal.match (mt_date, mt_st_num, mt_ti_num, mt_personnel, mt_state1)
SELECT
	date(adddate(adddate(now(), INTERVAL 3 DAY), INTERVAL 0 DAY)),
	sc_st_num,
	sc_ti_num,
	sc_personnel,
	if(st_available = 0, 0, if(date(adddate(now(), INTERVAL 0 DAY)) >= av_notdate, 1, 0))
FROM
	futsal.schedule
	join
futsal.time on sc_ti_num = ti_num
	join
futsal.stadium on sc_st_num = st_num
	left join
futsal.availability on av_st_num = st_num
WHERE ti_day = (SELECT SUBSTR('일월화수목금토', DAYOFWEEK(adddate(now(), INTERVAL 3 DAY)), 1));
INSERT INTO futsal.match (mt_date, mt_st_num, mt_ti_num, mt_personnel, mt_state1)
SELECT
	date(adddate(adddate(now(), INTERVAL 4 DAY), INTERVAL 0 DAY)),
	sc_st_num,
	sc_ti_num,
	sc_personnel,
	if(st_available = 0, 0, if(date(adddate(now(), INTERVAL 0 DAY)) >= av_notdate, 1, 0))
FROM
	futsal.schedule
	join
futsal.time on sc_ti_num = ti_num
	join
futsal.stadium on sc_st_num = st_num
	left join
futsal.availability on av_st_num = st_num
WHERE ti_day = (SELECT SUBSTR('일월화수목금토', DAYOFWEEK(adddate(now(), INTERVAL 4 DAY)), 1));
INSERT INTO futsal.match (mt_date, mt_st_num, mt_ti_num, mt_personnel, mt_state1)
SELECT
	date(adddate(adddate(now(), INTERVAL 5 DAY), INTERVAL 0 DAY)),
	sc_st_num,
	sc_ti_num,
	sc_personnel,
	if(st_available = 0, 0, if(date(adddate(now(), INTERVAL 0 DAY)) >= av_notdate, 1, 0))
FROM
	futsal.schedule
	join
futsal.time on sc_ti_num = ti_num
	join
futsal.stadium on sc_st_num = st_num
	left join
futsal.availability on av_st_num = st_num
WHERE ti_day = (SELECT SUBSTR('일월화수목금토', DAYOFWEEK(adddate(now(), INTERVAL 5 DAY)), 1));
INSERT INTO futsal.match (mt_date, mt_st_num, mt_ti_num, mt_personnel, mt_state1)
SELECT
	date(adddate(adddate(now(), INTERVAL 6 DAY), INTERVAL 0 DAY)),
	sc_st_num,
	sc_ti_num,
	sc_personnel,
	if(st_available = 0, 0, if(date(adddate(now(), INTERVAL 0 DAY)) >= av_notdate, 1, 0))
FROM
	futsal.schedule
	join
futsal.time on sc_ti_num = ti_num
	join
futsal.stadium on sc_st_num = st_num
	left join
futsal.availability on av_st_num = st_num
WHERE ti_day = (SELECT SUBSTR('일월화수목금토', DAYOFWEEK(adddate(now(), INTERVAL 6 DAY)), 1));
INSERT INTO futsal.match (mt_date, mt_st_num, mt_ti_num, mt_personnel, mt_state1)
SELECT
	date(adddate(adddate(now(), INTERVAL 0 DAY), INTERVAL 7 DAY)),
	sc_st_num,
	sc_ti_num,
	sc_personnel,
	if(st_available = 0, 0, if(date(adddate(now(), INTERVAL 7 DAY)) >= av_notdate, 1, 0))
FROM
	futsal.schedule
	join
futsal.time on sc_ti_num = ti_num
	join
futsal.stadium on sc_st_num = st_num
	left join
futsal.availability on av_st_num = st_num
WHERE ti_day = (SELECT SUBSTR('일월화수목금토', DAYOFWEEK(adddate(now(), INTERVAL 0 DAY)), 1));
INSERT INTO futsal.match (mt_date, mt_st_num, mt_ti_num, mt_personnel, mt_state1)
SELECT
	date(adddate(adddate(now(), INTERVAL 1 DAY), INTERVAL 7 DAY)),
	sc_st_num,
	sc_ti_num,
	sc_personnel,
	if(st_available = 0, 0, if(date(adddate(now(), INTERVAL 7 DAY)) >= av_notdate, 1, 0))
FROM
	futsal.schedule
	join
futsal.time on sc_ti_num = ti_num
	join
futsal.stadium on sc_st_num = st_num
	left join
futsal.availability on av_st_num = st_num
WHERE ti_day = (SELECT SUBSTR('일월화수목금토', DAYOFWEEK(adddate(now(), INTERVAL 1 DAY)), 1));
INSERT INTO futsal.match (mt_date, mt_st_num, mt_ti_num, mt_personnel, mt_state1)
SELECT
	date(adddate(adddate(now(), INTERVAL 2 DAY), INTERVAL 7 DAY)),
	sc_st_num,
	sc_ti_num,
	sc_personnel,
	if(st_available = 0, 0, if(date(adddate(now(), INTERVAL 7 DAY)) >= av_notdate, 1, 0))
FROM
	futsal.schedule
	join
futsal.time on sc_ti_num = ti_num
	join
futsal.stadium on sc_st_num = st_num
	left join
futsal.availability on av_st_num = st_num
WHERE ti_day = (SELECT SUBSTR('일월화수목금토', DAYOFWEEK(adddate(now(), INTERVAL 2 DAY)), 1));
INSERT INTO futsal.match (mt_date, mt_st_num, mt_ti_num, mt_personnel, mt_state1)
SELECT
	date(adddate(adddate(now(), INTERVAL 3 DAY), INTERVAL 7 DAY)),
	sc_st_num,
	sc_ti_num,
	sc_personnel,
	if(st_available = 0, 0, if(date(adddate(now(), INTERVAL 7 DAY)) >= av_notdate, 1, 0))
FROM
	futsal.schedule
	join
futsal.time on sc_ti_num = ti_num
	join
futsal.stadium on sc_st_num = st_num
	left join
futsal.availability on av_st_num = st_num
WHERE ti_day = (SELECT SUBSTR('일월화수목금토', DAYOFWEEK(adddate(now(), INTERVAL 3 DAY)), 1));
INSERT INTO futsal.match (mt_date, mt_st_num, mt_ti_num, mt_personnel, mt_state1)
SELECT
	date(adddate(adddate(now(), INTERVAL 4 DAY), INTERVAL 7 DAY)),
	sc_st_num,
	sc_ti_num,
	sc_personnel,
	if(st_available = 0, 0, if(date(adddate(now(), INTERVAL 7 DAY)) >= av_notdate, 1, 0))
FROM
	futsal.schedule
	join
futsal.time on sc_ti_num = ti_num
	join
futsal.stadium on sc_st_num = st_num
	left join
futsal.availability on av_st_num = st_num
WHERE ti_day = (SELECT SUBSTR('일월화수목금토', DAYOFWEEK(adddate(now(), INTERVAL 4 DAY)), 1));
INSERT INTO futsal.match (mt_date, mt_st_num, mt_ti_num, mt_personnel, mt_state1)
SELECT
	date(adddate(adddate(now(), INTERVAL 5 DAY), INTERVAL 7 DAY)),
	sc_st_num,
	sc_ti_num,
	sc_personnel,
	if(st_available = 0, 0, if(date(adddate(now(), INTERVAL 7 DAY)) >= av_notdate, 1, 0))
FROM
	futsal.schedule
	join
futsal.time on sc_ti_num = ti_num
	join
futsal.stadium on sc_st_num = st_num
	left join
futsal.availability on av_st_num = st_num
WHERE ti_day = (SELECT SUBSTR('일월화수목금토', DAYOFWEEK(adddate(now(), INTERVAL 5 DAY)), 1));
INSERT INTO futsal.match (mt_date, mt_st_num, mt_ti_num, mt_personnel, mt_state1)
SELECT
	date(adddate(adddate(now(), INTERVAL 6 DAY), INTERVAL 7 DAY)),
	sc_st_num,
	sc_ti_num,
	sc_personnel,
	if(st_available = 0, 0, if(date(adddate(now(), INTERVAL 7 DAY)) >= av_notdate, 1, 0))
FROM
	futsal.schedule
	join
futsal.time on sc_ti_num = ti_num
	join
futsal.stadium on sc_st_num = st_num
	left join
futsal.availability on av_st_num = st_num
WHERE ti_day = (SELECT SUBSTR('일월화수목금토', DAYOFWEEK(adddate(now(), INTERVAL 6 DAY)), 1));
INSERT INTO futsal.match (mt_date, mt_st_num, mt_ti_num, mt_personnel, mt_state1)
SELECT
	date(adddate(adddate(now(), INTERVAL 0 DAY), INTERVAL 14 DAY)),
	sc_st_num,
	sc_ti_num,
	sc_personnel,
	if(st_available = 0, 0, if(date(adddate(now(), INTERVAL 14 DAY)) >= av_notdate, 1, 0))
FROM
	futsal.schedule
	join
futsal.time on sc_ti_num = ti_num
	join
futsal.stadium on sc_st_num = st_num
	left join
futsal.availability on av_st_num = st_num
WHERE ti_day = (SELECT SUBSTR('일월화수목금토', DAYOFWEEK(adddate(now(), INTERVAL 0 DAY)), 1));
INSERT INTO futsal.match (mt_date, mt_st_num, mt_ti_num, mt_personnel, mt_state1)
SELECT
	date(adddate(adddate(now(), INTERVAL 1 DAY), INTERVAL 14 DAY)),
	sc_st_num,
	sc_ti_num,
	sc_personnel,
	if(st_available = 0, 0, if(date(adddate(now(), INTERVAL 14 DAY)) >= av_notdate, 1, 0))
FROM
	futsal.schedule
	join
futsal.time on sc_ti_num = ti_num
	join
futsal.stadium on sc_st_num = st_num
	left join
futsal.availability on av_st_num = st_num
WHERE ti_day = (SELECT SUBSTR('일월화수목금토', DAYOFWEEK(adddate(now(), INTERVAL 1 DAY)), 1));
INSERT INTO futsal.match (mt_date, mt_st_num, mt_ti_num, mt_personnel, mt_state1)
SELECT
	date(adddate(adddate(now(), INTERVAL 2 DAY), INTERVAL 14 DAY)),
	sc_st_num,
	sc_ti_num,
	sc_personnel,
	if(st_available = 0, 0, if(date(adddate(now(), INTERVAL 14 DAY)) >= av_notdate, 1, 0))
FROM
	futsal.schedule
	join
futsal.time on sc_ti_num = ti_num
	join
futsal.stadium on sc_st_num = st_num
	left join
futsal.availability on av_st_num = st_num
WHERE ti_day = (SELECT SUBSTR('일월화수목금토', DAYOFWEEK(adddate(now(), INTERVAL 2 DAY)), 1));
INSERT INTO futsal.match (mt_date, mt_st_num, mt_ti_num, mt_personnel, mt_state1)
SELECT
	date(adddate(adddate(now(), INTERVAL 3 DAY), INTERVAL 14 DAY)),
	sc_st_num,
	sc_ti_num,
	sc_personnel,
	if(st_available = 0, 0, if(date(adddate(now(), INTERVAL 14 DAY)) >= av_notdate, 1, 0))
FROM
	futsal.schedule
	join
futsal.time on sc_ti_num = ti_num
	join
futsal.stadium on sc_st_num = st_num
	left join
futsal.availability on av_st_num = st_num
WHERE ti_day = (SELECT SUBSTR('일월화수목금토', DAYOFWEEK(adddate(now(), INTERVAL 3 DAY)), 1));
INSERT INTO futsal.match (mt_date, mt_st_num, mt_ti_num, mt_personnel, mt_state1)
SELECT
	date(adddate(adddate(now(), INTERVAL 4 DAY), INTERVAL 14 DAY)),
	sc_st_num,
	sc_ti_num,
	sc_personnel,
	if(st_available = 0, 0, if(date(adddate(now(), INTERVAL 14 DAY)) >= av_notdate, 1, 0))
FROM
	futsal.schedule
	join
futsal.time on sc_ti_num = ti_num
	join
futsal.stadium on sc_st_num = st_num
	left join
futsal.availability on av_st_num = st_num
WHERE ti_day = (SELECT SUBSTR('일월화수목금토', DAYOFWEEK(adddate(now(), INTERVAL 4 DAY)), 1));
INSERT INTO futsal.match (mt_date, mt_st_num, mt_ti_num, mt_personnel, mt_state1)
SELECT
	date(adddate(adddate(now(), INTERVAL 5 DAY), INTERVAL 14 DAY)),
	sc_st_num,
	sc_ti_num,
	sc_personnel,
	if(st_available = 0, 0, if(date(adddate(now(), INTERVAL 14 DAY)) >= av_notdate, 1, 0))
FROM
	futsal.schedule
	join
futsal.time on sc_ti_num = ti_num
	join
futsal.stadium on sc_st_num = st_num
	left join
futsal.availability on av_st_num = st_num
WHERE ti_day = (SELECT SUBSTR('일월화수목금토', DAYOFWEEK(adddate(now(), INTERVAL 5 DAY)), 1));
INSERT INTO futsal.match (mt_date, mt_st_num, mt_ti_num, mt_personnel, mt_state1)
SELECT
	date(adddate(adddate(now(), INTERVAL 6 DAY), INTERVAL 14 DAY)),
	sc_st_num,
	sc_ti_num,
	sc_personnel,
	if(st_available = 0, 0, if(date(adddate(now(), INTERVAL 14 DAY)) >= av_notdate, 1, 0))
FROM
	futsal.schedule
	join
futsal.time on sc_ti_num = ti_num
	join
futsal.stadium on sc_st_num = st_num
	left join
futsal.availability on av_st_num = st_num
WHERE ti_day = (SELECT SUBSTR('일월화수목금토', DAYOFWEEK(adddate(now(), INTERVAL 6 DAY)), 1));
INSERT INTO futsal.match (mt_date, mt_st_num, mt_ti_num, mt_personnel, mt_state1)
SELECT
	date(adddate(now(), INTERVAL 21 DAY)),
	sc_st_num,
	sc_ti_num,
	sc_personnel,
	if(st_available = 0, 0, if(date(adddate(now(), INTERVAL 21 DAY)) >= av_notdate, 1, 0))
FROM
	futsal.schedule
	join
futsal.time on sc_ti_num = ti_num
	join
futsal.stadium on sc_st_num = st_num
	left join
futsal.availability on av_st_num = st_num
WHERE ti_day = (SELECT SUBSTR('일월화수목금토', DAYOFWEEK(now()), 1));

insert into manager(mn_mt_num, mn_me_num)
values
(902, 3), (463, 3) ,(522, 3), (8, 3), (48, 3),
(1337, 3), (1344, 3), (465, 4), (524, 4),
(20, 3), (121, 3), (304, 3), (423, 3);

insert into preferred_region(pr_me_num, pr_rg_num)
values
(3, 2), (3, 3), (3, 8), (4, 8) ,(5, 2), (5, 3), (5, 8);

insert into preferred_time(pt_ti_num, pt_me_num)
values
(11 , 3), (12 , 3), (18 , 3), (19 , 3), (20 , 3),
(35 , 3), (36 , 3), (42 , 3), (43 , 3), (44 , 3),
(59 , 3), (60 , 3), (66 , 3), (67 , 3), (68 , 3),
(83 , 3), (84 , 3), (90 , 3), (91 , 3), (92 , 3),
(107 , 3), (108 , 3), (114 , 3), (115 , 3), (116 , 3),
(131 , 3), (132 , 3), (138 , 3), (139 , 3), (140 , 3),
(155 , 3), (156 , 3), (162 , 3), (163 , 3), (164 , 3),
(11 , 4), (12 , 4), (13 , 4), (14 , 4), (15 , 4),
(16 , 4), (17 , 4), (18 , 4), (19 , 4), (20 , 4),
(35 , 4), (36 , 4), (37 , 4), (38 , 4), (39 , 4),
(40 , 4), (41 , 4), (42 , 4), (43 , 4), (44 , 4),
(59 , 4), (60 , 4), (61 , 4), (62 , 4), (63 , 4),
(64 , 4), (65 , 4), (66 , 4), (67 , 4), (68 , 4),
(83 , 4), (84 , 4), (85 , 4), (86 , 4), (87 , 4),
(88 , 4), (89 , 4), (90 , 4), (91 , 4), (92 , 4),
(107 , 4), (108 , 4), (109 , 4), (110 , 4), (111 , 4),
(112 , 4), (113 , 4), (114 , 4), (115 , 4), (116 , 4),
(131 , 4), (132 , 4), (133 , 4), (134 , 4), (135 , 4),
(136 , 4), (137 , 4), (138 , 4), (139 , 4), (140 , 4),
(155 , 4), (156 , 4), (157 , 4), (158 , 4), (159 , 4),
(160 , 4), (161 , 4), (162 , 4), (163 , 4), (164 , 4),
(11 , 5), (12 , 5), (18 , 5), (19 , 5), (20 , 5),
(35 , 5), (36 , 5), (42 , 5), (43 , 5), (44 , 5),
(59 , 5), (60 , 5), (66 , 5), (67 , 5), (68 , 5),
(83 , 5), (84 , 5), (90 , 5), (91 , 5), (92 , 5),
(107 , 5), (108 , 5), (114 , 5), (115 , 5), (116 , 5),
(131 , 5), (132 , 5), (138 , 5), (139 , 5), (140 , 5),
(155 , 5), (156 , 5), (162 , 5), (163 , 5), (164 , 5);

insert into team(te_mt_num, te_type)
values
(463, 0), (902, 0), (524, 0), (465, 1),
(522, 1), (522, 2), (20, 0), (20, 1), (20, 2),
(20, 3), (121, 1), (121, 2),(121, 3), (186, 1),
(186, 2), (243, 0), (304, 0), (304, 1), (304, 2),
(304, 3), (366, 0), (423, 0), (423, 1), (423, 2),
(423, 3);

delete from team
where te_mt_num in (20, 304, 423) and te_type = 0;

insert into entry(en_me_num, en_te_num)
values
(5, 1), (6, 1), (7, 1), (8, 1), (9, 1),
(10, 1), (11, 1), (12, 1), (13, 1), (14, 1),
(15, 1), (16, 1), (17, 1), (18, 1), (19, 1),

(5, 2), (6, 2), (7, 2), (8, 2), (9, 2),
(10, 2), (11, 2), (12, 2),

(5, 3), (6, 3), (7, 3), (8, 3), (9, 3),
(10, 3), (11, 3), (12, 3), (13, 3), (14, 3),
(15, 3), (16, 3), (17, 3), (18, 3), (19, 3),
-- 20
(1, 8), (4, 8), (7, 8), (10, 8), (13, 8), (16, 8), (19, 8), (22, 8), 
(2, 9), (5, 9), (8, 9), (11, 9), (14, 9), (17, 9), (20, 9), (23, 9), 
(3, 10), (6, 10), (9, 10), (12, 10), (15, 10), (18, 10), (21, 10), (24, 10),
-- 243
(1, 16), (3, 16), (5, 16), (7, 16), (9, 16), (11, 16), (13, 16), (15, 16), (16, 16), (19, 16), (21, 16), (23, 16), 
-- 304
(1, 18), (2, 18), (3, 18), (4, 18), (5, 18), (6, 18), 
(7, 19), (8, 19), (9, 19), (10, 19), (11, 19), (12, 19), 
(13, 20), (14, 20), (15, 20), (16, 20), (17, 20), (18, 20), 
-- 366
(1, 21), (3, 21), (5, 21), (7, 21), (9, 21), (11, 21), (13, 21), (15, 21), (17, 21), (19, 21), (21, 21), (23, 21),
-- 423
(1, 23), (2, 23), (3, 23), (4, 23), (5, 23), (6, 23), 
(7, 24), (8, 24), (9, 24), (10, 24), (11, 24), (12, 24), 
(13, 25), (14, 25), (15, 25), (16, 25), (17, 25), (18, 25);

insert into holding_coupon(hp_me_num, hp_cp_num)
values(5, 3), (5, 4), (5, 5);

insert into point_history(ph_price, ph_source, ph_mt_num, ph_me_num)
values
(-60000, 1, 121, 1), (-60000, 1, 121, 11), (-60000, 1, 121, 21),
(-60000, 1, 186, 1), (-60000, 1, 186, 21),
(-10000, 1, 20, 1), (-10000, 1, 20, 2), (-10000, 1, 20, 3), (-10000, 1, 20, 4),
(-10000, 1, 20, 5), (-10000, 1, 20, 6), (-10000, 1, 20, 7), (-10000, 1, 20, 8),
(-10000, 1, 20, 9), (-10000, 1, 20, 10),(-10000, 1, 20, 11), (-10000, 1, 20, 12),
(-10000, 1, 20, 13), (-10000, 1, 20, 14), (-10000, 1, 20, 15), (-10000, 1, 20, 16),
(-10000, 1, 20, 17), (-10000, 1, 20, 18), (-10000, 1, 20, 19), (-10000, 1, 20, 20),
(-10000, 1, 20, 21), (-10000, 1, 20, 22), (-10000, 1, 20, 23), (-10000, 1, 20, 24),
(-10000, 1, 243, 1), (-10000, 1, 243, 3), (-10000, 1, 243, 5), (-10000, 1, 243, 7), (-10000, 1, 243, 9), (-10000, 1, 243, 11),
(-10000, 1, 243, 13), (-10000, 1, 243, 15), (-10000, 1, 243, 17), (-10000, 1, 243, 19), (-10000, 1, 243, 21), (-10000, 1, 243, 23),
(-10000, 1, 304, 1), (-10000, 1, 304, 2), (-10000, 1, 304, 3), (-10000, 1, 304, 4), (-10000, 1, 304, 5), (-10000, 1, 304, 6),
(-10000, 1, 304, 7), (-10000, 1, 304, 8), (-10000, 1, 304, 9), (-10000, 1, 304, 10), (-10000, 1, 304, 11), (-10000, 1, 304, 12),
(-10000, 1, 304, 13), (-10000, 1, 304, 14), (-10000, 1, 304, 15), (-10000, 1, 304, 16), (-10000, 1, 304, 17), (-10000, 1, 304, 18),
(-10000, 1, 366, 1), (-10000, 1, 366, 3), (-10000, 1, 366, 5), (-10000, 1, 366, 7), (-10000, 1, 366, 9), (-10000, 1, 366, 11),
(-10000, 1, 366, 13), (-10000, 1, 366, 15), (-10000, 1, 366, 17), (-10000, 1, 366, 19), (-10000, 1, 366, 21), (-10000, 1, 366, 23),
(-10000, 1, 423, 1), (-10000, 1, 423, 2), (-10000, 1, 423, 3), (-10000, 1, 423, 4), (-10000, 1, 423, 5), (-10000, 1, 423, 6),
(-10000, 1, 423, 7), (-10000, 1, 423, 8), (-10000, 1, 423, 9), (-10000, 1, 423, 10), (-10000, 1, 423, 11), (-10000, 1, 423, 12),
(-10000, 1, 423, 13), (-10000, 1, 423, 14), (-10000, 1, 423, 15), (-10000, 1, 423, 16), (-10000, 1, 423, 17), (-10000, 1, 423, 18),
(-10000, 1, 463, 5), (-10000, 1, 463, 6), (-10000, 1, 463, 7), (-10000, 1, 463, 8), (-10000, 1, 463, 9),
(-10000, 1, 463, 10), (-10000, 1, 463, 11), (-10000, 1, 463, 12),(-10000, 1, 463, 13), (-10000, 1, 463, 14),
(-10000, 1, 463, 15), (-10000, 1, 463, 16), (-10000, 1, 463, 17), (-10000, 1, 463, 18), (-10000, 1, 463, 19),
(-10000, 1, 902, 5), (-10000, 1, 902, 6), (-10000, 1, 902, 7), (-10000, 1, 902, 8), (-10000, 1, 902, 9),
(-10000, 1, 902, 10), (-10000, 1, 902, 11), (-10000, 1, 902, 12),
(-10000, 1, 524, 5), (-10000, 1, 524, 6), (-10000, 1, 524, 7), (-10000, 1, 524, 8), (-10000, 1, 524, 9),
(-10000, 1, 524, 10), (-10000, 1, 524, 11), (-10000, 1, 524, 12), (-10000, 1, 524, 13), (-10000, 1, 524, 14),
(-10000, 1, 524, 15), (-10000, 1, 524, 16), (-10000, 1, 524, 17), (-10000, 1, 524, 18), (-10000, 1, 524, 19),
(-60000, 1, 465, 1), (-60000, 1, 522, 11), (-60000, 1, 522, 21);

insert into club(cl_name, cl_rg_num)
values
('클럽1', 1), ('클럽2', 2), ('클럽3', 2);

insert into club_member(cm_me_num, cm_cl_num, cm_authority)
values
(1, 1, 'LEADER'), (2, 1, 'MEMBER'), (3, 1, 'MEMBER'), (4, 1, 'MEMBER'), (5, 1, 'MEMBER'),
(6, 1, 'MEMBER'), (7, 1, 'MEMBER'), (8, 1, 'MEMBER'), (9, 1, 'MEMBER'), (10, 1, 'MEMBER'),
(11, 2, 'LEADER'), (12, 2, 'MEMBER'), (13, 2, 'MEMBER'), (14, 2, 'MEMBER'), (15, 2, 'MEMBER'),
(16, 2, 'MEMBER'), (17, 2, 'MEMBER'), (18, 2, 'MEMBER'), (19, 2, 'MEMBER'), (20, 2, 'MEMBER'),
(21, 3, 'LEADER'), (22, 3, 'MEMBER'), (23, 3, 'MEMBER'), (24, 3, 'MEMBER'), (25, 3, 'MEMBER'),
(26, 3, 'MEMBER'), (27, 3, 'MEMBER'), (28, 3, 'MEMBER'), (29, 3, 'MEMBER'), (30, 3, 'MEMBER'),
(1, 2, 'MEMBER'), (1, 3, 'MEMBER');

insert into team_preferred_time(tt_cl_num, tt_ti_num)
values
(1, 7), (1, 8), (1, 9), (1, 10), (1, 11), (1, 12),
(1, 13), (1, 14), (1, 15), (1, 16), (1, 17), (1, 18),
(1, 19), (1, 20), (1, 21), (1, 22), (1, 23), (1, 24),
(1, 31), (1, 32), (1, 33), (1, 34), (1, 35), (1, 36),
(1, 37), (1, 38), (1, 39), (1, 40), (1, 41), (1, 42),
(1, 43), (1, 44), (1, 45), (1, 46), (1, 47), (1, 48),
(1, 55), (1, 56), (1, 57), (1, 58), (1, 59), (1, 60),
(1, 61), (1, 62), (1, 63), (1, 64), (1, 65), (1, 66),
(1, 67), (1, 68), (1, 69), (1, 70), (1, 71), (1, 72),
(1, 79), (1, 80), (1, 81), (1, 82), (1, 83), (1, 84),
(1, 85), (1, 86), (1, 87), (1, 88), (1, 89), (1, 90),
(1, 91), (1, 92), (1, 93), (1, 94), (1, 95), (1, 96),
(1, 103), (1, 104), (1, 105), (1, 106), (1, 107), (1, 108),
(1, 109), (1, 110), (1, 111), (1, 112), (1, 113), (1, 114),
(1, 115), (1, 116), (1, 117), (1, 118), (1, 119), (1, 120),
(1, 127), (1, 128), (1, 129), (1, 130), (1, 131), (1, 132),
(1, 133), (1, 134), (1, 135), (1, 136), (1, 137), (1, 138),
(1, 139), (1, 140), (1, 141), (1, 142), (1, 143), (1, 144),
(1, 151), (1, 152), (1, 153), (1, 154), (1, 155), (1, 156),
(1, 157), (1, 158), (1, 159), (1, 160), (1, 161), (1, 162),
(1, 163), (1, 164), (1, 165), (1, 166), (1, 167), (1, 168),
(2, 7), (2, 8), (2, 9), (2, 10), (2, 11), (2, 12),
(2, 13), (2, 14), (2, 15), (2, 16), (2, 17), (2, 18),
(2, 19), (2, 20), (2, 21), (2, 22), (2, 23), (2, 24),
(2, 31), (2, 32), (2, 33), (2, 34), (2, 35), (2, 36),
(2, 37), (2, 38), (2, 39), (2, 40), (2, 41), (2, 42),
(2, 43), (2, 44), (2, 45), (2, 46), (2, 47), (2, 48),
(2, 55), (2, 56), (2, 57), (2, 58), (2, 59), (2, 60),
(2, 61), (2, 62), (2, 63), (2, 64), (2, 65), (2, 66),
(2, 67), (2, 68), (2, 69), (2, 70), (2, 71), (2, 72),
(2, 79), (2, 80), (2, 81), (2, 82), (2, 83), (2, 84),
(2, 85), (2, 86), (2, 87), (2, 88), (2, 89), (2, 90),
(2, 91), (2, 92), (2, 93), (2, 94), (2, 95), (2, 96),
(2, 103), (2, 104), (2, 105), (2, 106), (2, 107), (2, 108),
(2, 109), (2, 110), (2, 111), (2, 112), (2, 113), (2, 114),
(2, 115), (2, 116), (2, 117), (2, 118), (2, 119), (2, 120),
(2, 127), (2, 128), (2, 129), (2, 130), (2, 131), (2, 132),
(2, 133), (2, 134), (2, 135), (2, 136), (2, 137), (2, 138),
(2, 139), (2, 140), (2, 141), (2, 142), (2, 143), (2, 144),
(2, 151), (2, 152), (2, 153), (2, 154), (2, 155), (2, 156),
(2, 157), (2, 158), (2, 159), (2, 160), (2, 161), (2, 162),
(2, 163), (2, 164), (2, 165), (2, 166), (2, 167), (2, 168),
(3, 7), (3, 8), (3, 9), (3, 10), (3, 11), (3, 12),
(3, 13), (3, 14), (3, 15), (3, 16), (3, 17), (3, 18),
(3, 19), (3, 20), (3, 21), (3, 22), (3, 23), (3, 24),
(3, 31), (3, 32), (3, 33), (3, 34), (3, 35), (3, 36),
(3, 37), (3, 38), (3, 39), (3, 40), (3, 41), (3, 42),
(3, 43), (3, 44), (3, 45), (3, 46), (3, 47), (3, 48),
(3, 55), (3, 56), (3, 57), (3, 58), (3, 59), (3, 60),
(3, 61), (3, 62), (3, 63), (3, 64), (3, 65), (3, 66),
(3, 67), (3, 68), (3, 69), (3, 70), (3, 71), (3, 72),
(3, 79), (3, 80), (3, 81), (3, 82), (3, 83), (3, 84),
(3, 85), (3, 86), (3, 87), (3, 88), (3, 89), (3, 90),
(3, 91), (3, 92), (3, 93), (3, 94), (3, 95), (3, 96),
(3, 103), (3, 104), (3, 105), (3, 106), (3, 107), (3, 108),
(3, 109), (3, 110), (3, 111), (3, 112), (3, 113), (3, 114),
(3, 115), (3, 116), (3, 117), (3, 118), (3, 119), (3, 120),
(3, 127), (3, 128), (3, 129), (3, 130), (3, 131), (3, 132),
(3, 133), (3, 134), (3, 135), (3, 136), (3, 137), (3, 138),
(3, 139), (3, 140), (3, 141), (3, 142), (3, 143), (3, 144),
(3, 151), (3, 152), (3, 153), (3, 154), (3, 155), (3, 156),
(3, 157), (3, 158), (3, 159), (3, 160), (3, 161), (3, 162),
(3, 163), (3, 164), (3, 165), (3, 166), (3, 167), (3, 168);


insert into club_team(ct_te_num, ct_cl_num)
values
(4, 1), (5, 2), (6, 3), (11, 1), (12, 2), (13, 3), (14, 1), (15, 3);

insert into entry(en_me_num, en_te_num)
values
(1, 4), (2, 4), (3, 4),
(11, 5), (12, 5), (13, 5), (14, 5),
(15, 5), (16, 5), (17, 5), (1, 5),
(21, 6), (22, 6), (23, 6), (24, 6),
(25, 6), (26, 6), (27, 6), (28, 6),
(1, 11), (2, 11), (3, 11), (4, 11), (5, 11), (6, 11), 
(11, 12), (12, 12), (13, 12), (14, 12), (15, 12), (16, 12), 
(21, 13), (22, 13), (23, 13), (24, 13), (25, 13), (26, 13),
(1, 14), (2, 14), (3, 14), (4, 14), (5, 14), (6, 14), 
(11, 15), (12, 15), (13, 15), (14, 15), (15, 15), (16, 15); 

INSERT INTO QUARTER(QU_MT_NUM, QU_TE_NUM1, QU_GOAL1, QU_TE_NUM2, QU_GOAL2)
VALUES
(20, 8, 1, 9, 0), (20, 8, 2, 10, 0), (20, 9, 1, 10, 0),
(20, 8, 1, 9, 1), (20, 8, 0, 10, 2), (20, 9, 2, 10, 1),
(20, 8, 2, 9, 0), (20, 8, 0, 10, 0), (20, 9, 1, 10, 2),
(121, 11, 1, 12, 1), (121, 11, 1, 13, 0), (121, 12, 1, 13, 2),
(121, 11, 0, 12, 1), (121, 11, 1, 13, 2), (121, 12, 2, 13, 3),
(121, 11, 0, 12, 3), (121, 11, 0, 13, 2), (121, 12, 3, 13, 2),
(304, 18, 1, 19, 0), (304, 18, 1, 20, 2), (304, 19, 1, 20, 0),
(304, 18, 2, 19, 1), (304, 18, 2, 20, 2), (304, 19, 2, 20, 3),
(304, 18, 0, 19, 0), (304, 18, 0, 20, 3), (304, 19, 2, 20, 2),
(423, 23, 1, 24, 2), (423, 23, 3, 25, 0), (423, 24, 0, 25, 2),
(423, 23, 0, 24, 1), (423, 23, 1, 25, 1), (423, 24, 2, 25, 1),
(423, 23, 1, 24, 3), (423, 23, 2, 25, 0), (423, 24, 3, 25, 1);

UPDATE `MATCH`
SET
	MT_STATE1 = 2
WHERE
	MT_NUM IN (20, 121, 186, 243, 304, 366, 423);

DROP TRIGGER IF EXISTS INSERT_MANAGER;
DROP TRIGGER IF EXISTS DELETE_MANAGER;
DROP TRIGGER IF EXISTS INSERT_TEAM;
DROP TRIGGER IF EXISTS DELETE_TEAM;
DROP TRIGGER IF EXISTS INSERT_CLUB_TEAM;
DROP TRIGGER IF EXISTS INSERT_ENTRY;
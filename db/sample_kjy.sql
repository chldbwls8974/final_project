INSERT INTO MEMBER(ME_ID, ME_PW, ME_RG_NUM, ME_NICKNAME, ME_AUTHORITY)
VALUES
('user1', 'user1', 2, 'B-1', 'BUSINESS'), ('user2', 'user2', 2, 'B-2', 'BUSINESS'), ('user3', 'user3', 2, 'M-1', 'MANAGER'),
('user4', 'user4', 2, 'M-2', 'MANAGER'), ('user5', 'user5', 2, 'U-1', 'USER'), ('user6', 'user6', 2, 'U-2', 'USER'),
('user7', 'user7', 2, 'U-3', 'USER'), ('user8', 'user8', 2, 'U-4', 'USER'), ('user9', 'user9', 2, 'U-5', 'USER'),
('user10', 'user10', 2, 'U-6', 'USER'), ('user11', 'user11', 2, 'U-7', 'USER'), ('user12', 'user12', 2, 'U-8', 'USER'),
('user13', 'user13', 2, 'U-9', 'USER'), ('user14', 'user14', 2, 'U-10', 'USER'), ('user15', 'user15', 2, 'U-11', 'USER'),
('user16', 'user16', 2, 'U-12', 'USER'), ('user17', 'user17', 2, 'U-13', 'USER'), ('user18', 'user18', 2, 'U-14', 'USER'),
('user19', 'user19', 2, 'U-15', 'USER'), ('user20', 'user20', 2, 'U-16', 'USER'),('user21', 'user21', 3, 'U-17', 'USER'),
('user22', 'user22', 3, 'U-18', 'USER'), ('user23', 'user23', 3, 'U-19', 'USER'), ('user24', 'user24', 4, 'U-20', 'USER'),
('user25', 'user25', 4, 'U-21', 'USER'), ('user26', 'user26', 4, 'U-22', 'USER'), ('user27', 'user27', 5, 'U-23', 'USER'),
('user28', 'user28', 6, 'U-24', 'USER'), ('user29', 'user29', 7, 'U-25', 'USER'), ('user30', 'user30', 8, 'B-30', 'BUSINESS');

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
(3, 117, 8), (3, 119, 4), (3, 121, 3), (3, 130, 6), (3, 132, 6),
(3, 135, 8), (3, 137, 8), (3, 139, 8), (3, 141, 8), (3, 143, 4),
(3, 145, 3), (3, 154, 6), (3, 156, 6), (3, 159, 8), (3, 161, 8),
(3, 163, 8), (3, 165, 8), (3, 167, 4), (4, 9, 5), (4, 11, 5),
(4, 14, 5), (4, 16, 5), (4, 18, 5), (4, 20, 3), (4, 33, 5),
(4, 35, 5), (4, 38, 5), (4, 40, 5), (4, 42, 5), (4, 44, 3),
(4, 57, 5), (4, 59, 5), (4, 62, 5), (4, 64, 5), (4, 66, 5),
(4, 68, 3), (4, 81, 5), (4, 83, 5), (4, 86, 5), (4, 88, 5),
(4, 90, 5), (4, 92, 3), (4, 105, 5), (4, 107, 5), (4, 110, 5),
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


insert into manager(mn_mt_num, mn_me_num)
values
(884, 3), (902, 3), (889, 4), (463, 3) ,(524, 3), (8, 3), (48, 3),
(1337, 3), (1344, 3);

update `match`
set
	mt_rule = 1
where
	mt_num = 884 or mt_num = 902 or mt_num = 889 or mt_num = 463 or
	mt_num = 524 or mt_num = 8 or mt_num = 48 or mt_num = 1337 or mt_num = 1344 ;

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
values(463, 0), (902, 0);

update `match`
set
	mt_type = 1,
    mt_state2 = 1
where
	mt_num = 902 or mt_num = 463;

insert into entry(en_me_num, en_te_num)
values
(5, 1), (6, 1), (7, 1), (8, 1), (9, 1), (10, 1), (11, 1), (12, 1),
(5, 2), (6, 2), (7, 2), (8, 2), (9, 2), (10, 2), (11, 2), (12, 2);

insert into holding_coupon(hp_me_num, hp_cp_num)
values(5, 3), (5, 4), (5, 5);
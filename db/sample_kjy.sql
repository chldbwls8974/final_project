-- 작동전 MEMBER.ME_TR_NAME NULL로 바꿀것

INSERT INTO MEMBER(ME_RG_NUM, ME_NICKNAME)
VALUES
(2, 'B-1'), (2, 'B-2'), (2, 'M-1'), (2, 'M-2'), (2, 'U-1'),
(2, 'U-2'), (2, 'U-3'), (2, 'U-4'), (2, 'U-5'), (2, 'U-6'),
(2, 'U-7'), (2, 'U-8'), (2, 'U-9'), (2, 'U-10'), (2, 'U-11'),
(2, 'U-12'), (2, 'U-13'), (2, 'U-14'), (2, 'U-15'), (2, 'U-16'),
(3, 'U-17'), (3, 'U-18'), (3, 'U-19'), (4, 'U-20'), (4, 'U-21'),
(4, 'U-22'), (5, 'U-23'), (6, 'U-24'), (7, 'U-25'), (8, 'B-30');

INSERT INTO BUISNESSMAN(BU_ME_NUM)
VALUES
(1), (2), (30);

INSERT INTO FACILITY(FA_BU_NUM, FA_RG_NUM, FA_NAME, FA_ADD, FA_ADD_DETAIL, FA_PHONE)
VALUES
(1, 1, '시설1', '주소1', '상세주소1', '010-1234-5678'),
(2, 1, '시설2', '주소2', '상세주소2', '010-1111-1111'),
(3, 8, '시설3', '주소3', '상세주소3', '010-1234-1234');

INSERT INTO STADIUM(ST_NAME, ST_LOCATE, ST_DOOR, ST_FLOORTYPE, ST_WIDTH, ST_HEIGHT, ST_MAX, ST_AVAILABLE, ST_FA_NUM) 
VALUES
('경기장 1-1', '위치1', 0, 0, 25, 16, 5, 1, 1),
('경기장 1-2', '위치2', 1, 3, 25, 16, 5, 0, 1),
('경기장 1-3', '위치3', 0, 0, 42, 25, 8, 0, 1),
('경기장 2-1', '위치4', 0, 2, 25, 16, 5, 0, 2),
('경기장 3-1', '위치5', 0, 1, 32, 19, 6, 0, 3),
('경기장 3-2', '위치6', 1, 3, 38, 22, 7, 0, 3);

INSERT INTO AVAILABILITY(AV_ST_NUM, AV_NOTDATE, AV_REASON) 
VALUES
('1', '2023-10-30', '잔디 교체');

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
('일', 09, 21, 3);

INSERT INTO futsal.match (mt_ga_date, mt_st_num, mt_ti_num, mt_personnel)
SELECT
	date(adddate(adddate(now(), INTERVAL 0 DAY), INTERVAL 14 DAY)), sc_st_num, sc_ti_num, sc_personnel
FROM
	futsal.schedule
		join
	futsal.time on sc_ti_num = ti_num
WHERE ti_day = (SELECT SUBSTR('일월화수목금토', DAYOFWEEK(adddate(now(), INTERVAL 0 DAY)), 1));
INSERT INTO futsal.match (mt_ga_date, mt_st_num, mt_ti_num, mt_personnel)
SELECT
	date(adddate(adddate(now(), INTERVAL 1 DAY), INTERVAL 14 DAY)), sc_st_num, sc_ti_num, sc_personnel
FROM
	futsal.schedule
		join
	futsal.time on sc_ti_num = ti_num
WHERE ti_day = (SELECT SUBSTR('일월화수목금토', DAYOFWEEK(adddate(now(), INTERVAL 1 DAY)), 1));
INSERT INTO futsal.match (mt_ga_date, mt_st_num, mt_ti_num, mt_personnel)
SELECT
	date(adddate(adddate(now(), INTERVAL 2 DAY), INTERVAL 14 DAY)), sc_st_num, sc_ti_num, sc_personnel
FROM
	futsal.schedule
		join
	futsal.time on sc_ti_num = ti_num
WHERE ti_day = (SELECT SUBSTR('일월화수목금토', DAYOFWEEK(adddate(now(), INTERVAL 2 DAY)), 1));
INSERT INTO futsal.match (mt_ga_date, mt_st_num, mt_ti_num, mt_personnel)
SELECT
	date(adddate(adddate(now(), INTERVAL 3 DAY), INTERVAL 14 DAY)), sc_st_num, sc_ti_num, sc_personnel
FROM
	futsal.schedule
		join
	futsal.time on sc_ti_num = ti_num
WHERE ti_day = (SELECT SUBSTR('일월화수목금토', DAYOFWEEK(adddate(now(), INTERVAL 3 DAY)), 1));
INSERT INTO futsal.match (mt_ga_date, mt_st_num, mt_ti_num, mt_personnel)
SELECT
	date(adddate(adddate(now(), INTERVAL 4 DAY), INTERVAL 14 DAY)), sc_st_num, sc_ti_num, sc_personnel
FROM
	futsal.schedule
		join
	futsal.time on sc_ti_num = ti_num
WHERE ti_day = (SELECT SUBSTR('일월화수목금토', DAYOFWEEK(adddate(now(), INTERVAL 4 DAY)), 1));
INSERT INTO futsal.match (mt_ga_date, mt_st_num, mt_ti_num, mt_personnel)
SELECT
	date(adddate(adddate(now(), INTERVAL 5 DAY), INTERVAL 14 DAY)), sc_st_num, sc_ti_num, sc_personnel
FROM
	futsal.schedule
		join
	futsal.time on sc_ti_num = ti_num
WHERE ti_day = (SELECT SUBSTR('일월화수목금토', DAYOFWEEK(adddate(now(), INTERVAL 5 DAY)), 1));
INSERT INTO futsal.match (mt_ga_date, mt_st_num, mt_ti_num, mt_personnel)
SELECT
	date(adddate(adddate(now(), INTERVAL 6 DAY), INTERVAL 14 DAY)), sc_st_num, sc_ti_num, sc_personnel
FROM
	futsal.schedule
		join
	futsal.time on sc_ti_num = ti_num
WHERE ti_day = (SELECT SUBSTR('일월화수목금토', DAYOFWEEK(adddate(now(), INTERVAL 6 DAY)), 1));
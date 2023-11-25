SET GLOBAL event_scheduler = ON;

USE FUTSAL;

DROP EVENT IF EXISTS insert_match_event;
-- 매일 자정에 등록된 스케줄에 따라 21일 뒤의 날짜에 매치를 자동으로 생성
DELIMITER $$
CREATE EVENT IF NOT EXISTS insert_match_event
ON SCHEDULE EVERY 1 day
STARTS TIMESTAMP(CURRENT_DATE, '00:00:00')
DO
BEGIN
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
    WHERE st_available != 2 and ti_day = (SELECT SUBSTR('일월화수목금토', DAYOFWEEK(now()), 1));
END;
$$
DELIMITER ;

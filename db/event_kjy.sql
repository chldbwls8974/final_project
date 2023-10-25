SET GLOBAL event_scheduler = ON;

USE FUTSAL;

DELIMITER $$
CREATE EVENT IF NOT EXISTS insert_match_event
ON SCHEDULE EVERY 1 day
STARTS TIMESTAMP(CURRENT_DATE, '00:00:00')
DO
BEGIN
    INSERT INTO futsal.match (mt_ga_date, mt_st_num, mt_ti_num, mt_personnel, mt_state1)
    SELECT
		date(adddate(now(), INTERVAL 21 DAY)),
        sc_st_num,
        sc_ti_num,
        sc_personnel,
        if(st_available = 0, 0, if(date(adddate(now(), INTERVAL 21 DAY)) > av_notdate, 0, 2))
    FROM
		futsal.schedule
		join
	futsal.time on sc_ti_num = ti_num
		join
	futsal.stadium on sc_st_num = st_num
		left join
	futsal.availability on av_st_num = st_num
    WHERE ti_day = (SELECT SUBSTR('일월화수목금토', DAYOFWEEK(now()), 1));
END;
$$
DELIMITER ;

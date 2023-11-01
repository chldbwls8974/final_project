use futsal;

DROP EVENT IF EXISTS TEST_EVENT;

CREATE EVENT TEST_EVENT
ON SCHEDULE EVERY 1 day
DO 
	UPDATE futsal.expense 
    SET ex_price = ex_pre, ex_pre=null, ex_date = null
    where ex_date < now();
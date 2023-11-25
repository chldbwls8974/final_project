-- 이벤트 스케줄러 활성화
SET GLOBAL event_scheduler = ON;


-- 티어 보상 이벤트 스케줄러
SELECT * FROM information_schema.EVENTS   ;    
DROP EVENT AddCouponsEvent;
DELIMITER //
CREATE EVENT IF NOT EXISTS AddCouponsEvent
ON SCHEDULE EVERY 1 YEAR
STARTS '2023-11-01 00:37:00'
DO
BEGIN
    DECLARE currentDate DATE;
    SET currentDate = DATE_FORMAT(CURRENT_DATE, '%Y-01-01');
    
    -- 브론즈 회원에게 쿠폰 추가
    INSERT INTO holding_coupon (hp_me_num, hp_cp_num, hp_state)
    SELECT m.me_num, c.cp_num, 0
    FROM `member` m
    JOIN coupon c ON c.cp_num = 4
    WHERE m.me_tr_name = '브론즈';

    -- 실버 회원에게 쿠폰 추가
	INSERT INTO holding_coupon (hp_me_num, hp_cp_num, hp_state)
    SELECT m.me_num, c.cp_num, 0
    FROM `member` m
    JOIN coupon c ON c.cp_num = 5
    WHERE m.me_tr_name = '실버';

    -- 골드 회원에게 쿠폰 추가
   INSERT INTO holding_coupon (hp_me_num, hp_cp_num, hp_state)
    SELECT m.me_num, c.cp_num, 0
    FROM `member` m
    JOIN coupon c ON c.cp_num = 6
    WHERE m.me_tr_name = '골드';

    -- 플레티넘 회원에게 쿠폰 추가
    INSERT INTO holding_coupon (hp_me_num, hp_cp_num, hp_state)
    SELECT m.me_num, c.cp_num, 0
    FROM `member` m
    JOIN coupon c ON c.cp_num = 7
    WHERE m.me_tr_name = '플래티넘';

    -- 다이아 회원에게 쿠폰 추가
    INSERT INTO holding_coupon (hp_me_num, hp_cp_num, hp_state)
    SELECT m.me_num, c.cp_num, 0
    FROM `member` m
    JOIN coupon c ON c.cp_num = 8
    WHERE m.me_tr_name = '다이아';
    
    -- 마스터 회원에게 쿠폰 추가
    INSERT INTO holding_coupon (hp_me_num, hp_cp_num, hp_state)
    SELECT m.me_num, c.cp_num, 0
    FROM `member` m
    JOIN coupon c ON c.cp_num = 9
    WHERE m.me_tr_name = '마스터';
END;
//
DELIMITER ;

--


-- 초대보상(기존)을 가진 회원이 경기 참여를 할 시에, 사용가능 쿠폰으로 변경해 주는 트리거
show triggers;

drop trigger UpdateCouponStateTrigger;

DELIMITER //
CREATE TRIGGER UpdateCouponStateTrigger
AFTER INSERT ON entry
FOR EACH ROW
BEGIN
    -- 보유쿠폰(holding_coupon) 중에 hp_cp_num = 2 이고 hp_state = 1 인 쿠폰을 찾아서 상태를 변경
    UPDATE holding_coupon
    SET hp_state = 0
    WHERE hp_me_num = NEW.en_me_num -- NEW.en_me_num은 새로 추가된 회원의 en_me_num을 나타냅니다
    AND hp_cp_num = 2
    AND hp_state = 1;
END;
//
DELIMITER ;





-- 최근 한 달동안 4경기를 참여하고, 한 달동안 제재를 1회도 받지 않은 회원에게 최대 1장의 쿠폰 지급하는 이벤트 스케줄러 
DELIMITER //
CREATE EVENT IF NOT EXISTS GiveCouponEvent
ON SCHEDULE EVERY 1 MONTH STARTS '2023-11-01 15:25:00'
DO
BEGIN
    -- 1월 1일을 기준으로 한 달 전의 날짜 계산
    DECLARE startDate DATE;
    SET startDate = DATE_SUB(CURRENT_DATE, INTERVAL 1 MONTH);

    -- 참가자테이블(entry)에서 한 달 동안 4번 이상 등록한 회원(en_me_num) 조회
    INSERT INTO holding_coupon (hp_me_num, hp_cp_num, hp_state)
    SELECT e.en_me_num, 3, 0
    FROM entry e
    JOIN team t ON e.en_te_num = t.te_num
    JOIN `match` m ON t.te_mt_num = m.mt_num
    WHERE m.mt_date >= startDate
    GROUP BY e.en_me_num
    HAVING COUNT(*) >= 4
    AND e.en_me_num NOT IN (
        -- 신고테이블(report)에 등록된 회원(en_me_num) 중 rp_state가 '제재'인 회원 제외
        SELECT r.rp_me_num2
        FROM report r
        WHERE r.rp_date >= startDate
        AND r.rp_state = '제재'  -- 신고 상태가 '제재'가 아닌 경우만
    );
END;
//
DELIMITER ;




-- 매일 커뮤니티 정지여부를 확인하고 정지상태를 변경해주는 이벤트
DROP EVENT CheckBoardPenaltyEvent;

DELIMITER //
CREATE EVENT IF NOT EXISTS CheckBoardPenaltyEvent
ON SCHEDULE EVERY 1 day
STARTS '2023-11-10 11:03:00'
DO
  BEGIN
    UPDATE member
    SET me_state2 = 0
    WHERE me_state2 = 1
      AND me_num IN (
        SELECT p.pn_me_num  
        FROM penalty p
        WHERE p.pn_me_num = member.me_num  
          AND p.pn_type = '커뮤니티'
          AND p.pn_end < CURDATE()
      );
  END //
DELIMITER ;



-- 매일 경기 정지여부를 확인하고 정지상태를 변경해주는 이벤트
DROP EVENT CheckMatchPenaltyEvent;
DELIMITER //
CREATE EVENT IF NOT EXISTS CheckMatchPenaltyEvent
ON SCHEDULE EVERY 1 DAY
STARTS '2023-11-10 11:28:00'
DO
  BEGIN
    UPDATE member
    SET me_state1 = 0
    WHERE me_state1 = 1
      AND me_num IN (
        SELECT p.pn_me_num  
        FROM penalty p
        WHERE p.pn_me_num = member.me_num  
          AND p.pn_type = '경기'
          AND p.pn_end < CURDATE()
      );
  END //
DELIMITER ;

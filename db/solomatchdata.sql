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

insert into manager(mn_me_num, mn_mt_num)
value(4, 464), (4, 467);

insert into team(te_mt_num, te_type)
values
(464, 0), (467, 0);

insert into entry(en_me_num, en_te_num)
values
(5, 26),(6, 26), (7, 26), (8, 26), (9, 26),
(10, 26), (11, 26), (12, 26), (13, 26), (14, 26),
(15, 26), (16, 26), (17, 26), (18, 26), (19, 26);
insert into entry(en_me_num, en_te_num)
values
(6, 27), (7, 27), (8, 27), (9, 27),
(10, 27), (11, 27), (12, 27), (13, 27), (14, 27),
(15, 27), (16, 27), (17, 27), (18, 27), (19, 27);

DROP TRIGGER IF EXISTS INSERT_MANAGER;
DROP TRIGGER IF EXISTS DELETE_MANAGER;
DROP TRIGGER IF EXISTS INSERT_TEAM;
DROP TRIGGER IF EXISTS DELETE_TEAM;
DROP TRIGGER IF EXISTS INSERT_CLUB_TEAM;
DROP TRIGGER IF EXISTS INSERT_ENTRY;
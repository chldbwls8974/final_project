insert into entry(en_me_num, en_te_num)
values
(13, 1), (14, 1), (15, 1), (16, 1), (17, 1), (18, 1), (19, 1);

insert into report(rp_rc_num, rp_content, rp_me_num, rp_me_num2, rp_state, rp_date, rp_mt_num)
values
(5, '비매너', 1, 25, '미확인', curdate(), 522);

update member
set me_state1 = 1
where me_num = 25;
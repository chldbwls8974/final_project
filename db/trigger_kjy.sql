-- 점수, 티어 업데이트 쿼리
UPDATE
	member
SET
	me_rating = null,
	me_tr_name = (
		select
			tr_name
		from
			tier
		where
			tr_min_rating <= me_rating
		order by
			tr_min_rating desc
		limit
			1);
-- 클럽 매치 페이지에서 내 클럽의 클럽원 리스트
select
	club_member.*,
    me_nickname,
    me_rating,
    me_tr_name,
    en_num
from
	team
		join
	club_team on ct_te_num = te_num
		join
	club_member on cm_cl_num = ct_cl_num
		join
	member on cm_me_num = me_num
		left join
	(select
		entry.*
	from
		entry
			join
		team on en_te_num = te_num
	where
		te_mt_num = 526) as T on T.en_me_num = me_num
where
	te_mt_num = 526 and
	(cm_authority = 'LEADER' or cm_authority = 'MEMBER')
order by
	cm_cl_num asc,
	me_rating desc;
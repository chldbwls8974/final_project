SELECT * FROM futsal.match;
select
			`match`.*,
            stadium.*,
            facility.*,
            region.*,
            `time`.*,
            manager.mn_me_num,
            if(ifnull(T1.t1, 0) + ifnull(T2.t2, 0) + ifnull(T3.t3, 0) + ifnull(mn_me_num, 0)= 0, true, false) as T,
            (select month(mt_date) * 100000 + day(mt_date) * 1000 + ti_num) as f
		from
			`match`
				join
			stadium on mt_st_num = st_num
				join
			facility on st_fa_num = fa_num
				join
			region on fa_rg_num = rg_num
				join
			`time` on mt_ti_num = ti_num
				left join
			manager on mn_mt_num = mt_num
				left join -- 매니저가 해당 날짜에 이미 등록된 매치가 있으면 해당 매치 제외
			(select
                mt_ti_num as t1
			from
				manager
					join
				`match` on mn_mt_num = mt_num
			where
				mn_me_num = 3 and
                mt_date = '2023-11-10') as T1 on T1.t1 = mt_ti_num
            	left join -- 매치는 2시간동안 진행되므로 1시간 전 매치도 제외
			(select
                mt_ti_num + 1 as t2
			from
				manager
					join
				`match` on mn_mt_num = mt_num
			where
				mn_me_num = 3 and
                mt_date = '2023-11-10') as T2 on T2.t2 = mt_ti_num
                left join -- 매치는 2시간동안 진행되므로 1시간 뒤 매치도 제외
			(select
                mt_ti_num - 1 as t3
			from
				manager
					join
				`match` on mn_mt_num = mt_num
			where
				mn_me_num = 3 and
                mt_date = '2023-11-10') as T3 on T3.t3 = mt_ti_num
		where
			mt_date = '2023-11-10' and
            mt_state1 = 0 and
            if(ifnull(T1.t1, 0) + ifnull(T2.t2, 0) + ifnull(T3.t3, 0) + ifnull(mn_me_num, 0)= 0, true, false)
		order by
			ti_time asc;


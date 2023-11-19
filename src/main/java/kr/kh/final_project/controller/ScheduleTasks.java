package kr.kh.final_project.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;

import kr.kh.final_project.service.MatchService;

@Controller
@Component
public class ScheduleTasks {
    
	@Autowired
	MatchService matchService;
	
    @Scheduled(cron = "0 30 * * * *")
    public void scheduled30() {
    	/* 경기 시작 시간 90분 전까지
    	 * mt_state2 = 0인 매치 삭제(아예 삭제)
    	 * mt_type == 0인 매치 삭제처리(mt_state1 = 1로 수정)
    	 */
        matchService.deleteMatch();
        /* 경기 시작 시간 90분 전까지 mt_type = 1(개인전)인 경기의 인원이 다 모이지 않으면
         * 환불 후 삭제처리(mt_state1 = 1로 수정)
         */
        matchService.deleteMatchSolo();
    }
    
    @Scheduled(cron = "0 0 * * * *")
    public void scheduled0() {
    	/* 경기 시작 시간 12시간 전까지 mt_type = 2(클럽전)인 경기의 클럽이 다 모이지 않으면
         * 환불 후 삭제처리(mt_state1 = 1로 수정)
         */
    	matchService.deleteMatchClub();
    	/* 경기 시간 12시간 후
    	 * 경기결과가 확정되지 않은 (mt_state1 = 0) 경기를 경기결과 확정으로 변경(mt_state1 = 2)
    	 * 경기결과 확정시 기록된 경기결과에 따라 참가자들의 점수와 티어 업데이트
    	 */
    	matchService.updateEndMatch();
    }
}
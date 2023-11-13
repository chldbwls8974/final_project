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
    public void myScheduledMethod() {
        matchService.deleteMatch();
    }
}
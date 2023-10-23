package kr.kh.final_project.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.kh.final_project.dao.AccountDAO;

@Service
public class AccountServiceImp implements AccountService {

	@Autowired
	AccountDAO accountDao;
}

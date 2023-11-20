package kr.kh.final_project.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import kr.kh.final_project.dao.MemberDAO;
import kr.kh.final_project.vo.MemberVO;

// 상속받아야 함
public class AdminInterceptor extends HandlerInterceptorAdapter{

	@Autowired
	MemberDAO memberDao;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		MemberVO user = (MemberVO)request.getSession().getAttribute("user");
		//로그인 하지 않았다면
		if(user == null) {
			response.sendRedirect(request.getContextPath()+"/member/login");
			return false;
		}
		MemberVO dbUser = memberDao.selectMemberByNum(user.getMe_num());
		if(!dbUser.getMe_authority().equals("ADMIN")) {
			response.sendRedirect(request.getContextPath()+"/");
			return false;
		}
		//로그인 했으면 기존에 가려던 URL을 방문해서 작업
		return true;
	}
}

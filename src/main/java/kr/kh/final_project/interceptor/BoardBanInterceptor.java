package kr.kh.final_project.interceptor;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.springframework.web.util.WebUtils;

import kr.kh.final_project.dao.MemberDAO;
import kr.kh.final_project.vo.MemberVO;

public class BoardBanInterceptor extends HandlerInterceptorAdapter{
	
	@Autowired
	MemberDAO memberDao;
	
	@Override
	public boolean preHandle(HttpServletRequest request, 
			HttpServletResponse response, Object handler)
			throws Exception {
		MemberVO user= (MemberVO)request.getSession().getAttribute("user");
		Cookie cookie = WebUtils.getCookie(request, "loginCookie");
		//로그인 하지 않았고, 자동로그인을 설정하지 않았다면
		if(user == null && cookie == null) {
			response.sendRedirect(request.getContextPath()+"/member/login");
			return false;
		}
		
		MemberVO dbUser = memberDao.selectMemberByNum(user.getMe_num());
		
		//유저가 커뮤니티 정지 상태이면
		if(isBan(dbUser)) {
			response.sendRedirect(request.getContextPath()+"/util/ban");
			return false;
		}
		//정지가 아니라면 컨트롤러로 넘어감
		return true;
	}

	private boolean isBan(MemberVO user) {
		if(user.getMe_state2() == 1) {
			return true;
		}
		return false;
	}
}
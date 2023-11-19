package kr.kh.final_project.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import kr.kh.final_project.vo.MemberVO;

public class MemberInterceptor extends HandlerInterceptorAdapter{
	
	@Override
	public boolean preHandle(HttpServletRequest request, 
			HttpServletResponse response, Object handler)
			throws Exception {
		MemberVO user= (MemberVO)request.getSession().getAttribute("user");
		
		//유저가 커뮤니티 정지 상태이면
		if(isBan(user)) {
			System.out.println("정지임");
			response.sendRedirect(request.getContextPath()+"/util/ban");
			return false;
		}
		//정지가 아니라면 컨트롤러로 넘어감
		return true;
	}

	private boolean isBan(MemberVO user) {
		if(user.getMe_state2() == 1 || user.getMe_state1() == 1) {
			return true;
		}
		return false;
	}
}
package kr.kh.final_project.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import kr.kh.final_project.vo.MemberVO;

// 상속받아야 함
public class BusinessInterceptor extends HandlerInterceptorAdapter{

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		MemberVO user = (MemberVO)request.getSession().getAttribute("user");
		//로그인 하지 않았다면
		if(user == null) {
			response.sendRedirect(request.getContextPath()+"/member/login");
			//기존에 가려던 URL은 방문하지 않고 메인으로 이동
			return false;
		}
		if(!user.getMe_authority().equals("BUSINESS")) {
			response.sendRedirect(request.getContextPath()+"/");
			//기존에 가려던 URL은 방문하지 않고 메인으로 이동
			return false;
		}
		//로그인 했으면 기존에 가려던 URL을 방문해서 작업
		return true;
	}
}

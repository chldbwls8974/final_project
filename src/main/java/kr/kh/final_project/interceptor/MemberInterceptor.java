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
		//user 권한이 없으면 로그인 페이지로 이동
		MemberVO user= (MemberVO)request.getSession().getAttribute("user");
		//로그인이 안되어 있으면
		if(user == null) {
			//로그인 페이지로 이동
			response.sendRedirect(request.getContextPath()+"/member/login");
			return false;
		}
		//로그인 했으면 기존에 가려던 URL을 방문해서 작업 
		return true;
	}
}

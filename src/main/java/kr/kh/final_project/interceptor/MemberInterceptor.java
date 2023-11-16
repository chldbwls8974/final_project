package kr.kh.final_project.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import kr.kh.final_project.vo.MemberVO;

public class MemberInterceptor extends HandlerInterceptorAdapter{
	
	@Override
	public boolean preHandle(HttpServletRequest request, 
			HttpServletResponse response, Object handler)
			throws Exception {
		//user 권한이 없으면 로그인 페이지로 이동
		HttpSession session = request.getSession();
		MemberVO user = (MemberVO)session.getAttribute("user");
		//MemberVO user= (MemberVO)request.getSession().getAttribute("user");
		
		System.out.println("인터셉터 :"+ user);
		//유저가 커뮤니티 정지 상태이면
		if(user.getMe_state2() == 1) {
			System.out.println("정지임");
			//로그인 페이지로 이동
//			ModelAndView mv = new ModelAndView("redirect:/util/message");
//			mv.addObject("url", "/");
//			mv.addObject("msg", "왜 안되냐고");
//			response.sendRedirect(request.getContextPath()+"/util/message");
			request.setAttribute("msg", "되냐");
            request.setAttribute("url", "/");
            request.getRequestDispatcher("/util/message2").forward(request, response);
			return false;
		}
		//정지가 아니라면 컨트롤러로 넘어감
		return true;
	}
}
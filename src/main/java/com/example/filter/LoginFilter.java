package com.example.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LoginFilter implements Filter {

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
		// TODO Auto-generated method stub
		HttpServletRequest req = ((HttpServletRequest)request);
		HttpSession session = req.getSession();
		String uri = req.getRequestURI();
		if(!uri.equals("/meeting/") && !uri.equals("/meeting/index.jsp") && !uri.equals("/meeting")) {
			if(session.getAttribute("role") == null && !uri.equals("/meeting/common/login")) {
				((HttpServletResponse)response).sendRedirect("/meeting/index.jsp");
				return ;
			}
		}
		chain.doFilter(request, response);
		
	}

	@Override
	public void destroy() {
		// TODO Auto-generated method stub
		
	}

}

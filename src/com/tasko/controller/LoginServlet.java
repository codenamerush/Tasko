package com.tasko.controller;

import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.tasko.dao.BoardDao;
import com.tasko.dao.UserDao;
import com.tasko.model.Board;
import com.tasko.model.User;

public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 2L;
	private UserDao dao;
	private BoardDao bdao;

	public LoginServlet() {
		super();
		dao = new UserDao();
		bdao = new BoardDao();
	}
	
	   
	
	// Logout on get request
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession(true);
		session.invalidate();
		response.sendRedirect("/tasko/");
	}
	
	// Login on post call
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String email = request.getParameter("email");
		String password = request.getParameter("password");
		HttpSession session = request.getSession(true);
		User user = dao.getUserByEmailAndPassword(email, password);

		if (user.getEmail() != null && user.getEmail() != "") {
			ArrayList<Board> boards = bdao.getAllBoards(user.getUserid());
			session.setAttribute("user", user);
			session.setAttribute("boards", boards);
			response.sendRedirect("/tasko/boards.jsp");
		} else {
			session.setAttribute("msg","Wrong userid/password");
			response.sendRedirect("/tasko/");
		}
		
	}
}
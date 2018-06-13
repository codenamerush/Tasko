package com.tasko.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.tasko.dao.BoardDao;
import com.tasko.model.Board;
import com.tasko.model.User;

public class BoardController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private BoardDao dao;

	public BoardController() {
		super();
		dao = new BoardDao();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession(true);
		User user = (User) session.getAttribute("user");
		Board board = new Board();
		board.setUserid(user.getUserid());
		board.setName(request.getParameter("board"));

		if (user != null) {
			dao.deleteBoard(board);
			ArrayList<Board> boards = dao.getAllBoards(user.getUserid());
			session.setAttribute("boards", boards);
		}
		response.sendRedirect("/tasko/boards.jsp");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession(true);
		User user = (User) session.getAttribute("user");
		ArrayList<Board> boards = (ArrayList<Board>) session.getAttribute("boards");
		if (boards == null) {
			boards = new ArrayList<Board>();
		}
		Board board = new Board();
		board.setUserid(user.getUserid());
		board.setName(request.getParameter("board"));

		if (user != null) {
			dao.addBoard(board);
			boards.add(board);
			session.setAttribute("boards", boards);
		}
		response.sendRedirect("/tasko/boards.jsp");
	}
}
package com.tasko.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLDecoder;
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

public class PlaygroundController extends HttpServlet {
	private static final long serialVersionUID = 3L;
	private BoardDao dao;

	public PlaygroundController() {
		super();
		dao = new BoardDao();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession(true);
		User user = (User) session.getAttribute("user");
		if (user != null) {
			Board board = dao.getBoard(user.getUserid(), request.getParameter("board"));
			if (board != null && board.getName() != null && board.getName() != "") {
				session.setAttribute("playground", board);

			}
			response.sendRedirect("/tasko/playground.jsp?board=" + request.getParameter("board"));

		} else {
			response.sendRedirect("/tasko/");
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession(true);
		User user = (User) session.getAttribute("user");
		Board board = new Board();
		board.setUserid(user.getUserid());
		board.setName(URLDecoder.decode(request.getParameter("board"), "UTF-8"));
		board.setColumns(request.getParameter("data"));
		if (user != null) {
			String boardsJSON = "[";
			
			dao.updatePlaygroundOnBoard(board);
			session.setAttribute("playground", board);

			ArrayList<Board> boards = dao.getAllBoards(user.getUserid());
			
			Iterator<Board> itx = boards.iterator();
			String prefix = "";
			while (itx.hasNext()) {
				Board b = itx.next();
				boardsJSON = boardsJSON + prefix + b.getColumns();
				if (itx.hasNext()) {
					prefix = ",";
				}

			}
			
			boardsJSON += "]";
			session.setAttribute("boardsJSON", boardsJSON);
			PrintWriter out = response.getWriter();
			out.println(boardsJSON);
		}

	}

}

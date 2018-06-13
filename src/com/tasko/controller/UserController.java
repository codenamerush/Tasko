package com.tasko.controller;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.tasko.dao.UserDao;
import com.tasko.model.User;

public class UserController extends HttpServlet {
	private static final long serialVersionUID = 4L;
	private UserDao dao;

	public UserController() {
		super();
		dao = new UserDao();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		User user = new User();
		user.setFirstName(request.getParameter("fname"));
		user.setLastName(request.getParameter("lname"));
		user.setPassword(request.getParameter("password"));
		user.setEmail(request.getParameter("email"));
		dao.addUser(user);
		RequestDispatcher view = request.getRequestDispatcher("/");
		view.forward(request, response);
	}
}
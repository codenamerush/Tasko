package com.tasko.dao;

import java.sql.Connection;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.tasko.model.*;
import com.tasko.util.DbUtil;
		
public class BoardDao {
	private Connection connection;

	public BoardDao() {
		connection = DbUtil.getConnection();
	}

	public void addBoard(Board board){
		try {
			PreparedStatement preparedStatement = connection
					.prepareStatement("insert into boards(userid,name) values (?, ?)");
			preparedStatement.setInt(1, board.getUserid());
			preparedStatement.setString(2, board.getName());
			preparedStatement.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public void updatePlaygroundOnBoard(Board board){
		
		try {
			PreparedStatement preparedStatement = connection
					.prepareStatement("update boards set columns=? where userid=? and name=?");
			preparedStatement.setString(1, board.getColumns());
			preparedStatement.setInt(2, board.getUserid());
			preparedStatement.setString(3, board.getName());
			preparedStatement.executeUpdate();
			System.out.println(board.getColumns());
			System.out.println(board.getUserid());
			System.out.println(board.getName());

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public Board getBoard(int uid, String boardname) {
		Board board = new Board();
		try {
			PreparedStatement preparedStatement = connection
					.prepareStatement("select * from boards where userid=? and name=?");
			preparedStatement.setInt(1, uid);
			preparedStatement.setString(2, boardname);
			ResultSet rs = preparedStatement.executeQuery();
			
			while (rs.next()) {
				board.setUserid(rs.getInt("userid"));
				board.setName(rs.getString("name"));
				board.setBoardId(rs.getInt("boardid"));
				board.setColumns(rs.getString("columns"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return board;
	}
	
	public ArrayList<Board> getAllBoards(int uid) {
		ArrayList<Board> boards = new ArrayList<Board>();
		try {
			PreparedStatement preparedStatement = connection
					.prepareStatement("select * from boards where userid=?");
			preparedStatement.setInt(1, uid);
			ResultSet rs = preparedStatement.executeQuery();
			
			while (rs.next()) {
				Board board = new Board();
				board.setUserid(rs.getInt("userid"));
				board.setName(rs.getString("name"));
				board.setBoardId(rs.getInt("boardid"));
				board.setColumns(rs.getString("columns"));
				boards.add(board);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return boards;
	}
	
	public void deleteBoard(Board board){
		try {
			PreparedStatement preparedStatement = connection
					.prepareStatement("delete from boards where userid=? and name=?");
			preparedStatement.setInt(1, board.getUserid());
			preparedStatement.setString(2, board.getName());
			preparedStatement.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}

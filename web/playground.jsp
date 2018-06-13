<%@page import="com.tasko.dao.BoardDao"%>
<%@page import="com.tasko.model.Board"%>
<%@page import="com.tasko.model.User"%>
<%
	if (session == null) {
		response.sendRedirect("/tasko");
	}
	User user = (User) session.getAttribute("user");
	Board board = (Board) session.getAttribute("playground");
	if (user == null && board == null) {
		response.sendRedirect("/tasko");
	} 
	else 
	{
		String columns = "";
		if(board != null){
			columns = board.getColumns();
		}
%>
<html>
<head>
<title>Index.html</title>
<script src="./js/jquery-1.12.4.js"></script>
<script src="./js/jquery-ui.js"></script>
<link rel="stylesheet" type="text/css" href="./css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="./css/bootstrap-theme.min.css">
<script src="./js/bootstrap.min.js"></script>
<link rel="stylesheet" type="text/css" href="./css/font-awesome.min.css" />
<link href="./css/raleway.css"
	rel="stylesheet">
<link rel="stylesheet" type="text/css" href="./css/style.css" />
<link rel="stylesheet" type="text/css" href="./css/playground.css">
<script src="./js/bootstrap.min.js"></script>
<script src="./js/playground.js"></script>
<script src="./js/app.js"></script>



		<link rel="stylesheet"
			  href="./css/ripples.css"/>

		<link rel="stylesheet" href="./css/bootstrap-material-datetimepicker.css" />
		<link href='http://fonts.googleapis.com/css?family=Roboto:400,500' rel='stylesheet' type='text/css'>
		<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">


		<script src="./js/ripples.min.js"></script>
        <script src="./js/material.min.js"></script>
		<script type="text/javascript" src="http://momentjs.com/downloads/moment-with-locales.min.js"></script>
		<script type="text/javascript" src="./js/bootstrap-material-datetimepicker.js"></script>
		

<script>
	var content = '<%= columns %>';
	var boardsJSON = '<%= (String) session.getAttribute("boardsJSON") %>';
	setAlerts(boardsJSON);
</script>
</head>
<body>
	<div class="container">
		<div class="alert alert-success">
			<strong>Success!</strong> Your changes were saved!.
		</div>

		<div class="alert alert-warning">
			<strong>Oops!</strong> Something went wrong.
		</div>
		<div class="row  panel panel-default">
			<div class="col-md-8">
				<h1>
					Plan your task for
					<%=request.getParameter("board")%></h1>
			</div>
			<div class="col-md-1 action-button">
				<a href="/tasko/boards.jsp">
					<button class="btn btn-info">My boards</button>
				</a>&nbsp;&nbsp;&nbsp;
			</div>
			<div class="col-md-1 action-button">
				<button id="save" class="btn btn-info">SAVE ME</button>
			</div>
			<div class="col-md-1 action-button">
				<button id="add-col" class="btn btn-info ">Add Column</button>
			</div>
		</div>
		<div class="row">
			<div class="panel playground-tip">
				<i class="fa fa-info-circle"></i> Pro tip - Click boxes to edit
			</div>
		</div>
		<div class="row main-panel-tasko">
			<div class="ccolumn col-md-2">
				<div class="ccolumn connect col-data panel panel-default">
					<div class="panel-heading not-draggable">
						<h6 class="editable content columnheader">Board title</h6>
						<i class="fa fa-pencil-square-o edit"></i>
					</div>
					<br /><br />
					<div class="add-task btn btn-default"> <i class="fa fa-plus-circle"></i> Click to add</div>
				</div>
			</div>
		</div>
	</div>
	<div class="logout"><a href="/tasko/logout"><button type="submit" class="btn btn-success btn-sm">Logout</button></a></div>
</body>
</html>
<%}%>
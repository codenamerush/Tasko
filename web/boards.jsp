<%@page import="com.tasko.dao.BoardDao"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Iterator"%>
<%@page import="com.tasko.model.Board"%>
<%@page import="com.tasko.model.User"%>
<%
	if (session == null) {
		response.sendRedirect("/tasko");
	} else {
	User user = (User) session.getAttribute("user");
	if (user == null) {
		response.sendRedirect("/tasko");
	} else {
	
	BoardDao dao = new BoardDao();
	ArrayList<Board> boards =  dao.getAllBoards(user.getUserid());
	String boardsJSON = "[";
	Iterator<Board> itx = boards.iterator();
	String prefix = "";
	while(itx.hasNext()){
		Board b = itx.next();
		boardsJSON =  boardsJSON + prefix + b.getColumns();
		if (itx.hasNext()){
			prefix = ",";
		}
		
	}
	boardsJSON += "]";
	session.setAttribute("boardsJSON", boardsJSON);
%>
<!DOCTYPE html>
<head>
	<meta charset="UTF-8" />
	<title>Tasko</title>
	<script src="./js/jquery-1.12.4.js"></script>
	<script src="./js/jquery-ui.js"></script>
	<link rel="stylesheet" type="text/css" href="./css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="./css/bootstrap-theme.min.css">
	<script src="./js/bootstrap.min.js"></script>
	<link rel="stylesheet" type="text/css" href="./css/font-awesome.min.css" />
	<link href="./css/raleway.css"
		rel="stylesheet">
	<link rel="stylesheet" type="text/css" href="./css/style.css" />
	<script src="./js/app.js"></script>
	<script>
		var boardsJSON = '<%= (String) session.getAttribute("boardsJSON") %>';
		setAlerts(boardsJSON);
	</script>
</head>
<body>
	<div class="vspacer"></div>
	<div class="container">
		<div class="row">
			<div class="col-md-4 col-md-offset-4">
				<div class="panel panel-default">
					<div class="panel-heading ">
						<h2>Hi <%= user.getFirstName() %></h2>
					</div>	
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-md-4 col-md-offset-4">
				<div class="panel panel-default">
					<div class="panel-heading">
						<h3>Your Boards</h3>
						<ul class="list-group">
							<%
								if (boards != null) {
									Iterator it = boards.iterator();
									while (it.hasNext()) {
										Board b = (Board) it.next();
							%>
							<li class="list-group-item"><a
								href="/tasko/go/to/playground?board=<%=b.getName()%>"> <%=b.getName()%>
							</a> <a href="/tasko/board/delete?board=<%=b.getName()%>"
								class="pull-right"><i
									class="fa fa-minus-circle delete-board" aria-hidden="true"></i></a>
							</li>
							<%
								}
								}
							%>
							<li class="list-group-item">
								<button data-toggle="modal" data-target="#myModal">
									<i class="fa fa-plus" aria-hidden="true"></i> Add a board
								</button>
							</li>
						</ul>
					</div>
				</div>
			</div>
		</div>
		<div id="myModal" class="modal fade" role="dialog">
			<div class="modal-dialog">

				<!-- Modal content-->
				<div class="modal-content">
					<form class="form-horizontal" method="post"
						action="/tasko/board/create" role="form">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal">&times;</button>
							<h4 class="modal-title">Type your board name</h4>
						</div>
						<div class="modal-body">

							<div class="form-group">
								<div class="col-sm-12">
									<input type="text" class="form-control" name="board"
										id="boardName" placeholder="What should we call your board?"
										required="">
								</div>
							</div>

						</div>
						<div class="modal-footer">
							<button type="submit" class="btn btn-success btn-sm">Submit</button>
							<button type="reset" class="btn btn-default btn-sm">Reset</button>
							<button type="button" class="btn btn-default btn-sm"
								data-dismiss="modal">Close</button>
						</div>
					</form>
				</div>

			</div>
		</div>
	</div>
	<div class="logout"><a href="/tasko/logout"><button type="submit" class="btn btn-success btn-sm">Logout</button></a></div>
</body>
</html>

<% }
}%>
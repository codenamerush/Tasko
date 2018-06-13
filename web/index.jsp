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
</head>
<body>
	<div class="vspacer"></div>
	<div class="container">
		<% String msg = (String) session.getAttribute("msg");
			if(msg != null){
		%>
		<div class="alert login-msg alert-warning">
				<strong><%= msg %></strong>.
			</div>
		<%
				session.removeAttribute("msg");
			} 
		%>
		<div class="row">
			<div class="col-md-8">
				<div class="panel panel-default panel-dark">
					<h1 class="main-title">Tasko</h1>
					<h5>
						Organizing your tasks better, it's as simple as drag and drop! <br />
						It can't be more fun than this.
					</h5>
				</div>

			</div>
			<div class="col-md-4">
				<div class="panel panel-default">
					<div class="panel-heading">
						<strong class="">Login</strong>

					</div>
					<div class="panel-body">
						<form class="form-horizontal" method="post" action="/tasko/login"
							role="form">
							<div class="form-group">
								<label for="email" class="col-sm-3 control-label">Email</label>
								<div class="col-sm-9">
									<input type="email" class="form-control" name="email"
										id="email" placeholder="Email" required="">
								</div>
							</div>
							<div class="form-group">
								<label for="password" class="col-sm-3 control-label">Password</label>
								<div class="col-sm-9">
									<input type="password" class="form-control" name="password"
										id="password" placeholder="Password" required="">
								</div>
							</div>
							<div class="form-group last">
								<div class="col-sm-offset-3 col-sm-9">
									<button type="submit" class="btn btn-success btn-sm">Sign
										in</button>
									<button type="reset" class="btn btn-default btn-sm">Reset</button>
								</div>
							</div>
						</form>
					</div>
					<div class="panel-footer">
						Not Registered? <a href="/tasko/register.jsp" class="">Register
							here</a>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
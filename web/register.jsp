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
		<div class="row">
			<div class="col-md-4 col-md-offset-4">
				<div class="panel panel-default">
					<div class="panel-heading">
						<strong class="">Sign up</strong>
					</div>
					<div class="panel-body">
						<form class="form-horizontal" id="signupform" method="post"
							action="/tasko/signup">
							<div class="form-group">
								<label for="fname" class="col-sm-4 control-label">First
									Name</label>
								<div class="col-sm-8">
									<input type="text" class="form-control" name="fname" id="fname"
										placeholder="First Name" required="">
								</div>
							</div>
							<div class="form-group">
								<label for="lname" class="col-sm-4 control-label">Last
									Name</label>
								<div class="col-sm-8">
									<input type="text" class="form-control" name="lname" id="lname"
										placeholder="Last Name" required="">
								</div>
							</div>
							<div class="form-group">
								<label for="email" class="col-sm-4 control-label">Email</label>
								<div class="col-sm-8">
									<input type="email" class="form-control" name="email"
										id="email" placeholder="Email" required="">
								</div>
							</div>
							<div class="form-group">
								<label for="password" class="col-sm-4 control-label">Password</label>
								<div class="col-sm-8">
									<input type="password" class="form-control" name="password"
										id="password" placeholder="Password" required="">
								</div>
							</div>
							<div class="form-group last">
								<div class="col-sm-offset-3 col-sm-9">
									<button type="submit" class="btn btn-success btn-submit btn-sm">Sign
										up</button>
								</div>
							</div>
						</form>
					</div>
					<div class="panel-footer">
						Already Registered? <a href="/tasko" class="">Login here</a>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
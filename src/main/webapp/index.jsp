<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<!DOCTYPE html>
<html>
  
<!-- Mirrored from v3.bootcss.com/examples/signin/ by HTTrack Website Copier/3.x [XR&CO'2013], Sun, 26 Jan 2014 11:51:19 GMT -->
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="shortcut icon" href="resources/images/meeting.jpg">

    <title>Login</title>

    <!-- Bootstrap core CSS -->
  	    <link href="resources/css/bootstrap.min.css"  rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="resources/css/login.css" rel="stylesheet">
    <link href="resources/css/jquery-confirm.css" rel="stylesheet">
    <script type="text/javascript" src="resources/js/jquery-1.9.1.min.js"></script>
	<script type="application/javascript" src="resources/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="resources/js/autoMail.1.0.min.js"></script>
	<script type="text/javascript" src="resources/js/common.js"></script>
	<script type="text/javascript" src="resources/js/jquery-confirm.js"></script>
	<script type="text/javascript">
	$(function() {
		common.init("", "");
		$('#email1').autoMail(
				{
					emails : [ 'qq.com', '163.com', '126.com', 'sina.com',
							'sohu.com', 'yahoo.cn' ]
				});
		})
	</script>

  </head>

  <body>
    <div class="container">
	  <center><img alt="" src="resources/images/meetingLogin.png"></center>
      <form class="form-signin" role="form" method="post" action="/meeting/common/login">
        <input type="text" name="email" class="form-control" placeholder="请输入邮箱" id="email1">
        <input type="password" id="password" class="form-control" placeholder="密码">
        <input type="hidden" name="password" id="real_password">
       <center>
  		<label class="radio">
   		员工 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="tag" id="position" value="1" checked>
   		部门经理 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="tag" id="position1" value="2" >
   		管理员 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="tag" id="position2" value="3" >
    	</label>
    	</center> 
        <input class="btn btn-lg btn-primary btn-block" type="submit" id="submit" value="登陆">
      </form>

    </div> <!-- /container -->

  </body>
  
</html>

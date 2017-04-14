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
    <script type="text/javascript" src="resources/js/jquery-1.9.1.min.js"></script>
	<script type="application/javascript" src="resources/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="resources/js/autoMail.1.0.min.js"></script>
	<script type="text/javascript">
	$(function() {
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
        <span name="emailValidate" style="color: red"></span>
        <input type="password" name="password" class="form-control" placeholder="密码">
      	<span name="passwordValidate" style="color: red"></span>
       <center>
  		<label class="radio">
   		员工 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="tag" id="position" value="1" checked>
   		部门经理 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="tag" id="position1" value="2" >
   		管理员 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="tag" id="position2" value="3" >
    	</label>
    	</center> 
        <input class="btn btn-lg btn-primary btn-block" type="submit" value="登陆">
      </form>

    </div> <!-- /container -->

  </body>
  <script type="text/javascript">
  		$(function(){
  			$(":submit").click(function(){
  				var email = $("[name=email]").val();
  				if(email==""||email.indexOf(' ')!=-1){
  					$("[name=emailValidate]").text("邮箱不能为空!");
  					$("[name=email]").focus();
					return false;
  				}
  				else if(!(/^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\.[a-zA-Z0-9_-]+)+$/.test(email))){
  					$("[name=emailValidate]").text("邮箱不合法");
  					$("[name=email]").focus();
  					return false;
  				}else{
  					$("[name=emailValidate]").text("");
  				}
  				var pwd = $("[name=password]").val();
				if(pwd == ""||pwd.indexOf(' ')!=-1){
					$("[name=passwordValidate]").text("密码不能为空或包含空格");
					$("[name=password]").focus();
					return false;
				}else{
					$("[name=passwordValidate]").text("");
				}
				
  				//都合法填写完毕后,将密码在前台加密
  				var pwd=$(":password").val();
				var data={"password":pwd};
				var url = "/meeting/common/md5"
				$.ajax({
						async : false,
						cache : false,
						success: function(data){
							$("[name=password]").val(data);
						},
						type : "POST",
						url : url,
						data : data
					});
					//获取当前页面被选中的的单选框的值
					var radioValue = $("input[type='radio']:checked").val()
  					//现在根据页面上radio的值,来决定去哪个控制器中去进行登录验证
  					var loginUrl = "";
  					if(radioValue==1){
  						loginUrl = "user/login";
  					}else if(radioValue==2){
  						loginUrl = "manager/login";
  					}else{
  						loginUrl = 	"admin/login";
  					}
  			});
  		});
  </script>
  
</html>

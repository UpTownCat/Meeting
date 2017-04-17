/**
 * 对name,password,password2,电话,进行验证
 */
$(function(){

	//获取当前网址，如： http://localhost:8083/uimcardprj/share/meun.jsp
    var curWwwPath = window.document.location.href;
    //获取主机地址之后的目录，如： uimcardprj/share/meun.jsp
    var pathName = window.document.location.pathname;
    //获取带"/"的项目名，如：/uimcardprj
    var projectName = pathName.substring(0, pathName.substr(1).indexOf('/') + 1);
    //所以前台页面注意给name 的input多加一个属性str
    var str = $("[name=name]").attr("str");//从页面获取要访问的路径信息.user的sign就是user,manager的sign就是manager...
	//对姓名是否重名进行验证
	var nameOk=0;//这个全局变量是表示,这个表单的名字条件既不是空格或包含空格也不是重名.0表示不行,1表示可以提交了
	$("[name=name]").blur(function(){
		//首先这个不是在jsp页面中.编译的时候,谁认识你这个${applicationScope.url }或者<%=..%>(这标签你写在下面都不带变颜色的),
		//java是编译执行语言,所以在服务器上执行的是编译的结果,因此就不行了
		var url = projectName+"/"+str+"/validateNameIsUseful";
		var name = this.value;
		//如果用户名为空或者包含空格的情况,这里不管,这里只是对填写合法或的用户名进行验证.
		if(name==""||name.indexOf(' ')!=-1){
			//这种情况交给点击提交时处理
		}
		else{
			var res='';
			var data={"name":name};
			$.ajax({
					async : false,
					cache : false,
					success: function(data){
						res=data;
					},
					type : "POST",
					url : url,
					data : data
				});
				if(res==1)
				{	
					nameOk = 1;
					$("[name=nameValidate]").css("color","green");
					$("[name=nameValidate]").text("该用户名可以使用");
				}
				else{
					nameOk = 0;
					$("[name=nameValidate]").css("color","red");
					$("[name=nameValidate]").text("该用户名已被注册");
				}
		}
	});
	
	//对电话号码唯一性进行验证
	var phoneOk=0;//这个全局变量是表示,这个表单的名字条件既不是空格或包含空格也不是重名.0表示不行,1表示可以提交了
	$("[name=phone]").blur(function(){
		var url = projectName+"/"+str+"/validatePhoneIsUseful";
		var phone = this.value;
		if(phone==""||phone.indexOf(' ')!=-1){
			$("[name=phoneValidate]").text("号码不能为空!"); 
			$("[name=phoneValidate]").css("color","red");
			//alert(123);
			phoneOk = 0;
		}else if(!(/^1[3|4|5|8][0-9]\d{4,8}$/.test(phone))){ 
			$("[name=phoneValidate]").text("号码不合法"); 
			$("[name=phoneValidate]").css("color","red");
			$("[name=phone]").focus();
			phoneOk = 0;
		}
		else{
			var res='';
			var data={"phone":phone};
			$.ajax({
					async : false,
					cache : false,
					success: function(data){
						res=data;
					},
					type : "POST",
					url : url,
					data : data
				});
				if(res==1)
				{	
					phoneOk = 1;
					$("[name=phoneValidate]").css("color","green");
					$("[name=phoneValidate]").text("该号码可以注册");
				}
				else{
					phoneOk = 0;
					$("[name=phoneValidate]").css("color","red");
					$("[name=phoneValidate]").text("该号码已被注册");
				}
		}
	});
	
	//对邮箱唯一性进行验证
	var emailOk=0;//这个全局变量是表示,这个表单的名字条件既不是空格或包含空格也不是重名.0表示不行,1表示可以提交了
	$("[name=email]").blur(function(){
		var url = projectName+"/"+str+"/validateEmaliIsUseful";
		var email = this.value;
		if(email==""||email.indexOf(' ')!=-1){
			$("[name=emailValidate]").text("邮箱不能为空!"); 
			$("[name=emailValidate]").css("color","red");
			/*alert(123);*/
			emailOk = 0;
		}else if(!(/^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\.[a-zA-Z0-9_-]+)+$/.test(email))){ 
			$("[name=emailValidate]").text("邮箱不合法"); 
			$("[name=emailValidate]").css("color","red");
			$("[name=email]").focus();
			emailOk = 0;
		}
		else{
			var res='';
			var data={"email":email};
			$.ajax({
					async : false,
					cache : false,
					success: function(data){
						res=data;
					},
					type : "POST",
					url : url,
					data : data
				});
				if(res==1)
				{	
					emailOk = 1;
					$("[name=emailValidate]").css("color","green");
					$("[name=emailValidate]").text("该邮箱可以注册");
				}
				else{
					emailOk = 0;
					$("[name=emailValidate]").css("color","red");
					$("[name=emailValidate]").text("该邮箱已被注册");
				}
		}
	});
	
	//下面进行表单提交时的非空及不合法验证
	$(":submit").click(function(){
		var name = $("[name=name]").val();
			if(name==''||name.indexOf(' ')!=-1){
				$("[name=nameValidate]").text("(姓名不能为空或者包含空格)");
				$("[name=nameValidate]").css("color","red");
				$("[name=name]").focus();
				return false;
			}else if(nameOk==0){
				$("[name=nameValidate]").focus();
				return false;
			}
			var pwd = $("[name=password]").val();
			if(pwd == ""||pwd.indexOf(' ')!=-1){
				$("[name=passwordValidate]").text("密码不能为空或包含空格");
				$("[name=password]").focus();
				return false;
			}else{
				$("[name=passwordValidate]").text("");
			}
			
			var phone = $("[name=phone]").val();//写这个的主要目的是防止用户不写电话直接提交没提示
			if(phone==""||phone.indexOf(' ')!=-1){
				$("[name=phoneValidate]").text("号码不能为空!"); 
				$("[name=phone]").focus();
			}
			if(phoneOk == 0){
				return false;
			}
			
			var email = $("[name=email]").val();//写这个的主要目的是防止用户不写邮箱直接提交没提示
			if(email==""||email.indexOf(' ')!=-1){
				$("[name=emailValidate]").text("邮箱不能为空!"); 
				$("[name=email]").focus();
			}
			if(emailOk == 0)
			{
				return false;
			}
			
			var age = $("[name=age]").val();
			if(age == ""){
				$("[name=ageValidate]").text("年龄不能为空");
				$("[name=age]").focus();
				return false;
			}else{
				$("[name=ageValidate]").text("");
			}
			var emailValidateCode = $("[name=emailValidateCode]").val();
			if(emailValidateCode == ""){
				$("[name=emailValidateCodeValidate]").text("邮箱验证码不能为空");
				$("[name=emailValidateCode]").focus();
				return false;
			}else{
				$("[name=emailValidateCodeValidate]").text("");
			}
			return true;
	});
});
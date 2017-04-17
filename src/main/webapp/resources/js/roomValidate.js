$(function(){
	//获取当前网址，如： http://localhost:8083/uimcardprj/share/meun.jsp
    var curWwwPath = window.document.location.href;
    //获取主机地址之后的目录，如： uimcardprj/share/meun.jsp
    var pathName = window.document.location.pathname;
    //获取带"/"的项目名，如：/uimcardprj
    var projectName = pathName.substring(0, pathName.substr(1).indexOf('/') + 1);

    var id = Number($("[name=id]").val());//判断页面是否是更新页面,有id就是更新,否则就是新加
	//对number是否重名进行验证
    var numberOk=0;//这个全局变量是表示,这个表单的名字条件既不是空格或包含空格也不是重名.0表示不行,1表示可以提交了
    if(id>0)
    	numberOk=1;//如果用户在更新页面刚开始啥都不做直接提交,那么也是可以的
	$("[name=number]").blur(function(){
		//首先这个不是在jsp页面中.编译的时候,谁认识你这个${applicationScope.url }或者<%=..%>(这标签你写在下面都不带变颜色的),
		//java是编译执行语言,所以在服务器上执行的是编译的结果,因此就不行了
		var url = projectName+"/room/validateNumberIsUseful";
		var number = this.value;
		num = Number(number.trim());
		//如果编号合法,还要检验是否重复
		if(/^[1-9]*[1-9][0-9]*$/.test(num)){
			var res='';
			num = encodeURI(num);
			var data={"number":num};
			if(id>0){
				data={"number":num,"id":id}
			}
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
					numberOk = 1;
					$("[name=numberValidate]").css("color","green");
					$("[name=numberValidate]").text("该编号可以使用");
				}
				else{
					numberOk = 0;
					$("[name=numberValidate]").css("color","red");
					$("[name=numberValidate]").text("该编号已被注册");
				}
		}else{
			numberOk = 0;
			$("[name=numberValidate]").css("color","red");
			$("[name=numberValidate]").text("该编号不能为空且必须正整数");
		}
	
	});
	
	/*//对地点的唯一性验证.
	var locationOk=0;//这个全局变量是表示,这个表单的名字条件既不是空格或包含空格也不是重名.0表示不行,1表示可以提交了
	 if(id>0)
		 locationOk=1;
	$("[name=location]").blur(function(){
		var url = projectName+"/room/validateLocationIsUseful";
		var location = this.value;
		if(location==""||location.indexOf(' ')!=-1){
			$("[name=locationValidate]").text("地点不能为空!"); 
			$("[name=locationValidate]").css("color","red");
			//alert(123);
			location = 0;
		}
		else{
			var res='';
			var data={"location":location};
			if(id>0){
				data={"location":location,"id":id};
			}
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
					locationOk = 1;
					$("[name=locationValidate]").css("color","green");
					$("[name=locationValidate]").text("该地点可以使用");
				}
				else{
					locationOk = 0;
					$("[name=locationValidate]").css("color","red");
					$("[name=locationValidate]").text("该地点已被使用");
				}
		}
	});*/
	
	//下面进行表单提交时的非空及不合法验证
	$(":submit").click(function(){
			var capacity = $("[name=capacity]").val();//写这个的主要目的是防止用户不写电话直接提交没提示
			cnum = Number(capacity.trim());
			if((/^[1-9]*[1-9][0-9]*$/.test(cnum))&&(cnum<=1000)){
			
			}else{
				$("[name=capacityValidate]").text("容量不能为空,且必须是小于1000的正整数!"); 
				$("[name=capacity]").focus();
				return false;
			}
			if(numberOk == 0)
				return false;
			if(locationOk == 0)
				return false;
			return true;
	});
});
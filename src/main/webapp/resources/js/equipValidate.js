$(function(){
	//获取当前网址，如： http://localhost:8083/uimcardprj/share/meun.jsp
    var curWwwPath = window.document.location.href;
    //获取主机地址之后的目录，如： uimcardprj/share/meun.jsp
    var pathName = window.document.location.pathname;
    //获取带"/"的项目名，如：/uimcardprj
    var projectName = pathName.substring(0, pathName.substr(1).indexOf('/') + 1);

    var id = Number($("[name=id]").val());//判断页面是否是更新页面,有id就是更新,否则就是新加
	//对number是否重名进行验证
    var nameOk=0;//这个全局变量是表示,这个表单的名字条件既不是空格或包含空格也不是重名.0表示不行,1表示可以提交了
    if(id>0)
    	nameOk=1;//如果用户在更新页面刚开始啥都不做直接提交,那么也是可以的
	$("[name=name]").blur(function(){
		var url = projectName+"/equipment/validateNameIsUseful";
		var name = this.value;
		if(name==""||name.indexOf(' ')!=-1){
			nameOk = 0;
			$("[name=nameValidate]").text("(名称不能为空或者包含空格)");
			$("[name=nameValidate]").css("color","red");
		}else{
			
			var res='';
			name = encodeURI(name);
			var data={"name":name};
			if(id>0){
				data={"name":name,"id":id}
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
				nameOk = 1;
				$("[name=nameValidate]").css("color","green");
				$("[name=nameValidate]").text("该名称可以使用");
			}
			else{
				nameOk = 0;
				$("[name=nameValidate]").css("color","red");
				$("[name=nameValidate]").text("该名称已被注册");
			}
		}
	
	});
	
	//下面进行表单提交时的非空及不合法验证
	$("[name=addOrUpdate]").click(function(){
			var count = $("[name=count]").val();//写这个的主要目的是防止用户不写电话直接提交没提示
			if(count==''){
				$("[name=countValidate]").text("数量不能为空,且必须是小于5000的非负整数!"); 
				return false;
			}else{
				cnum = Number(count.trim());
				if((/^[0-9]*[0-9]*$/.test(cnum)&&(cnum<=5000))){
					
				}else{
					$("[name=countValidate]").text("数量不能为空,且必须是小于5000的非负整数!"); 
					return false;
				}
			}
			
			var name;
			if(id>0)
				name = $("[name=name]").val();
			else
				name = $("[name=name]")[1].value;//如果是新加页面的话
			if(name==''||name.indexOf(' ')!=-1){
				$("[name=nameValidate]").text("(名称不能为空或者包含空格)");
				$("[name=nameValidate]").css("color","red");
				$("[name=name]").focus();
				return false;
			}else if(nameOk == 0)
				return false;
			return true;
	});
});
var tag = 1;
var deleteId = -1;
var URL;
var common = {
		init : function(url, msgSuffix) {
			URL = url;
			$("#btn").click(function(){
				var icon = $("#icon");
				if(tag == 1) {
					tag = 0;
					icon.removeClass();
					icon.addClass("glyphicon glyphicon-minus");
				}else{
					tag = 1;
					icon.removeClass();
					icon.addClass("glyphicon glyphicon-plus");
				}
			});
			
			$('#deleteModal').on('show.bs.modal', function (event) {
				  var button = $(event.relatedTarget)
				  var value = button.data('whatever')
				  console.log(value);
				  var index = value.indexOf(",");
				  var name = value.substring(index+1);
				  deleteId = value.substring(0, index);
				  $("#msg").html("您确定要删除: " + name + msgSuffix);
			});
			
			$('#updateModal').on('show.bs.modal', function (event) {
				  var button = $(event.relatedTarget);
				  var value = button.data('whatever');
				  $("#id").val(value.substring(0, value.indexOf(",")));
				  $("#msg2").html("帮:  " + value.substring(value.indexOf(",") + 1) + "  找回密码");
			});
			
			$("#delete").click(function() {
				var url = "/meeting/"+ URL +"/" + deleteId + "/delete";
				var args = {_method : "DELETE"};
				$("#msg").html("正在删除， 请勿刷新页面， 耐心等待！");
				$.post(url, args, function(data){
					window.location.reload();
				})
			});
			
			$("#forward").click(function(){
				console.log(url);
				var index = $("#toIndex").val();
				if(index.length == 0)
					return ;
				if(index < 1)
					return ;
				var total = $("#total").html();
				if(index > parseInt(total))
					return false;
				var url2 = URL + "?index=" + index;
				$(this).attr("href", url2);
			});
			
			$(".detail").click(function() {
				var href = $(this).attr("href");
				var meetingId = href.substring(17, href.lastIndexOf("/"));
				var validateUrl = "/meeting/meeting/" + meetingId + "/validate";
				var myTag = "1";
				$.ajax({url:validateUrl, cache:false, async:false, success:function(data) {
					if(!data.tag){
						myTag = "0";
						console.log("11111111111");
						$.confirm({
							backgroundDismiss: true,
							title: "提示",
							content: "该会议没有邀请您， 您没有权限查看！",
							buttons: {
								"确定": function(){},
							}
						});
					}
				}});
				if(myTag == "0")
					return false;
			});
			
			$("#submit").click(function(){
  				var email = $("[name=email]").val();
  				if(email==""||email.indexOf(' ')!=-1){
  					$.confirm({
  						backgroundDismiss: true,
  						title: "提示",
  						content: "邮箱不能为空!",
  						buttons: {
  							"关闭": function(){}
  						}
  					});
//  					$("[name=emailValidate]").text("邮箱不能为空!");
  					$("[name=email]").focus();
					return false;
  				}
  				else if(!(/^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\.[a-zA-Z0-9_-]+)+$/.test(email))){
  					$.confirm({
  						backgroundDismiss: true,
  						title: "提示",
  						content: "邮箱不合法",
  						buttons: {
  							"关闭": function(){}
  						}
  					});
//  					$("[name=emailValidate]").text("邮箱不合法");
  					$("[name=email]").focus();
  					return false;
  				}else{
  					$("[name=emailValidate]").text("");
  				}
  				var pwd = $("#password").val();
				if(pwd == ""||pwd.indexOf(' ')!=-1){
					$.confirm({
  						backgroundDismiss: true,
  						title: "提示",
  						content: "密码不能为空或包含空格",
  						buttons: {
  							"关闭": function(){}
  						}
  					});
//					$("[name=passwordValidate]").text("密码不能为空或包含空格");
					$("[name=password]").focus();
					return false;
				}else{
					$("[name=passwordValidate]").text("");
				}
				
  				//都合法填写完毕后,将密码在前台加密
				var data={"password":pwd};
				var url = "/meeting/common/md5";
				$.ajax({
						async : false,
						cache : false,
						success: function(data){
							console.log(data);
							$("#real_password").val(data);
						},
						type : "POST",
						"url" : url,
						data : data
					});
  			});
			
			$("#resetPassword").click(function() {
				var password = $("#password").val();
				if(password == null || password.length == 0) {
					$.confirm({
						backgroundDismiss: true,
						title: "提示",
						content: "密码不能为空",
						buttons: {
							"关闭": function(){},
						}
					});
					return false;
				}
				$.ajax({
					url: "/meeting/common/md5",
					type: "POST",
					async: false,
					data: {"password": password},
					success: function(data) {
						var tag = $("#tag").val();
						var id = $("#id").val();
						$.post("/meeting/common/resetPassword", {"id": id, "tag": tag, "password": data}, function(data2) {
							if(data2 == 1) {
								$("#updateModal").modal({"show": false,});
								$.confirm({
									backgroundDismiss: true,
									title: "提示",
									content: "修改成功",
									buttons: {
										"关闭": function(){}
									}
								})
							}
						})
					}
				})
			});
			
			$("#commonReset").click(function() {
				var result = reset.init();
				if(result == 0) {
					return false;
				}
				common.remind("密码修改成功！");
			})
		},
		remind: function(content) {
			$.confirm({
				backgroundDismiss: true,
				title: "提示",
				"content": content,
				buttons: {
					"关闭": function(){},
				}
			})
		}
}
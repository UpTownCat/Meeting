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
				  $("#msg").html("��ȷ��Ҫɾ��: " + name + msgSuffix);
			});
			
			$('#updateModal').on('show.bs.modal', function (event) {
				  var button = $(event.relatedTarget);
				  var value = button.data('whatever');
				  $("#id").val(value.substring(0, value.indexOf(",")));
				  $("#msg2").html("��:  " + value.substring(value.indexOf(",") + 1) + "  �һ�����");
			});
			
			$("#delete").click(function() {
				var url = "/meeting/"+ URL +"/" + deleteId + "/delete";
				var args = {_method : "DELETE"};
				$("#msg").html("����ɾ���� ����ˢ��ҳ�棬 ���ĵȴ���");
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
							title: "��ʾ",
							content: "�û���û���������� ��û��Ȩ�޲鿴��",
							buttons: {
								"ȷ��": function(){},
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
  						title: "��ʾ",
  						content: "���䲻��Ϊ��!",
  						buttons: {
  							"�ر�": function(){}
  						}
  					});
//  					$("[name=emailValidate]").text("���䲻��Ϊ��!");
  					$("[name=email]").focus();
					return false;
  				}
  				else if(!(/^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\.[a-zA-Z0-9_-]+)+$/.test(email))){
  					$.confirm({
  						backgroundDismiss: true,
  						title: "��ʾ",
  						content: "���䲻�Ϸ�",
  						buttons: {
  							"�ر�": function(){}
  						}
  					});
//  					$("[name=emailValidate]").text("���䲻�Ϸ�");
  					$("[name=email]").focus();
  					return false;
  				}else{
  					$("[name=emailValidate]").text("");
  				}
  				var pwd = $("#password").val();
				if(pwd == ""||pwd.indexOf(' ')!=-1){
					$.confirm({
  						backgroundDismiss: true,
  						title: "��ʾ",
  						content: "���벻��Ϊ�ջ�����ո�",
  						buttons: {
  							"�ر�": function(){}
  						}
  					});
//					$("[name=passwordValidate]").text("���벻��Ϊ�ջ�����ո�");
					$("[name=password]").focus();
					return false;
				}else{
					$("[name=passwordValidate]").text("");
				}
				
  				//���Ϸ���д��Ϻ�,��������ǰ̨����
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
						title: "��ʾ",
						content: "���벻��Ϊ��",
						buttons: {
							"�ر�": function(){},
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
									title: "��ʾ",
									content: "�޸ĳɹ�",
									buttons: {
										"�ر�": function(){}
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
				common.remind("�����޸ĳɹ���");
			})
		},
		remind: function(content) {
			$.confirm({
				backgroundDismiss: true,
				title: "��ʾ",
				"content": content,
				buttons: {
					"�ر�": function(){},
				}
			})
		}
}
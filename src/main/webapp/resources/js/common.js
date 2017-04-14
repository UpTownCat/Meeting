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
			})
			
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
			})
		}
		
}
<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<div style="float:left; width: 300px;" class="panel panel-default">
	<div class="panel-heading text-center">
		<h3>公告</h3>
	</div>
	<div class="panel-body">
		<label id="noticeShow">
			
		</label>
	</div>
</div>

<script type="text/javascript">
	$(function(){
		$.get("/meeting/common/notice", {}, function(data) {
			var content = data.content;
			if(content == null || content.length == 0) {
				$("#noticeShow").html("暂无公告!");
				return ;
			}
			$("#noticeShow").html(data.content);
		})
	})
</script>
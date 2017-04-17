<%@ page language="java" import="java.util.*" pageEncoding="GBK"
	isELIgnored="false"%>
<%
String path = request.getContextPath();
pageContext.setAttribute("partName", "manager");
%>

<!DOCTYPE html>
<html>
<head>

<title>${partName }</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<%@include file="../common2l.jsp"%>
<script type="text/javascript">
		$(function() {
			common.init("equipment", "  ��");
			var index = "${page.index }";
			var total = "${page.total }";
			var url = "/meeting/department/list";
			page.init(6, index, total, url);
			$("#forward").click(function(){
				var index2 = $("#forwardPage").val();
				var indexNum = Number(index2.trim());
				if(/^[1-9]*[1-9][0-9]*$/.test(indexNum)&&indexNum<=total){
					$("#toIndex").val(indexNum);
					$("#form").submit();
				}
				return false;
			});
			$(".pageItem").click(function(){
				var index2 = $(this).html();
				var href1 = $(this).attr("href");
				var form = $("#form");
				index2 = href1.substring(href1.lastIndexOf("=") + 1);
				var toIndex = $("#toIndex");
				toIndex.val(index2);
				form.submit();
				return false;
			});
			
			var t1 = 1;
			$(".name").blur(function() {
				var val = this.value;
				if(val.length == 0) {
					common.remind("�豸���ֲ���Ϊ�գ�");
					t1 = 0;
					return false;
				}
				val = encodeURI(val);
				$.get("/meeting/common/name", {"tag": 5, "name": val}, function(data) {
					if(data != 0) {
						t1 = 2;
						common.remind("�����Ƶ��豸�Ѿ����ڣ�");
					}else {
						t1 = 1;
					}
				})
			})
			
			$("#submit44").click(function() {
				if(t1 == 0) {
					common.remind("�豸���ֲ���Ϊ�գ�");
					return false;
				}
				if(t1 == 2) {
					common.remind("�����Ƶ��豸�Ѿ����ڣ�");
					return false;
				};
				var count = $("#count").val();
				if(count.length == 0) {
					common.remind("��Ϣ��������");
					return false;
				}
				var reg = /^\+?[1-9][0-9]*$/;
				if(!reg.test(count)) {
					common.remind("����Ĳ�����������");
					return false;
				}
			})
		})
	</script>
</head>

<body>
	<%@include file="../nav.jsp" %>
	<div style="float:left; margin-top:50px">
		<%@include file="../menu.jsp" %>
	</div>
	<div class="container col-lg-9" style="float:left; margin-top:50px; padding : 0 0;">
		<div class="panel panel-default">
			<div class="panel-heading">
				<h3>�����豸�б�</h3>
			</div>
			<div class="panel-body">
				<form class="navbar-form navbar-left" id="form">
				     <input type="hidden" name="index" value="1" id="toIndex">
				     <div class="form-group">
					     <input type="text" class="form-control" name="name" placeholder="�豸����" value="${page.name }">
				     </div>
				     <div class="form-group">
				     	<label class="control-label">������</label>	
				     	<select name="count2" class="form-control">
					    	<c:if test="${page.count2 == 0 }">
					    		<option value="0">Ĭ��</option>
						     	<option value="1">�ɴ�С</option>
						     	<option value="2">��С����</option>
					    	</c:if>
					    	<c:if test="${page.count2 == 1 }">
					    		<option value="0">Ĭ��</option>
						     	<option value="1" selected="selected">�ɴ�С</option>
						     	<option value="2">��С����</option>
					    	</c:if>
					    	<c:if test="${page.count2 == 2 }">
					    		<option value="0">Ĭ��</option>
						     	<option value="1">�ɴ�С</option>
						     	<option value="2" selected="selected">��С����</option>
					    	</c:if>
					    </select>
				     </div>
				     <button type="submit" class="btn btn-info">����</button>
			    </form>
				<table class="table table-striped">
					<thead>
						<tr>
							<th>����</th>
							<th>����</th>
							<th></th>
							<th></th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${equipments }" var="equipment"
							varStatus="status">
							<tr>
								<td>${equipment.name }</td>
								<td>${equipment.count }</td>
								<td><a class="btn btn-primary"
									href="/meeting/equipment/${equipment.id }/update?id=${equipment.id}&index=${page.index }">����</a></td>
								<td><a class="btn btn-danger" href="#deleteModal" data-toggle="modal" data-whatever="${equipment.id},${equipment.name }">ɾ��</a></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			<div class="panel-footer">
				<button class="btn btn-primary" data-toggle="collapse"
					data-target="#collapse" id="btn">
					���ӻ����豸<span id="icon" class="glyphicon glyphicon-plus"></span>
				</button>
				<%@include file="../page.jsp"%>
				<div class="collapse" id="collapse">
					<div class="well">
						<form class="form-inline" action="/meeting/equipment/add"
							method="post">
							<input type="hidden" name="index"
								value="${size == 5 ? page.index + 1 : page.index }">
							<div class="form-group">
								<label class="control-label">����</label> 
								<input
									class="form-control name" name="name" type="text">
							</div>
							<div class="form-group">
								<label class="control-label">����</label> 
								
								<input
									class="form-control" name="count" type="text" id="count">
							</div>
							<button type="submit" class="btn btn-primary" id="submit44">ȷ��</button>
						</form>
					</div>
				</div>
			</div>
			<div class="modal fade" id="deleteModal" role="dialog" tabindex="-1">
				<div class="modal-dialog">
					<div class="modal-content">
						<div calss="modal-header"></div>
						<div class="modal-body">
							<p id="msg"></p>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-primary"
								data-dismiss="modal">ȡ��</button>
							<button type="button" class="btn btn-danger" id="delete">ȷ��</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>

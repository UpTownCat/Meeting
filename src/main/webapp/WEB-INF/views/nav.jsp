<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="navbar navbar-inverse navbar-fixed-top">
		<div class="container">
			<c:if test="${sessionScope.role != 3 }">
				<div class="navbar-header">
					<a class="navbar-brand" href="/meeting/index.jsp">�������ϵͳ</a>
				</div>
					 <ul class="nav navbar-nav navbar-right">
			 	<li><a href="/meeting/meeting/list?state=3">������ʾ</a></li>
			 	<li><a href="/meeting/room/list">��������ʾ</a></li>
		       	<c:if test="${sessionScope.role == 2 }">
		       		<li><a href="/meeting/department/${sessionScope.manager.department.id }/detail">�ҵĲ���</a>
		       		<li><a href="/meeting/meeting/open">���ٿ��Ļ���</a></li>
		       		<li><a href="/meeting/manager/meeting/first1">����ԤԼ </a></li>
		       	</c:if>
 		        <li class="dropdown">
 	            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">��������<span class="caret"></span></a> 
	            <ul class="dropdown-menu">
	            <li>
	            	<c:if test="${sessionScope.role == 1}">
	            		<a href="/meeting/user/${sessionScope.user.id }/detail">������Ϣ</a>
	            	</c:if>
	            	<c:if test="${sessionScope.role == 2}">
	            		<a href="/meeting/manager/${sessionScope.manager.id }/detail">������Ϣ</a>
	            	</c:if>
	            </li> 
	            <li><a href="#reset" data-toggle="modal">�޸�����</a></li> 
	            <li><a href="/meeting/meeting/mine?state=2">��Ҫ�μӻ���</a></li> 
 	            <li><a href="/meeting/meeting/mine">�Ѳμӻ���</a></li> 
 	            <c:if test="${sessionScope.role == 1 }">
 	            	<li><a href="/meeting/meeting/record?state=1">�ύ�����ĵ�</a></li> 
 	            </c:if>
	          </ul>
			</c:if>
			
			<c:if test="${sessionScope.role == 3 }">
				<div class="navbar-header">
					<a class="navbar-brand" href="/meeting/index.jsp">�������ϵͳ��̨����</a>
				</div>
			</c:if>
			
			<div class="modal fade" id="reset" role="dialog" tabindex="-1">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<h4 id="msg2">�޸�����</h4>
						</div>
						<div class="modal-body">
							<label>ԭ����:</label>
							<input type="password" id="oldPassword" class="form-control">
							<label>������:</label>
							<input type="password" class="form-control" id="password1">
							<label>��������:</label>
							<input type="password" class="form-control" id="password2">
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-primary"
								data-dismiss="modal">ȡ��</button>
							<button type="button" class="btn btn-danger" id="commonReset" data-dismiss="modal">ȷ��</button>
						</div>
					</div>
				</div>
			</div>
		</div>
</div>

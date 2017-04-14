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
		       	<c:if test="${sessionScope.role == 2 }">
		       		<li><a href="/meeting/department/${sessionScope.manager.department.id }/detail">�ҵĲ���</a>
		       		<li><a href="/meeting/meeting/open">���ٿ��Ļ���</a></li>
		       		<li><a href="/meeting/manager/meeting/first1">����ԤԼ </a></li>
		       	</c:if>
	<!--%	       	<li><a href="/meeting/meeting/mine">�ҲμӵĻ���</a></li>
	            <c:if test="${sessionScope.role == 1 }">
	            	<li><a href="/meeting/meeting/record">�Ҽ�¼�Ļ���</a></li>
	            </c:if>
	            
	      %      -->
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
	            <li><a href="/meeting/meeting/list">�޸�����</a></li> 
	            <li><a href="/meeting/meeting/mine?state=2">��Ҫ�μӻ���</a></li> 
 	            <li><a href="/meeting/meeting/mine">�Ѳμӻ���</a></li> 
 	            <li><a href="/meeting/meeting/record?state=1">�ύ�����ĵ�</a></li> 
	          </ul>
			</c:if>
			
			<c:if test="${sessionScope.role == 3 }">
				<div class="navbar-header">
					<a class="navbar-brand" href="/meeting/index.jsp">�������ϵͳ��̨����</a>
				</div>
			</c:if>
		</div>
</div>
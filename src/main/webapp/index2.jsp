<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
%>

<!doctype html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="initial-scale=1, maximum-scale=1, user-scalable=no">
<title>jeDate��ʱ�������ڿؼ����� - վ���ز�</title>
<script type="text/javascript" src="resources/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="resources/js/jedate/jedate.js"></script>
<script type="text/javascript">
	$(function(){
		console.log("ok");
		var table = $("#table");
		var trs = table.find("tr");
		for(var i = 0; i < trs.length; i++) {
			var tds = trs.eq(i).find("td");
			console.log(tds.length);
			tds.eq(0).html("aaa");
			tds.eq(1).html("ssss");
		}
	})
</script>

</head>

<body>
	<form action="/meeting/testUpload" method="post" enctype="multipart/form-data">
		<input type="hidden" name="_method" value="PUT">
		<input type="text" name="name">
		<br>
		<input type="file" name="file">
		<br>
		<button type="submit">ȷ��</button>
	</form>
	
	<table id="table">
		<tr>
			<td>44</td>
			<td>55</td>
		</tr>
		<tr>
			<td>66</td>
			<td>77</td>
		</tr>
	</table>
	<div style="width:100%;height:100px;">
		<p class="datep">
			<input class="datainp" id="indate" type="text" placeholder="ֻ��ʾ����"
				value="" readonly>
		</p>
		<p class="datep">
			<input class="datainp" id="dateinfo" type="text" placeholder="��ѡ��"
				readonly>
		</p>
		<p class="datep">
			<input class="datainp" id="datebut" type="text" placeholder="��ѡ��"
				readonly
				onfocus="jeDate({dateCell:'#datebut',isTime:true,format:'YYYY-MM-DD hh:mm:ss'})">
		</p>
	</div>
	<script type="text/javascript">
    //jeDate.skin('gray');
	jeDate({
		dateCell:"#indate",//isinitVal:true,
		format:"YYYY-MM",
		isTime:false, //isClear:false,
		minDate:"2015-10-19 00:00:00",
		maxDate:"2016-11-8 00:00:00"
	})
    jeDate({
		dateCell:"#dateinfo",
		format:"YYYY��MM��DD�� hh:mm:ss",
		isinitVal:true,
		isTime:true, //isClear:false,
		minDate:"2014-09-19 00:00:00",
		okfun:function(val){alert(val)}
	})

</script>

	<div
		style="text-align:center;margin:150px 0; font:normal 14px/24px 'MicroSoft YaHei';">
		<p>�����������360��FireFox��Chrome��Safari��Opera�����Ρ��ѹ�������֮��. ��֧��IE8�������������</p>
		<p>
			��Դ��<a href="http://sc.chinaz.com/" target="_blank">վ���ز�</a>
		</p>
	</div>
</body>
</html>


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
<title>jeDate带时分秒日期控件代码 - 站长素材</title>
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
		<button type="submit">确定</button>
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
			<input class="datainp" id="indate" type="text" placeholder="只显示年月"
				value="" readonly>
		</p>
		<p class="datep">
			<input class="datainp" id="dateinfo" type="text" placeholder="请选择"
				readonly>
		</p>
		<p class="datep">
			<input class="datainp" id="datebut" type="text" placeholder="请选择"
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
		format:"YYYY年MM月DD日 hh:mm:ss",
		isinitVal:true,
		isTime:true, //isClear:false,
		minDate:"2014-09-19 00:00:00",
		okfun:function(val){alert(val)}
	})

</script>

	<div
		style="text-align:center;margin:150px 0; font:normal 14px/24px 'MicroSoft YaHei';">
		<p>适用浏览器：360、FireFox、Chrome、Safari、Opera、傲游、搜狗、世界之窗. 不支持IE8及以下浏览器。</p>
		<p>
			来源：<a href="http://sc.chinaz.com/" target="_blank">站长素材</a>
		</p>
	</div>
</body>
</html>


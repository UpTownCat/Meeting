var valid = {
		init : function() {
			$("#ok")
			.click(
					function() {
						var v1 = $("#start").val();
						var v2 = $("#end").val();
						var title = $("#title2").val();
						if(v1.length == 0 || v2.length == 0 || title.length == 0) {
							alert("会议开始时间， 结束时间， 主题其中之一不能为空");
							return false;
						}
						var start = new Date(v1);
						var end = new Date(v2);
						var startHour = start.getHours();
						var endHour = end.getHours();
						var startMinute = start.getMinutes();
						var endMinute = end.getMinutes();
						if (v1.length == 0 || v2.length == 0) {
							alsert("会议时间不能为空！");
							return false;
						}
						if (v1.substring(0, 10) != v2.substring(0,
								10)) {
							alert("会议的开始时间和结束时间不在同一天");
							return false;
						}
						if (start.getTime() < new Date().getTime()
								|| end.getTime() < new Date()
										.getTime()) {
							alert("开始时间或结束时间不能比当前时间小！");
							return false;
						}
						if (start.getTime() > end.getTime()) {
							alert("结束时间不能比开始时间小！");
							return false;
						}

						if (startHour > 22 || startHour < 8) {
							alert("开会开始时间会选择错误!");
							return false;
						}
						if (endHour > 22 || endHour < 8) {
							alert("开会结束时间会选择错误!");
							return false;
						}

						if (endHour == 22 && endMinute != 0) {
							alert("结束时间有误！");
							return false;
						}

						if ((startHour == 12 && startMinute > 0)
								|| (startHour == 17 && startMinute > 0)) {
							alert("开始时间选择有误！");
							return false;
						}
						if ((endHour == 12 && endMinute > 0)
								|| (endHour == 17 && endMinute > 0)) {
							alert("结束时间选择有误！");
							return false;
						}
						if (end.getTime() - start.getTime() < 1000 * 60 * 30) {
							alert("开会时间至少为30分钟!")
							return false;
						}
						var room = document.getElementById("room");
						var roomId = room.options[room.selectedIndex].value;
						var tag = 0;
						$.ajax({
							url : "/meeting/room/valid?id="+roomId + "&startTime="+v1,
							async : false,
							success : function(data) {
								if(data == 0) {
									tag = 1;
									alert("该时间段该会议室已经有会议要召开， 请重新选择会议室或时间");
								} else {
									if(data == 2) {
										tag = 2;
//											alert("该时间段该会议室已经有预约， 有可能不能成功预约");
									}
								}
							}
						})
						if(tag == 1) {
							return false;
						}else {
							if(tag == 2) {
								$("#msg").html("该时间段该会议室已经有预约， 有可能不能成功预约, 您是否要继续预约?")
								$("#myModal").modal({show : true});
								return false;
							}
						}
						
					});
		}
}
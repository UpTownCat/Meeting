var valid = {
		init : function() {
			$("#ok")
			.click(
					function() {
						var v1 = $("#start").val();
						var v2 = $("#end").val();
						var title = $("#title2").val();
						if(v1.length == 0 || v2.length == 0 || title.length == 0) {
							alert("���鿪ʼʱ�䣬 ����ʱ�䣬 ��������֮һ����Ϊ��");
							return false;
						}
						var start = new Date(v1);
						var end = new Date(v2);
						var startHour = start.getHours();
						var endHour = end.getHours();
						var startMinute = start.getMinutes();
						var endMinute = end.getMinutes();
						if (v1.length == 0 || v2.length == 0) {
							alsert("����ʱ�䲻��Ϊ�գ�");
							return false;
						}
						if (v1.substring(0, 10) != v2.substring(0,
								10)) {
							alert("����Ŀ�ʼʱ��ͽ���ʱ�䲻��ͬһ��");
							return false;
						}
						if (start.getTime() < new Date().getTime()
								|| end.getTime() < new Date()
										.getTime()) {
							alert("��ʼʱ������ʱ�䲻�ܱȵ�ǰʱ��С��");
							return false;
						}
						if (start.getTime() > end.getTime()) {
							alert("����ʱ�䲻�ܱȿ�ʼʱ��С��");
							return false;
						}

						if (startHour > 22 || startHour < 8) {
							alert("���Ὺʼʱ���ѡ�����!");
							return false;
						}
						if (endHour > 22 || endHour < 8) {
							alert("�������ʱ���ѡ�����!");
							return false;
						}

						if (endHour == 22 && endMinute != 0) {
							alert("����ʱ������");
							return false;
						}

						if ((startHour == 12 && startMinute > 0)
								|| (startHour == 17 && startMinute > 0)) {
							alert("��ʼʱ��ѡ������");
							return false;
						}
						if ((endHour == 12 && endMinute > 0)
								|| (endHour == 17 && endMinute > 0)) {
							alert("����ʱ��ѡ������");
							return false;
						}
						if (end.getTime() - start.getTime() < 1000 * 60 * 30) {
							alert("����ʱ������Ϊ30����!")
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
									alert("��ʱ��θû������Ѿ��л���Ҫ�ٿ��� ������ѡ������һ�ʱ��");
								} else {
									if(data == 2) {
										tag = 2;
//											alert("��ʱ��θû������Ѿ���ԤԼ�� �п��ܲ��ܳɹ�ԤԼ");
									}
								}
							}
						})
						if(tag == 1) {
							return false;
						}else {
							if(tag == 2) {
								$("#msg").html("��ʱ��θû������Ѿ���ԤԼ�� �п��ܲ��ܳɹ�ԤԼ, ���Ƿ�Ҫ����ԤԼ?")
								$("#myModal").modal({show : true});
								return false;
							}
						}
						
					});
		}
}
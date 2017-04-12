var valid = {
		init : function(meetingId) {
			$("#ok")
			.click(
					function() {
						var v1 = $("#start").val();
						var v2 = $("#end").val();
						var title = $("#title2").val();
						if(v1.length == 0 || v2.length == 0 || title.length == 0) {
							$.confirm({
								backgroundDismiss: true,
								title: "��������",
								content: "���鿪ʼʱ�䣬 ����ʱ�䣬 ��������֮һ����Ϊ��",
								buttons: {
									"�ر�": function(){},
								},
							})
							return false;
						}
						var start = new Date(v1);
						var end = new Date(v2);
						var startHour = start.getHours();
						var endHour = end.getHours();
						var startMinute = start.getMinutes();
						var endMinute = end.getMinutes();
						if (v1.length == 0 || v2.length == 0) {
							$.confirm({
								backgroundDismiss: true,
								title: "��������",
								content: "����ʱ�䲻��Ϊ��",
								buttons: {
									"�ر�": function(){},
								},
							})
							return false;
						}
						if (v1.substring(0, 10) != v2.substring(0,
								10)) {
							$.confirm({
								backgroundDismiss: true,
								title: "��������",
								content: "����Ŀ�ʼʱ��ͽ���ʱ�䲻��ͬһ��",
								buttons: {
									"�ر�": function(){},
								},
							})
							return false;
						}
						if (start.getTime() < new Date().getTime()
								|| end.getTime() < new Date()
										.getTime()) {
							$.confirm({
								backgroundDismiss: true,
								title: "��������",
								content: "��ʼʱ������ʱ�䲻�ܱȵ�ǰʱ��С��",
								buttons: {
									"�ر�": function(){},
								},
							})
							return false;
						}
						if (start.getTime() > end.getTime()) {
							$.confirm({
								backgroundDismiss: true,
								title: "��������",
								content: "����ʱ�䲻�ܱȿ�ʼʱ��С��",
								buttons: {
									"�ر�": function(){},
								},
							})
							return false;
						}

						if (startHour > 22 || startHour < 8) {
							$.confirm({
								backgroundDismiss: true,
								title: "��������",
								content: "���Ὺʼʱ���ѡ�����!",
								buttons: {
									"�ر�": function(){},
								},
							})
							return false;
						}
						if (endHour > 22 || endHour < 8) {
							$.confirm({
								backgroundDismiss: true,
								title: "��������",
								content: "�������ʱ���ѡ�����!",
								buttons: {
									"�ر�": function(){},
								},
							})
							return false;
						}

						if (endHour == 22 && endMinute != 0) {
							$.confirm({
								backgroundDismiss: true,
								title: "��������",
								content: "����ʱ������",
								buttons: {
									"�ر�": function(){},
								},
							})
							return false;
						}

						if ((startHour == 12 && startMinute > 0)
								|| (startHour == 17 && startMinute > 0)) {
							$.confirm({
								backgroundDismiss: true,
								title: "��������",
								content: "��ʼʱ��ѡ������",
								buttons: {
									"�ر�": function(){},
								},
							})
							return false;
						}
						if ((endHour == 12 && endMinute > 0)
								|| (endHour == 17 && endMinute > 0)) {
							$.confirm({
								backgroundDismiss: true,
								title: "��������",
								content: "����ʱ��ѡ������",
								buttons: {
									"�ر�": function(){},
								},
							})
							return false;
						}
						if (end.getTime() - start.getTime() < 1000 * 60 * 30) {
							$.confirm({
								backgroundDismiss: true,
								title: "��������",
								content: "����ʱ������Ϊ30����!",
								buttons: {
									"�ر�": function(){},
								},
							})
							return false;
						}
						var room = document.getElementById("room");
						var roomId = room.options[room.selectedIndex].value;
						var tag = 0;
						$.ajax({
							url : "/meeting/room/valid?id="+roomId + "&startTime="+v1 + "&meetingId=" + meetingId,
							async : false,
							success : function(data) {
								if(data == 0) {
									tag = 1;
									$.confirm({
										backgroundDismiss: true,
										title: "������ʾ",
										content: "��ʱ��θû������Ѿ��л���Ҫ�ٿ��� ������ѡ������һ�ʱ��",
										buttons: {
											"�ر�": function(){},
										},
									})
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
								$.confirm({
									backgroundDismiss: false, 
									title: "������ʾ", 
									content: "��ʱ��θû������Ѿ���ԤԼ�� �п��ܲ��ܳɹ�ԤԼ, ���Ƿ�Ҫ����ԤԼ?",
									buttons: {
										"ȡ��": function(){},
										"ȷ��": function(){$("#form").submit();}
									}
								})
								return false;
							}
						}
						
					});
		}
}
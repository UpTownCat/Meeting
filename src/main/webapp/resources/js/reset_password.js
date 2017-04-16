var reset = {
		init: function() {
			var old = $("#oldPassword").val();
			var new1 = $("#password1").val();
			var new2 = $("#password2").val();
			
			if(old.length == 0 || new1.length == 0 || new2.length == 0) {
				common.remind("ԭ���룬 �����붼����Ϊ�գ�");
				return 0;
			} 
			
			if(new1 != new2) {
				common.remind("�����벻һ�£�");
				return 0;
			}
			var tag = 0;
			$.ajax({
				url: "/meeting/common/reset",
				type: "POST",
				async: false,
				data: {"old": old, "new1": new1},
				success: function(data) {
					if(data == 0) {
						common.remind("ԭ���벻��ȷ��");
					}else {
						tag = 1;
					}
				}
			});
			return tag;
		}
}
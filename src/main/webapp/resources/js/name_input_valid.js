var name_valid = {
		init: function(n) {
			var t1 = 1;
			$(".name").blur(function() {
				var val = this.value;
				if(n.length != 0 && n == val){
					return false;
				}
				if(val.length == 0) {
					t1 = 2;
					common.remind("�����ұ�Ų���Ϊ�գ�");
					return false;
				}
				val = encodeURI(val);
				$.get("/meeting/common/name", {"tag": 3, "name": val}, function(data) {
					if(data == 0) {
						t1 = 1;
					}else {
						t1 = 0;
						common.remind("�ñ�ŵĻ������Ѿ����ڣ�");
					}
				})
			})
			
			$("#submit44").click(function() {
				if(t1 == 2) {
					common.remind("�����ұ�Ų���Ϊ�գ�");
					return false;
				}
				if(t1 == 0) {
					var val = $(".name").val();
					if(n != val) {
						common.remind("�ñ�ŵĻ������Ѿ����ڣ�");
						return false;
					}
				}
				if(check() == 0) {
					common.remind("������Ϣ�������� ��������");
					return false;
				}
			})
			
			function check() {
					var inputs = $(".input");
					for(var i = 0; i < inputs.length; i++) {
						if(inputs.eq(i).val().length == 0) {
							return 0;
						}
					}
					return 1;
				}
		}
}
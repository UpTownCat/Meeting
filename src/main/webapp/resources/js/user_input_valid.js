var userInput = {
		init: function(t1, t2, p1, e1) {
			$(".email").blur(function() {
				var val = this.value;
				if(e1.length != 0 && e1 == val) {
					return false;
				}
				var reg = /^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/
				if(!reg.test(val)) {
					t1 = 2;
					common.remind("���䲻���Ϲ��� ���飡");
					return false;
				}
				$.get("/meeting/common/email", {"tag": 1, "email": val}, function(data) {
					if(data != 0) {
						t1 = 0;
						common.remind("��������û��Ѵ��ڣ�");
					}else {
						t1 = 1;
					}
				})
			});
			
			$(".phone").blur(function(){
				var val = this.value;
				if(p1.length != 0 && p1 == val) {
					return false;
				}
				if(val.length != 11) {
					common.remind("�ֻ����볤��Ϊ11λ�� ��ǰ����Ϊ��" + val.length);
					t2 = 2;
					return false;
				}
				var reg = /^1[3|4|5|7|8][0-9]{9}$/
					if(reg.test(val)) {
						$.get("/meeting/common/phone", {"tag": 1, "phone": val}, function(data) {
							if(data != 0) {
								t2 = 0;
								common.remind("���ֻ�������û��Ѵ��ڣ�");
							}else {
								t2 = 1;
							}
						})
					}else {
						t2 = 3;
						common.remind("�ֻ����벻���Ϲ��� ���飡");
					}
			});
			
			$("#submit44").click(function() {
				if(t2 == 3) {
					common.remind("�ֻ����벻���Ϲ��� ���飡");
					return false;
				}
				if(t1 == 0) {
					common.remind("��������û��Ѵ��ڣ�")
					return false;
				}
				if(t2 == 0) {
					common.remind("���ֻ�������û��Ѵ��ڣ�");
					return false;
				}
				if(t1 == 2) {
					common.remind("���䲻���Ϲ��� ���飡")
					return false;
				}
				if(t2 == 2) {
					common.remind("�ֻ����볤��ֻ��Ϊ11λ��");
					return false;
				}
				if(check() == 0) {
					common.remind("����д���û���Ϣ��������")
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
			};
		}
}
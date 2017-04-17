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
					common.remind("邮箱不符合规则， 请检查！");
					return false;
				}
				$.get("/meeting/common/email", {"tag": 1, "email": val}, function(data) {
					if(data != 0) {
						t1 = 0;
						common.remind("该邮箱的用户已存在！");
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
					common.remind("手机号码长度为11位， 当前长度为：" + val.length);
					t2 = 2;
					return false;
				}
				var reg = /^1[3|4|5|7|8][0-9]{9}$/
					if(reg.test(val)) {
						$.get("/meeting/common/phone", {"tag": 1, "phone": val}, function(data) {
							if(data != 0) {
								t2 = 0;
								common.remind("该手机号码的用户已存在！");
							}else {
								t2 = 1;
							}
						})
					}else {
						t2 = 3;
						common.remind("手机号码不符合规则， 请检查！");
					}
			});
			
			$("#submit44").click(function() {
				if(t2 == 3) {
					common.remind("手机号码不符合规则， 请检查！");
					return false;
				}
				if(t1 == 0) {
					common.remind("该邮箱的用户已存在！")
					return false;
				}
				if(t2 == 0) {
					common.remind("该手机号码的用户已存在！");
					return false;
				}
				if(t1 == 2) {
					common.remind("邮箱不符合规则， 请检查！")
					return false;
				}
				if(t2 == 2) {
					common.remind("手机号码长度只能为11位！");
					return false;
				}
				if(check() == 0) {
					common.remind("您填写的用户信息不完整！")
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
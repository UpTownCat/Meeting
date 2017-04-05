var ajax_page = {
	init : function() {
		$(".pageItem2").click(function(departmentId,total){
			var href = $(this).find("a").attr("href");
			var index = href.substring(href.lastIndexOf("=") + 1);
			initlizePageItem(index, total);
			t.init(index, departmentId);
			return false;
		});
		
		$("#next").click(function(){
			var pageContent = $("#pageContent2");
			var lis = pageContent.find("li");
			var index2 = 0;
			for(var i = 1; i < lis.length - 2; i++) {
				var clazz = lis.eq(i).attr("class");
				if(clazz.length > 10) {
					index2 = i;
					break;
				}
			}
			if(index2 != total) {
				initlizePageItem(index2 + 1, total);
				t.init(index2 + 1, departmentId);
			}
			return false;
		});
		
		$("#previous").click(function(){
			var pageContent = $("#pageContent2");
			var lis = pageContent.find("li");
			var index2 = 0;
			for(var i = 1; i < lis.length - 2; i++) {
				var clazz = lis.eq(i).attr("class");
				if(clazz.length > 10) {
					index2 = i;
					break;
				}
			}
			if(index2 != 1) {
				initlizePageItem(index2 - 1, total);
				t.init(index2 - 1, departmentId);
			}
			return false;
		});
		$("#forward").click(function(){
			var val = $("#forwardPage").val();
			$("#forwardPage").val("");
			initlizePageItem(val, total);
			t.init(val, departmentIds);
			return false;
		});
		
		function initlizePageItem(index, total) {
			var pageContent = $("#pageContent2");
			var lis = pageContent.find("li");
			for(var i = 1; i < lis.length - 2; i++) {
				lis.eq(i).removeClass("active");
			}
			if(total <= 6) {
				for(var i = 1; i < lis.length - 2; i++) {
					if(i == index){
						lis.eq(i).addClass("active");
					}
				}
			}else {
				if(index > 4 && index <= total - 2) {
					for(var i = 1; i < lis.length - 2; i++) {
						var val = index - 4 + i;
						lis.eq(i).find("a").html("" + val).attr("href", "=" + val);
						if(val == index) {
							lis.eq(i).addClass("active");
						}
					}
				}else{
					if(index <= 4){
						for(var i = 1; i < lis.length - 2; i++) {
							lis.eq(i).find("a").html("" + i).attr("href", "=" + i);
							if(i == index) {
								lis.eq(i).addClass("active");
							}
						}
					}else {
						if(index > total - 2) {
							for(var i = lis.length - 3; i >= 1; i--) {
								lis.eq(i).find("a").html("" + (total - (6 - i))).attr("href", "=" + (total - 6 + i));
								if((total - 6 + i) == index) {
									lis.eq(i).addClass("active");
								}
							}
						}
					}
				}
			}
		};
	}
}
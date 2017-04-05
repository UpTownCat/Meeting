var t = {
		init : function(index, id) {
			var href = "/meeting/department/users";
			$.ajax({
				url : href,
				data : {departmentId : id, "index" : index},
				aysnc : false,
				success : function(data) {
					var table = $("#table");
					var trs = table.find("tr");
					for(var i = 0; i < data.length; i++) {
						var user = data[i];
						var tr = trs.eq(i + 1);
						var tds = tr.find("td");
						tds.eq(0).html(user.name);
						tds.eq(1).html(user.phone);
						tds.eq(2).html(user.email);
						tds.eq(3).html(user.gender == 0 ? "Å®" : "ÄĞ");
						tds.eq(4).html("<a class='btn btn-info' href='/meeting/user/" + user.id + "/detail'>ÏêÇé</a>")
						
					}
				}
			})
		}
}
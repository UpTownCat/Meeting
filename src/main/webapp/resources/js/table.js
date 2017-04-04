var t = {
	init : function(index) {
		var arr = ["ÔçÉÏ:", "ÏÂÎç:", "ÍíÉÏ:"];
		var table = $("#table");
		var trs = table.find("tr");
		$.ajax({url:"/meeting/invitation/recent", data : {page : index},  aysnc:false, success:function(data){
			for(var i = 0; i < data.length; i++) {
				var tds = trs.eq(i + 1).find("td");
				var userInvitationDto = data[i];
				var dayInvitationDtos = userInvitationDto.dayInvitationDtos;
				tds.eq(0).html(userInvitationDto.name);
				for(var j = 0; j < dayInvitationDtos.length; j++) {
					var td = tds.eq(j + 1);
					var dayInvitationDto = dayInvitationDtos[j];
					if(dayInvitationDto.hasMeeting == 0) {
						continue;
					}
					var str = "";
					var dtos = dayInvitationDto.dtos;
					for(var l = 0; l < dtos.length; l++) {
						var dto = dtos[l];
						if(dto.id != 0) {
							str += arr[l];
							str += dto.title;
							str += "</br>";
						}
					}
					td.html(str);
				}
			}
		}});
	}
}
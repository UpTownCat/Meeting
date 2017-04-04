/**
 * 2017.03.21
 */
var page = {
	/**
	 * 
	 * @param pageSize 必须为偶数 显示的页数
	 * @param index 当前页数
	 * @param totalPage 总页数
	 * @param url
	 */
	init : function(pageSize, index, totalPage, url) {
		if(index < 1) {
			index = 1;
		}
		if(index > totalPage)
			index = totalPage;
		var pageContent = $("#pageContent");
		if(index > 1) {
			pageContent.append("<li><a class='pageItem' href='" + url + "?index=" + (index - 1) + "'>&laquo;</a></li>");
		}else {
			pageContent.append("<li class='disabled'><a class='tip' data-toggle='tooltip' data-placement='top' title='当前已经是首页'>&laquo;</a></li>");
		}
		if(totalPage <= pageSize) {
			this.createItem(pageContent, 1, totalPage, index, url);
		}
		else {
			if(index <= pageSize / 2) {
				this.createItem(pageContent, 1, pageSize, index, url);
			}else {
				if(index >= totalPage - (pageSize /2 - 1)) {
					this.createItem(pageContent, (totalPage- pageSize + 1), totalPage, index,url);
				}else {
					this.createItem(pageContent, index - (pageSize / 2), index - 0 + (pageSize / 2 - 1), index, url);
				}
			}
			
		}
		if(index < totalPage) {
			pageContent.append("<li><a class='pageItem' href='" + url + "?index=" + (index - 0 + 1) + "'>&raquo;</a></li>");
		}else {
			pageContent.append("<li class='disabled'><a class='tip' data-toggle='tooltip' data-placement='top' title='当前已经是尾页'>&raquo;</a></li>");
		}
		pageContent.append("<input id='forwardPage' class='tip' data-toggle='tooltip' data-placement='top' title='" + "总共" + totalPage + "页" +"' size='2' style='float:left; height : 35px'>");
		pageContent.append("<li><a id='forward' style='cursor : pointer'>跳转</a></li>");
		$('.tip').tooltip();
	},
	createItem : function(pageContent, begin, end, index, url){
		for(var i = begin; i <= end; i++) {
			if(i == index){
				pageContent.append("<li class='active'><a class='pageItem' href='" + url + "?index=" + i + "'>" + i + "</a></li>");
			}else {
				pageContent.append("<li><a class='pageItem' href='" + url + "?index=" + i + "'>" + i + "</a></li>");
			}
		}
	},	
	forward : function(total, url) {
		var toPage = $("#forwardPage").val();
		if(toPage.length == 0){
			return ;
		}
		if(toPage - 0 > total) {
			toPage = total;
		}
		if(toPage - 0 < 1){
			toPage = 1;
		}
		var forward = $("#forward");
		forward.attr("href", url + "?index=" + toPage);
	},
}

/**
 * 2017.03.21
 */
var page = {
	/**
	 * 
	 * @param pageSize ����Ϊż�� ��ʾ��ҳ��
	 * @param index ��ǰҳ��
	 * @param totalPage ��ҳ��
	 * @param url
	 */
	init : function(pageSize, index, totalPage, url) {
		if(index < 1) {
			index = 1;
		}
		if(index > totalPage)
			index = totalPage;
		var pageContent = $("#pageContent2");
		pageContent.append("<li id='previous'><a href='" + url + "?index=" + (index - 1) + "'>&laquo;</a></li>");
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
		pageContent.append("<li id='next'><a href='" + url + "?index=" + (index - 0 + 1) + "'>&raquo;</a></li>");
		pageContent.append("<input id='forwardPage' class='tip' data-toggle='tooltip' data-placement='top' title='" + "�ܹ�" + totalPage + "ҳ" +"' size='2' style='float:left; height : 35px'>");
		pageContent.append("<li ><a id='forward' style='cursor : pointer'>��ת</a></li>");
		$('.tip').tooltip();
	},
	createItem : function(pageContent, begin, end, index, url){
		for(var i = begin; i <= end; i++) {
			if(i == index){
				pageContent.append("<li class='active pageItem2'><a  href='" + url + "?index=" + i + "'>" + i + "</a></li>");
			}else {
				pageContent.append("<li class='pageItem2'><a href='" + url + "?index=" + i + "'>" + i + "</a></li>");
			}
		}
	},	
}

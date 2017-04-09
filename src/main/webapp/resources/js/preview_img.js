var p = {
	init : function() {
		var fileInput = document.getElementById('fileInput'), 
		info = document.getElementById('info'), 
		preview = document.getElementById('preview');
		// 监听change事件:
		fileInput.addEventListener('change', function() {
			// 清除背景图片:
			preview.style.backgroundImage = '';
			// 检查文件是否选择:
			if (!fileInput.value) {
				info.innerHTML = '没有选择文件';
				return;
			}
			// 获取File引用:
			var file = fileInput.files[0];
			// 获取File信息:
			var suffix = file.name.substring(file.name.lastIndexOf(".") + 1);
			if (suffix != "jpg" && suffix != "jpng" && suffix != "png") {
				$.confirm({
					backgroundDismiss : true,
					title: "",
					content: '不是有效的图片文件！',
					buttons: {
						"关闭" : function() {
						}
					}
				});
				return;
			}
			info.innerHTML = '文件: ' + file.name + '<br>' + '大小: ' + file.size
			+ '<br>';
			// 读取文件:
			var reader = new FileReader();
			reader.onload = function(e) {
				var data = e.target.result; // 'data:image/jpeg;base64,/9j/4AAQSk...(base64编码)...'
				$("#preview").attr("src", data);
			};
			// 以DataURL的形式读取文件:
			reader.readAsDataURL(file);
		});

	},
}
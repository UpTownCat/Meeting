var p = {
	init : function() {
		var fileInput = document.getElementById('fileInput'), 
		info = document.getElementById('info'), 
		preview = document.getElementById('preview');
		// ����change�¼�:
		fileInput.addEventListener('change', function() {
			// �������ͼƬ:
			preview.style.backgroundImage = '';
			// ����ļ��Ƿ�ѡ��:
			if (!fileInput.value) {
				info.innerHTML = 'û��ѡ���ļ�';
				return;
			}
			// ��ȡFile����:
			var file = fileInput.files[0];
			// ��ȡFile��Ϣ:
			var suffix = file.name.substring(file.name.lastIndexOf(".") + 1);
			if (suffix != "jpg" && suffix != "jpng" && suffix != "png") {
				$.confirm({
					backgroundDismiss : true,
					title: "",
					content: '������Ч��ͼƬ�ļ���',
					buttons: {
						"�ر�" : function() {
						}
					}
				});
				return;
			}
			info.innerHTML = '�ļ�: ' + file.name + '<br>' + '��С: ' + file.size
			+ '<br>';
			// ��ȡ�ļ�:
			var reader = new FileReader();
			reader.onload = function(e) {
				var data = e.target.result; // 'data:image/jpeg;base64,/9j/4AAQSk...(base64����)...'
				$("#preview").attr("src", data);
			};
			// ��DataURL����ʽ��ȡ�ļ�:
			reader.readAsDataURL(file);
		});

	},
}
$(function(){
	//��ȡ��ǰ��ַ���磺 http://localhost:8083/uimcardprj/share/meun.jsp
    var curWwwPath = window.document.location.href;
    //��ȡ������ַ֮���Ŀ¼���磺 uimcardprj/share/meun.jsp
    var pathName = window.document.location.pathname;
    //��ȡ��"/"����Ŀ�����磺/uimcardprj
    var projectName = pathName.substring(0, pathName.substr(1).indexOf('/') + 1);

    var id = Number($("[name=id]").val());//�ж�ҳ���Ƿ��Ǹ���ҳ��,��id���Ǹ���,��������¼�
	//��number�Ƿ�����������֤
    var nameOk=0;//���ȫ�ֱ����Ǳ�ʾ,����������������Ȳ��ǿո������ո�Ҳ��������.0��ʾ����,1��ʾ�����ύ��
    if(id>0)
    	nameOk=1;//����û��ڸ���ҳ��տ�ʼɶ������ֱ���ύ,��ôҲ�ǿ��Ե�
	$("[name=name]").blur(function(){
		var url = projectName+"/equipment/validateNameIsUseful";
		var name = this.value;
		if(name==""||name.indexOf(' ')!=-1){
			nameOk = 0;
			$("[name=nameValidate]").text("(���Ʋ���Ϊ�ջ��߰����ո�)");
			$("[name=nameValidate]").css("color","red");
		}else{
			
			var res='';
			name = encodeURI(name);
			var data={"name":name};
			if(id>0){
				data={"name":name,"id":id}
			}
			$.ajax({
				async : false,
				cache : false,
				success: function(data){
					res=data;
				},
				type : "POST",
				url : url,
				data : data
			});
			if(res==1)
			{	
				nameOk = 1;
				$("[name=nameValidate]").css("color","green");
				$("[name=nameValidate]").text("�����ƿ���ʹ��");
			}
			else{
				nameOk = 0;
				$("[name=nameValidate]").css("color","red");
				$("[name=nameValidate]").text("�������ѱ�ע��");
			}
		}
	
	});
	
	//������б��ύʱ�ķǿռ����Ϸ���֤
	$("[name=addOrUpdate]").click(function(){
			var count = $("[name=count]").val();//д�������ҪĿ���Ƿ�ֹ�û���д�绰ֱ���ύû��ʾ
			if(count==''){
				$("[name=countValidate]").text("��������Ϊ��,�ұ�����С��5000�ķǸ�����!"); 
				return false;
			}else{
				cnum = Number(count.trim());
				if((/^[0-9]*[0-9]*$/.test(cnum)&&(cnum<=5000))){
					
				}else{
					$("[name=countValidate]").text("��������Ϊ��,�ұ�����С��5000�ķǸ�����!"); 
					return false;
				}
			}
			
			var name;
			if(id>0)
				name = $("[name=name]").val();
			else
				name = $("[name=name]")[1].value;//������¼�ҳ��Ļ�
			if(name==''||name.indexOf(' ')!=-1){
				$("[name=nameValidate]").text("(���Ʋ���Ϊ�ջ��߰����ո�)");
				$("[name=nameValidate]").css("color","red");
				$("[name=name]").focus();
				return false;
			}else if(nameOk == 0)
				return false;
			return true;
	});
});
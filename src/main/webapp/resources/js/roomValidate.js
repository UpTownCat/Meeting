$(function(){
	//��ȡ��ǰ��ַ���磺 http://localhost:8083/uimcardprj/share/meun.jsp
    var curWwwPath = window.document.location.href;
    //��ȡ������ַ֮���Ŀ¼���磺 uimcardprj/share/meun.jsp
    var pathName = window.document.location.pathname;
    //��ȡ��"/"����Ŀ�����磺/uimcardprj
    var projectName = pathName.substring(0, pathName.substr(1).indexOf('/') + 1);

    var id = Number($("[name=id]").val());//�ж�ҳ���Ƿ��Ǹ���ҳ��,��id���Ǹ���,��������¼�
	//��number�Ƿ�����������֤
    var numberOk=0;//���ȫ�ֱ����Ǳ�ʾ,����������������Ȳ��ǿո������ո�Ҳ��������.0��ʾ����,1��ʾ�����ύ��
    if(id>0)
    	numberOk=1;//����û��ڸ���ҳ��տ�ʼɶ������ֱ���ύ,��ôҲ�ǿ��Ե�
	$("[name=number]").blur(function(){
		//�������������jspҳ����.�����ʱ��,˭��ʶ�����${applicationScope.url }����<%=..%>(���ǩ��д�����涼��������ɫ��),
		//java�Ǳ���ִ������,�����ڷ�������ִ�е��Ǳ���Ľ��,��˾Ͳ�����
		var url = projectName+"/room/validateNumberIsUseful";
		var number = this.value;
		num = Number(number.trim());
		//�����źϷ�,��Ҫ�����Ƿ��ظ�
		if(/^[1-9]*[1-9][0-9]*$/.test(num)){
			var res='';
			num = encodeURI(num);
			var data={"number":num};
			if(id>0){
				data={"number":num,"id":id}
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
					numberOk = 1;
					$("[name=numberValidate]").css("color","green");
					$("[name=numberValidate]").text("�ñ�ſ���ʹ��");
				}
				else{
					numberOk = 0;
					$("[name=numberValidate]").css("color","red");
					$("[name=numberValidate]").text("�ñ���ѱ�ע��");
				}
		}else{
			numberOk = 0;
			$("[name=numberValidate]").css("color","red");
			$("[name=numberValidate]").text("�ñ�Ų���Ϊ���ұ���������");
		}
	
	});
	
	/*//�Եص��Ψһ����֤.
	var locationOk=0;//���ȫ�ֱ����Ǳ�ʾ,����������������Ȳ��ǿո������ո�Ҳ��������.0��ʾ����,1��ʾ�����ύ��
	 if(id>0)
		 locationOk=1;
	$("[name=location]").blur(function(){
		var url = projectName+"/room/validateLocationIsUseful";
		var location = this.value;
		if(location==""||location.indexOf(' ')!=-1){
			$("[name=locationValidate]").text("�ص㲻��Ϊ��!"); 
			$("[name=locationValidate]").css("color","red");
			//alert(123);
			location = 0;
		}
		else{
			var res='';
			var data={"location":location};
			if(id>0){
				data={"location":location,"id":id};
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
					locationOk = 1;
					$("[name=locationValidate]").css("color","green");
					$("[name=locationValidate]").text("�õص����ʹ��");
				}
				else{
					locationOk = 0;
					$("[name=locationValidate]").css("color","red");
					$("[name=locationValidate]").text("�õص��ѱ�ʹ��");
				}
		}
	});*/
	
	//������б��ύʱ�ķǿռ����Ϸ���֤
	$(":submit").click(function(){
			var capacity = $("[name=capacity]").val();//д�������ҪĿ���Ƿ�ֹ�û���д�绰ֱ���ύû��ʾ
			cnum = Number(capacity.trim());
			if((/^[1-9]*[1-9][0-9]*$/.test(cnum))&&(cnum<=1000)){
			
			}else{
				$("[name=capacityValidate]").text("��������Ϊ��,�ұ�����С��1000��������!"); 
				$("[name=capacity]").focus();
				return false;
			}
			if(numberOk == 0)
				return false;
			if(locationOk == 0)
				return false;
			return true;
	});
});
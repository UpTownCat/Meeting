/**
 * ��name,password,password2,�绰,������֤
 */
$(function(){

	//��ȡ��ǰ��ַ���磺 http://localhost:8083/uimcardprj/share/meun.jsp
    var curWwwPath = window.document.location.href;
    //��ȡ������ַ֮���Ŀ¼���磺 uimcardprj/share/meun.jsp
    var pathName = window.document.location.pathname;
    //��ȡ��"/"����Ŀ�����磺/uimcardprj
    var projectName = pathName.substring(0, pathName.substr(1).indexOf('/') + 1);
    //����ǰ̨ҳ��ע���name ��input���һ������str
    var str = $("[name=name]").attr("str");//��ҳ���ȡҪ���ʵ�·����Ϣ.user��sign����user,manager��sign����manager...
	//�������Ƿ�����������֤
	var nameOk=0;//���ȫ�ֱ����Ǳ�ʾ,����������������Ȳ��ǿո������ո�Ҳ��������.0��ʾ����,1��ʾ�����ύ��
	$("[name=name]").blur(function(){
		//�������������jspҳ����.�����ʱ��,˭��ʶ�����${applicationScope.url }����<%=..%>(���ǩ��д�����涼��������ɫ��),
		//java�Ǳ���ִ������,�����ڷ�������ִ�е��Ǳ���Ľ��,��˾Ͳ�����
		var url = projectName+"/"+str+"/validateNameIsUseful";
		var name = this.value;
		//����û���Ϊ�ջ��߰����ո�����,���ﲻ��,����ֻ�Ƕ���д�Ϸ�����û���������֤.
		if(name==""||name.indexOf(' ')!=-1){
			//���������������ύʱ����
		}
		else{
			var res='';
			var data={"name":name};
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
					$("[name=nameValidate]").text("���û�������ʹ��");
				}
				else{
					nameOk = 0;
					$("[name=nameValidate]").css("color","red");
					$("[name=nameValidate]").text("���û����ѱ�ע��");
				}
		}
	});
	
	//�Ե绰����Ψһ�Խ�����֤
	var phoneOk=0;//���ȫ�ֱ����Ǳ�ʾ,����������������Ȳ��ǿո������ո�Ҳ��������.0��ʾ����,1��ʾ�����ύ��
	$("[name=phone]").blur(function(){
		var url = projectName+"/"+str+"/validatePhoneIsUseful";
		var phone = this.value;
		if(phone==""||phone.indexOf(' ')!=-1){
			$("[name=phoneValidate]").text("���벻��Ϊ��!"); 
			$("[name=phoneValidate]").css("color","red");
			//alert(123);
			phoneOk = 0;
		}else if(!(/^1[3|4|5|8][0-9]\d{4,8}$/.test(phone))){ 
			$("[name=phoneValidate]").text("���벻�Ϸ�"); 
			$("[name=phoneValidate]").css("color","red");
			$("[name=phone]").focus();
			phoneOk = 0;
		}
		else{
			var res='';
			var data={"phone":phone};
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
					phoneOk = 1;
					$("[name=phoneValidate]").css("color","green");
					$("[name=phoneValidate]").text("�ú������ע��");
				}
				else{
					phoneOk = 0;
					$("[name=phoneValidate]").css("color","red");
					$("[name=phoneValidate]").text("�ú����ѱ�ע��");
				}
		}
	});
	
	//������Ψһ�Խ�����֤
	var emailOk=0;//���ȫ�ֱ����Ǳ�ʾ,����������������Ȳ��ǿո������ո�Ҳ��������.0��ʾ����,1��ʾ�����ύ��
	$("[name=email]").blur(function(){
		var url = projectName+"/"+str+"/validateEmaliIsUseful";
		var email = this.value;
		if(email==""||email.indexOf(' ')!=-1){
			$("[name=emailValidate]").text("���䲻��Ϊ��!"); 
			$("[name=emailValidate]").css("color","red");
			/*alert(123);*/
			emailOk = 0;
		}else if(!(/^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\.[a-zA-Z0-9_-]+)+$/.test(email))){ 
			$("[name=emailValidate]").text("���䲻�Ϸ�"); 
			$("[name=emailValidate]").css("color","red");
			$("[name=email]").focus();
			emailOk = 0;
		}
		else{
			var res='';
			var data={"email":email};
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
					emailOk = 1;
					$("[name=emailValidate]").css("color","green");
					$("[name=emailValidate]").text("���������ע��");
				}
				else{
					emailOk = 0;
					$("[name=emailValidate]").css("color","red");
					$("[name=emailValidate]").text("�������ѱ�ע��");
				}
		}
	});
	
	//������б��ύʱ�ķǿռ����Ϸ���֤
	$(":submit").click(function(){
		var name = $("[name=name]").val();
			if(name==''||name.indexOf(' ')!=-1){
				$("[name=nameValidate]").text("(��������Ϊ�ջ��߰����ո�)");
				$("[name=nameValidate]").css("color","red");
				$("[name=name]").focus();
				return false;
			}else if(nameOk==0){
				$("[name=nameValidate]").focus();
				return false;
			}
			var pwd = $("[name=password]").val();
			if(pwd == ""||pwd.indexOf(' ')!=-1){
				$("[name=passwordValidate]").text("���벻��Ϊ�ջ�����ո�");
				$("[name=password]").focus();
				return false;
			}else{
				$("[name=passwordValidate]").text("");
			}
			
			var phone = $("[name=phone]").val();//д�������ҪĿ���Ƿ�ֹ�û���д�绰ֱ���ύû��ʾ
			if(phone==""||phone.indexOf(' ')!=-1){
				$("[name=phoneValidate]").text("���벻��Ϊ��!"); 
				$("[name=phone]").focus();
			}
			if(phoneOk == 0){
				return false;
			}
			
			var email = $("[name=email]").val();//д�������ҪĿ���Ƿ�ֹ�û���д����ֱ���ύû��ʾ
			if(email==""||email.indexOf(' ')!=-1){
				$("[name=emailValidate]").text("���䲻��Ϊ��!"); 
				$("[name=email]").focus();
			}
			if(emailOk == 0)
			{
				return false;
			}
			
			var age = $("[name=age]").val();
			if(age == ""){
				$("[name=ageValidate]").text("���䲻��Ϊ��");
				$("[name=age]").focus();
				return false;
			}else{
				$("[name=ageValidate]").text("");
			}
			var emailValidateCode = $("[name=emailValidateCode]").val();
			if(emailValidateCode == ""){
				$("[name=emailValidateCodeValidate]").text("������֤�벻��Ϊ��");
				$("[name=emailValidateCode]").focus();
				return false;
			}else{
				$("[name=emailValidateCodeValidate]").text("");
			}
			return true;
	});
});
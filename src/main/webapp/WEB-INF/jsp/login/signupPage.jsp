<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/common.css">
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.3.1.min.js"/></script>
	<title>Web Game FG - Signup</title>
</head>
<body>
<script type="text/javascript">
$(document).ready(function(){
	var duplicate_id = 0;
	var duplicate_name = 0;
	var auth_email = 0;
	var check_auth = 0;
	var auth = "";
	
	$("#id_input").on("keyup",function(e){
		if(e.keyCode == 13) 	$("#duplicate_id_button").trigger("click");
		else duplicate_id = 0;
	});
	
	$("#name_input").on("keyup",function(e){
		if(e.keyCode == 13) $("#duplicate_name_button").trigger("click");
		else duplicate_name = 0;
	});

	$("#email_input").on("keyup",function(e){
		if(e.keyCode == 13) $("#auth_email_button").trigger("click");
		else auth_email = 0;
	});
	
	$("#check_auth").on("keyup",function(e){
		if(e.keyCode == 13) $("#auth_button").trigger("click");
		else check_auth = 0;
	});
	
	$("#pw_input, #confirm_pw").on("keyup", function(){
		if($("#pw_input").val() != null && $("#pw_input").val() != ""
				&& $("#confirm_pw").val() == $("#pw_input").val()) {
			$("#pw_check").text("비밀번호가 일치합니다.");
		}
		else {
			$("#pw_check").text("비밀번호를 확인해주세요.");
		}
	});
	
	$("#duplicate_id_button").on("click",function(){
		var id_input = $("#id_input").val();
		$.ajax({
           type : "POST"
           , url : "/fg/login/checkId.do"
           , data : { send_id : id_input }
           , success : function(data) {
        	   var key = data.user_key;
        	   var error = data.error;
        	   if (error != null) {
        		   alert(error);
       		   }
        	   else if(key == null) {
        		   alert("possible");
        		   duplicate_id = 1;
       		   }
        	   else {
        		   alert("impossible id");
       		   }
           }, error : function(e) {
              console.log(e.result);
           }
       });
	});
	
	$("#duplicate_name_button").on("click",function(){
		var name_input = $("#name_input").val();
		$.ajax({
           type : "POST"
           , url : "/fg/login/checkName.do"
           , data : { send_name : name_input }
           , success : function(data) {
        	   var key = data.user_key;
        	   var error = data.error;
        	   if (error != null) {
        		   alert(error);
       		   }
        	   else if(key == null) {
        		   alert("possible name");
        		   duplicate_name = 1;
       		   }
        	   else {
        		   alert("impossible name");
       		   }
           }, error : function(e) {
              console.log(e.result);
           }
       });
	});
	
	$("#auth_email_button").on("click",function(){
		var email_input = $("#email_input").val();
 	   $("#auth_div").show();
		$("#check_auth").val("");
		$.ajax({
           type : "POST"
           , url : "/fg/login/authEmail.do"
           , data : { send_email : email_input }
           , success : function(data) {
        	   auth = data;
        	   check_auth = 0;
       		   auth_email = 1;
           }
           , error : function(e) {
              console.log(e.result);
           }
       });
		
	});

	$("#back_button").on("click",function(){
		var form = $("#back_form");
		form.attr('action', "/fg/login/loginPage.do");
		form.submit();
	});

	$("body").on("click","#auth_button",function(){
		if($("#check_auth").val() == auth){
			alert("Correct auth number");
			check_auth = 1;
		}
		else
			alert("Wrong auth number");
	});

	$("#signup_button").on("click",function(){
		if(duplicate_id == 0)
			alert("Please check duplicate ID");
		else if(duplicate_name == 0)
			alert("Please check duplicate Name");
		else if(auth_email == 0)
			alert("Please Authenticate E-mail");
		else if(check_auth == 0)
			alert("Please check Auth number");
		else if($("#pw_input").val() == null || $("#pw_input").val() == ""
				|| $("#confirm_pw").val() != $("#pw_input").val())
			alert("Please check Password");
		else {
			var id_input = $("#id_input").val();
			var name_input = $("#name_input").val();
			var pw_input = $("#pw_input").val();
			var email_input = $("#email_input").val();
			$.ajax({
	           type : "POST"
	           , url : "/fg/login/signupAction.do"
	           , data : {
	        	   send_id : id_input
	        	   , send_name : name_input
	        	   , send_pw : pw_input
	        	   , send_email : email_input
        	   }
	           , success : function() {
	        	   alert("Success Singup");
	        	   var form = $("#back_form");
	        	   form.attr('action', "/fg/login/loginPage.do");
	        	   form.submit();
	           }
	           , error : function(e) {
	        	   console.log(e.result);
	           }
	       });
		}
	});
})
</script>
<form id="back_form"></form>
<div class="html_part">
	<div class="div_center" style="top:40%;">
		<div class="div_text">
			<input type="text" id="id_input" class="login_page_input_button" placeholder="아이디를 입력하세요.">
			<input type="button" id="duplicate_id_button" class="login_page_button_input" value="duplicate">
		</div>
		<div class="div_text">
			<input type="text" id="name_input" class="login_page_input_button" placeholder="닉네임을 입력하세요.">
			<input type="button" id="duplicate_name_button" class="login_page_button_input" value="duplicate">
	    </div>
		<div class="div_text">
			<input type="password" id="pw_input" class="login_page_input" placeholder="비밀번호를 입력하세요.">
	    </div>
	    <div class="div_text">
	    	<input type="password" id="confirm_pw" class="login_page_input" placeholder="비밀번호를 다시 한번 입력하세요.">	
	    </div>
    	<span id="pw_check">비밀번호를 확인해주세요.</span>
		<div class="div_text">
			<input type="text" id="email_input" class="login_page_input_button" placeholder="이메일을 입력하세요.">    
			<input type="button" id="auth_email_button" class="login_page_button_input" value="auth">
		</div>
	    <div class="div_text" style="display:none;" id="auth_div">
			<input type="text" id="check_auth" class="login_page_input_button" placeholder="인증번호를 입력하세요.">    
			<input type="button" id="auth_button" class="login_page_button_input" value="OK">
	    </div>
		<div class="div_button"><input type="button" id="signup_button" class="login_page_button" value="SIGNUP"></div>
		<div class="div_button_bottom">
			<span class="div_right"><input type="button" id="back_button" class="none_bg_button" value="back"></span>
		</div>
		<!-- 
		<div class="div_text" id="id_input_div" style="display:none;">
			<input id="id_input" class="login_page_input" placeholder="아이디를 입력하세요." value="">
		</div>
		<div class="div_text"><input type="text" id="email_input" class="login_page_input" placeholder="이메일을 입력하세요." value=""></div>
		<div class="div_button"><input type="button" id="signup_button" class="login_page_button" value="FIND"></div>
		<div class="div_button_bottom">
			<span class="div_right"><input type="button" id="back_button" class="none_bg_button" value="back"></span>
		</div> -->
	</div>
</div>
</body>
</html>
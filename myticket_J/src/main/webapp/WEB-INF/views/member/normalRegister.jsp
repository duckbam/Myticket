<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:url var="root" value="/" />
<!doctype html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!--===============================================================================================-->
<link rel="icon" type="image/png"
	href="resources/images/icons/favicon.ico" />
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css"
	href="resources/vendor/bootstrap/css/bootstrap.min.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css"
	href="resources/fonts/font-awesome-4.7.0/css/font-awesome.min.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css"
	href="resources/fonts/Linearicons-Free-v1.0.0/icon-font.min.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css"
	href="resources/vendor/animate/animate.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css"
	href="resources/vendor/css-hamburgers/hamburgers.min.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css"
	href="resources/vendor/animsition/css/animsition.min.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css"
	href="resources/vendor/select2/select2.min.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css"
	href="resources/vendor/daterangepicker/daterangepicker.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css" href="resources/css/util.css">
<link rel="stylesheet" type="text/css" href="resources/css/main.css">
<!--===============================================================================================-->
</head>
<script>
	function sendAuth() {
		var e = document.getElementById('email').value;
		if (e == "") {
			$('#msg').text('이메일을 입력하세요.');
			return;
		}
		var s = {
			email : e
		}
		$.ajax({
			url : "sendAuth",
			type : "POST",
			data : JSON.stringify(s),
			contentType : "application/json;charset=utf-8",
			dataType : "json",
			success : function(result) {
				$('#msg').text(result.msg)
			},
			error : function() {
				$('#msg').text('Error')
			}
		})
	}

	function sendAuthConfirm() {
		var i = document.getElementById('inputAuthNum').value;
		if (i == "") {
			$('#msg').text('인증번호를 입력하세요.');
			return;
		}
		var s = {
			inputAuthNum : i
		}
		$.ajax({
			url : "authConfirm",
			type : "POST",
			data : JSON.stringify(s),
			contentType : "application/json;charset=utf-8",
			dataType : "json",
			success : function(result) {
				$('#msg').text(result.msg)
			},
			error : function() {
				$('#msg').text('Error')
			}
		})
	}
	 function numberMaxLength(e){
	        if(e.value.length > e.maxLength){
	            e.value = e.value.slice(0, e.maxLength);
	        }
	    }
</script>
<body>
	<div class="limiter">
		<div class="container-login100">
			<div class="wrap-login100 p-l-85 p-r-85 p-t-55 p-b-55">
				<form class="login100-form validate-form flex-sb flex-w" action="normalRegisterProc" method="post">
					<span class="login100-form-title p-b-32"> 마이티켓 일반 회원가입 </span> <span
						class="txt1 p-b-11"> 아이디 </span>
					<div class="wrap-input100 validate-input m-b-36"
						data-validate="아이디를 입력하세요!">
						<input class="input100" type="text" name="id" id="id"> 
						<span class="focus-input100"></span>
					</div>

					<span class="txt1 p-b-11"> 패스워드 </span>
					<div class="wrap-input100 validate-input m-b-36"
						data-validate="패스워드를 입력하세요!">
						<span class="btn-show-pass"> <i class="fa fa-eye"></i>
						</span> <input class="input100" type="password" name="pw" id="pw"> 
						<span class="focus-input100"></span>
					</div>

					<span class="txt1 p-b-11"> 패스워드 확인 </span>
					<div class="wrap-input100 validate-input m-b-36"
						data-validate="패스워드 확인을 입력하세요!">
						<span class="btn-show-pass"> <i class="fa fa-eye"></i>
						</span> <input class="input100" type="password" name="pwCheck" id="pwCheck"> 
						<span class="focus-input100"></span>
					</div>

					<span class="txt1 p-b-11"> 이름 </span>
					<div class="wrap-input100 validate-input m-b-36"
						data-validate="이름을 입력하세요!">
						<input class="input100" type="text" name="name" id="name"> 
						<span class="focus-input100"></span>
					</div>
					
					<span class="txt1 p-b-11"> 생년월일 </span>
					<div class="wrap-input100 validate-input m-b-36"
						data-validate="생년월일을 입력하세요!">
						<input class="input100" type="date" name="birth" id="birth"> 
						<span class="focus-input100"></span>
					</div>
					
					<span class="txt1 p-b-11"> 성별 </span>
					<div class="btn-group m-b-36" role="group">
					    <input type="radio" name="gender" value="m" class="btn-check" id="m" checked="checked">
					    <label class="btn btn-outline-dark" for="m">남성</label>
					
					    <input type="radio" name="gender" value="w" class="btn-check" id="w">
					    <label class="btn btn-outline-dark" for="w">여성</label>
					</div>
					
					<span class="txt1 p-b-11 w-100"></span>
					<span class="txt1 p-b-11"> 이메일 </span>
					<div class="wrap-input100 validate-input" data-validate="이메일을 입력하세요!">
						<input class="input100" type="email" aria-describedby="emailHelp" name="email" id="email"> 
						<span class="focus-input100"></span>
					</div>
					<button type="button" class="btn btn-dark m-b-36" onclick="sendAuth()" >인증번호전송</button>
					<font color="red" id="msg">${msg }</font>
					<span class="txt1 p-b-11 w-100"></span>
					<span class="txt1 p-b-11"> 인증번호 </span>
					<div class="wrap-input100 validate-input" data-validate="인증번호를 입력하세요!">
						<input class="input100" type="number" maxlength="6" oninput="numberMaxLength(this);" name='authNum' id="inputAuthNum"> 
						<span class="focus-input100"></span>
					</div>
					<button type="button" class="btn btn-dark m-b-36" onclick="sendAuthConfirm()">이메일 인증</button>
					
					<span class="txt1 p-b-11 w-100"></span>
					<span class="txt1 p-b-11"> 휴대폰 번호 </span>
					<div class="wrap-input100 validate-input m-b-36"
						data-validate="휴대폰 번호를 입력하세요!">
						<input class="input100" type="number" maxlength="11" name="phone" id="phone" 
						oninput="numberMaxLength(this);" placeholder="-없이 입력"> 
						<span class="focus-input100"></span>
					</div>
					
					<div class="container-login100-form-btn">
						<button class="login100-form-btn">회원가입</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	<div id="dropDownSelect1"></div>

	<!--===============================================================================================-->
	<script src="resources/vendor/jquery/jquery-3.2.1.min.js"></script>
	<!--===============================================================================================-->
	<script src="resources/vendor/animsition/js/animsition.min.js"></script>
	<!--===============================================================================================-->
	<script src="resources/vendor/bootstrap/js/popper.js"></script>
	<script src="resources/vendor/bootstrap/js/bootstrap.min.js"></script>
	<!--===============================================================================================-->
	<script src="resources/vendor/select2/select2.min.js"></script>
	<!--===============================================================================================-->
	<script src="resources/vendor/daterangepicker/moment.min.js"></script>
	<script src="resources/vendor/daterangepicker/daterangepicker.js"></script>
	<!--===============================================================================================-->
	<script src="resources/vendor/countdowntime/countdowntime.js"></script>
	<!--===============================================================================================-->
	<script src="resources/js/main.js"></script>
</body>
</html>
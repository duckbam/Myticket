<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!doctype html>
<head>
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- Bootstrap CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">

</head>
<style>
table {
    margin-left:auto; 
    margin-right:auto;
}
</style>
<script>
function sellerDelete() {
    if (!confirm("탈퇴 후 계정을 복구할 수 없습니다. 탈퇴하시겠습니까?")) {
    } else {
    	alert("지금까지 마이티켓을 이용해주셔서 감사합니다.");
    	document.getElementById('f').submit();
    }
}
</script>
<body>
	<h3>마이페이지 | 회원탈퇴</h3>
		<h5 style="text-align: center">
		<font color="red" id="msg">${msg }</font>
		</h5>
	<form id='f' action=sellerDeleteProc?sellerId=${sellerId} method="post">
		<table style="margin-bottom: 140px; margin-top: 80px;">
			<tr>
				<td>패스워드</td>
				<td><input type=password name='pw' placeholder='패스워드' class="form-control"/></td>
			</tr>
				<tr>
				<td>패스워드확인</td>
				<td><input type=password name='pwCheck' placeholder='패스워드 확인' class="form-control"/></td>
			</tr>
			<tr>
				<td align='center' height=40 colspan=4><input type=button
					value='탈퇴' onclick="sellerDelete()" class="btn btn-secondary" style="width: 120px;" /> <input type=reset value='취소'
					class="btn btn-secondary" onclick="location.href='sellerMypage'" style="width: 120px;" /></td>
			</tr>
		</table>
	</form>

	<!-- Optional JavaScript; choose one of the two! -->

	<!-- Option 1: Bootstrap Bundle with Popper -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
		crossorigin="anonymous"></script>

	<!-- Option 2: Separate Popper and Bootstrap JS -->
	<!--
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js" integrity="sha384-7+zCNj/IqJ95wo16oMtfsKbZ9ccEh31eOz1HGyDuCQ6wgnyJNSYdrPa03rtR1zdB" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js" integrity="sha384-QJHtvGhmr9XOIpI6YVutG+2QOK9T+ZnN4kzFN1RtK3zEFEIsxhlmWl5/YESvpZ13" crossorigin="anonymous"></script>
    -->
</body>

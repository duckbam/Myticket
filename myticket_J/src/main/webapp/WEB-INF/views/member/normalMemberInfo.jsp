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
</style>
<script>
function normalDelete() {
    if (!confirm("삭제 후 계정을 복구할 수 없습니다. 삭제하시겠습니까?")) {
    } else {
    	alert("[일반] ${normalInfo.getId()} 계정이 삭제되었습니다.");
    	location.href='adminNormalDeleteProc?normalId=${normalInfo.getId()}'
    }
}
</script>
<body>
	<table class="table" style="margin-bottom: 31px;">
		<thead>
			<tr>
				<th scope="col">정보</th>
				<th scope="col">내용</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<th scope="row">아이디</th>
				<td>${normalInfo.getId()}</td>
			</tr>
			<tr>
				<th scope="row">이름</th>
				<td>${normalInfo.getName()}</td>
			</tr>
			<tr>
				<th scope="row">휴대폰 번호</th>
				<td>${normalInfo.getPhone()}</td>
			</tr>
			<tr>
				<th scope="row">이메일</th>
				<td>${normalInfo.getEmail()}</td>
			</tr>
			<tr>
				<th scope="row">생년월일</th>
				<td>${normalInfo.getBirth()}</td>
			</tr>
			<tr>
				<th scope="row">성별</th>
				<c:if test="${normalInfo.getGender() == 'm'}">
					<td>남성</td>
				</c:if>
				<c:if test="${normalInfo.getGender() == 'w'}">
					<td>여성</td>
				</c:if>
			</tr>
			<tr>
				<th scope="row">계정 종류</th>
				<td>일반</td>
			</tr>
		</tbody>
	</table>
	<button type="button" class="btn btn-secondary" onclick="location.href='memberManage'">목록</button>
	<button type="button" class="btn btn-secondary" onclick="location.href='adminNormalModify?normalId=${normalInfo.getId()}'">수정</button>
	<button type="button" class="btn btn-secondary" onclick="normalDelete()">삭제</button>

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

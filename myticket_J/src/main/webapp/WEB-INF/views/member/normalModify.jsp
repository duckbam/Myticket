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
function numberMaxLength(e){
    if(e.value.length > e.maxLength){
        e.value = e.value.slice(0, e.maxLength);
    }
}
</script>
<body>
	<h3>마이페이지 | 정보수정</h3>
		<h5 style="text-align: center">
		<font color="red" id="msg">${msg }</font>
		</h5>
	<form action=normalModifyProc?normalId=${normalInfo.getId()} method="post">
		<table>
			<tr>
				<td><label for="basic-url">아이디</label></td>
				<td><input type=text name='id'
					value='${normalInfo.getId()}' readonly="readonly" class="form-control"/></td>
				<td colspan="2"></td>
			</tr>
			<tr>
				<td>패스워드</td>
				<td><input type=password name='pw' placeholder='패스워드' class="form-control"/></td>
			</tr>
				<tr>
				<td>패스워드확인</td>
				<td><input type=password name='pwCheck' placeholder='패스워드 확인' class="form-control"/></td>
			</tr>
			
			<tr>
				<td>이름</td>
				<td><input type=text name='name' id="name"
					value="${normalInfo.getName()}" class="form-control"/></td>
				<td colspan="2"></td>
			</tr>
			
			<tr>
				<td>E-Mail</td>
				<td><input type=email name='email' id="email"
					value="${normalInfo.getEmail()}" class="form-control" readonly="readonly"/></td>
				<td colspan="2"></td>
			</tr>
			<tr>
				<td>휴대폰 번호</td>
				<td><input type=number name='phone' id="phone"
					value="${normalInfo.getPhone()}" class="form-control" maxlength="11"
					oninput="numberMaxLength(this);"/></td>
				<td colspan="2"></td>
			</tr>
			<tr>
				<td>생년월일</td>
				<td><input type=date name='birth' id="birth"
					value="${normalInfo.getBirth()}" class="form-control"/></td>
				<td colspan="2"></td>
			</tr>
			<tr>
				<td>성별</td>
				<td>
				<c:if test="${normalInfo.getGender() == 'm' }">
						<input type=radio class="form-check-input" name='gender' value='m' checked="checked" />남자
						<input type=radio class="form-check-input" name='gender' value='w' disabled="disabled" />여자 
				</c:if> 
				<c:if test="${normalInfo.getGender() == 'w' }">
						<input type=radio class="form-check-input" name='gender' value='m' disabled="disabled" />남자
						<input type=radio class="form-check-input" name='gender' value='w' checked="checked" />여자 
				</c:if>
				</td>
				<td colspan="2"></td>
			</tr>
		 <%-- 	<tr>
				<td>우편번호</td>
				<td><input type=text name='zipcode' id="zipcode"
					value="${normalInfo.getZipcode()}" readonly="readonly" class="form-control" /></td>
				<td colspan="2"><input type="button" class="btn btn-secondary" value="우편번호 검색"
					onclick="daumPost()"></td>
			</tr>
			<tr>
				<td>주소</td>
				<td colspan="3"><input type=text name='addr1' id="addr1"
					value="${modifyAll.addr1 }" readonly="readonly"
					class="form-control" style="width: 475px;" /></td>
			</tr>
			<tr>
				<td>상세주소</td>
				<td colspan="3"><input type=text name='addr2' id="addr2"
					value="${modifyAll.addr2 }" style="width: 475px;" class="form-control" /></td>
			</tr> --%>
			<tr>
				<td align='center' height=40 colspan=4><input type=submit
					value='수정' class="btn btn-secondary" style="width: 120px;" /> <input type=button value='취소'
					class="btn btn-secondary" onclick="location.href='${root}index?formpath=normalMypage'"style="width: 120px;" /></td>
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

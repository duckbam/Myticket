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
<body>
	<ul class="nav nav-tabs" id="myTab" role="tablist">
		<li class="nav-item" role="presentation">
			<button class="nav-link active" id="home-tab" data-bs-toggle="tab"
				data-bs-target="#home" type="button" role="tab" aria-controls="home"
				aria-selected="true" style="color: black;">일반 회원</button>
		</li>
		<li class="nav-item" role="presentation">
			<button class="nav-link" id="profile-tab" data-bs-toggle="tab"
				data-bs-target="#profile" type="button" role="tab"
				aria-controls="profile" aria-selected="false" style="color: black;">판매자
				회원</button>
		</li>
	</ul>
	<div class="tab-content" id="myTabContent">
		<div class="tab-pane fade show active" id="home" role="tabpanel"
			aria-labelledby="home-tab">
			<c:set var="normalCount" value="${0 }" />
			<c:if test="${ normalDB.isEmpty() == false}">
				<table class="table">
					<thead>
						<tr>
							<th scope="col">아이디</th>
							<th scope="col">이름</th>
							<th scope="col">이메일</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="dto" items="${normalDB }">
							<c:set var="normalCount" value="${normalCount+1 }" />
							<tr>
								<td><a href="normalMemberInfo?info=${dto.getId()}" style="color: black; text-decoration-line: none;">${dto.getId()}</a></td>
								<td>${dto.getName()}</td>
								<td>${dto.getEmail()}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</c:if>
			total: ${normalCount}
		</div>
		<div class="tab-pane fade" id="profile" role="tabpanel"
			aria-labelledby="profile-tab">
			<c:set var="sellerCount" value="${0 }" />
			<c:if test="${ sellerDB.isEmpty() == false}">
				<table class="table">
					<thead>
						<tr>
							<th scope="col">아이디</th>
							<th scope="col">기업명</th>
							<th scope="col">이메일</th>
							<th scope="col">사업자등록번호</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="dto2" items="${sellerDB }">
							<c:set var="sellerCount" value="${sellerCount+1 }" />
							<tr>
								<td><a href="sellerMemberInfo?info=${dto2.getId()}" style="color: black; text-decoration-line: none;">${dto2.getId()}</a></td>
								<td>${dto2.getCompany()}</td>
								<td>${dto2.getEmail()}</td>
								<td>${dto2.getTin()}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</c:if>
			total: ${sellerCount}
		</div>
	</div>

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

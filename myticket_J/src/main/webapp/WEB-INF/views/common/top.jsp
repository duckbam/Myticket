<%@page import="javax.mail.Session"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:url var="root" value="/" />
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
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<div class="container-fluid">
			<a class="navbar-brand" href="${root}index?formpath=home"><img
				src="resources/img/logo.png"></a>
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
				aria-controls="navbarSupportedContent" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarSupportedContent">
				<ul class="navbar-nav me-auto mb-2 mb-lg-0">
					<li class="nav-item"><a class="nav-link" href="${root}index?formpath=movie"><img
							src="resources/img/movie.png"></a></li>
					<li class="nav-item"><a class="nav-link" href="${root}index?formpath=theater"><img
							src="resources/img/theater.png"></a></li>
					<li class="nav-item"><a class="nav-link" href="${root}index?formpath=concert"><img
							src="resources/img/concert.png"></a></li>
					<li class="nav-item"><a class="nav-link" href="${root}index?formpath=sports"><img
							src="resources/img/sport.png"></a></li>
					<li class="nav-item"><a class="nav-link" href="${root}index?formpath=leisure"><img
							src="resources/img/leisure.png"></a></li>
				</ul>
				<form class="d-flex">
					<c:choose>
						<c:when test="${id.isEmpty() == false && type == 'admin'}">
							<a class="nav-link" href="#" style="color:black">[관리자] ${id}님</a>
							<button type="button" class="btn btn-secondary" onclick="location.href='${root}index?formpath=adminPage'">관리페이지</button>
							<button type="button" class="btn btn-dark" onclick="location.href='logout'">로그아웃</button>
							<button type="button" class="btn btn-dark" onclick="location.href='${root}centerProc'">고객센터</button>
						</c:when>
						<c:when test="${id.isEmpty() == false && type == 'normal'}">
							<a class="nav-link" href="#" style="color:black">[일반] ${id}님</a>
							<button type="button" class="btn btn-secondary" onclick="location.href='normalMypage'">마이페이지</button>
							<button type="button" class="btn btn-dark" onclick="location.href='logout'">로그아웃</button>
							<button type="button" class="btn btn-dark" onclick="location.href='${root}centerProc'">고객센터</button>
						</c:when>
						<c:when test="${id.isEmpty() == false && type == 'seller'}">
							<a class="nav-link" href="#" style="color:black">[판매자] ${id}님</a>
							<button type="button" class="btn btn-secondary" onclick="location.href='sellerMypage'">마이페이지</button>
							<button type="button" class="btn btn-dark" onclick="location.href='logout'">로그아웃</button>
							<button type="button" class="btn btn-dark" onclick="location.href='${root}centerProc'">고객센터</button>
						</c:when>
						<c:otherwise>
							<button type="button" class="btn btn-secondary" onclick="location.href='${root}index?formpath=loginSelect'">로그인</button>
							<button type="button" class="btn btn-dark" onclick="location.href='${root}index?formpath=registerSelect'">회원가입</button>
							<button type="button" class="btn btn-dark" onclick="location.href='${root}centerProc'">고객센터</button>
						</c:otherwise>
					</c:choose>
				</form>
			</div>
		</div>
	</nav>
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

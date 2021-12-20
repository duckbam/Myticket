<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page session="false"%>
<c:url var="root" value="/"/>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
	$("document").ready(function(){
		$("div.saleCode").css("cursor", "pointer").click(function(){
			let saleCode = $(this).attr("id");
			$("#saleCode").val(saleCode);
			$("#f").attr("action", "${root}bookingProc");
			$("#f").submit();
		})
	});
</script>
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
body {
	overflow-x: hidden;
}

#wrapper {
	padding-left: 0;
	-webkit-transition: all 0.5s ease;
	-moz-transition: all 0.5s ease;
	-o-transition: all 0.5s ease;
	transition: all 0.5s ease;
}

#wrapper.toggled {
	padding-left: 250px;
}

#sidebar-wrapper {
	z-index: 1000;
	position: fixed;
	left: 250px;
	width: 0;
	height: 100%;
	margin-left: -250px;
	overflow-y: auto;
	background: #000;
	-webkit-transition: all 0.5s ease;
	-moz-transition: all 0.5s ease;
	-o-transition: all 0.5s ease;
	transition: all 0.5s ease;
}

#wrapper.toggled #sidebar-wrapper {
	width: 250px;
}

#page-content-wrapper {
	width: 100%;
	position: absolute;
	padding: 15px;
}

#wrapper.toggled #page-content-wrapper {
	position: absolute;
	margin-right: -250px;
}

/* Sidebar Styles */
.sidebar-nav {
	position: absolute;
	top: 0;
	width: 250px;
	margin: 0;
	padding: 0;
	list-style: none;
}

.sidebar-nav li {
	text-indent: 20px;
	line-height: 40px;
}

.sidebar-nav li a {
	display: block;
	text-decoration: none;
	color: #999999;
}

.sidebar-nav li a:hover {
	text-decoration: none;
	color: #fff;
	background: rgba(255, 255, 255, 0.2);
}

.sidebar-nav li a:active, .sidebar-nav li a:focus {
	text-decoration: none;
}

.sidebar-nav>.sidebar-brand {
	height: 65px;
	font-size: 18px;
	line-height: 60px;
}

.sidebar-nav>.sidebar-brand a {
	color: #999999;
}

.sidebar-nav>.sidebar-brand a:hover {
	color: #fff;
	background: none;
}

@media ( min-width :768px) {
	#wrapper {
		padding-left: 0;
	}
	#wrapper.toggled {
		padding-left: 250px;
	}
	#sidebar-wrapper {
		width: 0;
	}
	#wrapper.toggled #sidebar-wrapper {
		width: 250px;
	}
	#page-content-wrapper {
		padding: 20px;
		position: relative;
	}
	#wrapper.toggled #page-content-wrapper {
		position: relative;
		margin-right: 0;
	}
}
</style>
<body>
	<div id="wrapper" class="toggled">

		<div id="sidebar-wrapper">
			<ul class="sidebar-nav">
				<li class="sidebar-brand"><a href="${root}index?formpath=concert"> 콘서트 </a></li>
				<li><a href="${root}index?formpath=concert?category=01">발라드</a></li>
				<li><a href="${root}index?formpath=concert?category=02">락/메탈</a></li>
				<li><a href="${root}index?formpath=concert?category=03">랩/힙합</a></li>
				<li><a href="${root}index?formpath=concert?category=04">재즈/소울</a></li>
			</ul>
		</div>
		<div id="page-content-wrapper">
			<div class="container-fluid">
				<form id="f" action="" method="post">
					<input type="hidden" name="saleCode" id="saleCode">
					<table class="table">
					<colgroup>
						<col width="20%">
						<col width="15%">
						<col width="65%">
					</colgroup>
					<thead>
						<tr>
						    <th colspan="3">${concertView.name} [${concertView.saleCode}]</th>
					   	</tr>
					</thead>
					<tbody>
						<tr>
							<td rowspan="11">
								<c:if test='${not empty concertView.img && concertView.img != "없음" }'>
									<img alt="titleImage" src="${root}/display?fileName=${concertView.img}&regDate=${concertView.regDate}" style="width: 300px; height: 390px;">
								</c:if>	
							</td>
						</tr>
						<tr>
							<td>상품 명 </td>
							<td>${concertView.name}</td>
						</tr>
						<tr>
							<td>상품 코드 </td>
							<td>${concertView.saleCode}</td>
						</tr>
						<tr>
							<td>판매자 </td>
							<td>${concertView.id}</td>
						</tr>
						<tr>
							<td>장소명 </td>
							<td>${concertView.place}</td>
						</tr>
						<tr>
							<td>주소 </td>
							<td>${concertView.addr1} ${concertView.addr2}</td>
						</tr>
						<tr>
							<td>공연 시작 날짜 </td>
							<td>${concertView.startDate}</td>
						</tr>
						<tr>
							<td>공연 종료 날짜 </td>
							<td>${concertView.endDate}</td>
						</tr>
						<tr>
							<td>관람 나이 </td>
							<c:choose>
								<c:when test="${concertView.age == 0}">
									<td>전체 관람</td>
								</c:when>
								<c:otherwise>
									<td>${concertView.age}세 관람</td>
								</c:otherwise>
							</c:choose>
							
						</tr>
						<tr>
							<td>잔여 좌석 </td>
							<td>${concertView.seat}</td>
						</tr>
						<tr>
							<td>가격 </td>
							<td><fmt:formatNumber type="number" value="${concertView.price}"/>원</td>
						</tr>
						
						<tr>
							<td style="height: 300px;" colspan="3"><h4><b>상품 소개</b></h4><br> ${concertView.content}</td>
						</tr>
					</tbody>
				</table>
				<div class="d-grid gap-2 d-md-flex justify-content-md-end">
					<c:choose>
							<c:when test="${concertView.seat == 0}">
								<p>판매가 끝났습니다. 다음에 또 이용해주세요.</p>
								<input type="button" value="돌아가기" style="width: 80px; background-color: #D5D5D5; border: none; border-radius: 3px; font-weight: bold;" onclick="location.href='${root}index?formpath=concert'">
							</c:when>
							<c:otherwise>
								<div id="${concertView.saleCode}" class="saleCode" style="padding:10px; width: 85px; display: inline; background-color: #D5D5D5; border: none; border-radius: 3px; font-weight: bold;">예약하기</div>
								<input type="button" value="돌아가기"  style="width: 80px; background-color: #D5D5D5; border: none; border-radius: 3px; font-weight: bold;" onclick="location.href='${root}index?formpath=concert'">
							</c:otherwise>
					</c:choose>
				</div>		
				</form>	
			</div>
		</div>

	</div>

	<!-- Footer -->
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

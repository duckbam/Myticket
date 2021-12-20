<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:url var="root" value="/"/>
<c:if test="${empty sessionScope.id}">
	<script>
		alert('로그인 후 이용하실 수 있습니다.')
		location.href = 'index?formpath=normalLogin'
	</script>
</c:if>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
	$("document").ready(function(){
		$("div.bNum").css("cursor", "pointer").click(function(){
			let bNum = $(this).attr("id");
			$("#bNum").val(bNum);
			$("#f").attr("action", "${root}bookCancelProc");
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
				<li class="sidebar-brand"><a href="normalMypage">마이페이지</a></li>
				<li><a href="${root}index?formpath=bookList">예약내역</a></li>
				<li><a href="normalModify">정보수정</a></li>
				<li><a href="normalDelete">회원탈퇴</a></li>
			</ul>
		</div>
		<div id="page-content-wrapper">
			<div class="container-fluid">
			<h2><b>상세 정보</b></h2><br>
			<form id="f" action="" method="post">
			<input type="hidden" name="bNum" id="bNum">
			<table class="table">
					<colgroup>
						<col width="20%">
						<col width="25%">
						<col width="65%">
					</colgroup>
					<thead>
						<tr>
						    <th colspan="3">${view.bName}[예약번호 : ${view.bNum}]</th>
					   	</tr>
					</thead>
					<tbody>
						<tr>
							<td rowspan="8">
									<c:if test='${not empty viewImg.img && viewImg.img != "없음" }'>
									<img alt="titleImage" src="${root}/display?fileName=${viewImg.img}&regDate=${viewImg.regDate}" style="width: 300px; height: 390px;">
								</c:if>	
							</td>
						</tr>
						<tr>
							<td>상품명 </td>
							<td>${view.bName}</td>
						</tr>
						<tr>
							<td>공연 일자 </td>
							<td>${viewImg.startDate} ~ ${viewImg.endDate}</td>
						</tr>
						<tr>
							<td>예약 일자</td>
							<td>${view.bWatch}</td>
						</tr>
						<tr>
							<td>예약 매수 </td>
							<td>${view.bTicket}매</td>
						</tr>
						<tr>
							<td>예약한 날짜 / 취소 가능 날짜 </td>
							<td>${view.bToday} / ${view.bCancel}</td>
						</tr>
							<c:choose>
								<c:when test="${view.bState == 'b'}">
									<tr>
										<td>예약 여부</td>
										<td>예약 중</td>
									</tr>
									<tr>
										<td style="height: 300px;" colspan="3"><h4><b>&nbsp;취소 안내</b></h4><br>&nbsp;취소 가능 날짜인 ${view.bCancel}까지 취소 가능합니다.<br><br>&nbsp;취소 시 수수료가 부가될 수 있습니다</td>
									</tr>
								</c:when>
								<c:otherwise>
									<tr>
										<td>예약 여부</td>
										<td>예약 취소</td>
									</tr>
									<tr>
										<td style="height: 300px;" colspan="3"><h4><b>&nbsp;취소 안내</b></h4><br>&nbsp;취소가 완료되었습니다.<br><br>&nbsp;취소한 이후 다시 예약을 되돌릴 수 없습니다.<br><br>&nbsp;다시 이용을 원하시면 재구매를 해주세요. </td>
									</tr>
								</c:otherwise>
							</c:choose>
					</tbody>
				</table>
				<div class="d-grid gap-2 d-md-flex justify-content-md-end">
					<c:choose>
						<c:when test="${view.bState == 'b'}">
							<input type="button" value="확인" style="width: 80px;background-color: #D5D5D5; border: none; border-radius: 3px; font-weight: bold;" onclick="location.href='bookList'">
							<div id="${view.bNum}" class="bNum" style="padding:10px; width: 85px; display: inline; background-color: #D5D5D5; border: none; border-radius: 3px; font-weight: bold;" >취소하기</div>
						</c:when>
						<c:otherwise>
							<input type="button" value="확인" style="width: 80px;background-color: #D5D5D5; border: none; border-radius: 3px; font-weight: bold;" onclick="location.href='bookList'">
						</c:otherwise>
					
					</c:choose>
				</div>		
			</form>	
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

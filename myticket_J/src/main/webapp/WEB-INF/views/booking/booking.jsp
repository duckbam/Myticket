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
<c:if test="${type == 'admin' || type == 'seller'}">
	<script>
		alert('판매자/관리자는 예약기능을 이용할 수 없습니다.')
		location.href = 'index?formpath=home'
	</script>
</c:if>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
	$("document").ready(function(){
		$("div.saleCode").css("cursor", "pointer").click(function(){
			let saleCode = $(this).attr("id");
			$("#saleCode").val(saleCode);
			$("#f").attr("action", "${root}bookProc");
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
			<c:if test="${categoryTab == '영화' }">
				<li class="sidebar-brand"><a href="${root}index?formpath=movie"> 영화 </a></li>
				<li><a href="${root}index?formpath=movie?category=01">액션</a></li>
				<li><a href="${root}index?formpath=movie?category=02">멜로/로맨스</a></li>
				<li><a href="${root}index?formpath=movie?category=03">범죄/스릴러</a></li>
				<li><a href="${root}index?formpath=movie?category=04">코미디</a></li>
				<li><a href="${root}index?formpath=movie?category=05">공포(호러)</a></li>
				<li><a href="${root}index?formpath=movie?category=06">SF/판타지</a></li>
				<li><a href="${root}index?formpath=movie?category=07">애니메이션</a></li>
			</c:if>
			<c:if test="${categoryTab == '연극' }">
				<li class="sidebar-brand"><a href="${root}index?formpath=theater"> 연극 </a></li>
				<li><a href="${root}index?formpath=theater">연극</a></li>
			</c:if>
			<c:if test="${categoryTab == '콘서트' }">
				<li class="sidebar-brand"><a href="${root}index?formpath=concert"> 콘서트 </a></li>
				<li><a href="${root}index?formpath=concert?category=01">발라드</a></li>
				<li><a href="${root}index?formpath=concert?category=02">락/메탈</a></li>
				<li><a href="${root}index?formpath=concert?category=03">랩/힙합</a></li>
				<li><a href="${root}index?formpath=concert?category=04">재즈/소울</a></li>
			</c:if>
			<c:if test="${categoryTab == '스포츠' }">
				<li class="sidebar-brand"><a href="${root}index?formpath=sports"> 스포츠 </a></li>
				<li><a href="${root}index?formpath=sports?category=01">야구</a></li>
				<li><a href="${root}index?formpath=sports?category=02">축구</a></li>
				<li><a href="${root}index?formpath=sports?category=03">농구</a></li>
				<li><a href="${root}index?formpath=sports?category=04">배구</a></li>
				<li><a href="${root}index?formpath=sports?category=05">e스포츠</a></li>
			</c:if>
			<c:if test="${categoryTab == '레저' }">
				<li class="sidebar-brand"><a href="${root}index?formpath=leisure"> 레저 </a></li>
				<li><a href="${root}index?formpath=leisure?category=01">워터파크/스파</a></li>
				<li><a href="${root}index?formpath=leisure?category=02">스키/눈썰매</a></li>
				<li><a href="${root}index?formpath=leisure?category=03">캠핑/휴양림</a></li>
			</c:if>
				
			</ul>
		</div>
		<div id="page-content-wrapper">
			<div class="container-fluid">
					<form id="f" action="" method="post">
					<input type="hidden" name="saleCode" id="saleCode">
						<table class="table">
							<colgroup>
							<col width="20%">
							<col width="25%">
							<col width="65%">
							</colgroup>
								<tr>
								    <th colspan="2" style="text-align: center; width: 500px;"><h2><b>예약 확정하기</b></h2></th>
							   	</tr>

								<tr>
									<td style="text-align: center;">상품 명 </td>
									<td style="text-align: left;">${booking.name}</td>
								</tr>
								<tr>
									<td style="text-align: center;">상품 코드 </td>
									<td style="text-align: left;">${booking.saleCode}</td>
								</tr>
								<tr>
								    <td style="text-align: center;">구매자 ID</td>
								    <td style="text-align: left;"><input type="text" id="bookId" name="bookId" value="${sessionScope.id}" disabled="disabled"></td>
							   	</tr>
							   	<tr>
								    <td style="text-align: center;">구매자 이름</td>
								    <td style="text-align: left;"><input type="text" id="bookName" name="bookName" value="${member.name}" placeholder="구매자 이름"> *필수항목</td> 
							   	</tr>
							   	<tr>
								    <td style="text-align: center;">구매자 핸드폰번호</td>
								    <td style="text-align: left;"><input type="text" id="bookPhone" name="bookPhone" value="${member.phone}"placeholder="구매자 핸드폰번호"> *필수항목</td>
							   	</tr>
								<tr>
									<td style="text-align: center;">공연 날짜 선택</td>
									<td style="text-align: left;"><input type="date" id="bookDate" name="bookDate" min="${booking.startDate}" max="${booking.endDate}" placeholder="${booking.startDate}" /></td>
								</tr>
								<tr>
									<td style="text-align: center;">관람 나이 </td>
										<c:choose>
											<c:when test="${booking.age == 0}">
												<td style="text-align: left;">전체 관람</td>
											</c:when>
											<c:otherwise>
												<td style="text-align: left;">${booking.age}세 관람</td>
											</c:otherwise>
										</c:choose>
								</tr>
								<tr>
									<td style="text-align: center;">잔여 좌석 </td>
									<td style="text-align: left;">${booking.seat}</td>
								</tr>
								<tr>
									<td style="text-align: center;">구매 매수 </td>
									<td style="text-align: left;"><input type="text" id="bookCount" name="bookCount" style="width: 80px;" placeholder="구매 매수"> *필수항목</td>
								</tr>
								<tr>
									<td style="text-align: center;">가격 </td>
									<td style="text-align: left;"><fmt:formatNumber type="number" value="${booking.price}"/>원</td>
								</tr>
								
								<tr>
									<td style="height: 200px;" colspan="2"><h4><b>&nbsp;예약 확정 안내</b></h4><br>&nbsp;예약 내용을 확인해주세요.<br><br>&nbsp;*필수항목을 입력하지 않으면 예약 확정 되지 않습니다. <br><br>&nbsp;문의를 원하실때에는 고객센터를 이용해주세요.
									<br><br><br><a href="${root}centerProc" style="text-decoration: none; color: black;"><h4>고객센터</h4></a></td>
								</tr>
						</table>
							<div id="${booking.saleCode}" class="saleCode" style="padding:10px; width: 150px; height: 180px; display: inline; background-color: #D5D5D5; border: none; border-radius: 3px; font-weight: bold;" >예약 확정 하기
							</div>
							&nbsp;&nbsp;
							<input type="button" value="취소" style="width: 80px; padding:10px; background-color: #D5D5D5; border: none; border-radius: 3px; font-weight: bold;" onclick="location.href='${root}index?formpath=home'">
								
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

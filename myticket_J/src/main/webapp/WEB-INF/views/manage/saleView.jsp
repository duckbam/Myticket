<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt"%>
<%@ page session="false"%>
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
	#wrapper {margin: 0 auto; width: 50%;}
</style>
<script type="text/javascript">
	function GetsGenreName() {
		var movie = ["전체","액션","멜로/로맨스","범죄/스릴러","코미디","공포/호러","SF/판타지","애미메이션"];
		var theater = ["전체","연극"];
		var concert = ["전체","발라드","락/메탈","랩/힙합","재즈/소울"];
		var sports = ["전체","야구","축구","농구","배구","e스포츠"];
		var leisure = ["전체","워터파크/스파","스키/눈썰매","캠핑/휴양림"];
		
		var category = '<c:out value="${searchDto.category}"/>';
		var sGenre = parseInt('<c:out value="${sale.sGenre}"/>');
		var getName;
		
		switch(category){
		case'movie': getName = movie[sGenre]; break;
		case'theater': getName = theater[sGenre]; break;
		case'concert': getName = concert[sGenre]; break;
		case'sports': getName = sports[sGenre]; break;
		case'leisure': getName = leisure[sGenre]; break;
		default : break;	
		}
		
		document.write(getName);
	}
</script>
<body>
<c:if test="${not empty msg}"><script>alert("${msg}")</script></c:if>
	<div id="wrapper">
		<div id="page-content-wrapper">
			<h2><b>상세 정보</b></h2><br>
			<form name="form" id="form" role="form" method="post">
				<table class="table">
					<colgroup>
						<col width="20%">
						<col width="15%">
						<col width="65%">
					</colgroup>
					<thead>
						<tr>
						    <th colspan="3">${sale.name}[${sale.saleCode}]</th>
					   	</tr>
					</thead>
					<tbody>
						<tr>
							<td rowspan="8">
								<c:if test='${not empty sale.img && sale.img != "없음" }'>
									<img alt="titleImage" src="${root}/display?fileName=${sale.img}&regDate=${sale.regDate}" style="width: 300px; height: 390px;">
								</c:if>	
							</td>
							<td>장르 </td>
							<td><script type="text/javascript">GetsGenreName();</script></td>
						</tr>
						<tr>
							<td>등록일 </td>
							<td>${sale.regDate}</td>
						</tr>
						<tr>
							<td>판매자 </td>
							<td>${sale.id}</td>
						</tr>
						<tr>
							<td>장소 </td>
							<td>${sale.place}<br>[${sale.zipcode}]${sale.addr1}<br>${sale.addr2}</td>
						</tr>
						<tr>
							<td>기간 </td>
							<td>${sale.startDate} ~ ${sale.endDate}</td>
						</tr>
						<tr>
							<td>이용연령 </td>
							<td>
								<c:if test="${sale.age == 0}">
									전체 이용가
								</c:if>
								<c:if test="${sale.age != 0}">
									${sale.age}세이상 이용가능
								</c:if>
							</td>
						</tr>
						<tr>
							<td>가격 </td>
							<td>
								<fmt:formatNumber value="${sale.price}" pattern="#,###"/>원
							</td>
						</tr>
						<tr>
							<td>잔여 좌석 </td>
							<td>${sale.seat}</td>
						</tr>
						<tr><td style="height: 300px;" colspan="3"><h4><b>상품 설명</b></h4><br><br>${sale.content }</td></tr>
					</tbody>
				</table>				
				<div class="d-grid gap-2 d-md-flex justify-content-md-end">
					<button type="submit" class="btn btn-sm btn-primary" id="btnList" formaction="${root}index?formpath=saleModify">수정</button>
					<button type="submit" class="btn btn-sm btn-primary" id="btnList" formaction="${root}saleViewDelProc">삭제</button>
					<button 	type="submit" class="btn btn-sm btn-primary" id="btnList" formaction="${root}manageProc">목록</button>
				</div>
				<input type="hidden" name="writer" value="${sale.id}"/>
				<input type="hidden" name="saleCode" value="${sale.saleCode}"/>
				<input type="hidden" name="pageNumber" value="${searchDto.pageNumber}"/>
				<input type="hidden" name="category" value="${searchDto.category}"/>
				<input type="hidden" name="mode" value="${searchDto.mode}"/>
				<input type="hidden" name="find" value="${searchDto.find}"/>
				<input type="hidden" name="data" value="${searchDto.data}"/>
				<input type="hidden" id="sGenre" name="sGenre" value="${searchDto.sGenre}"/>
			</form>
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

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:url var="root" value="/" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
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
<script>
	<%-- 제목 커서 표시 및 sunmit --%>
	$(document).ready(function (){
		$("div.name").css("cursor", "pointer").click(function(){
			let saleCode = $(this).attr("id");
			$("#saleCode").val(saleCode);
			$("#f").attr("action", "${root}saleViewProc");
			$("#f").submit();
		});
		if(${not empty searchDto.sGenre}){
			$('.nav-link active').attr('class','nav-link');
			$('a[data-value=${searchDto.sGenre}]').attr('class','nav-link active'); 	
		}
	});	
	<%--등록 버튼--%>
	$(document).on('click','#saleReg',function(){
		$("#f").attr("action", "${root}index?formpath=saleReg");
		$("#f").submit();
	});
	<%--prev 버튼--%>
	$(document).on('click','#a-tag-Prev',function(){
		$("#pageNumber").val(${cl.getPageNumber()-1});
		$("#f").attr("action", "${root}manageProc");
		$("#f").submit();
	});
	<%--page 버튼--%>
	$(document).on('click','#a-tag-Page',function(){
		var page = $(this).text();
		$("#pageNumber").val(page);
		$("#f").attr("action", "${root}manageProc");
		$("#f").submit();
	});
	<%--next 버튼--%>
	$(document).on('click','#a-tag-Next',function(){
		$("#pageNumber").val(${cl.getPageNumber()+1});
		$("#f").attr("action", "${root}manageProc");
		$("#f").submit();
	});
	
	<%--tab 버튼--%>
	$(document).on('click','#a-tag-Tab',function(){
		$("#sGenre").val($(this).data('value'));
		$("#f").attr("action", "${root}manageProc");
		$("#f").submit();
	});
</script>
<body>
	<c:if test="${not empty msg}"><script>alert("${msg}")</script></c:if>
	<form id="f" method="post">
		<input type="hidden" id="saleCode" name="saleCode"/>
		<input type="hidden" id="pageNumber" name="pageNumber" value="${cl.getPageNumber()}"/>
		<input type="hidden" name="category" value="${searchDto.category}"/>
		<input type="hidden" name="mode" value="${searchDto.mode}"/>
		<input type="hidden" name="find" value="${searchDto.find}"/>
		<input type="hidden" name="data" value="${searchDto.data}"/>
		<input type="hidden" id="sGenre" name="sGenre" value="${searchDto.sGenre}"/>
	</form>
	<div id="wrapper" class="toggled">
		<div id="sidebar-wrapper">
			<ul class="sidebar-nav">
				<li class="sidebar-brand"><a href="${root}manageProc">상품 관리</a></li>
				<li><a href="${root}manageProc?category=movie">영화</a></li>
				<li><a href="${root}manageProc?category=theater">연극</a></li>
				<li><a href="${root}manageProc?category=concert">콘서트</a></li>
				<li><a href="${root}manageProc?category=sports">스포츠</a></li>
				<li><a href="${root}manageProc?category=leisure">레저</a></li>
				<li><br></li>
				<li><br></li>
				<c:if test='${type == "admin"}'>
	               <li class="sidebar-brand"><a href="${root}index?formpath=adminPage">관리페이지</a></li>
	            </c:if>
	            <c:if test='${type == "seller"}'>
	               <li class="sidebar-brand"><a href="sellerMypage">마이페이지</a></li>
	            </c:if>
				
				</ul>
		</div>
		<div id="page-content-wrapper">
			<h3>&ensp;<b>${searchDto.category}</b></h3>
			<div class="container-fluid">
				<ul class="nav nav-tabs">
				<!-- Tab 아이템이다. 태그는 li과 li > a이다. a태그에 active는 현재 선택되어 있는 탭 메뉴이다. -->
				<!-- 해당 링크를 통해 subject를 검색하는 방법을 사용한다.  -->
				<li class="nav-item"><a id="a-tag-Tab" class="nav-link" data-toggle="tab" data-value="00">전체</a></li>
				<c:choose>
					<c:when test='${searchDto.category == "movie"}'>
						<li class="nav-item"><a id="a-tag-Tab" class="nav-link" data-toggle="tab" data-value="01">액션</a></li>
						<li class="nav-item"><a id="a-tag-Tab" class="nav-link" data-toggle="tab" data-value="02">멜로/로맨스</a></li>
						<li class="nav-item"><a id="a-tag-Tab" class="nav-link" data-toggle="tab" data-value="03">범죄/스릴러</a></li>
						<li class="nav-item"><a id="a-tag-Tab" class="nav-link" data-toggle="tab" data-value="04">코미디</a></li>
						<li class="nav-item"><a id="a-tag-Tab" class="nav-link" data-toggle="tab" data-value="05">공포/호러</a></li>
						<li class="nav-item"><a id="a-tag-Tab" class="nav-link" data-toggle="tab" data-value="06">SF/판타지</a></li>
						<li class="nav-item"><a id="a-tag-Tab" class="nav-link" data-toggle="tab" data-value="07">애니메이션</a></li>	
					</c:when>
					<c:when test='${searchDto.category == "theater"}'>
					</c:when>
					<c:when test='${searchDto.category == "concert"}'>
						<li class="nav-item"><a id="a-tag-Tab" class="nav-link" data-toggle="tab" data-value="01">발라드</a></li>
						<li class="nav-item"><a id="a-tag-Tab" class="nav-link" data-toggle="tab" data-value="02">락/메탈</a></li>
						<li class="nav-item"><a id="a-tag-Tab" class="nav-link" data-toggle="tab" data-value="03">랩/힙합</a></li>
						<li class="nav-item"><a id="a-tag-Tab" class="nav-link" data-toggle="tab" data-value="04">재즈/소울</a></li>
					</c:when>
					<c:when test='${searchDto.category == "sports"}'>
						<li class="nav-item"><a id="a-tag-Tab" class="nav-link" data-toggle="tab" data-value="01">야구</a></li>
						<li class="nav-item"><a id="a-tag-Tab" class="nav-link" data-toggle="tab" data-value="02">축구</a></li>
						<li class="nav-item"><a id="a-tag-Tab" class="nav-link" data-toggle="tab" data-value="03">농구</a></li>
						<li class="nav-item"><a id="a-tag-Tab" class="nav-link" data-toggle="tab" data-value="04">배구</a></li>
						<li class="nav-item"><a id="a-tag-Tab" class="nav-link" data-toggle="tab" data-value="05">e스포츠</a></li>
					</c:when>
					<c:when test='${searchDto.category == "leisure"}'>
					 	<li class="nav-item"><a id="a-tag-Tab" class="nav-link" data-toggle="tab" data-value="01">워터파크/스파</a></li>
						<li class="nav-item"><a id="a-tag-Tab" class="nav-link" data-toggle="tab" data-value="02">스키/눈썰매</a></li>
						<li class="nav-item"><a id="a-tag-Tab" class="nav-link" data-toggle="tab" data-value="03">캠핑/휴양림</a></li>
					</c:when>
				</c:choose>
			</ul>
				<table class="table">
					<thead>
					<tr>
						<th style="width: 5%;" scope="col" class="text-center"></th>
						<th style="width: 50%;" scope="col" class="text-center">상품명</th>
						<th style="width: 15%;" scope="col" class="text-center">판매자</th>
						<th style="width: 15%;" scope="col" class="text-center">등록일</th>
						<th style="width: 15%;" scope="col" class="text-center">기간</th>
					</tr>
					</thead>
					<tbody>
					<c:forEach var="i" begin="${cl.getStart()}" end="${cl.getScroll() + cl.getStart() - 1}" step="1">
						<c:if test="${i < cl.getTotalRecord()}">
							<c:set var="list" value="${merchList.get(i)}"/>
							<tr>
								<td scope="row" class="text-center" valign="middle">
									<c:if test='${not empty list.img && list.img != "없음" }'>
										<img alt="titleImage" src="${root}/display?fileName=${list.img}&regDate=${list.regDate}" style="width: 100px; height: 130px;">
									</c:if>
								</td>
								<td scope="row" class="text-center" valign="middle"><div id="${list.saleCode }" class="name">${list.name }[${list.saleCode}]</div></td>
								<td scope="row" class="text-center" valign="middle">${list.id }</td>
								<td scope="row" class="text-center" valign="middle">${list.regDate }</td>
								<td scope="row" class="text-center" valign="middle">${list.startDate }<br>~${list.endDate} </td>
							</tr>
						</c:if>
					</c:forEach>
					</tbody>
				</table>
				<div class="d-grid gap-2 d-md-flex justify-content-md-end">
					<button type="button" class="btn btn-secondary" id="saleReg">상품 등록</button>		
				</div>
				<br>
				<br>
				<form action="${root}manageProc" method="post" id="search-f">
					<input type="hidden" name="category" value="${searchDto.category}"/>
					<input type="hidden" name="pageNumber" value="${cl.getPageNumber()}"/>
					<input type="hidden" name="sGenre" value="${searchDto.sGenre}"/>
					<input type="hidden" name="mode" value="search"/>
					<select id="find" name="find">
						<option value="name">상품명</option>
						<option value="id">판매자</option>
						<option value="place">장소</option>
						<option hidden="hidden" value="sGenre">장르</option>
					</select>
					<input type="text" id="data" name="data" value="${searchDto.data}">
					<c:if test='${not empty searchDto.find}'>
						<script>$('#find').val('${searchDto.find}').prop("selected",true);</script>
					</c:if>
					<button type="submit" class="btn btn-secondary">검색</button>
				</form>
				<nav aria-label="Page navigation example">
					<ul class="pagination justify-content-center">
				  		<c:choose>
							<c:when test="${cl.getPageNumber() <= 1}">
								<li class="page-item disabled">
									<a class="page-link" href="#" tabindex="-1" aria-disabled="true">Prev</a>
								</li>
							</c:when>
							<c:otherwise>
								<c:set var="tmpPrev" value="${cl.getPageNumber() - 1}"/>
								<li class="page-item">
									<a class="page-link" id="a-tag-Prev">Prev</a>
								</li>
							</c:otherwise> 
						</c:choose>	
				    	<c:forEach var="i" begin="1" end="${cl.getTotalPage()}" step="1">
							<c:choose>
								<c:when test="${cl.getPageNumber() == i}">
									  <li class="page-item active"><a class="page-link" href="#">${i }</a></li>
								</c:when>
								<c:otherwise>
								   <li class="page-item"><a class="page-link" id="a-tag-Page">${i }</a></li>
								</c:otherwise> 
							</c:choose>	
						</c:forEach>
						<c:choose>
							<c:when test="${cl.getPageNumber() >= cl.getTotalPage()}">
								<li class="page-item disabled">
									<a class="page-link" href="#" tabindex="-1" aria-disabled="true">Next</a>
								</li>
							</c:when>
							<c:otherwise>
								<c:set var="tmpNext" value="${cl.getPageNumber() + 1}"/>
								<li class="page-item">
				      				<a class="page-link" id="a-tag-Next">Next</a>
				    			</li>
							</c:otherwise> 
						</c:choose>
				  </ul>
				</nav>
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

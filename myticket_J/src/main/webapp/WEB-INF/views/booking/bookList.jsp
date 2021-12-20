<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
			$("#f").attr("action", "${root}bookViewProc");
			$("#f").submit();
		})
	});

	$(document).ready(function(){
		$("#searching").click(function(){
			$("#clsCheck").val("y");
			$("#f").attr("action", "${root}searchDataProc");
			$("#f").submit();
		})
	});
	
	$(document).ready(function(){
		$("#searchData").keydown(function(e){
			if (e.keyCode == 13) {
				$("#clsCheck").val("y");
				$("#f").attr("action", "${root}searchDataProc");
				$("#f").submit();
			}
		})
	});
	<%--prev 버튼--%>
	$(document).on('click','#a-tag-Prev',function(){
		$("#pageNumber").val(${cls.getPageNumber()-1});
		$("#f").attr("action", "bookList");
		$("#f").submit();
	});
	<%--page 버튼--%>
	$(document).on('click','#a-tag-Page',function(){
		var page = $(this).text();
		$("#pageNumber").val(page);
		$("#f").attr("action", "bookList");
		$("#f").submit();
	});
	<%--next 버튼--%>
	$(document).on('click','#a-tag-Next',function(){
		$("#pageNumber").val(${cls.getPageNumber()+1});
		$("#f").attr("action", "bookList");
		$("#f").submit();
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
		<div id="page-content-wrapper">
			<div class="container-fluid">
			
			<form id="f" action="" method="post">
			<input type="hidden" name="bNum" id="bNum">
			<input type="hidden" id="pageNumber" name="pageNumber" value="${cls.getPageNumber()}"/>
					<table class="table">
					<thead>
					<tr>
						<th style="width: 20%;" scope="col" class="text-center">예약 번호</th>
						<th style="width: 40%;" scope="col" class="text-center">예약 상품</th>
						<th style="width: 60%;" scope="col" class="text-center">예약 상태</th>
					</tr>
					</thead>
					<c:choose>
							<c:when test="${empty seachReturn}">
										<c:forEach var="i" begin="${cls.getStart()}" end="${cls.getScroll() + cls.getStart() - 1}" step="1">
											<c:if test="${i < cls.getTotalRecord()}">
												<c:set var="bList" value="${bookList.get(i)}"/>
											<tr>
												<td style="width: 20%;" scope="row" class="text-center"><div id="${bList.bNum}" class="bNum">${bList.bNum}</div></td>
												<td style="width: 40%;" scope="row" class="text-center">${bList.bName}</td>
												<c:choose>
													<c:when test="${bList.bState == 'c'}">
														<td style="width: 60%;" scope="row" class="text-center">취소 완료</td>
													</c:when>
													<c:otherwise>
														<td style="width: 60%;" scope="row" class="text-center">예약 중</td>
													</c:otherwise>
												</c:choose>
											</tr>
											</c:if>
										</c:forEach>
									</c:when>
									<c:otherwise>
										<c:forEach var="j" begin="${cls.getStart()}" end="${cls.getScroll() + cls.getStart() - 1}" step="1">
											<c:if test="${j < cls.getTotalRecord()}">
												<c:set var="bList" value="${seachReturn.get(j)}"/>
											<tr>
												<td style="width: 20%;" scope="row" class="text-center"><div id="${bList.bNum}" class="bNum">${bList.bNum}</div></td>
												<td style="width: 40%;" scope="row" class="text-center">${bList.bName}</td>
												<c:choose>
													<c:when test="${bList.bState == 'c'}">
														<td style="width: 60%;" scope="row" class="text-center">취소 완료</td>
													</c:when>
													<c:otherwise>
														<td style="width: 60%;" scope="row" class="text-center">예약 중</td>
													</c:otherwise>
												</c:choose>
											</tr>
											</c:if>
										</c:forEach>
									</c:otherwise>
								</c:choose>
				</table>
	
				<br>
				<nav aria-label="Page navigation example">
					<ul class="pagination justify-content-center">
					<c:choose>
							<c:when test="${cls.getPageNumber() <= 1}">
								<li class="page-item disabled">
									<a class="page-link" href="#" tabindex="-1" aria-disabled="true">Prev</a>
								</li>
							</c:when>
							<c:otherwise>
								<c:set var="tmpPrev" value="${cls.getPageNumber() - 1}"/>
								<li class="page-item">
									<a class="page-link" id="a-tag-Prev" >Prev</a>
								</li>
							</c:otherwise> 
						</c:choose>

	
				    		<c:forEach var="i" begin="1" end="${cls.getTotalPage()}" step="1">
							<c:choose>
								<c:when test="${cls.getPageNumber() == i}">
									  <li class="page-item active"><a class="page-link" href="#">${i }</a></li>
								</c:when>
								<c:otherwise>
								   <li class="page-item"><a class="page-link" id="a-tag-Page" >${i }</a></li>
								</c:otherwise> 
							</c:choose>	
						</c:forEach>


						<c:choose>
							<c:when test="${cls.getPageNumber() >= cls.getTotalPage()}">
								<li class="page-item disabled">
									<a class="page-link" href="#" tabindex="-1" aria-disabled="true">Next</a>
								</li>
							</c:when>
							<c:otherwise>
								<c:set var="tmpNext" value="${cls.getPageNumber() + 1}"/>
								<li class="page-item">
				      				<a class="page-link" id="a-tag-Next">Next</a>
				    			</li>
							</c:otherwise> 
						</c:choose>
				 </ul>
				</nav>
				<br>
				<br>
				
							<input type="hidden" id="stage" name="stage" value="b">
							<input type="hidden" id="clsCheck" name="clsCheck">
								<select id="find" name="find">
									<option value="title">제목</option>
									<option value="sellNum">예약번호</option>
									<option value="sellState">예약상태</option>
								</select>
							<input type="text" id="searchData" name="searchData">
							<button type="button" class="btn btn-secondary" id="searching">검색</button>
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

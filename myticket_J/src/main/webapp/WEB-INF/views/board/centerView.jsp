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
	#wrapper {margin: 0 auto; width: 50%;}
</style>
<body>
<c:if test="${not empty msg}"><script>alert("${msg}")</script></c:if>
	<div id="wrapper">
		<div id="page-content-wrapper">
			<h2><b>상세 정보</b></h2><br>
			<form name="form" id="form" role="form" method="post">
				<table class="table">
					<thead>
					   <tr><th style="width: 80%;">${center.title}</th><th style="width: 20%;">${center.writeDate}</th></tr>
					</thead>
					<tbody>
						<tr>
							<td style="height: 50px;">
								<c:if test="${center.saleCode == '선택하지 않음'}">
									${center.saleCode}
								</c:if>
								<c:if test="${center.saleCode != '선택하지 않음'}">
									<a href="${root}viewMovieProc?saleCode=${center.saleCode}" target="_blank">${saleName}[${center.saleCode}]</a>
								</c:if>
							</td>
							<td style="width: 40%; height: 50px;">작성자 [${center.id}]</td>
						</tr>
						<tr><td style="height: 300px;" colspan="2">${center.content }</td></tr>
					</tbody>
				</table>				
				<div class="d-grid gap-2 d-md-flex justify-content-md-end">
					<c:if test="${center.groupOrd == 0 && not empty id && (type == 'seller' || type == 'admin') }">
						<button type="submit" class="btn btn-sm btn-primary" id="btnList" formaction="${root}index?formpath=centerReWrite?saleCode=${center.saleCode}">답변하기</button>
					</c:if>
					<c:if test="${searchDto.category != 'My' && (empty type || type == 'normal') }">
						<button type="submit" class="btn btn-sm btn-primary" id="btnList" formaction="${root}index?formpath=centerWrite">글쓰기</button>
					</c:if>
					<c:if test="${(center.groupOrd == 0 && type != 'seller') || (center.groupOrd == 1 && type != 'normal') }">
						<button type="submit" class="btn btn-sm btn-primary" id="btnList" formaction="${root}index?formpath=centerModify">수정</button>
						<button type="submit" class="btn btn-sm btn-primary" id="btnList" formaction="${root}CenterViewDelProc?originNo=${center.originNo}">삭제</button>
					</c:if>
					<button type="submit" class="btn btn-sm btn-primary" id="btnList" formaction="${root}${reUri }">목록</button>
				</div>
				<input type="hidden" id="reUri" name="reUri" value="${reUri }"/>
				<input type="hidden" name="writer" value="${center.id}"/>
				<input type="hidden" name="no" value="${center.no}"/>
				<input type="hidden" name="pageNumber" value="${searchDto.pageNumber}"/>
				<input type="hidden" name="category" value="${searchDto.category}"/>
				<input type="hidden" name="mode" value="${searchDto.mode}"/>
				<input type="hidden" name="find" value="${searchDto.find}"/>
				<input type="hidden" name="data" value="${searchDto.data}"/>
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

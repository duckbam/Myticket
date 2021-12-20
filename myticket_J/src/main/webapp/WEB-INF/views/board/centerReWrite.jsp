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
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
$(document).on('focus','.form-control',function(){
	if($(this).parent().find(".invalid-feedback").css("display") == "block")
    	$(this).parent().find(".invalid-feedback").hide();
});

$(document).on('click','#btnSave',function(){	
	//제목 체크
	var title = $("#title").val();
	if(title.trim() == "") {
		$("#title").parent().find(".invalid-feedback").show();
	 	return false;	
	}
	
	var content = $("#content").val();
	if(content.trim() == "") {
		$("#content").parent().find(".invalid-feedback").show();
	 	return false;	
	}
	
	return true;
});
</script>
<body>
<c:if test="${not empty msg}"><script>alert("${msg}")</script></c:if>
	<div id="wrapper">
		<div id="page-content-wrapper">
				<h2><b>답변</b></h2><br>
				<form name="form" id="form" role="form" method="post">
					<div class="mb-3">
						<label for="title">제목</label>
						<input type="text" class="form-control" name="title" id="title" value="ㄴ[re]${center.title}" readonly="readonly">
						<div class ="invalid-feedback" style="display:none;">
					      	제목을 입력하세요
					    </div>
					</div>
					<div class="mb-3">
						<label for="sale">문의 상품</label>
						<input type="text" class="form-control" name="saleCode" id="saleCode" value="${center.saleCode}" readonly="readonly">
					</div>
					<div class="mb-3">
						<label for="id">작성자</label>
						<input type="text" class="form-control" name="id" id="id"  value="${sessionScope.id }"  readonly="readonly">
					</div>
					<div class="mb-3">
						<label for="content">내용</label>
						<textarea class="form-control" rows="5" name="content" id="content" placeholder="내용을 입력해 주세요" maxlength="1000" ></textarea>
						<div class ="invalid-feedback" style="display:none;">
					      	내용을 입력하세요
					    </div>
					</div>
					<div class="d-grid gap-2 d-md-flex justify-content-md-end">
						<button type="submit" class="btn btn-sm btn-primary" id="btnSave" formaction="${root }centerReWriteProc?originNo=${center.no}&reUri=${reUri}">저장</button>
						<button type="submit" class="btn btn-sm btn-primary" id="btnList" formaction="${root}${reUri}">목록</button>
					</div>
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

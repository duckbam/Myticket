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
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="${root}resources/js/manage.js"></script>

<script>	
	<%--카테고리 변경시 분류 option 변경--%>
	$(document).on('change','#categoryCode',function(){
		var movie = ["액션","멜로/로맨스","범죄/스릴러","코미디","공포/호러","SF/판타지","애미메이션"];
		var theater = ["연극"];
		var concert = ["발라드","락/메탈","랩/힙합","재즈/소울"];
		var sports = ["야구","축구","농구","배구","e스포츠"];
		var leisure = ["워터파크/스파","스키/눈썰매","캠핑/휴양림"];
		
		var select = $("#categoryCode option:selected").val();
		var changeItem;
		
	    $('#sGenreCode').empty();
	    
		switch(select){
			case'm': changeItem = movie; break;
			case't': changeItem = theater; break;
			case'c': changeItem = concert; break;
			case's': changeItem = sports; break;
			case'l': changeItem = leisure; break;
			default : break;
		}
		for(var i = 1; i <= changeItem.length; i++){
			var val = ("0"+i).slice(-2);
			$('#sGenreCode').append($("<option value="+val+">"+changeItem[i-1]+"</option>"));
		}
		$("#sGenreCode option:eq(0)").prop("selected", true);
	});
	function daumPost() {
		new daum.Postcode({
			onComplete : function(data) {
				var addr = "";
				if (data.userSelectedType === "R"){//도로명 주소 타입 R
					addr = data.roadAddress;
					}
				else{//지번 주소 타입 J
					addr = data.jibunAddress;
				}
				document.getElementById("zipcode").value = data.zonecode;
				document.getElementById("addr1").value = addr;
				document.getElementById("addr2").focus();			
			}
		}).open();
	}
</script>
<body>
	<div id="wrapper">
		<div id="page-content-wrapper">
				<h2><b>상품 등록</b></h2><br>
				<form name="form" id="form" role="form" method="post"  enctype="multipart/form-data">
					<div class="mb-3">
						<label for="name">상품명</label>
						<input type="text" class="form-control" name="name" id="name" placeholder="상품명" maxlength="50" >
					    <div class ="invalid-feedback" style="display:none;">
					      	상품명을 입력하세요
					    </div>
					    <span class="focus-input100"></span>
					</div>
					<div class="mb-3">
						<div class="input-group mb-3">
							<span class="input-group-text">카테고리</span>
							<div>
								<select id="categoryCode"name="categoryCode" class="form-select">
									<option value="m" selected="selected">영화</option>	
									<option value="t">연극</option>	
									<option value="c">콘서트</option>	
									<option value="s">스포츠</option>	
									<option value="l">레저</option>	
								</select>    
							</div>
							<span class="input-group-text">장르</span>
							<div class="w-25">
						    	<select id="sGenreCode" name="sGenreCode" class="form-select">
									<option value="01" selected="selected">액션</option>	
									<option value="02">멜로/로맨스</option>	
									<option value="03">범죄/스릴러</option>	
									<option value="04">코미디</option>	
									<option value="05">공포/호러</option>	
									<option value="06">SF/판타지</option>	
									<option value="07">애니메이션</option>	
								</select>    
							</div>
						</div>
					</div>
					<div class="mb-3">
						<label for="id">작성자</label>
						<input type="text" class="form-control" name="id" id="id"  value="${sessionScope.id }"  readonly="readonly">
					</div>
					<div class="mb-3">
						<div class="input-group">
							<span class="input-group-text">장소</span>
							<input type="text" class="form-control"  name='place' id="place" maxlength="50" /> 
							<div class ="invalid-feedback" style="display:none;">
					      		장소를 입력하세요
					     	</div>
						</div>
						<div class="input-group w-50">
							<span class="input-group-text">우편번호</span>
							<input type="text" class="form-control" name='zipcode' id="zipcode" readonly="readonly"/> 
							<button type="button" class="btn btn-sm btn-primary" onclick="daumPost()">우편번호 검색</button>
							<div class ="invalid-feedback" style="display:none;">
					      		우편번호를 검색하세요
					     	</div>
						</div>
						<div class="input-group">
							<span class="input-group-text">주 소</span>
							<input type="text" class="form-control"  name='addr1' id="addr1" readonly="readonly"/> 
						</div>
						<div class="input-group">
							<span class="input-group-text">상세주소</span>
							<input type="text" class="form-control"  name='addr2' id="addr2"  maxlength="100"/> 
						</div>
					</div>
					<div class="mb-3">
						<div class="input-group">
							<span class="input-group-text">시작 날짜</span> 
							<input type="date" class="form-control" name='startDate' id="startDate" /> 
							<span class="input-group-text">종료 날짜</span>
							<input type="date" class="form-control" name='endDate' id="endDate" /> 
							<div class ="invalid-feedback" style="display:none;">
					      		날짜를 확인하세요
					     	</div>
						</div>
					</div>
					<div class="mb-3">
						<div class="input-group">
							<span class="input-group-text">나이 등급</span>
							<select id="age" name="age" class="form-select">
									<option value="0" selected="selected">전체</option>	
									<option value="7">7세</option>	
									<option value="12">12세</option>	
									<option value="15">15세</option>	
									<option value="18">청소년 불가</option>	
							</select>  
							<span class="input-group-text">가격</span>
							<input type="number" class="form-control" name='price' id="price" placeholder="(원)" min="0" /> 
							<span class="input-group-text">좌석</span>
							<input type="number" class="form-control" name='seat' id="seat" placeholder="좌석 수"  min="0" />
							<div class ="invalid-feedback" style="display:none;">
					      		가격과 좌석을 확인하세요
					     	</div> 
						</div>
					</div>
					<div class="mb-3">
					 	<label for="content">내용</label>
						<textarea class="form-control" rows="5" name="content" id="content" placeholder="내용을 입력해 주세요" maxlength="1000"></textarea>
					</div>
					<div class="input-group mb-3">
						<input type="file" class="form-control" id="file" name="file" accept="image/png, image/jpeg, image/jpg"/>
					</div>
					<div class="d-grid gap-2 d-md-flex justify-content-md-end">
						<button type="submit" class="btn btn-sm btn-primary" id="btnSave" formaction="${root}saleRegProc">저장</button>
						<button type="submit" class="btn btn-sm btn-primary" id="btnList" formaction="${root}manageProc">목록</button>
					</div>
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

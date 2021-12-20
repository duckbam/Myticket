
(function ($) {
	'use strict'
	
	$(document).on('focus','.form-control',function(){
		if($(this).parent().find(".invalid-feedback").css("display") == "block")
        	$(this).parent().find(".invalid-feedback").hide();
    });
	
	$(document).on('click','#btnSave',function(){	
		//상품명 체크
		var name = $("#name").val();
		if(name.trim() == "") {
			$("#name").parent().find(".invalid-feedback").show();
		 	return false;	
		}
		
		//장소 체크
		var place = $("#place").val();
		if(place.trim() == "") {
			$("#place").parent().find(".invalid-feedback").show();
		 	return false;	
		}
			
		//우편번호 체크
		var zipcode = $("#zipcode").val();
		if(zipcode == "") {
			$("#zipcode").parent().find(".invalid-feedback").show();
		 	return false;	
		}
	
		//날짜 체크
		var startDate = $("#startDate").val();
		var endDate = $("#endDate").val();
		var currentData = new Date();
		currentData = currentData.getFullYear() + "-" + ("0"+(currentData.getMonth()+1)).slice(-2) + "-" + ("0"+(currentData.getDate())).slice(-2);
		
		if(startDate == "" || endDate == "") {
			$("#startDate").parent().find(".invalid-feedback").show();
		 	return false;	
		}
		if(endDate < startDate){
			$("#startDate").parent().find(".invalid-feedback").show();
		 	return false;	
		}
		if(endDate < currentData){
			$("#startDate").parent().find(".invalid-feedback").show();
		 	return false;	
		}

		//가격 체크
		var price = $("#price").val();
		if(price == undefined || price == "") {
			$("#price").parent().find(".invalid-feedback").show();
		 	return false;	
		}

		//좌석 체크
		var seat = $("#seat").val();
		if(seat == undefined || seat == "") {
			$("#seat").parent().find(".invalid-feedback").show();
		 	return false;	
		}
		
		//파일 확장 자 및 size 체크
		var fileName = $("#file").val();
		if( fileName != "" ){
			var ext = fileName.split('.').pop().toLowerCase(); //확장자분리
			 //아래 확장자가 있는지 체크
			if($.inArray(ext, ['jpg','jpeg','png']) == -1) {
				alert("jpg,jpeg,png파일만 업로드 할수 있습니다.");
				return false;
			} 
			 
			var fileSize = $("#file")[0].files[0].size;
			if(fileSize > maxSize){
				alert("첨부파일 사이즈는 50MB 이내로 등록 가능합니다.");
				$("#file").val("");
				return false;
			}
		}
		return true;
	});
})(jQuery);
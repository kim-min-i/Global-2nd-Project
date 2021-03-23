<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix ="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix ="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../nav.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>펫츠리뷰 | 리뷰쓰기</title>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.9/css/select2.min.css" rel="stylesheet" />

<style>
* {
  box-sizing: border-box;
}
/* Style the search field */
form.example input[type=text] {
  padding: 10px;
  font-size: 17px;
  border: 1px solid grey;
  float: left;
  width: 80%;
  background: #f1f1f1;
}

/* Style the submit button */
form.example button {
  float: left;
  width: 20%;
  padding: 10px;
  background: #2196F3;
  color: white;
  font-size: 17px;
  border: 1px solid grey;
  border-left: none; /* Prevent double borders */
  cursor: pointer;
}

form.example button:hover {
  background: #0b7dda;
}

/* Clear floats */
form.example::after {
  content: "";
  clear: both;
  display: table;
}
.rating .rate_radio {
    position: relative;
    display: inline-block;
    z-index: 20;
    opacity: 0.001;
    width: 60px;
    height: 60px;
    background-color: #fff;
    cursor: pointer;
    vertical-align: top;
    display: none;
}
.rating .rate_radio + label {
    position: relative;
    display: inline-block;
    margin-left: -4px;
    z-index: 10;
    width: 60px;
    height: 60px;
    background-image: url('/pet/resources/img/starrate.png');
    background-repeat: no-repeat;
    background-size: 60px 60px;
    cursor: pointer;
    background-color: #f0f0f0;
}
.rating .rate_radio:checked + label {
    background-color: orange;
}
</style>

</head>
<body>
	<c:if test="${sessionScope.member == null }"> 
		<script>
			alert("로그인이 필요한 화면입니다.");
			location.href="/pet/member/login.do";
		</script>
	</c:if>

<script>
document.addEventListener('DOMContentLoaded', function(){
    //별점선택 이벤트 리스너
    const rateForms = document.querySelectorAll('.rating'); /* 별점 선택 템플릿을 모두 선택 */
	rateForms.forEach(function(item){//클릭 이벤트 리스너 각각 등록
		item.addEventListener('click',function(e){
			let elem = e.target;
			if(elem.classList.contains('rate_radio')){
				rating.setRate(elem.parentElement, parseInt(elem.value)); // setRate() 에 ".rating" 요소를 첫 번째 파라메터로 넘김
			}
		})
	});
});


//별점 마킹 모듈 프로토타입으로 생성
function Rating(){};
Rating.prototype.rate = 0;
Rating.prototype.setRate = function(rateobj, newrate){
    //별점 마킹 - 클릭한 별 이하 모든 별 체크 처리
    this.rate = newrate;
	let checks = null;
	//요소가 파라메터로 넘어오면 별점 클릭, 없으면 저장 후 전체 초기화
	if(rateobj){
		rateobj.querySelector('.ratefill').style.width = parseInt(newrate * 60) + 'px'; // 현재 별점 갯수 채색
		checks = rateobj.querySelectorAll('.rate_radio'); // 넘어온 요소 하위의 라디오버튼만 선택
	}else{
		//전체 별점 채색 초기화
		const rateFills = document.querySelectorAll('.ratefill');
		rateFills.forEach(function(item){
			item.style.width = parseInt(newrate * 60) + 'px';
		});
		//전체 라디오 버튼 초기화
		checks = document.querySelectorAll('.rate_radio');
	}
	//별점 체크 라디오 버튼 처리
	if(checks){
		checks.forEach(function(item, idx){
			if(idx < newrate){
				item.checked = true;
			}else{
				item.checked = false;
			}
		});		
	}
}

let rating = new Rating();//별점 인스턴스 생성

// 선택한 별점 값 컨트롤러로 전송

	function ratingSubmit() {
		var ratingName = ['kind', 'waiting', 'clean', 'detail', 'price', 'after'];
		var ratingChk = ['kindChk', 'waitingChk', 'cleanChk', 'detailChk', 'priceChk', 'afterChk'];
		
		for(var i = 0; i < ratingName.length; i++){
		    var obj = $('[name='+ratingChk[i]+']');
		    var chkArray = new Array(); // 배열 선언
		
		    $('input:checkbox[name='+ratingChk[i]+']:checked').each(function() { // 체크된 체크박스의 value 값을 가지고 온다.
		        chkArray.push(this.value);
		    });
		    
		    var maxValue = Math.max.apply(null, chkArray);
		    document.getElementById(ratingName[i]).value = maxValue;
		}
		
		var theForm = document.forms['reviewForm'];
		var input   = document.createElement('input');
	
		input.type   = 'hidden';
		input.name  = 'cart_num';
		input.value  = $();
		
		theForm.appendChild(input);
		
		check();
	}

	function check(){
		var form = document.reviewForm;
		
		if(form.doc_name.value == ''){
			alert('의사이름을 입력해주세요.');
			form.doc_name.focus();
			return false;
		}
		
		if(form.auth.value == ''){
			alert('인증사진을 올려주세요.');
			form.auth.focus();
			return false;
		}
		
		if(form.docter_review.value == ''){
			alert('리뷰를 입력해주세요.');
			form.docter_review.focus();
			return false;
		}
		
		if(form.hospital_review.value == ''){
			alert('리뷰를 입력해주세요.');
			form.hospital_review.focus();
			return false;
		}
		
		if(form.summary.value == ''){
			alert('리뷰를 입력해주세요.');
			form.summary.focus();
			return false;
		}
		
		if($('input[name="subject_info"]').length == 0){
			alert('진료과목을 입력해주세요.');
			form.add_subject.focus();
			return false;
		}
		
		if(form.revisit.value == ''){
			alert('재방문추천을 입력해주세요.');
			form.revisit.focus();
			return false;
		}
		
		if(form.kind.value == 0){
			alert('평점을 입력해주세요.');
			form.kind.focus();
			return false;
		}
		
		if(form.waiting.value == 0){
			alert('평점을 입력해주세요.');
			form.waiting.focus();
			return false;
		}
		
		if(form.clean.value == 0){
			alert('평점을 입력해주세요.');
			form.clean.focus();
			return false;
		}
		
		if(form.detail.value == 0){
			alert('평점을 입력해주세요.');
			form.detail.focus();
			return false;
		}
		
		if(form.price.value == 0){
			alert('평점을 입력해주세요.');
			form.price.focus();
			return false;
		}
		
		if(form.after.value == 0){
			alert('평점을 입력해주세요.');
			form.after.focus();
			return false;
		}
		
		form.submit();
	}

</script>

	<div style="margin-top: 35px;text-align: center	">
	<div class="p-4" style="width: 1000x; display: inline-block;">
	

	<form name="reviewForm" method = "post" enctype="multipart/form-data"  action="/pet/review/insertreviewpro.do">
		<!-- 테스트용 코드 -->
		<input type="hidden" name="member_email" value="${sessionScope.member.email}">
						
		<div style="text-align: left" >
		<h6 style="text-align: left"><span class="badge badge-pill badge-dark">1. 병원조회</span> 병원 이름을 입력하세요.</h6>
			<select class="form-control" name="hospital_no">
					<c:forEach var="hospitalList" items="${hospitalList}">
					<option value="${hospitalList.no}">${hospitalList.name}, ${hospitalList.road_adr}</option>
					</c:forEach>
				</select>
   		 	</div>
   		 	<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.9/js/select2.min.js"></script>
			<script>
			// select2 초기화
			$('select').select2();
			</script>
		<br>	
		<h6 style="text-align: left"><span class="badge badge-pill badge-dark">2. 의사입력	</span> 진료받은 의사를 입력하세요.</h6>
		<div style="text-align: left" ><input style="width:100%;" type="text" name="doc_name"> <br /></div>
		<br>
		<h6 style="text-align: left"><span class="badge badge-pill badge-dark">3. 자료첨부</span> 진료자료를 업로드해 주세요.</h6>
		<div style="text-align: left" ><input type="file" name="auth"></div>
		<br>
		<br>

		<h6 style="text-align: left"><span class="badge badge-pill badge-dark">4. 별점등록</span>
		'매우 그렇다'면  5점, '전혀 그렇지 않다'면 1점을 주세요.</h6>
		
		<div class="review_rating">
		<div class="rating">
                    <ul class="list-group list-group-flush">
		  		<li class="list-group-item pl-0 pr-0 pt-3">
  		 <div class="d-flex justify-content-between align-items-center">
  			<div class="ratefill" style="width: 300px;">친절함</div>
                <!-- 해당 별점을 클릭하면 해당 별과 그 왼쪽의 모든 별의 체크박스에 checked 적용 -->
                <input type="checkbox" name="kindChk" id="rating11" value="1" class="rate_radio" title="1점">
                <label for="rating11"></label>		
                <input type="checkbox" name="kindChk" id="rating12" value="2" class="rate_radio" title="2점">
                <label for="rating12"></label>
                <input type="checkbox" name="kindChk" id="rating13" value="3" class="rate_radio" title="3점" >
                <label for="rating13"></label>
                <input type="checkbox" name="kindChk" id="rating14" value="4" class="rate_radio" title="4점">
                <label for="rating14"></label>
                <input type="checkbox" name="kindChk" id="rating15" value="5" class="rate_radio" title="5점">
                <label for="rating15"></label>
                <input type="hidden" name="kind" id="kind" value="0"></div> </li>
                
  		<li class="list-group-item pl-0 pr-0 pt-3">
  		<div class="d-flex justify-content-between align-items-center">
  			<div class="ratefill" style="width: 300px;">대기시간</div>
                <!-- 해당 별점을 클릭하면 해당 별과 그 왼쪽의 모든 별의 체크박스에 checked 적용 -->
                <input type="checkbox" name="waitingChk" id="rating21" value="1" class="rate_radio" title="1점">
                <label for="rating21	"></label>
                <input type="checkbox" name="waitingChk" id="rating22" value="2" class="rate_radio" title="2점">
                <label for="rating22"></label>
                <input type="checkbox" name="waitingChk" id="rating23" value="3" class="rate_radio" title="3점" >
                <label for="rating23"></label>
                <input type="checkbox" name="waitingChk" id="rating24" value="4" class="rate_radio" title="4점">
                <label for="rating24"></label>
                <input type="checkbox" name="waitingChk" id="rating25" value="5" class="rate_radio" title="5점">
                <label for="rating25"></label>
                <input type="hidden" name="waiting" id="waiting" value="0"></div></li>
                
 		<li class="list-group-item pl-0 pr-0 pt-3">
  		<div class="d-flex justify-content-between align-items-center">
  			<div class="ratefill" style="width: 300px;">청결함</div>
                <!-- 해당 별점을 클릭하면 해당 별과 그 왼쪽의 모든 별의 체크박스에 checked 적용 -->
                <input type="checkbox" name="cleanChk" id="rating31" value="1" class="rate_radio" title="1점">
                <label for="rating31"></label>
                <input type="checkbox" name="cleanChk" id="rating32" value="2" class="rate_radio" title="2점">
                <label for="rating32"></label>
                <input type="checkbox" name="cleanChk" id="rating33" value="3" class="rate_radio" title="3점" >
                <label for="rating33"></label>
                <input type="checkbox" name="cleanChk" id="rating34" value="4" class="rate_radio" title="4점">
                <label for="rating34"></label>
                <input type="checkbox" name="cleanChk" id="rating35" value="5" class="rate_radio" title="5점">
                <label for="rating35"></label>
                <input type="hidden" name="clean" id="clean" value="0"></div></li>
                
  		<li class="list-group-item pl-0 pr-0 pt-3">
  		<div class="d-flex justify-content-between align-items-center">
  			<div class="ratefill" style="width: 300px;">진료 설명</div>
                <!-- 해당 별점을 클릭하면 해당 별과 그 왼쪽의 모든 별의 체크박스에 checked 적용 -->
                <input type="checkbox" name="detailChk" id="rating41" value="1" class="rate_radio" title="1점">
                <label for="rating41"></label>
                <input type="checkbox" name="detailChk" id="rating42" value="2" class="rate_radio" title="2점">
                <label for="rating42"></label>
                <input type="checkbox" name="detailChk" id="rating43" value="3" class="rate_radio" title="3점" >
                <label for="rating43"></label>
                <input type="checkbox" name="detailChk" id="rating44" value="4" class="rate_radio" title="4점">
                <label for="rating44"></label>
                <input type="checkbox" name="detailChk" id="rating45" value="5" class="rate_radio" title="5점">
                <label for="rating45"></label>
                <input type="hidden" name="detail" id="detail" value="0"></div></li>
                              
  		<li class="list-group-item pl-0 pr-0 pt-3">
  		<div class="d-flex justify-content-between align-items-center">
  			<div class="ratefill" style="width: 300px;">가격</div>
                <!-- 해당 별점을 클릭하면 해당 별과 그 왼쪽의 모든 별의 체크박스에 checked 적용 -->
                <input type="checkbox" name="priceChk" id="rating51" value="1" class="rate_radio" title="1점">
                <label for="rating51"></label>
                <input type="checkbox" name="priceChk" id="rating52" value="2" class="rate_radio" title="2점">
                <label for="rating52"></label>
                <input type="checkbox" name="priceChk" id="rating53" value="3" class="rate_radio" title="3점" >
                <label for="rating53"></label>
                <input type="checkbox" name="priceChk" id="rating54" value="4" class="rate_radio" title="4점">
                <label for="rating54"></label>
                <input type="checkbox" name="priceChk" id="rating55" value="5" class="rate_radio" title="5점">
                <label for="rating55"></label>
                <input type="hidden" name="price" id="price" value="0"></div></li>
                
         <li class="list-group-item pl-0 pr-0 pt-3">
         <div class="d-flex justify-content-between align-items-center">
  		
  			<div class="ratefill" style="width: 300px;">치료 후 결과</div>
                <!-- 해당 별점을 클릭하면 해당 별과 그 왼쪽의 모든 별의 체크박스에 checked 적용 -->
                <input type="checkbox" name="afterChk" id="rating61" value="1" class="rate_radio" title="1점">
                <label for="rating61"></label>
                <input type="checkbox" name="afterChk" id="rating62" value="2" class="rate_radio" title="2점">
                <label for="rating62"></label>
                <input type="checkbox" name="afterChk" id="rating63" value="3" class="rate_radio" title="3점" >
                <label for="rating63"></label>
                <input type="checkbox" name="afterChk" id="rating64" value="4" class="rate_radio" title="4점">
                <label for="rating64"></label>
                <input type="checkbox" name="afterChk" id="rating65" value="5" class="rate_radio" title="5점">
                <label for="rating65"></label>
                <input type="hidden" name="after" id="after" value="0"></div></li>
        		</ul>
        		</div>
        		</div>	
       	<br>
       	<br>		
		<div style="text-align: center">
		<h6 style="text-align: left"><span class="badge badge-pill badge-dark">5. 텍스트 리뷰</span> 솔직한 리뷰를 입력해 주세요.</h6>
		
			<h6 style="text-align: left">의사리뷰 </h6><textarea style="width:100%; text-align:left;" name="docter_review"  rows="3" cols="50"></textarea><br>
			
			<h6 style="text-align: left">병원리뷰</h6><textarea style="width:100%; text-align:left;"name="hospital_review" rows="3" cols="50"></textarea><br>
			
			<h6 style="text-align: left">한줄평</h6><input style="width:100%; text-align:left;" type="text" name="summary" maxlength="30"><br>
		</div>
		<br>
		<br>		
		<div>
		<h6 style="text-align: left"><span class="badge badge-pill badge-dark">6. 가격정보</span> 치료받은 가격 정보를 입력해 주세요.</h6>
			<table id="list_table" class="table-dark">
				<colgroup>
					<col style="width: 200px">
					<col style="width: 200px">
					<col style="width: 50px">
				</colgroup>
				
				<thead>
					<tr>
						<th>진료과목</th>
						<th>가격</th>
					</tr>
				</thead>
				
				<tbody>
				</tbody>
			</table>		
		</div>
		<br>
		<div id="priceReview" style="text-align:left">
			<!--<input type="text" id="add_subject" placeholder ="진료 과목">  -->
			<select name="add_subject" id="add_subject">
				<option selected>진료과목</option>
				<c:forEach var="subjectList" items="${subjectList}">
					<option value="${subjectList}">${subjectList}</option>
				</c:forEach>
			</select>
			<input type="text" id="add_price" placeholder="가격" >
			<button class="btn btn-outline-dark" type="button" id="append_row">추가</button>
   		</div>
   		<br>
   		<br>	
   		<div style="text-align: left">
   		<h6 style="text-align: left"><span class="badge badge-pill badge-dark">7. 재방문 추천</span> 이 병원을 재방문 하실 의사가 있나요?</h6>
			<input type="radio" name="revisit" value="Y">YES
			<input type="radio" name="revisit" value="N">NO
		</div>
		<br>
		<div style="text-align: left">
		<h6 style="text-align: left"><span class="badge badge-pill badge-dark">8. 병원사진</span> 병원 인테리어 사진을 업로드해 주세요.</h6>
			<input multiple="multiple" type="file" name="hospital" maxlength="3">
		<br>
		<br>	
		<h6 style="text-align: left"><span class="badge badge-pill badge-dark">9. 치료사진</span> 치료 사진을 업로드해 주세요.</h6>
			<input multiple="multiple" type="file" name="cure" maxlength="3">
		</div>
		<br>
		<br>
		<div style="text-align: left">
		<h6 style="text-align: left"><span class="badge badge-pill badge-dark">10. 나의 페이지에 공개</span></h6>
			<input type="checkbox" name="public_check" value="Y">나의 페이지에 공개
		</div>
		<br>
		<button class="btn btn-dark p-2 w-50" type="button" onclick="ratingSubmit();">리뷰 작성하기</button>
	</form>
	</div>
	</div>
	</div>
</body>
<script type="text/javascript">

// 진료과목 추가
$("#append_row").on("click", function() {
	var subject = $("#add_subject").val();
	var price = $("#add_price").val()
	$("#list_table").append(
		$("<tr>").append(		
			$("<td>").append(subject),
			$("<td>").append(price),
			$("<td>").append(
				$("<button>").prop("type","button").addClass("delete-link").append("삭제")     
			),
			$("<td>").append("<input type='hidden' name='subject_info' value='"+subject+"'/>"),
			$("<td>").append("<input type='hidden' name='price_info' value='"+price+"'/>")
		)	
	);	
});

// 삭제
$("#list_table").on("click", ".delete-link", function () {
	$(this).parent().parent().remove();
});





</script>
</html>
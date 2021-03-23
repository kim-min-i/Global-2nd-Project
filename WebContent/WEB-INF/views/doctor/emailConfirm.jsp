<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ include file="../nav2.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>펫츠리뷰 for doctors | 이메일 인증</title>
</head>
<body>
	<div style="margin-top: 35px; text-align: center">
	<div class="p-4" style="width: 1000px; display: inline-block;">
	
	<h3> 메일 인증이 완료되었습니다. 가입을 진행해주세요.</h3><br>
	
	<form action="emailOk.do" method="post" enctype="multipart/form-data">
		<table class="table" style="text-align: center">
			<tr>
				<th>1. 의사면허증 <span class="badge badge-primary">필수</span>  /  ${doc_mail }</th> 
			</tr>
			<tr>
				<td><input type="file" name="license" /></td>
			</tr>
			<tr>
				<th>2. 사업자등록증 또는 의료기관개설신고(허가)증    <span class="badge badge-primary">필수</span></th>
			</tr>
			<tr>
				<td><input type="file" name="registration" /></td>
			</tr>
			<tr>
				<th>3. 병원 / 의사 정보공개 동의서</th>
			</tr>
			<tr>			<%-- 파일이름이 고정되어있기에  ?로  안해도 됨. --%>
				<td><a href="/pet/doctor/down.do">동의서 다운 </a> <br>
					<input type="file" name="agreement" />
				</td>
			</tr>
			<tr>
				<td><input type="hidden" name="doc_mail" value="${doc_mail}" />
					<input type="hidden" name="authKey" value="${authKey}"/></td>
			</tr>
		</table>
		<input class="btn btn-dark"  type="submit" value="제출하기" />
		
	</form>	
</div>
</div>
</body>
</html>
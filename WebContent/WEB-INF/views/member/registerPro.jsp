<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import = "pet.model.dto.MemberDTO" %>
<%@ page import = "java.sql.Timestamp" %>
<%@ taglib prefix = "c" uri="http://java.sun.com/jsp/jstl/core"%>




<c:if test="${result == 0 }">
	<script>
		alert("�̸����� �ߺ��˴ϴ�.");
		history.go(-1)
	</script>
</c:if>
<c:if test="${result == 1 }">
	<script>
		alert("�ݰ����ϴ�. �̸��� ���� �� �̿����ּ��� :)");
		window.location="/pet/member/login.do"
	</script>
</c:if>
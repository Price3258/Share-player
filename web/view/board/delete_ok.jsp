<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<jsp:useBean id="dao" class="dao.BoardDao"/>
<jsp:useBean id="vo" class="domain.Board"/>
<jsp:setProperty name="vo" property="*" />
			
<%
	int idx = Integer.parseInt(request.getParameter("idx"));
	int pg = Integer.parseInt(request.getParameter("pg"));

	try {
		dao.delete(idx);
	} catch (Exception e) {
		e.printStackTrace();
	}
%>
<script language=javascript>
self.window.alert("�ش� ���� �����Ͽ����ϴ�.");
location.href="list.jsp?pg=<%=pg%>";
</script>
		

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
self.window.alert("해당 글을 삭제하였습니다.");
location.href="list.jsp?pg=<%=pg%>";
</script>
		

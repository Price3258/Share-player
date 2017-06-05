<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<jsp:useBean id="dao" class="dao.BoardDao" />
<jsp:useBean id="vo" class="domain.Board" />
<jsp:setProperty name="vo" property="*" />

<%
	int idx = Integer.parseInt(request.getParameter("idx"));
	int pg = Integer.parseInt(request.getParameter("pg"));
	String memo = new String(request.getParameter("memo").getBytes("8859_1"),"UTF-8");
	String title = new String(request.getParameter("title").getBytes("8859_1"),"UTF-8");
	vo.setBoard_title(title);
	vo.setBoard_content(memo);
	dao.modify(vo, idx);
		%>
<script language=javascript>
	self.window.alert("글이 수정되었습니다.");
	location.href="view.jsp?idx=<%=idx%>&pg=<%=pg%>";
</script>


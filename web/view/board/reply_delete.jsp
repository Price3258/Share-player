<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="dao.ReplyDao" %>
<%@ page import="domain.Reply" %>
<jsp:useBean id="dao" class="dao.ReplyDao"/>
<jsp:useBean id="Bdao" class="dao.BoardDao"/>
<jsp:useBean id="vo" class="domain.Reply"/>
<jsp:setProperty name="vo" property="*" />

<%
int reply_id = Integer.parseInt(request.getParameter("reply_id"));
int pg = Integer.parseInt(request.getParameter("pg"));
int idx = Integer.parseInt(request.getParameter("idx"));
dao.deleteReply(reply_id);
%>

<script language=javascript>
   self.window.alert("댓글 삭제 완료.");
   location.href="view.jsp?idx=<%=idx%>&pg=<%=pg%>";
</script>
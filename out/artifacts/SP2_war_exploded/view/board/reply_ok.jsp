<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.ReplyDao" %>
<%@ page import="domain.Reply" %>
<jsp:useBean id="dao" class="dao.ReplyDao"/>
<jsp:useBean id="Bdao" class="dao.BoardDao"/>
<jsp:useBean id="vo" class="domain.Reply"/>
<jsp:setProperty name="vo" property="*" />
<%
	String email= (String)session.getAttribute("email");
	String nickname = Bdao.getNickname(email);
	int user_id = Bdao.getUserid(nickname);
	int idx = Integer.parseInt(request.getParameter("idx"));
	int pg = Integer.parseInt(request.getParameter("pg"));
	String content= new String(request.getParameter("reply").getBytes("8859_1"),"UTF-8");
	
	vo.setBoard_id(idx);
	vo.setUser_id(user_id);
	vo.setReply_content(content);

	try {
		dao.insertReply(vo);
	} catch (Exception e) {
		e.printStackTrace();
	}

%>
  <script language=javascript>	 <!-- 처리 완료 후 alert창을 띄워 주고 댓글을 작성했던 페이지로 돌아간다. -->
   self.window.alert("댓글 등록 완료.");
   location.href="view.jsp?idx=<%=idx%>&pg=<%=pg%>";
  </script>
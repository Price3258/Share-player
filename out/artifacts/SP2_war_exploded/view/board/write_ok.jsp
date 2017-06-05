<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="dao" class="dao.BoardDao" />
<jsp:useBean id="doma" class="domain.Board" />
<jsp:setProperty name="doma" property="*" />
<% 
request.setCharacterEncoding("UTF-8");
%>
<%
String email= (String)session.getAttribute("email");
String nickname = dao.getNickname(email);		//닉네임
String memo = new String(request.getParameter("memo").getBytes("8859_1"),"UTF-8");		//내용
String title = new String(request.getParameter("title").getBytes("8859_1"),"UTF-8");	//제목
int user_id = dao.getUserid(nickname);			//DB에 접근하기 위한 user_id
doma.setBoard_title(title);
doma.setBoard_content(memo);
%>

<%	
	dao.insertWrite(doma, user_id);
%>

<script language=javascript>
   self.window.alert("입력한 글을 저장하였습니다.");
   location.href="list.jsp";
</script>
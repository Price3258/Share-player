<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import = "domain.Message" %>
<jsp:useBean id="dao" class="dao.MessageDao" />
<% 
request.setCharacterEncoding("UTF-8");
%>
<%
String title = request.getParameter("title");
String content = request.getParameter("content");
String nickname = request.getParameter("receive_id");
if(!dao.hasUser(nickname)){
%>
<script language="javascript">
self.window.alert("존재하지 않는 닉네임 입니다.");
history.back();
</script>
<%
}else{

int send_id = Integer.parseInt(request.getParameter("send_id"));	//보낸 사람
int receive_id = dao.getuser_idn(nickname);

Message vo = new Message();
vo.setTitle(title);
vo.setContent(content);
vo.setSend_user(send_id);
vo.setReceive_user(receive_id);

dao.sendMessage(vo);

%>
<script language=javascript>
   self.window.alert("쪽지를 전송 하였습니다.");
   location.href="message.jsp";
</script>
<%
}

%>


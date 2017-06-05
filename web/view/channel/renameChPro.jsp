<%@ page import="dao.ChDao" %>
<%@ page import="dao.UserDao" %><%--
  Created by IntelliJ IDEA.
  User: wontae
  Date: 2016. 8. 2.
  Time: 오후 9:16
  To change this template use File | Settings | File Templates.
--%>
<%
    request.setCharacterEncoding("UTF-8");
    ChDao chHandler = ChDao.getInstance();
    UserDao userHanlder = UserDao.getInstance();
    String email = (String)session.getAttribute("email");
    int user_id = userHanlder.getUser_id(email);
    int ch_id = chHandler.getChid(user_id);
    String ch_name = request.getParameter("ch_name");
    chHandler.UpdateChName(ch_name,ch_id);
%>

<script language=javascript>
    self.window.alert("채널 이름을 재설정하였습니다.");
    location.href="mainCh.jsp?ch_id<%=ch_id%>";
</script>
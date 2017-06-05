<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="dao.ChDao" %>
<%@ page import="dao.UserDao" %><%--
  Created by IntelliJ IDEA.
  User: wontae
  Date: 2016. 11. 10.
  Time: PM 4:02
  To change this template use File | Settings | File Templates.
--%>
<%
    request.setCharacterEncoding("UTF-8");
%>


<%
    String email = (String)session.getAttribute("email");

    UserDao userHandler = UserDao.getInstance();
    ChDao chHandler = ChDao.getInstance();
    int user_id = userHandler.getUser_id(email);
    int ch_id = chHandler.getChid(user_id);
    int requested_ch_id = Integer.parseInt(request.getParameter("ch_id"));

    try {
       chHandler.deleteChannel(requested_ch_id);
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
<script language=javascript>
    self.window.alert("채널 삭제를 완료하였습니다.");
    location.href="mainCh.jsp?ch_id=<%=ch_id%>";
</script>

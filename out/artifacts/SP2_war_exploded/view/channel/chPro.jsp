<%--
  Created by IntelliJ IDEA.
  User: wontae
  Date: 2016. 7. 20.
  Time: 오후 5:53
  To change this template use File | Settings | File Templates.
  <%@ page session="true"%>
--%>

<%-- Insert user's channel Pro Controller--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="dao.ChDao"%>
<%@ page import="dao.UserDao" %>
<%
    request.setCharacterEncoding("UTF-8");
    String email = (String)session.getAttribute("email");
    String ch_name = request.getParameter("ch_name");
    int user_id;

    UserDao userHandler = UserDao.getInstance();
    ChDao chHandler = ChDao.getInstance();
    int check;
    try {
        user_id=userHandler.getUser_id(email);
        session.setAttribute("user_id",user_id);
        session.setAttribute("ch_name",ch_name);
        chHandler.insertCh(ch_name,user_id);
        int ch_id = chHandler.getChid(user_id);

%>
    <%--<jsp:forward page="mainCh.jsp">--%>
        <%--<jsp:param name="ch_id" value="<%=ch_id%>"></jsp:param>--%>
    <%--</jsp:forward>--%>

<script language=javascript>
    self.window.alert("채널 등록 완료.");
    location.href="mainCh.jsp?ch_id=<%=ch_id%>";
</script>
<%

    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<%@ page import="dao.ChDao" %>
<%@ page import="dao.RecomDao" %>
<%@ page import="dao.UserDao" %><%--
  Created by IntelliJ IDEA.
  User: wontae
  Date: 2016. 10. 11.
  Time: PM 2:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<%
    ChDao chHandler = ChDao.getInstance();
    RecomDao rcHandler = RecomDao.getInstance();
    UserDao userHandler = UserDao.getInstance();

    String email = (String)session.getAttribute("email");
    int ch_id = Integer.parseInt(request.getParameter("ch_id"));
    int user_id = userHandler.getUser_id(email);
    System.out.println("chid="+ch_id);
    System.out.println("user_id="+user_id);

    try {
        rcHandler.insertReco(ch_id,user_id);
    } catch (Exception e) {
        e.printStackTrace();
    }
//        response.sendRedirect("chList.jsp");
%>
<script language=javascript>
    self.window.alert("추천 완료.");
    location.href="mainCh.jsp?ch_id=<%=ch_id%>";
</script>

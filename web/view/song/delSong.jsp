<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="dao.SongDao" %>
<%@ page import="dao.UserDao" %>
<%@ page import="dao.ChDao" %><%--
  Created by IntelliJ IDEA.
  User: wontae
  Date: 2016. 8. 2.
  Time: 오후 2:52
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
    int song_id = Integer.parseInt(request.getParameter("song_id"));


    SongDao songHandler =SongDao.getInstance();
    try {
        songHandler.deleteSong(song_id);
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
<script language=javascript>
    self.window.alert("링크 삭제를 완료하였습니다.");
    location.href="../channel/mainCh.jsp?ch_id=<%=ch_id%>";
</script>
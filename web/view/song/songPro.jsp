<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="dao.SongDao" %><%--
  Created by IntelliJ IDEA.
  User: wontae
  Date: 2016. 8. 1.
  Time: 오후 3:47
  To change this template use File | Settings | File Templates.
--%>

<%
    request.setCharacterEncoding("UTF-8");
    String song_link = request.getParameter("song_link");
    String song_name = request.getParameter("song_name");
    String singer = request.getParameter("singer");
    int ch_id;
    SongDao songHandler = SongDao.getInstance();

    try{

        ch_id=Integer.parseInt(request.getParameter("ch_id"));

        songHandler.insertSong(song_link,song_name,singer,ch_id);
%>
<script language=javascript>
    self.window.alert("링크 등록 완료.");
    location.href="../channel/mainCh.jsp?ch_id=<%=ch_id%>";
</script>
<%
    }catch (Exception e ){
        e.printStackTrace();
    }

%>
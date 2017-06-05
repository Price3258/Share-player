<%@ page import="dao.UserDao" %>
<%@ page import="dao.ChDao" %>

<%--
  Created by IntelliJ IDEA.
  User: wontae
  Date: 2016. 7. 27.
  Time: 오후 4:18
  To change this template use File | Settings | File Templates.
--%>

<%-- Not use anymore
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setCharacterEncoding("UTF-8");
    String email= (String)session.getAttribute("email");
    UserDao userHandler = UserDao.getInstance();
    ChDao chHandler = ChDao.getInstance();
    try{
        int user_id = userHandler.getUser_id(email);
        if(chHandler.chCheck(user_id)==1){
            int ch_id = chHandler.getChid(user_id);
            String ch_name = chHandler.getChName(user_id);

            session.setAttribute("email",email);
            session.setAttribute("ch_id",ch_id);
            session.setAttribute("ch_name",ch_name);

            response.sendRedirect("mainCh.jsp");
        }
        else{
            session.setAttribute("email",email);
            response.sendRedirect("regisCh.jsp");
        }

    }catch (Exception e){
        e.printStackTrace();
    }

%>

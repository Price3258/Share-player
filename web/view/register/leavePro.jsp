<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="dao.UserDao" %><%--
  Created by IntelliJ IDEA.
  User: wontae
  Date: 2016. 8. 4.
  Time: 오후 9:41
  To change this template use File | Settings | File Templates.
--%>
<%
    UserDao userHandler= UserDao.getInstance();
    String email= (String)session.getAttribute("email");
    String password= request.getParameter("password");
    try {
        userHandler.deleteUser(email,password);
    } catch (Exception e) {
        e.printStackTrace();
    }

    session.setAttribute("email", null);
    session.invalidate();
    response.sendRedirect("../../index.jsp");
%>
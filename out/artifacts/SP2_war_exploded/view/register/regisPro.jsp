<%--
  Created by IntelliJ IDEA.
  User: wontae
  Date: 2016. 7. 13.
  Time: 오후 8:44
  To change this template use File | Settings | File Templates.
--%>

<%@ page import="dao.UserDao" %>
<%
    request.setCharacterEncoding("UTF-8");
%>

<%
    String user_nickname = request.getParameter("nickname");
    String user_pwd = request.getParameter("password");
    String user_email = request.getParameter("email");

    UserDao userHandler = UserDao.getInstance();

    int check;
    try {
        check = userHandler.userCheck(user_email,user_pwd);
        if(check==-1){
            try {
                userHandler.insertUser(user_email,user_nickname,user_pwd);
                response.sendRedirect("../../index.jsp");
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        else{
            session.setAttribute("msg","duplicate ID");
/*
            RequestDispatcher rd = request.getRequestDispatcher("register.jsp");
            rd.forward(request, response);
*/
            response.sendRedirect("register.jsp");
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
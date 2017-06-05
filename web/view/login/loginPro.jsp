<%--
  Created by IntelliJ IDEA.
  User: wontae
  Date: 2016. 7. 13.
  Time: 오후 8:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="dao.UserDao" %>



<%
    request.setCharacterEncoding("utf-8");
    UserDao userHandler = UserDao.getInstance();

    String email = request.getParameter("email");
    String password = request.getParameter("password");
   // String nickname = request.getParameter("nickname");

    int user_id;
    request.setAttribute("email",email);
    request.setAttribute("password",password);

    int check;

    try {
        user_id=userHandler.getUser_id(email);
        check = userHandler.userCheck(email,password);
        String nickname = userHandler.getNickname(email);
        //System.out.println(check);
        session.setAttribute("email",email);
        session.setAttribute("user_id",user_id);
        session.setAttribute("nickname",nickname);
        if(check==1){
            response.sendRedirect("../main.jsp");
        }
        else if(check==0){
            request.setAttribute("passwdErr","write password correctly.");
            response.sendRedirect("../../index.jsp");
        }
        else{
            session.setAttribute("idErr","write id or password correctly.");
//            RequestDispatcher rd = request.getRequestDispatcher("../../index.jsp");
//            rd.forward(request,response);
            response.sendRedirect("../../index.jsp");
        }
    } catch (Exception e) {
        e.printStackTrace();
    }



%>
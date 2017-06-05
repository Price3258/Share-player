<%--
  Created by IntelliJ IDEA.
  User: wontae
  Date: 2016. 7. 14.
  Time: 오전 11:34
  To change this template use File | Settings | File Templates.
--%>
<%
    if ((session.getAttribute("email") == null) || (session.getAttribute("email") == "")) {
        response.sendRedirect("../../index.jsp");
    } else {
%>
<%
    session.setAttribute("email", null);
    session.invalidate();
    response.sendRedirect("../../index.jsp");
%>
<%
    }
%>
<%@ page import="domain.Channel" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="dao.ChDao" %>
<%@ page import="dao.UserDao" %><%--
  Created by IntelliJ IDEA.
  User: wontae
  Date: 2016. 11. 10.
  Time: PM 4:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    if ((session.getAttribute("email") == null) || (session.getAttribute("email") == "")) {
        response.sendRedirect("../../index.jsp");
    } else {
            request.setCharacterEncoding("UTF-8");
%>
<%

    UserDao userHandler=UserDao.getInstance();
    ChDao chHandler = ChDao.getInstance();
    String email = (String) session.getAttribute("email");
    int user_id = userHandler.getUser_id(email);
    String search_name = request.getParameter("searchString");
    int ch_id = chHandler.getChid(user_id);
    ArrayList<Channel> chList= chHandler.getSearchChannelList(search_name);



%>
<!DOCTYPE HTML>
<html>
<head>

    <!-- Design import -->
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- Custom Fonts -->
    <link rel="stylesheet" href="http://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.6.3/css/font-awesome.min.css">

    <!-- Material Design fonts -->
    <link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Roboto:300,400,500,700" type="text/css">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">

    <!-- Bootstrap -->
    <link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" rel="stylesheet">

    <!-- Bootstrap Material Design -->
    <link href="../../dist/css/bootstrap-material-design.css" rel="stylesheet">
    <link href="../../dist/css/ripples.min.css" rel="stylesheet">

    <!-- Custom Style -->
    <link href="../../css/custom.css" rel="stylesheet">

    <!-- Jquery -->
    <script src="//code.jquery.com/jquery-1.10.2.min.js"></script>

    <!-- Bootstrap Js -->
    <script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>

    <!-- Bootstrap material Js -->
    <script src="../../dist/js/ripples.min.js"></script>
    <script src="../../dist/js/material.min.js"></script>
    <script>
        $.material.init();
    </script>

    <title>Channel List</title>

</head>

<body>



<div class="container-fluid">

    <div class="row">
        <!-- 네비게이션 -->
        <div class="navbar navbar-default white-nav">
            <div class="container-fluid">
                <div class="navbar-header">
                    <button class="navbar-toggle" type="button" data-toggle="collapse" data-target=".navbar-responsive-collapse">
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand" href="../main.jsp"><strong>Share Player</strong></a>
                </div>
                <div class="navbar-collapse collapse navbar-responsive-collapse">
                    <ul class="nav navbar-nav">
                        <li><a href="../main.jsp">HOME</a></li>
                        <li><a href="mainCh.jsp?ch_id=<%=ch_id%>">Go Your Channels</a></li>
                        <li class="active"><a href="chList.jsp">Search Channels</a></li>
                        <li><a href="../board/list.jsp">Board</a></li>
                        <li><a href="../login/logout.jsp">Log Out</a></li>
                        <li><a href="../register/leave.jsp">Drop Out</a></li>
                    </ul>
                    <form class="navbar-form navbar-left" action="search.jsp">
                        <div class="form-group">
                            <input class="form-control col-sm-8" type="text" name="searchString" placeholder="Search">

                        </div>
                    </form>

                    <script type="text/javascript">
                        function messagePopup(){
                            window.open('../message/message.jsp?user_id=<%=user_id%>', 'window팝업', 'width=700, height=420, menubar=no, status=no, toolbar=no');
                        }
                    </script>
                    <!-- Message -->
                    <button type="button" class="btn btn-default" aria-label="Left Align" onclick="messagePopup();">
                        <span class="glyphicon glyphicon-envelope"></span>
                    </button>

                    <ul class="nav navbar-nav navbar-right">
                        <li><a href="#" data-toggle="modal" data-target="#mymodal">How to use</a></li>
                    </ul>
                    <!-- /navbar-collapse collapse navbar-responsive-collapse -->
                </div>
                <!-- /container-fluid -->
            </div>
            <!-- /navbar navbar-default -->
        </div>
        <!-- //네비게이션 -->
    </div>

    <h1 class="chlist-head"><strong>All Channel</strong></h1>

    <%
        for (Channel ch : chList) {
          /*for(int i=0;i<chList.size();i++){
          Channel ch = chList.get(i);*/
    %>
    <div>

        <h1><strong> <img src="../../img/play-button.png" height="30" width="30">
            <a href="mainCh.jsp?ch_id=<%=ch.getCh_id()%>&email=<%=email%>"><%=ch.getNickname()%> - <%=ch.getCh_name()%>  </a></strong>
        </h1>

    </div>
    <%
        }
    %>






    <!-- How To Use Modal -->
    <div class="modal" id="mymodal">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button class="close" aria-hidden="true" type="button" data-dismiss="modal">x</button>
                    <h1 class="modal-title">How To Use</h1>
                </div>
                <div class="modal-body">
                    <h3>1. Go Youtube and Search</h3>
                    <h3>2. Check Link</h3>
                    <h3>2-1. Paste Link</h3>
                    <h3>3. Add Song</h3>
                    <h3>4. Select and Load</h3>
                    <h3>5. Play</h3>
                </div>
            </div>
        </div>
        <!-- /modal -->
    </div>



    <!-- /container-fluid -->
</div>
<!-- //container-fluid -->

</body>

<!-- Customize -->
<script>
    function goBack(){
        window.history.back();
    }
</script>
</html>



<%
    }
%>
<%@ page import="dao.ChDao" %>
<%@ page import="dao.UserDao" %><%--
  Created by IntelliJ IDEA.
  User: wontae
  Date: 2016. 8. 4.
  Time: 오후 9:41
  To change this template use File | Settings | File Templates.
--%>
<%
    request.setCharacterEncoding("UTF-8");
%>
<%
    if ((session.getAttribute("email") == null) || (session.getAttribute("email") == "")) {
        response.sendRedirect("../../index.jsp");
    } else {
%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<%
    String email= (String) session.getAttribute("email");

    UserDao userHandler =UserDao.getInstance();
    ChDao chHandler = ChDao.getInstance();
    int user_id= userHandler.getUser_id(email);
    int ch_id = chHandler.getChid(user_id);
%>
<html>
<head>
    <!-- Design import -->
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="http://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.6.3/css/font-awesome.min.css">
    <link rel="stylesheet" href="../../css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
    <script src="../../js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.10.0/css/bootstrap-select.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.10.0/js/bootstrap-select.min.js"></script>

    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

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

    <!-- 네이버 API -->
    <script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.2.js" charset="utf-8"></script>

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



    <title>Drop out</title>
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
                    <a class="navbar-brand"><strong>Share Player</strong></a>
                </div>
                <div class="navbar-collapse collapse navbar-responsive-collapse">
                    <ul class="nav navbar-nav">
                        <li><a href="../main.jsp">HOME</a></li>
                        <li><a href="../channel/mainCh.jsp?ch_id=<%=ch_id%>">Go Yours Channels</a></li>
                        <li><a href="../channel/chList.jsp">Channels</a></li>
                        <li><a href="../board/list.jsp">Board</a></li>
                        <li><a href="../login/logout.jsp">Log Out</a></li>
                        <li class="active"><a href="leave.jsp">Drop Out</a></li>
                    </ul>

                    <script type="text/javascript">
                        function messagePopup(){
                            window.open('../message/message.jsp?user_id=<%=user_id%>', 'window팝업', 'width=700, height=420, menubar=no, status=no, toolbar=no');
                        }
                    </script>
                    <!-- Message -->
                    <button type="button" class="btn btn-default" aria-label="Left Align" onclick="messagePopup();">
                        <span class="glyphicon glyphicon-envelope"></span>
                    </button>


                    <form class="navbar-form navbar-left" action="../channel/search.jsp">
                        <div class="form-group">
                            <input class="form-control col-sm-8" type="text" name="searchString" placeholder="Search">

                        </div>
                    </form>
                    <ul class="nav navbar-nav navbar-right">
                        <li><a href="#" data-toggle="modal" data-target="#mymodal">How to use</a></li>
                    </ul>
                    <!-- /navbar-collapse collapse navbar-responsive-collapse -->
                </div>
                <!-- /container-fluid -->
            </div>
            <!-- /navbar navbar-default -->
        </div>
    </div>
    <div style="margin-top:-20px; width:100%; height:150px; background-color:#B0BEC5; /*BLue Grey 200*/ color:#fff; padding-top:70px;">
        <p style="font-size:40px; margin-left:210px;">Drop out</p>
    </div>
    <div class="container">
        <div class="card" style="padding:20px;">
            <form action="leavePro.jsp" method="post">
            <div class="row">
                <div class="col-md-6 col-md-offset-3">

                    <div class="form-group label-floating">
                        <label for="email">Email (Using ID)</label>
                        <input id="email" class="form-control" type="text" name="email" max="50" value="" placeholder="ID" />
                    </div>

                    <div class="form-group label-floating">
                        <label for="password" id="password">Password </label>
                        <input class="form-control" type="password" name="password" max="20" value="" placeholder="password"/>
                    </div>

                    <input type="submit"  class="btn btn-default" value="Submit" />
                    <button onclick="goBack()" class="btn btn-md btn-primary">Cancel</button>

                </div>
            </div>
            </form>
        </div>
    </div>
    <!-- Cutomize -->
    <script>
        function goBack(){
            window.history.back();
        }
    </script>
</body>
</html>
<%
    }
%>
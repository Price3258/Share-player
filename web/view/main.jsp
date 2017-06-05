<%@ page import="dao.UserDao" %>
<%@ page import="dao.ChDao" %><%--
  Created by IntelliJ IDEA.
  User: wontae
  Date: 2016. 7. 13.
  Time: 오후 9:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF8" language="java" %>
<%
    request.setCharacterEncoding("UTF-8");
%>
<%
    if ((session.getAttribute("email") == null) || (session.getAttribute("email") == "")) {
        response.sendRedirect("../../index.jsp");
    } else {
%>
<%
    String email= (String) session.getAttribute("email");

    UserDao userHandler =UserDao.getInstance();
    ChDao chHandler = ChDao.getInstance();
    int user_id= userHandler.getUser_id(email);
    int ch_id = chHandler.getChid(user_id);
    String nickname= userHandler.getNickname(email);

%>
<!Doctype html>
<html>
<head>

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
    <link href="../dist/css/bootstrap-material-design.css" rel="stylesheet">
    <link href="../dist/css/ripples.min.css" rel="stylesheet">

    <!-- Custom Style -->
    <link href="../css/custom.css" rel="stylesheet">

    <!-- 네이버 API -->
    <script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.2.js" charset="utf-8"></script>

    <!-- Jquery -->
    <script src="//code.jquery.com/jquery-1.10.2.min.js"></script>

    <!-- Bootstrap Js -->
    <script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>

    <!-- Bootstrap material Js -->
    <script src="../dist/js/ripples.min.js"></script>
    <script src="../dist/js/material.min.js"></script>
    <script>
        $.material.init();
    </script>

    <title>Share Player</title>


</head>

<body>

<script type="text/javascript">
    function messagePopup(){
        window.open('message/message.jsp?user_id=<%=user_id%>', 'window팝업', 'width=700, height=420, menubar=no, status=no, toolbar=no');
    }
</script>
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
                    <a class="navbar-brand" href="main.jsp"><strong>Share Player</strong></a>
                </div>
                <div class="navbar-collapse collapse navbar-responsive-collapse">
                    <ul class="nav navbar-nav">
                        <li class="active"><a>HOME</a></li>
                        <li><a href="channel/mainCh.jsp?ch_id=<%=ch_id%>">Go Your Channels</a></li>
                        <li><a href="channel/chList.jsp">Channels</a></li>
                        <li><a href="board/list.jsp">Board</a></li>
                        <li><a href="login/logout.jsp">Log Out</a></li>
                        <li><a href="register/leave.jsp">Drop Out</a></li>
                    </ul>
                    <form class="navbar-form navbar-left" action="channel/search.jsp">
                        <div class="form-group">
                            <input class="form-control col-sm-8" type="text" name="searchString" placeholder="Search">

                        </div>
                    </form>
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

    <div class="row">
        <div class="main-center">
            <img class="camera" src="../img/camera.png" />
            <h1>Welcome <%=nickname%> !</h1>
            <h1>SharePlayer is most popular Web site</h1>
            <h1>You can see other people Channels whenever</h1>
        </div>
    </div>

    <div class="container">
        <div class="main-content1">
        </div>
        <div class="main-content2">
        </div>
        <div class="main-content3">
        </div>
    </div>



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

</html>
<%
    }
%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="dao.ChDao" %>
<%@ page import="dao.UserDao" %>

<jsp:useBean id="dao" class="dao.BoardDao"/>
<jsp:useBean id="vo1" class="domain.Board"/>
<%
    String email = (String) session.getAttribute("email");
    int idx = Integer.parseInt(request.getParameter("idx"));
    int pg = Integer.parseInt(request.getParameter("pg"));
    domain.Board vo = dao.getView(idx);
    String nickname = dao.getNickname(vo.getUser_id());

    ChDao chHandler = ChDao.getInstance();
    UserDao userHanlder = UserDao.getInstance();
    int user_id = userHanlder.getUser_id(email);
    int ch_id = chHandler.getChid(user_id);
%>

<script language = "javascript">

    function modifyCheck()
    {
        var form = document.modifyform;

        if( !form.title.value )
        {
            alert( "제목을 적어주세요" );
            form.title.focus();
            return;
        }

        if( !form.memo.value )
        {
            alert( "내용을 적어주세요" );
            form.memo.focus();
            return;
        }
        form.submit();
    }
</script>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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
    <link href="../../dist/css/bootstrap-material-design.css" rel="stylesheet">
    <link href="../../dist/css/ripples.min.css" rel="stylesheet">

    <!-- Custom Style -->
    <link href="../../css/custom.css" rel="stylesheet">

    <!-- 占썬�쇽옙��占� API -->
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

    <title>게시판</title>

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
                        <li><a href="../channel/mainCh.jsp?ch_id=<%=ch_id%>">Go Your Channels</a></li>
                        <li><a href="../channel/chList.jsp">Channels</a></li>
                        <li class="active"><a href="list.jsp">Board</a></li>
                        <li><a href="../login/logout.jsp">Log Out</a></li>
                        <li><a href="../register/leave.jsp">Drop Out</a></li>

                    </ul>
                    <form class="navbar-form navbar-left" action="../channel/search.jsp">
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
    </div>


    <div class="row">
        <div style="margin-top:-20px; width:100%; height:150px; background-color:#B0BEC5; /*BLue Grey 200*/ color:#fff; padding-top:70px;">
            <p style="font-size:40px; margin-left:230px;">Board</p>
        </div>
    </div>

</div><!--./container-fluid -->


<div class="container">

    <div class="card" style="margin-top:20px;">
        <!-- Modify -->
        <form name=modifyform method=post action="modify_ok.jsp?idx=<%=idx%>&pg=<%=pg%>">
            <table class="table">
                <tr style="text-align:center;">
                    <td colspan="2">글수정</td>
                </tr>
                <tr>
                    <td>제목</td>
                    <td><input class="form-control" type="text" name=title value="<%=vo.getBoard_title()%>"/></td>
                </tr>
                <tr>
                    <td>이름</td>
                    <td><%= nickname %></td>
                </tr>
                <tr>
                    <td>내용</td>
                    <td><textarea class="form-control" type="text" name=memo><%=vo.getBoard_content()%></textarea></td>
                </tr>
            </table>
            <div class="form-group">
                <div class="col-md-6">
                    <input class="btn btn-success" type="button" value="수정" OnClick="javascript:modifyCheck();">
                </div>
                <div class="col-md-6">
                    <input class="btn btn-warning" type="button" value="취소" OnClick="javascript:history.back(-1)">
                </div>
            </div>
        </form>
        <!-- //Modify -->
    </div>
</div>

</body>
</html>

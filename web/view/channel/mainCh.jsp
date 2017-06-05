<%@ page import="dao.ChDao" %>
<%@ page import="dao.SongDao" %>
<%@ page import="dao.UserDao" %>
<%@ page import="domain.Channel" %>
<%@ page import="domain.Song" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="dao.RecomDao" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    if ((session.getAttribute("email") == null) || (session.getAttribute("email") == "")) {
        response.sendRedirect("../index.jsp");
    } else {
%>
<%
    UserDao userHandler = UserDao.getInstance();
    ChDao chHandler= ChDao.getInstance();
    SongDao songHandler = SongDao.getInstance();
    //Singleton


    String email = (String)session.getAttribute("email");
    int user_id = userHandler.getUser_id(email);
    //user's user_id who logged in

    int ch_id = Integer.parseInt(request.getParameter("ch_id"));


    String ch_name = chHandler.getChName(ch_id);

    ArrayList<Song>songlist = songHandler.getSongList(ch_id);
    request.setAttribute("songlist",songlist);

    ArrayList<Channel> channelArrayList= chHandler.getOwnChannelList(user_id);

    int getUserIdByEmail = userHandler.getUser_id(email);
    int getUserIDbyChID=chHandler.getUser_id(ch_id);// Channel's User_id..

    RecomDao recomHandler = RecomDao.getInstance();

    int recommend =recomHandler.getRecom(ch_id);
    //채널의 추천수
    int nonrecommend=recomHandler.getNonRecom(ch_id);
    //채널의 비추천수

%>
<!Doctype HTML>
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
    <link href="../../css/custom.css?ver=1" rel="stylesheet">

    <!-- Custom Mobile Style -->
    <link href="../../css/mobile.css?ver=1" rel="stylesheet">

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

    <title><%=session.getAttribute("nickname")%>'s Channel</title>

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
                        <li class="active"><a href="mainCh.jsp?ch_id=<%=ch_id%>">Go Your Channels</a></li>
                        <li><a href="chList.jsp">Channels</a></li>
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

        <!-- /row -->
    </div>
    <!-- //row -->


    <div class="row">

        <!-- 사이드 바 -->
        <div class="side-bar-wrapper">
            <div class="side-bar-brand">
                Your Channels <a class="side-toggle" data-toggle="collapse" data-target="#side-bar-content"><img src="../../img/menu-button.png"  /></a>
            </div>
            <div id="side-bar-content" class="side-bar-content collapse">
                <ul class="list-group">
                    <li class="list-group-item"><Strong>All Channel</Strong></li>
                    <br>
                    <%
                        for (Channel ch : channelArrayList) {
                /*for(int i=0;i<chList.size();i++){
                    Channel ch = chList.get(i);*/
                    %>
                    <li class="list-group-item list-group-item-success">/<span><a href="mainCh.jsp?ch_id=<%=ch.getCh_id()%>&email=<%=email%>"><%=ch.getNickname()%>'s channel is <%=ch.getCh_name()%>   </a><br></span></li>
                    <%
                        }
                    %>
                    <li><a href="#" data-toggle="modal" data-target="#pluschannel"><img src="../../img/plus.png" /></a></li>
                </ul>
            </div>
        </div>
        <!-- //사이드바  -->

        <div class="mainCh-content-wrapper">
            <div class="card mainCh-content-card">

                <div style="text-align:right;">

                    <%
                        if (getUserIDbyChID==getUserIdByEmail){
                            //  // When user doesn't match with this channel
                    %>
                    <a href="deleteCh.jsp?ch_id=<%=ch_id%>"><img src="../../img/error_16.png" /></a>
                    <%
                        }
                    %>
                </div>
                <h1 class="mainCh-title"><strong><%=ch_name%></strong></h1>


                <!-- youtube player-->
                <div id="player"></div>
                <script>
                    // 2. This code loads the IFrame Player API code asynchronously.
                    var tag = document.createElement('script');

                    tag.src = "https://www.youtube.com/iframe_api";
                    var firstScriptTag = document.getElementsByTagName('script')[0];
                    firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);

                    // 3. This function creates an <iframe> (and YouTube player)
                    //    after the API code downloads.
                    var player;
                    var getSongID= [];

                    getSongID=[<% for(int i=0;i<songlist.size();i++){%>
                        "<%=songlist.get(i).getSong_link()%>"<%=i+1 <songlist.size() ? ",":""%>
                        <%
                        }
                        %>];

                    function onYouTubeIframeAPIReady() {
                        player = new YT.Player('player', {
                            height: '390',
                            width: '640',
                            loadPlaylist:{
                                listType:'playlist',
                                list:getSongID,
                                index:parseInt(0),
                                suggestedQuality:'small'
                            },
                            events: {
                                'onReady': onPlayerReady,
                                'onStateChange': onPlayerStateChange
                            }
                        });
                    }
                    // 4. The API will call this function when the video player is ready.
                    function onPlayerReady(event) {
                        event.target.loadPlaylist(getSongID);
                        event.target.setLoop(true);// When reach the final list, go first
                    }

                    // 5. The API calls this function when the player's state changes.
                    //    The function indicates that when playing a video (state=1),
                    //    the player should play for six seconds and then stop.
                    var done = false;
                    function onPlayerStateChange(event) {
                        if (event.data == YT.PlayerState.PLAYING && !done) {
                            //setTimeout(stopVideo, 6000);
                            done = true;
                        }
                    }
                    function stopVideo() {
                        player.stopVideo();
                    }
                </script>
                <!-- Player End-->

                <!-- 노래 추가 및 채널 리네임 (아코디언)-->
                <div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">

                    <%
                        if (getUserIDbyChID==getUserIdByEmail){
                      //  // When user doesn't match with this channel
                    %>
                    <!-- 첫번째 아코디언 (노래추가)-->
                    <div class="panel panel-default">
                        <div class="panel-heading" role="tab" id="headingOne">
                            <h4 class="panel-title">
                                <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                                    <strong>Add Song</strong>
                                </a>
                            </h4>
                        </div>
                        <div id="collapseOne" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingOne">
                            <div class="panel-body">
                                <form  action="../song/songPro.jsp?ch_id=<%=ch_id%>" method="post" onSubmit="return checkIt()">
                                    <div class="form-group label-floating form-group-lg">
                                        <label class="control-label" for="song_link">Link(Use to Youtube)</label>
                                        <input class="form-control" id="song_link" name="song_link" type="text">
                                    </div>
                                    <div class="form-group label-floating form-group-lg">
                                        <label class="control-label" for="song_name">song_name</label>
                                        <input class="form-control" id="song_name" name="song_name" type="text">


                                    </div>
                                    <div class="form-group label-floating form-group-lg">

                                        <label class="control-label" for="singer">singer</label>
                                        <input class="form-control" id="singer" name="singer" type="text">
                                    </div>

                                    <div class="form-group">
                                        <div class="col-md-12">
                                            <input type="submit" class="btn btn-raised btn-primary btn-block" data-inline="true" value="Add" />
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                    <!-- //첫번째 아코디언 -->

                    <!-- 두번째 아코디언 (채널 리네임)-->
                    <div class="panel panel-default">
                        <div class="panel-heading" role="tab" id="headingTwo">
                            <h4 class="panel-title">
                                <a class="collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
                                    <strong>Rename Channel</strong>
                                </a>
                            </h4>
                        </div>
                        <div id="collapseTwo" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingTwo">
                            <div class="panel-body">
                                <form action="renameChPro.jsp" method="post">
                                    <div class="form-group label-floating form-group-lg">
                                        <label class="control-label" for="ch_name"> New Channel's Name</label>
                                        <input class="form-control" type="text" id="ch_name" name="ch_name">
                                    </div>
                                    <div class="form-group">
                                        <input type="submit" class="btn btn-raised btn-primary btn-block" data-inline="true" value="Rename">
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                    <!-- //두번째 아코디언 -->

                    <!-- 세번째 아코디언 (노래 삭제)-->
                    <div class="panel panel-default">
                        <div class="panel-heading" role="tab" id="headingTwo">
                            <h4 class="panel-title">
                                <a class="collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseThree" aria-expanded="false" aria-controls="collapseTwo">
                                    <strong>Delete</strong>
                                </a>
                            </h4>
                        </div>
                        <div id="collapseThree" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingTwo">
                            <div class="panel-body">
                                <ul id="PlayList" class="list-group-item">
                                    <%
                                        for (Song option : songlist) {
                      				/*for(int i=0; i<songlist.size();i++){
                          			Song option= songlist.get(i);*/
                                    %>
                                    <li id="songList" class="list-group-item" value="<%=option.getSong_link()%>">
                                        <%=option.getSinger()%>
                                        <input id="delete" type="button" onclick="location.href='../song/delSong.jsp?song_id=<%=option.getSong_id()%>'" class="btn btn-raised btn-primary btn-block" value="Delete">

                                    </li>
                                    <%
                                        }
                                    %>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <!-- //세번째 아코디언 -->




                    <!-- /panel-group -->
                </div>
                <!-- //노래추가 및 리네임 (아코디언) -->

            </div>
        </div>


        <%
        }else{ //자신의 채널이 아닌 경우만 추천, 비추천이 가능.
        %>
        <!-- 네번째 아코디언 (채널 추천)-->
        <div class="panel panel-default">
            <div class="panel-heading" role="tab" id="headingTwo">
                <h4 class="panel-title">
                    <a class="collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseThree" aria-expanded="false" aria-controls="collapseTwo">
                        <strong>Recommend</strong>
                    </a>
                </h4>
            </div>
            <div id="collapseThree" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingTwo">
                <div class="panel-body">
                    <ul id="Recommend" class="list-group-item">
                        <li><input type="button" onclick="location.href='recommendController.jsp?ch_id=<%=ch_id%>'" class="btn btn-raised btn-primary btn-block" value="추천"></li>
                        <li><strong><%=recommend%></strong></li>
                    </ul>
                    <ul id="NONRecommend" class="list-group-item">
                        <li><input type="button" onclick="location.href='nonrecommendedController.jsp?ch_id=<%=ch_id%>'" class="btn btn-raised btn-primary btn-block" value="비추천"></li>
                        <li><strong><%=nonrecommend%></strong></li>
                    </ul>
                </div>
            </div>
        </div>
        <!-- //네번째 아코디언 -->


        <!-- -->
    <%
        }
    %>



        <!-- /row -->
    </div>
    <!-- //row -->




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

    <!-- 채널 추가 모달 -->
    <div class="modal" id="pluschannel">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button class="close" aria-hidden="true" type="button" data-dismiss="modal">x</button>
                    <h1 class="modal-title">Plus Channel</h1>
                </div>
                <div class="modal-body">
                    <form action="chPro.jsp" method="post">
                        <input class="form-control" id="ch_name" name="ch_name" type="text">
                        <input type="submit" class="btn btn-raised btn-primary btn-block" value="plus" />
                    </form>
                </div>
            </div>
        </div>
    </div>
    <!-- //채널 추가 모달 -->




    <!-- /container-fluid -->
</div>
<!-- //container-fluid -->



<!--import JS file -->
<script>

</script>

</body>
</html>
<%
    }
%>

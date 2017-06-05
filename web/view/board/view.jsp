<%@page import="dao.ChDao"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="dao.UserDao" %>
<%@ page import="domain.Board" %>
<%@ page import="domain.Reply" %>
<%@ page import="java.util.ArrayList" %>
<jsp:useBean id="dao" class="dao.BoardDao"/>
<jsp:useBean id="Rdao" class="dao.ReplyDao"/>
<jsp:useBean id="Rvo" class="domain.Reply"/>
<script language = "javascript">
    function replycheck(){	//댓글의 내용이 있나 없나 체크

        var form = document.replyform;

        if( !form.reply.value )
        {
            alert( "내용을 적어주세요" );
            form.reply.focus();
            return;
        }
        else{
            form.submit();
        }
    }


</script>
<%
    String email= (String)session.getAttribute("email");
    String logined_nick = dao.getNickname(email);				// 로그인된 닉네임
    int idx = Integer.parseInt(request.getParameter("idx"));	// 게시판 번호
    int pg = Integer.parseInt(request.getParameter("pg"));		// 페이지 번호
    int total = Rdao.count(idx);								// 댓글의 갯수

    ArrayList<domain.Reply> alist = Rdao.getThisReply(idx);		// reply 테이블에 있는 게시판 번호에 해당하는 댓글을 가져옴

    Board vo = dao.getView(idx);								// 해당게시글의 댓글을 보여줌
    dao.UpdateHit(idx);											// 조회수1증가
    String nickname = dao.getNickname(vo.getUser_id());			// 게시글을 게시한 사람의 닉네임
    ChDao chHandler = ChDao.getInstance();

    UserDao userHanlder = UserDao.getInstance();
    int user_id = userHanlder.getUser_id(email);
    int ch_id = chHandler.getChid(user_id);

%>
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
                        <li><a href="../channel/mainCh.jsp?ch_id=<%=ch_id%>">Go Yours Channels</a></li>
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
    </div><!-- ./row -->

    <div class="row">
        <div style="margin-top:-20px; width:100%; height:150px; background-color:#B0BEC5; /*BLue Grey 200*/ color:#fff; padding-top:70px;">
            <p style="font-size:40px; margin-left:230px;">Board</p>
        </div>
    </div>

</div><!-- ./ container-fluid -->


<div class="container">
    <div class="card" style="margin-top:20px; padding: 20;">

        <!-- 게시판 글 내용 보기 -->
        <table class="table">
            <tr style="text-align:center;">
                <td colspan="2">내용</td>
            </tr>
            <tr>
                <td>글번호</td>
                <td><%=idx%></td>
            </tr>
            <tr>
                <td>조회수</td>
                <td><%=vo.getHits()%></td>
            </tr>
            <tr>
                <td>이름</td>
                <td><%=nickname%></td>
            </tr>
            <tr>
                <td>작성일</td>
                <td><%=vo.getSince()%></td>
            </tr>
            <tr>
                <td>제목</td>
                <td><%=vo.getBoard_title()%></td>
            </tr>
            <tr>
                <td colspan="2"><%=vo.getBoard_content() %></td>
            </tr>
        </table>
        <!-- // 게시판 글내용 보기 -->

        <!-- 게시판 댓글 보기 -->
        <table class="table">
            <%if(total == 0){						// 댓글의 갯수가 0이면
            %>
            <tr>
                <td>등록된 댓글이 없습니다.</td>

            </tr>

            <% }else{								// 댓글의 갯수가 0이 아니면

                for(int i=0;i<alist.size();i++){
                    Reply rvo = alist.get(i);
                    String r_nickname = dao.getNickname(rvo.getUser_id());	// 댓글 작성자의 닉네임
                    String since = rvo.getSince();							// 댓글 작성 시간
                    String content = rvo.getReply_content();				// 댓글 내용
            %>
            <tr>
                <td><%=r_nickname %></td>
                <td><%=content %></td>
                <%if(logined_nick.equals(r_nickname)){
                %>
                <form method="post" action="reply_delete.jsp?reply_id=<%=rvo.getReply_id()%>&pg=<%=pg%>&idx=<%=idx%>">
                    <td><input type="submit" class="btn btn-danger" value="삭제"></td>
                </form>
                <% }%>
            </tr>

            <%} %>

            <%} %>

        </table>
        <!-- // 게시판 댓글 보기 -->

        <!-- 게시판 댓글 달기 -->
        <form name="replyform" method="post" action="reply_ok.jsp?idx=<%=idx %>&pg=<%=pg%>">
            <table class="table">
                <tr>
                    <td>댓글</td>
                    <td><input class="form-control" type="text" name="reply"/></td>
                    <td><input type="button" class="btn btn-success" value="등록" OnClick="javascript:replycheck();"></td>
                </tr>
            </table>
        </form>
        <!-- // 게시판 댓글 달기 -->

        <!-- 글 수정 및 삭제 and 돌아가기 -->
        <table class="table">
            <tr>
                <td>
                    <input type=button value="글쓰기" class="btn btn-raised btn-default" OnClick="window.location='write.jsp'">
                </td>
                <td>
                    <input type=button value="목록" class="btn btn-raised btn-default" OnClick="window.location='list.jsp?pg=<%=pg%>'">
                </td>
                <%if(logined_nick.equals(nickname)){	// 로그인된 닉네임과 글 작성자의 닉네임이 동일하면 수정과 삭제 버튼이 나온다.
                %>
                <td>
                    <input type=button value="수정"  class="btn btn-raised btn-default"OnClick="window.location='modify.jsp?idx=<%=idx%>&pg=<%=pg%>'">
                </td>
                <td>
                    <input type=button value="삭제" class="btn btn-raised btn-default" OnClick="window.location='delete_ok.jsp?idx=<%=idx%>&pg=<%=pg%>'">
                </td>
                <%} %>
            </tr>
        </table>
        <!-- //글 수정 및 삭제 and 돌아가기 -->

    </div>
</div>

</body>
</html>

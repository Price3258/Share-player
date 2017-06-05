<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="dao.MessageDao" %>
<jsp:useBean id="dao" class="dao.MessageDao"></jsp:useBean>
<% String email= (String)session.getAttribute("email");
    int user_id = dao.getuser_id(email);
    String nickname = dao.getNickname(user_id);
%>
<script language = "javascript">  // 자바 스크립트 시작

function writeCheck()				// 게시글을 작성하기 앞서 제목과 내용이 작성 되었는지 체크
{
    var form = document.writeform;

    if( !form.receive_id.value )
    {
        alert( "받는 사람을 적어주세요" );
        form.receive_id.focus();
        return;
    }

    if( !form.title.value )
    {
        alert( "제목을 적어주세요" );
        form.title.focus();
        return;
    }

    if( !form.content.value )
    {
        alert( "내용을 적어주세요" );
        form.content.focus();
        return;
    }

    form.submit();
}
</script>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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

    <title>쪽지 보내기</title>

</head>
<style>
    .leftMenu {
        float: left;
        width: 25%;
        height: 100%;
        boder: 1px;
        padding: 20px;
    }

    .MainMenu {
        float: right;
        width: 70%;
        height: 100%;
        boder: 1px;
        padding: 20px;
    }
</style>

<body>
<div class="leftMenu">
    <table class="table">
      <thead>
        <tr><td><%=nickname %>님의 쪽지함</td></tr>
      </thead>
        <tr><td><a href="message.jsp">받은 쪽지함</a></td></tr>
        <tr><td><a href="sendMessage.jsp">쪽지 보내기</a></td></tr>
    </table>
</div>

<div class="Mainmenu">

    <form name=writeform method=post action="sendOk.jsp?send_id=<%=user_id%>">
        <table class="table">
            <tr style="text-align:center;">
                <td colspan="2">쪽지 보내기</td>
            </tr>
            <tr>
                <td>보낼사람</td>
                <td><input class="form-control" type="text" name="receive_id" /> </td>
            </tr>
            <tr>
                <td>제목</td>
                <td><input class="form-control" type="text" name="title"/></td>
            </tr>
            <tr>
                <td>내용</td>
                <td height="200" colspan="2"><textarea class="form-control" style="height:100%;" name="content"></textarea></td>
            </tr>
            <tr>
                <td><input class="btn btn-success" type=button value="보내기" OnClick="javascript:writeCheck();"></td>
                <td><input class="btn btn-info" type=button value="취소" OnClick="javascript:history.back(-1)"></td>
            </tr>
        </table>
    </form>

</div>

</body>
</html>

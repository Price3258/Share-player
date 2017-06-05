<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.MessageDao" %>
<%@ page import="domain.Message" %>
<jsp:useBean id="dao" class="dao.MessageDao"/>



<%
	String email= (String)session.getAttribute("email");
	int logined = dao.getuser_id(email);				// 로그인된 user_id
	int idx = Integer.parseInt(request.getParameter("idx"));	// 게시판 번호
	int pg = Integer.parseInt(request.getParameter("pg"));		// 페이지 번호
	System.out.println(idx);

	Message vo = dao.getMessageList(idx);		// reply 테이블에 있는 게시판 번호에 해당하는 댓글을 가져옴

	System.out.println(vo.getSend_user());
	dao.readMessage(idx);							// 해당 쪽지를 읽음으로 변경
	String nickname = dao.getNickname(vo.getSend_user());			// 게시글을 게시한 사람의 닉네임
%>
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


    <title>쪽지함</title>

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
			<tr><td><%=dao.getNickname(logined) %>님의 쪽지함</td></tr>
		</thead>
		<tbody>
			<tr><td><a href="message.jsp">받은 쪽지함</a></td></tr>
			<tr><td><a href="sendMessage.jsp">쪽지 보내기</a></td></tr>
		</tbody>
	</table>
	</div>
<div class="MainMenu">

  <table class="table">
    <tr style="text-align:center;">
      <td colspan="2">내용</td>
    </tr>
    <tr>
      <td>보낸 사람</td>
      <td><%=nickname%></td>
    </tr>
    <tr>
      <td>제목</td>
      <td><%=vo.getTitle()%></td>
    </tr>
    <tr>
      <td>작성일</td>
      <td><%=vo.getSince()%></td>
    </tr>
    <tr>
      <td height="250" colspan="2"><%=vo.getContent() %></td>
    </tr>
    <tr>
      <td><input class="btn btn-success" type=button value="답장" OnClick="window.location='sendReply.jsp?nickname=<%=nickname%>'"></td>
      <td><input class="btn btn-info" type=button value="목록으로" OnClick="window.location='message.jsp'"></td>
    </tr>
  </table>

</div>
</body>
</html>

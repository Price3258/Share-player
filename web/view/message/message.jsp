<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ page import="dao.MessageDao" %>
<%@ page import="domain.Message" %>

<%
	String email= (String) session.getAttribute("email");
	MessageDao Mdao = MessageDao.getInstance();
	int user_id= Mdao.getuser_id(email);
	int total = 0;
	if(Mdao.receive_count(user_id) != 0){
		total = Mdao.receive_count(user_id);
	}
	String nickname = "";


	ArrayList<Message> alist = Mdao.getMessage(user_id);		//리스트를 받아 저장할 ArrayList

	int size = alist.size();
	int size2 = size;

	final int ROWSIZE = 8;								//페이징 게시글의 제한 수
	final int BLOCK = 9;
	int indent = 0;

	int pg = 1;											//페이지 변수

	if(request.getParameter("pg")!=null) {
		pg = Integer.parseInt(request.getParameter("pg"));
	}

	int end = (pg*ROWSIZE);

	int allPage = 0;

	int startPage = ((pg-1)/BLOCK*BLOCK)+1;
	int endPage = ((pg-1)/BLOCK*BLOCK)+BLOCK;

	allPage = (int)Math.ceil(total/(double)ROWSIZE);

	if(endPage > allPage) {
		endPage = allPage;
	}

	size2 -=end;
	if(size2 < 0) {
		end = size;
	}

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

	<title>Insert title here</title>
</head>
<style>
	.leftMenu {
		float: left;
		width: 25%;
		height: 100%;
		padding: 20px;
	}

	.MainMenu {
		float: right;
		width: 70%;
		height: 100%;
		margin-left: 1%;
		padding-top: 20px;
		padding-right: 20px;
	}

	.MidSide {
		float: left;
		width: 4%;
		height: 100%;
		padding-top: 20px;
	}
</style>
<body>

<div class="leftMenu">
	<table class="table">
		<thead>
		<tr><td><%=Mdao.getNickname(user_id) %>님의 쪽지함</td></tr>
		</thead>
		<tbody>
		<tr><td><a href="message.jsp">받은 쪽지함</a></td></tr>
		<tr><td><a href="sendMessage.jsp">쪽지 보내기</a></td></tr>
		</tbody>
	</table>
</div>
<div class="MidSide">
	<img src="../../img/spring2.png">
</div>
<div class="MainMenu">
	<table class="table table-hover">
		<thead>
		<tr>
			<td width="200">제목</td>
			<td width="100" align="center">보낸사람</td>
			<td width="150" align="center">날짜</td>
			<td width="73" align="center">읽음</td>
		</tr>
		</thead>
		<tbody>
		<%if(total == 0){

		%><tr align="center" bgcolor="#FFFFFF" height="30">
			<td colspan="6">등록된 글이 없습니다.</td>
		</tr>
		<%}else{
			for(int i=ROWSIZE*(pg-1); i<end;i++){
				Message vo = alist.get(i);
				//indent = vo.getIndent();
				int idx = vo.getM_id();
		%>
		<tr height="25" align="center">
			<td align="left">
				<a style="text-decoration:none;" href="content.jsp?idx=<%=idx%>&pg=<%=pg%>"><%=vo.getTitle()%>
				</a></td>
			<td align="center"><%=Mdao.getNickname(vo.getSend_user())%></td>
			<td align="center"><%=vo.getSince() %></td>
			<td align="center">
				<%if(!vo.isIs_read()){
				%>New
				<% } else{
				%>읽음
				<%} %>
			</td>

				<% } }%>
		</tbody>
	</table>
	<div style="text-align:center;">
		<ul class="pagination pagination-sm">
			<%
				if(pg>BLOCK) {
			%>
			[<li><a href="message.jsp?pg=1">◀◀</a></li>]
			[<li><a href="message.jsp?pg=<%=startPage-1%>">◀</a></li>]
			<%
				}
			%>

			<%
				for(int i=startPage; i<= endPage; i++){
					if(i==pg){
			%>
			<li class="active"><a href="#"><%=i %></a></li>
			<%
			}else{
			%>
			<li><a href="message.jsp?pg=<%=i %>"><%=i %></a></li>
			<%
					}
				}
			%>

			<%
				if(endPage<allPage){
			%>
			[<li><a href="message.jsp?pg=<%=endPage+1%>">▶</a></li>]
			[<li><a href="message.jsp?pg=<%=allPage%>">▶▶</a></li>]
			<%
				}
			%>
		</ul>
	</div>
</div>

</body>
</html>

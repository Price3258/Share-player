<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="dao.ChDao" %>
<%@ page import="domain.Board" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="dao.UserDao" %>
<jsp:useBean id="Rdao" class="dao.ReplyDao"/>
<jsp:useBean id="dao" class="dao.BoardDao"/>
<% String email= (String)session.getAttribute("email");
%>

<%
	int total = dao.count();							//게시물의 총 갯수
	ArrayList<Board> alist = dao.getMemberList();		//리스트를 받아 저장할 ArrayList
	int size = alist.size();
	int size2 = size;

	final int ROWSIZE = 10;								//페이징 게시글의 제한 수
	final int BLOCK = 11;
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
			<p style="font-size:40px; margin-left:210px;">Board</p>
		</div>
		<a href="write.jsp">
			<div style="margin-left:80px; margin-top:-80px; width:100px; height:100px; border-radius:100px; background-color:#607D8B; /*BLue Grey 500*/ text-align:center; padding-top:30px;">
				<img src="../../img/plus.png" />
			</div>
		</a>
	</div>

	<table class="table table-striped table-hover">
		<thead>
		<tr>
			<th>&nbsp;</th>
			<th>&nbsp;</th>
			<th>글번호</th>
			<th>제목</th>
			<th>작성자</th>
			<th>작성일</th>
			<th>조회수</th>
		</tr>
		</thead>
		<tbody>
		<%
			if(total==0) {		//작성된 글이 없을 경우
		%>
		<tr align="center" bgcolor="#FFFFFF" height="30">
			<td colspan="6">등록된 글이 없습니다.</td>
		</tr>
		<%
		} else {
			for(int i=ROWSIZE*(pg-1); i<end;i++){
				Board vo = alist.get(i);
				//indent = vo.getIndent();
				int idx = vo.getBoard_id();
		%>
		<tr>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td><%=idx%></td>
			<td>
				<a style="text-decoration:none;" href="view.jsp?idx=<%=idx%>&pg=<%=pg%>"><%=vo.getBoard_title()%>
				</a>	<!-- 게시글을 클릭했을 경우 idx,pg,Board_title의 값을 넘겨줌 -->
				<%
					if(Rdao.count(idx) > 0){			// 게시글 제목 옆에 [숫자]식으로 댓글의 수를 표현해 주기 위함
				%>
				[<%=Rdao.count(idx) %>]
				<% }%>
			</td>
			<td><%=vo.getEmail()%></td>
			<td><%=vo.getSince() %></td>
			<td><%=vo.getHits() %></td>
			<td>&nbsp;</td>

				<% } }%>
		</tbody>
	</table>
	<div style="text-align:center;">
		<ul class="pagination pagination-lg">
			<%
				if(pg>BLOCK) {
			%>
			[<li><a href="list.jsp?pg=1">◀◀</a></li>]
			[<li><a href="list.jsp?pg=<%=startPage-1%>">◀</a></li>]
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
			<li><a href="list.jsp?pg=<%=i %>"><%=i %></a></li>
			<%
					}
				}
			%>
			<%
				if(endPage<allPage){
			%>
			[<li><a href="list.jsp?pg=<%=endPage+1%>">▶</a></li>]
			[<li><a href="list.jsp?pg=<%=allPage%>">▶▶</a></li>]
			<%
				}
			%>
		</ul>
	</div>
</div>
</body>
</html>

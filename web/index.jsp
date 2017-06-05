<%-- Created by IntelliJ IDEA. --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  request.setCharacterEncoding("UTF-8");
%>
<!Doctype html>
<html>
<head>


  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">

  <!-- Custom Fonts -->
  <link rel="stylesheet" href="http://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.6.3/css/font-awesome.min.css">

  <!-- Material Design fonts -->
  <link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Roboto:300,400,500,700" type="text/css">
  <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">

  <!-- Bootstrap -->
  <link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" rel="stylesheet">

  <!-- Bootstrap Material Design -->
  <link href="dist/css/bootstrap-material-design.css" rel="stylesheet">
  <link href="dist/css/ripples.min.css" rel="stylesheet">

  <!-- Custom Style -->
  <link href="css/custom.css" rel="stylesheet">

  <!-- Jquery -->
  <script src="//code.jquery.com/jquery-1.10.2.min.js"></script>

  <!-- Bootstrap Js -->
  <script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>

  <!-- Bootstrap material Js -->
  <script src="dist/js/ripples.min.js"></script>
  <script src="dist/js/material.min.js"></script>
  <script>
    $.material.init();
  </script>

  <!-- Firebase init -->
  <script src="https://www.gstatic.com/firebasejs/3.5.1/firebase.js"></script>
  <script src="firebase/init.js"></script>

  <title>Share Player</title>

</head>
<%
  String passwdErr =(String)session.getAttribute("passwdErr");
  if(passwdErr==null){
    passwdErr="";
  }
  String idErr =(String)session.getAttribute("idErr");
  if(idErr==null){
    idErr="";
  }
%>


<body>

<div class="container-fluid index_bg-signup_bg-signout_bg">

  <div class="row vcenter">
    <div class="col-md-6 col-md-offset-3">
      <h1>Share Player</h1>
      <br />

      <div class="card login-card">
        <!-- 로그인 폼 -->
        <form class="login_form" action="view/login/loginPro.jsp" method="post">
          <div class="form-group label-floating form-group-lg">
            <label class="control-label" for="email" >Email</label>
            <input class="form-control" id="email" name="email" type="text" >
          </div>
          <p id="idErr"><%=idErr%></p>
          <div class="form-group label-floating form-group-lg">
            <label class="control-label" for="password">Password</label>
            <input class="form-control" id="password" name="password" type="password">
          </div>
          <p id="passwdErr"><%=passwdErr%></p>
          <div class="form-group">
            <div class="col-md-6">
              <!-- 일반 로그인 -->
              <input type="submit" class="btn btn-raised btn-primary btn-block" value="Login" />
            </div>
            <div class="col-md-6">
              <!-- 회원가입 -->
              <input type="button"  onclick="location.href='view/register/register.jsp'" class="btn btn-raised btn-warning btn-block" value="Sign up">
            </div>
          </div>
        </form>
        <!-- //로그인 폼 -->

      </div>



    </div>
    <!-- /row -->
  </div>
  <!-- //row -->



</div>
<!-- //container-fluid -->
</body>
<footer>

</footer>
</html>

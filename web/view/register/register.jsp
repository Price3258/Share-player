<%--
  Created by IntelliJ IDEA.
  User: wontae
  Date: 2016. 7. 13.
  Time: 오후 8:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setCharacterEncoding("UTF-8");
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
    <link href="../../css/custom.css" rel="stylesheet">

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

    <title>Register Page</title>

</head>

<body>

<script>
    function checkIt() {
        var userInput = document.userinput;
        if(!userInput.email.value) {
            alert("need email");
            userInput.email.focus();
            return false;
        }
        if(!userInput.password.value ) {
            alert("need password");
            userInput.password.focus();
            return false;
        }
        if(!userInput.nickname.value) {
            alert("need your nickname");
            userInput.name.focus();
            return false;
        }
        return true;
    }
    function fn_press_han(obj)
    {
        //좌우 방향키, 백스페이스, 딜리트, 탭키에 대한 예외
        if(event.keyCode == 8 || event.keyCode == 9 || event.keyCode == 37 || event.keyCode == 39
                || event.keyCode == 46 ) return;
        //obj.value = obj.value.replace(/[\a-zㄱ-ㅎㅏ-ㅣ가-힣]/g, '');
        obj.value = obj.value.replace(/[\ㄱ-ㅎㅏ-ㅣ가-힣]/g, '');
    }
</script>
<%
    String msg= (String)session.getAttribute("msg");
    if(msg==null){
        msg="";
    }
%>


<div class="container-fluid index_bg-signup_bg-signout_bg">

    <div class="row vcenter">
        <div class="col-md-6 col-md-offset-3">
            <h2>Sign In Our Site</h2>
            <h4>Insert Your Email, NickName, PassWord</h4>
            <br />

            <div class="card signup-card">
                <!-- 회원가입 폼 -->
                <form name="userinput" action="regisPro.jsp" method="post"  onSubmit="return checkIt()">
                    <div class="form-group label-floating">
                        <label class="control-label" for="email">Email</label>
                        <input class="form-control" id="email" name="email" type="text" value="" onkeydown="fn_press_han(this);">
                    </div>
                    <div class="form-group label-floating">
                        <label class="control-label" for="nickname">NickName</label>
                        <input class="form-control" id="nickname" name="nickname" type="text" value="">
                    </div>
                    <div class="form-group label-floating">
                        <label class="control-label" for="password">Password</label>
                        <input class="form-control" id="password" name="password" type="password" value="" onkeydown="fn_press_han(this);">
                    </div>
                    <div class="form-group">
                        <div class="col-md-6">
                            <input type="submit"  onclick="location.href='../../index.jsp'" class="btn btn-raised btn-success btn-block" value="Submit" />
                        </div>
                        <div class="col-md-6">
                            <input type="button" onclick="location.href='../../index.jsp'" class="btn btn-raised btn-danger btn-block" value="Login here">
                        </div>
                    </div>
                </form>
                <!-- //회원가입 폼 -->
            </div>

        </div>
    </div>

    <!-- /container-fluid -->
</div>


</body>
</html>

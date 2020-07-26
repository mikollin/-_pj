

<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>


<html>

<%
  request.setCharacterEncoding("UTF-8");
  response.setCharacterEncoding("UTF-8");
%>

<head>

  <meta charset="UTF-8" >

  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <!-- 以上代码IE=edge告诉IE使用最新的引擎渲染网页，chrome=1则可以激活Chrome Frame. -->
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <!-- 让当前 viewport 的宽度等于设备的宽度 -->

  <title>my_pj_注册</title>
  <script src="source/jquery-1.10.2/jquery-1.10.2.js"></script>

  <script src="source/bootstrap/js/bootstrap.min.js"></script>
  <link href="source/bootstrap/css/bootstrap.min.css" rel="stylesheet" />

  <script src="source/bootstrapValidator/js/bootstrapValidator.min.js"></script>
  <link href="source/bootstrapValidator/css/bootstrapValidator.min.css" rel="stylesheet" />

  <link rel="stylesheet" href="source/font-awesome-4.7.0/css/font-awesome.min.css"/>

  <link rel="stylesheet" type="text/css" media="screen" href="source/css/style.css" />

</head>




<body>

<header>

  <div>

    <div id="title">Hello World</div>

    <div id="titlebottom">

      Welcome to the "Hello World" to share your great pictures with us!


    </div>

    <div id="login" >

      <div>REGISTER TO YOUR ACCOUNT</div>


      <div>
        <form action="<%= request.getContextPath()%>/register" method="POST" id="to_login" >

          <div class="form-group">
            <label>Username</label>
            <input class="form-control"  id="id" name="id" type="text" placeholder="use letters&numbers" required>
            <!--                        <span class="deom">!!!</span> &lt;!&ndash;提示信息&ndash;&gt;-->
          </div>
          <div class="form-group">
            <label>Email</label>
            <input class="form-control"  id="email" name="email" type="email" placeholder=" Input Email like ***@126.com" required>
          </div>
          <div class="form-group">
            <label>Password</label>
            <input class="form-control" id="password1" name="password1" type="password" placeholder=" Create your password" required>


<%--            <%if(request.getParameter("password1").matches("^(?!([a-zA-Z]+|\\d+)$)[a-zA-Z\\d]{1,}$")){ %>--%>
            <small class="help-block" id="rightPass" data-tv-validator="regexp" data-bv-for="password1" style="color:green;display: inline-block"> </small>
<%--            --%>
<%--            <small style="font-size:18px;color:rgb(191,42,42)"> <i class="fa fa-exclamation-circle" aria-hidden="true"></i> 弱密码</small>--%>
<%--           --%>


          </div>
          <div class="form-group">
            <label>Confirm Password</label>
            <input class="form-control" id="password2" name="password2" type="password" placeholder=" Confirm your password" required>
          </div>
          <!-- 设置type使得密码不会显示出来 -->

          <div class="form-group">
            <label>Verification Code</label>
            <input class="form-control" id="verificationCode" name="verificationCode" type="text" placeholder=" Input the verification code" required>
            <img src="validateCodeServlet"  class="img-rounded" οnclick="this.src='validateCodeServlet?'+Math.random();" />

          </div>


          <br>



          <div class="form-group">
            <button type="submit" id="register_submit" name="login_submit" class="btn btn-primary">register</button>
            <!--因为插件用的是jquery的submit 方法，不能用name="submit" 属性-->
          </div>


        </form>
      </div>


      <br>

    </div>







  </div>

</header>


<footer>

  <div>

    <div>

      <p>LEARN MORE</p>

      <p>How it works?</p>

      <p>Meeting tools</p>

      <p>Live streaming</p>

      <p>Contact Method</p>

    </div>

    <div>

      <p>ABOUT US</p>

      <P>About us</P>

      <p>Features</p>

      <p>Privacy police</p>

      <p>Terms & Conditions</p>

    </div>

    <div>

      <p>SUPPORT</p>

      <p>FAQ</p>

      <p>Contact us</p>

      <p>Live chat</p>

      <p>Phone call</p>

    </div>

    <div>

      <p>ENJOY YOUR LIFE</p>

      <p>Copyright &copy 2010-2021 Yiling Zhao. </p>
      <p>All rights reserved.</p>
      <p> 备案号：18300290055</p>

    </div>

    <div>
      <p>

        <!-- wechat -->
        <img id="icon" src="source/img/二维码.jpg" />

      </p>

    </div>



  </div>


</footer>



</body>



</html>
<script src="source/js/register.js" ></script>
<script defer>
  let password=document.getElementById("password1");
  let passMess=document.getElementById("rightPass");
  password.onchange=function() {

    if (password.value.match("^(?!([a-zA-Z]+|\\d+)$)[a-zA-Z\\d]{6,12}$")) {
      let message = "<i class=\"fa fa-lightbulb-o\" aria-hidden=\"true\"></i> 强密码";
      passMess.style.color = "green";
      passMess.innerHTML = message;
    } else if (password.value.match("^[a-zA-Z\\d]{1,}$")) {
      passMess.style.color = "rgb(191,42,42)";
      let message = "<i class=\"fa fa-lightbulb-o\" aria-hidden=\"true\"></i> 弱密码";

      passMess.innerHTML = message;
    }else if(!password.value.match("[a-zA-Z\\d]{1,}$")) {
      passMess.innerHTML="";
    }
  }
</script>

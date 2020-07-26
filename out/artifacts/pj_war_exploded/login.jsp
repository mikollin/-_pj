

<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>


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

  <title>my_pj_登录</title>
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

      <div>LOG IN TO YOUR ACCOUNT</div>


      <div>
        <form action="<%= request.getContextPath()%>/login" method="POST" id="to_login" >

          <div class="form-group">
            <label>Username/Email</label>
            <input class="form-control" id="id" name="id" type="text" placeholder="Username/Email" value="<%= (request.getParameter("id")==null)?"": request.getParameter("id")%>" required>
            <!--                        <span class="deom">!!!</span> &lt;!&ndash;提示信息&ndash;&gt;-->
            <%if(request.getAttribute("message")!=null){ %>
            <%= "<small id=\"message\" style=\"font-size:18px;color:rgb(191,42,42);font-weight: bolder;\"> <i class=\"fa fa-exclamation-circle\" aria-hidden=\"true\"></i> "+request.getAttribute("message")+"</small>" %>
            <% } %>

          </div>
          <div class="form-group">
            <label>Password</label>
            <input class="form-control"  id="password" name="password" type="password" placeholder=" Input your password" value="<%= (request.getParameter("password")==null)?"": request.getParameter("password")%>" required>
          </div>

          <div class="form-group">
            <label>Verification Code</label>
            <input class="form-control" id="verificationCode" name="verificationCode" type="text" placeholder=" Input the verification code" required>
            <img src="validateCodeServlet"  class="img-rounded" οnclick="this.src='validateCodeServlet?'+Math.random();" />

          </div>



          <%

            if(request.getAttribute("message")==null) {
              request.getSession().setAttribute("referer", request.getHeader("referer"));
              System.out.println(request.getHeader("referer"));
            }
          %>



          <br>

          <div class="form-group">
            <button type="submit" id="login_submit" name="login_submit" class="btn btn-primary">login</button>
            <!--因为插件用的是jquery的submit 方法，不能用name="submit" 属性-->
          </div>


        </form>
      </div>


      <br>

      <a id="special" href="register.jsp">IF YOU HAVEN'T REGISTERED, CLICK THIS</a>


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
<%
  if(request.getAttribute("message")!=null&&request.getAttribute("message").equals("用户名和密码错误")){
%>
<script>
  let username=document.getElementById("id");
  username.style.borderColor="rgb(191,42,42)";
  username.style.borderWidth="5px";
</script>
<% } else if(request.getAttribute("message")!=null&&request.getAttribute("message").equals("登录成功")){ %>
<script>


//  let forms=document.getElementById("login_submit");
//  forms.onclick=function () {
    let small=document.getElementById("message");

    small.style.color="green";

    alert("登录成功!");

 //   }
<% String path=(String)session.getAttribute("referer");%>
  window.location.href="<%= path%>";
<%
//String path=(String)session.getAttribute("referer");
System.out.println((String)session.getAttribute("referer"));
session.removeAttribute("referer");
System.out.println("delete referer");
//response.sendRedirect(path); %>

</script>
<% } %>

<script src="source/js/login.js" ></script>

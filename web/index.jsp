<%@ page import="domain.User" %>
<%@ page import="domain.Picture" %>
<%@ page import="java.util.List" %>
<%@ page import="dao.UserDAO" %><%--
  Created by IntelliJ IDEA.
  User: yilingzhao
  Date: 2020/7/11
  Time: 下午1:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">




  <meta http-equiv="X-UA-Compatible" content="IE=edge">

  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="source/bootstrap-3.3.7-dist/css/bootstrap.css" rel="stylesheet">

  <script src="https://apps.bdimg.com/libs/jquery/2.1.4/jquery.min.js"></script>
  <script src="source/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>

  <link rel="stylesheet" type="text/css" media="screen" href="source/css/home.css" />
  <link rel="stylesheet" href="source/font-awesome-4.7.0/css/font-awesome.min.css"/>
  <title>my_pj_首页</title>
</head>
<body>

<header>
  <div>

    <div id="title">Hello World</div>

    <div id="titlebottom">

      Welcome to the "Hello World" to share your great pictures with us!


    </div>

  </div>
</header>

<div class="top">
  <ul>
    <!--  <ul id="1">  -->
    <li><img style="margin-top:-22px" id="logo" src="source/img/logo2.png"></li>

    <li><a id="now" href="index.jsp">Home</a></li>
<%--    <li><a href="browse.jsp">Browse</a></li>--%>
    <li><a href="search.jsp">Search</a></li>
    <!-- </ul> -->


    <li id="my_account">

      <%
        if(request.getSession()!=null&&request.getSession().getAttribute("user")!=null){
      %>

      <a href="#"> <%= ((User)(request.getSession().getAttribute("user"))).getUsername() %> </a>
      <ul >

        <li id="upload"><a href="upload.jsp"><i class="fa fa-cloud-upload" aria-hidden="true"></i> Upload</a></li>
        <li id="pics"><a href="mypics"><i class="fa fa-camera-retro" aria-hidden="true"></i> My Pics</a></li>
        <li id="favor"><a href="myfavor"><i class="fa fa-gratipay" aria-hidden="true"></i> My Favorite</a></li>
        <li id="friend"><a href="myfriends.jsp"><i class="fa fa-handshake-o" aria-hidden="true"></i> My Friends</a></li>
        <li id="log"><a href="logout"><i class="fa fa-sign-in" aria-hidden="true"></i> Log out</a></li>  <%-- 先注销session然后跳到登录页面？？--%>
      </ul>

      <% }else{ %>
      <a href="login.jsp">Log in</a>

      <% } %>
    </li>



  </ul>


</div>


<section >

  <a href="#" onclick="gototop()">
    <img id="backtotop" src="source/img/回到顶部.png"/>
  </a>


  <script>
    function gototop(){
      window.scrollTo('0','0');  //回到顶部
    }
  </script>



  <div  id="carousel-example-generic" class="carousel slide" data-ride="carousel">
    <!-- Indicators -->
    <ol class="carousel-indicators">
      <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
      <li data-target="#carousel-example-generic" data-slide-to="1"></li>
      <li data-target="#carousel-example-generic" data-slide-to="2"></li>
    </ol>

    <%
      List<Picture> hotpics=(List<Picture>)request.getAttribute("hotpics");
      List<Picture> newestpics=(List<Picture>)request.getAttribute("newestpics");
      if(hotpics==null&& newestpics==null) {
        request.getRequestDispatcher("index").forward(request, response);
      }else{


    %>


    <!-- Wrapper for slides -->
    <div class="carousel-inner" role="listbox">

      <%
        for(int i=0;i<hotpics.size();i++){
          if(i==0){
      %>

      <div class="item active">
        <%} else{%>
        <div class="item">
        <% } %>
          <a href="detail?imageId=<%= hotpics.get(i).getImageId() %>">
            <img src="source/upfile/<%= hotpics.get(i).getPath() %>" alt="...">
          </a>
        <div class="carousel-caption">
         <%= hotpics.get(i).getTitle()==null?"":hotpics.get(i).getTitle()%>
        </div>
      </div>




      <%
          }
      %>
<%--        <div class="item active" style="background:url(source/upfile/2-6596048341.jpg); background-size:cover;">--%>
<%--        <img src="source/upfile/2-6596048341.jpg" alt="...">--%>
<%--        <div class="carousel-caption">--%>
<%--         test--%>
<%--        </div>--%>
<%--      </div>--%>
<%--      <div class="item" style="background:url(source/upfile/2-6596048341.jpg); background-size:cover;">--%>
<%--        <img src="source/upfile/2-6596048341.jpg" alt="...">--%>
<%--        <div class="carousel-caption">--%>
<%--          test--%>
<%--        </div>--%>
<%--      </div>--%>
<%--        <div class="item" style="background:url(source/img/头图.jpg); background-size:cover;">--%>
<%--          <img src="source/img/头图.jpg" alt="...">--%>
<%--          <div class="carousel-caption">--%>
<%--            test--%>
<%--          </div>--%>
<%--       </div>--%>
    </div>


    <!-- Controls -->
    <a class="left carousel-control" href="#carousel-example-generic" role="button" data-slide="prev">
      <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
      <span class="sr-only">Previous</span>
    </a>
    <a class="right carousel-control" href="#carousel-example-generic" role="button" data-slide="next">
      <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
      <span class="sr-only">Next</span>
    </a>
  </div>
  </div>

  <%
  for(Picture picture:newestpics){
%>
  <div class="pic">
    <a href="detail?imageId=<%=picture.getImageId() %>">
      <img class="pic1" src="source/upfile/<%=picture.getPath()%> ">
      </a>
    <p class="word1" style="font-size: 16px;padding-top: 10px">
      <%= picture.getTitle()%>
    </p>
    <p class="word1">
     Author :
      <%
        int uid=picture.getAuthorId();
        String sql="select username from traveluser where uid=?";
        UserDAO userDAO=new UserDAO();
        String username=userDAO.getValue(sql,uid);
        out.println(username+"<br>");
      %>
      Theme : <%= picture.getContent()+"<br>"%>
      UploadDate: <% String date= picture.getUploadDate().toString();date=date.substring(0,date.length()-2); out.print(date+"<br>"); %>
    </p>
  </div>




  <% }} %>


</section>

</body>











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

<%@ page import="domain.Picture" %>
<%@ page import="java.util.List" %>
<%@ page import="domain.User" %><%--
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
  <!-- 以上代码IE=edge告诉IE使用最新的引擎渲染网页，chrome=1则可以激活Chrome Frame. -->
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <!-- 让当前 viewport 的宽度等于设备的宽度 -->
  <script src="source/jquery-1.10.2/jquery-1.10.2.js"></script>
  <link rel="stylesheet" href="source/font-awesome-4.7.0/css/font-awesome.min.css"/>
  <link rel="stylesheet" type="text/css" media="screen" href="source/css/mypics.css" />
  <title>my_pj_我的图片</title>
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
    <li><a href="index.jsp">Home</a></li>
    <li><a href="search.jsp">Search</a></li>
    <!-- </ul> -->

    <!--  <ul id="2">  -->
    <li id="my_account">

      <%
        if(request.getSession()!=null&&request.getSession().getAttribute("user")!=null){
      %>

      <a href="#"> <%= ((User)(request.getSession().getAttribute("user"))).getUsername() %> </a>
      <ul>
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

<section>
  <%
    User user=((User)(request.getSession().getAttribute("user")));
    if(user==null)
      response.sendRedirect("login.jsp");
    else{
      %>

  <div id="mypicscontent">

    <div class="mypics_til">MY PICTURES</div>

      <% List<Picture> pics=(List<Picture>)request.getAttribute("myPics");
      if(pics.size()==0){


    %>
    <h2>You haven't uploaded any pictures!

      <br>Please create sth!</h2>
      <%
    }else{


      int num=5;
      int pageNow = request.getParameter("page")==null ? 1 : Integer.parseInt( request.getParameter("page")) ;
      Integer allCount=(Integer) request.getAttribute("allCount");
      int count=allCount/num+(allCount%num!=0? 1:0);
      //根据总页数求出偏移量
      int offset = (pageNow -1) * num; //起始位置
      //System.out.println(allCount);
      // String path="/Users/yilingzhao/Desktop/卓越软件开发/pj/web/source/upfile/";

      for(Picture picture: pics){


    %>

    <div class="pic_each">


      <a href="detail?imageId=<%= picture.getImageId()%>"><img class="my_pics" src="source/upfile/<%= picture.getPath() %>"/></a>

      <article class="pic_word">
        <h2><%= picture.getTitle()%></h2>

        <p class="picword"> <%= picture.getDescription()%> </p>
      </article>

      <div class="con_word1">
        <div class="size2"><a class="modify delete" href="delete?imageId=<%= picture.getImageId()  %>" >DELETE</a></div>
      </div>


      <div class="con_word2">
        <div class="size2"><a class="modify" href="upload.jsp?imageId=<%= picture.getImageId()  %>" >MODIFY</a></div>
      </div>
    </div>

      <%
        }
      %>

    <script defer>


      let deletePic= document.getElementsByClassName("delete");
      for(let i=0;i<deletePic.length;i++)
      {
        deletePic[i].addEventListener("click", function (e) {

          //alert("dododo");
          let r = confirm("是否确定要删除此图片及其信息？");
          if (r == true) {
          } else {
            e.preventDefault();
          }
        });

      }

    </script>


    <div id="page"> <a href="mypics?offset=<%= offset-5>=0? offset-5:0 %>&page=<%= pageNow-1>0 ? pageNow-1:1 %>" >&lt&lt&nbsp</a>

      <% int i;
        if(pageNow-2>0&& pageNow+2<=count){
          for(i=pageNow-2;i<pageNow+3&&i<=count;i++) {
            if(i==pageNow){
              out.println("<a style=\"font-size:40px;color:#00CCCC;\" href=\"mypics?offset=" + (i - 1) * num + "&page=" + i  +  "\" > &nbsp " + i + " &nbsp</a>");

            }else
              out.println("<a href=\"mypics?offset=" + (i - 1) * num + "&page=" + i + "\" > &nbsp " + i + " &nbsp</a>");
          }
        }else if(pageNow-2<=0){
          for(i=1;i<6&&i<=count;i++)
          {
            if(i==pageNow){
              out.println("<a style=\"font-size:40px;color:#00CCCC;\" href=\"mypics?offset=" + (i - 1) * num + "&page=" + i  +  "\" > &nbsp " + i + " &nbsp</a>");

            }else
              out.println("<a href=\"mypics?offset=" + (i - 1) * num + "&page=" + i + "\" > &nbsp " + i + " &nbsp</a>");
          }
        }else if(pageNow+2>count){
          for(i=(count-4>0?count-4:1);i<count+1;i++)
          {
            if(i==pageNow){
              out.println("<a style=\"font-size:40px;color:#00CCCC;\" href=\"mypics?offset=" + (i - 1) * num + "&page=" + i  +  "\" > &nbsp " + i + " &nbsp</a>");

            }else
              out.println("<a href=\"mypics?offset=" + (i - 1) * num + "&page=" + i + "\" > &nbsp " + i + " &nbsp</a>");
          }
        }
      %>

      <a href="mypics?offset=<%= ((pageNow+1>count ? count:pageNow+1)-1)*num %>&page=<%= pageNow+1>count ? count:pageNow+1 %>" > >> &nbsp</a>


      <%
        }
        }
      %>



    <!--                    <div class="pic_each">-->
    <!---->
    <!--                    <a href="/detail.html"><img class="my_pics" src="../img\travel-images\normal/medium/8731523536.jpg"/></a>-->
    <!---->
    <!---->
    <!--                     <article class="pic_word">-->
    <!--                     <h2>Title</h2>-->
    <!-- -->
    <!--                     <p class="picword">St. Esteban's Cathedral is located on Budapest's Zellings Avenue. It was built in 1851 and was not completed until 1905. Co-designed by architects Hilde Joseph, Ibulmi Krosch, and Kausser Joseph, -->
    <!--                     it was built on the foundation of the palace of King Istvan. -->
    <!--                     The entire building project covers an area of 4,147 square meters. The church is splendid, and the hall can accommodate more than 8,500 people at the same time. -->
    <!--                     The church has a circular dome and two minarets. The dome was destroyed during the war. -->
    <!--                     It was rebuilt in 1949 and is 96 meters high. It is the highest dome in the city.</p>-->
    <!--                     </article>-->
    <!-- -->
    <!--                    <div class="con_word1">-->
    <!--                    <div class="size2"><a class="modify" href="#" onclick="alert('删除这张图片')">DELETE</a></div>-->
    <!--                    </div>-->
    <!---->
    <!--                    <div class="con_word2">-->
    <!--                    <div class="size2"><a class="modify" href="./upload.html">MODIFY</a></div>-->
    <!--                    </div>-->
    <!---->
    <!---->
    <!--                    </div>-->
    <!---->
    <!---->
    <!---->



  </div>
</section>


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


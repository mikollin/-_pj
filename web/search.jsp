<%@ page import="domain.User" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="domain.Picture" %>
<%@ page import="java.util.List" %><%--
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

  <link rel="stylesheet" href="source/font-awesome-4.7.0/css/font-awesome.min.css"/>
  <link rel="stylesheet" type="text/css" media="screen" href="source/css/search.css" />
  <title>my_pj_搜索页</title>
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
    <%--    <li><a href="browse.jsp">Browse</a></li>--%>
    <li><a id="now" href="search.jsp">Search</a></li>
    <!-- </ul> -->



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
        <li id="log"><a href="logout"><i class="fa fa-sign-in" aria-hidden="true"></i> Log out</a></li>
        <%-- 先注销session然后跳到登录页面？？--%>
      </ul>

      <% }else{ %>
      <a href="login.jsp">Log in</a>

      <% } %>
    </li>


  </ul>


</div>



<section>

  <div id="filter">
    <div class="til">SEARCH</div>
    <div id="choice">
      <form action="search" method="GET" name="to_search">
        <div style="font-family: Hoefler Text;font-size: 30px">Choose search type</div>
        <input name="type" value="Title" type="radio" required/>Filter by Title
        <input style="margin-left: 30px" name="type" value="Content" type="radio" />Filter by Theme

        <div style="font-family: Hoefler Text;font-size: 30px">Choose sort type</div>
        <input name="sort" value="FavoredNum" type="radio" required/>Sort by FavoredNum
        <input style="margin-left: 30px" name="sort" value="UploadDate" type="radio" />Sort by UploadDate

        <input id="frame1" name="filter_value" type="text"></input>
        <br>
        <input id="fil" name="filter" type="submit" value="Search" >
      </form>
    </div>
  </div>



  <div id="result">
    <div class="til">RESULT</div>

    <%




      List<Picture> results=new ArrayList<>();
      results=(List<Picture> )request.getAttribute("results");


        if(request.getAttribute("results")!=null && ((List<Picture>) request.getAttribute("results")).size()!=0){


      int num=5;
      int pageNow = request.getParameter("page")==null ? 1 : Integer.parseInt( request.getParameter("page")) ;
      Integer allCount=(Integer) request.getAttribute("allCount");
      int count=allCount/num+(allCount%num!=0? 1:0);
      //根据总页数求出偏移量
      int offset = (pageNow -1) * num; //起始位置
      System.out.println(allCount);




          for(Picture pic:results){
    %>

    <div class="result1">
      <a href="detail?imageId=<%= pic.getImageId()%>">
      <img class="res_pic" src="source/upfile/<%= pic.getPath()%>">
      </a>

      <article class="res_word">
        <h2><%= pic.getTitle()==null?"":pic.getTitle() %></h2>

        <p class="resword"><%= pic.getDescription()==null?"":pic.getDescription() %></p>
      </article>



  </div>
    <% } %>


    <div id="page"> <a href="search?offset=<%= offset-5>=0? offset-5:0 %>&page=<%= pageNow-1>0 ? pageNow-1:1 %>&

<%= request.getQueryString().startsWith("offset")?request.getQueryString().substring(request.getQueryString().indexOf("type")):request.getQueryString() %>" >&lt&lt&nbsp</a>

   <% int i;
   if(pageNow-2>0&& pageNow+2<=count){
     for(i=pageNow-2;i<pageNow+3&&i<=count;i++) {
       if(i==pageNow){
         out.println("<a style=\"font-size:40px;color:#00CCCC;\" href=\"search?offset=" + (i - 1) * num + "&page=" + i + "&" + (request.getQueryString().startsWith("offset") ? request.getQueryString().substring(request.getQueryString().indexOf("type")) : request.getQueryString()) + "\" > &nbsp " + i + " &nbsp</a>");

       }else
       out.println("<a href=\"search?offset=" + (i - 1) * num + "&page=" + i + "&" + (request.getQueryString().startsWith("offset") ? request.getQueryString().substring(request.getQueryString().indexOf("type")) : request.getQueryString()) + "\" > &nbsp " + i + " &nbsp</a>");
     }
     }else if(pageNow-2<=0){
     for(i=1;i<6&&i<=count;i++)
     {
       if(i==pageNow){
         out.println("<a style=\"font-size:40px;color:#00CCCC;\" href=\"search?offset=" + (i - 1) * num + "&page=" + i + "&" + (request.getQueryString().startsWith("offset") ? request.getQueryString().substring(request.getQueryString().indexOf("type")) : request.getQueryString()) + "\" > &nbsp " + i + " &nbsp</a>");

       }else
         out.println("<a href=\"search?offset=" + (i - 1) * num + "&page=" + i + "&" + (request.getQueryString().startsWith("offset") ? request.getQueryString().substring(request.getQueryString().indexOf("type")) : request.getQueryString()) + "\" > &nbsp " + i + " &nbsp</a>");

     }
   }else if(pageNow+2>count){
     for(i=(count-4>0?count-4:1);i<count+1;i++)
       {
         if(i==pageNow){
           out.println("<a style=\"font-size:40px;color:#00CCCC;\" href=\"search?offset=" + (i - 1) * num + "&page=" + i + "&" + (request.getQueryString().startsWith("offset") ? request.getQueryString().substring(request.getQueryString().indexOf("type")) : request.getQueryString()) + "\" > &nbsp " + i + " &nbsp</a>");

         }else
           out.println("<a href=\"search?offset=" + (i - 1) * num + "&page=" + i + "&" + (request.getQueryString().startsWith("offset") ? request.getQueryString().substring(request.getQueryString().indexOf("type")) : request.getQueryString()) + "\" > &nbsp " + i + " &nbsp</a>");

       }
   }
   %>

      <a href="search?offset=<%= ((pageNow+1>count ? count:pageNow+1)-1)*num %>&page=<%= pageNow+1>count ? count:pageNow+1 %>&<%= request.getQueryString().startsWith("offset")?request.getQueryString().substring(request.getQueryString().indexOf("type")):request.getQueryString() %>" > >> &nbsp</a>

<%--<%=  request.getQueryString().startsWith("offset")%>--%>
<%--      <%= request.getQueryString().substring(17)%>>--%>


    <%
      }
      else if(request.getParameter("type")!=null){

    %>

        <h2>No results</h2>
    <%
    } else{%>

      <h2>Please input sth to start searching!</h2>
    <%
    }
      %>


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
<script defer>


  let type=document.getElementsByName("type");
  let sortType=document.getElementsByName("sort");

  <%  if (request.getParameter("type")!=null&&request.getParameter("sort")!=null) {%>
  <% if(request.getParameter("type").equals("Title")) {%>
  type[0].setAttribute("checked","checked");
  <% }else if (request.getParameter("type").equals("Content")) { %>
  type[1].setAttribute("checked","checked");
  <% } %>

  <% if(request.getParameter("sort").equals("FavoredNum")) {%>
  sortType[0].setAttribute("checked","checked");
  <% }else if (request.getParameter("sort").equals("UploadDate")) { %>
  sortType[1].setAttribute("checked","checked");
  <% } %>
  let value=document.getElementById("frame1");
  value.value="<%= request.getParameter("filter_value")%>";
 <% }%>



</script>

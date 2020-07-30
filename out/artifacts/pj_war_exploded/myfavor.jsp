<%@ page import="domain.User" %>
<%@ page import="domain.Picture" %>
<%@ page import="java.util.List" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.net.URLDecoder" %>
<%@ page import="dao.PictureDAO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="dao.HistoryDAO" %>
<%@ page import="domain.History" %>
<%@ page import="dao.UserDAO" %>
<%--
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

  <link rel="stylesheet" type="text/css" media="screen" href="source/css/myfavor.css" />

  <title>my_pj_我的收藏</title>
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

  <div id="sidebar">

    <div id="footprints">

      <%
        String friendId=request.getParameter("friendId");
        UserDAO userDAO=new UserDAO();
        String sql="select uid id,username from traveluser where uid=?";
        User friend= userDAO.getInstance(sql,friendId);

      %>

      <table>
        <tr><th style="cursor: pointer;"><i class="fa fa-history" aria-hidden="true"></i>  <%= request.getParameter("friendId")==null?"My":friend.getUsername()+" 's "%> Footprints</th></tr>
        <%
          User user=((User)(request.getSession().getAttribute("user")));
          if(user==null)
            response.sendRedirect("login.jsp");
          else{
          //显示最近浏览过的十个图片
          //获取所有的Cookie
 /*
          Cookie[] cookies=request.getCookies();
          List<Cookie> history=new ArrayList<Cookie>();
          // 从中筛选出picture的Cookie，如果cookieName以MY_FOOTPRINTS_开头的即符合条件
          //显示cookieValue
          if(cookies!=null && cookies.length>0) {
            //System.out.println("length " + cookies.length);
            PictureDAO pictureDAO = new PictureDAO();

            for (int i = cookies.length - 1; i >= 0; i--) {
              Cookie c = cookies[i];
              String cookieName = c.getName();

              if (cookieName.startsWith("MY_FOOTPRINTS_" + user.getUsername())) {
                // String imageId=cookieName.substring(14+user.getUsername().length());
               history.add(c);

                String imageId = c.getValue();

                String sql = "select title from travelimage where imageid=?";
                String title = pictureDAO.getValue(sql, imageId);
                //  out.println("<tr><td><a href=\"detail?imageId="+imageId+"\">"+"<i class=\"fa fa-link\" aria-hidden=\"true\"></i>  "+ URLDecoder.decode(c.getValue(),"UTF-8")+"</a></td></tr>");
                out.println("<tr><td><a href=\"detail?imageId=" + imageId + "\">" + "<i class=\"fa fa-link\" aria-hidden=\"true\"></i>  " + title + "</a></td></tr>");
*/
          sql="select imageId from travelhistory where uid=?";
          HistoryDAO historyDAO=new HistoryDAO();
            List<History> history;

          if(friendId==null)
           history=historyDAO.getForList(sql,user.getId());
          else
            history=historyDAO.getForList(sql,friendId);


          String imageId=null;
          if(history!=null&&(request.getAttribute("message")==null||request.getAttribute("message").equals("canVisited"))) {

            for(int i=history.size()-1;i>=0;i--) {
              imageId = history.get(i).getImageId();
              PictureDAO pictureDAO = new PictureDAO();
              sql = "select title from travelimage where imageid=?";
              String title = pictureDAO.getValue(sql, imageId);
              out.println("<tr><td><a href=\"detail?imageId=" + imageId + "\">" + "<i class=\"fa fa-link\" aria-hidden=\"true\"></i>  " + title + "</a></td></tr>");

            }


          }




   /*       }

            }
          }

    */

        %>


      </table>
        <%
          if(history.size()==0)
          //if(history==null)
            out.println("<p style=\" color:white; \" >You haven't watched any picture !</p>");

          if(request.getAttribute("message")!=null&&request.getAttribute("message").equals("cannotVisited"))
            out.println("<p style=\" color:white; \" >You are not allowed to see "+friend.getUsername()+" 's footprints !</p>");

        %>

    </div>

  </div>



  <div id="myfavorcontent" style="min-height: <%= 300+history.size()*25%>px">

    <div class="myfavor_til"><%= request.getParameter("friendId")==null?"My":friend.getUsername()+" 's "%> FAVORITE</div>


    <%--
    难道点击跳转到myfavorServlet 然后数据库找好之后 再跳转到jsp页面？？？

    --%>


    <% List<Picture> pics=(List<Picture>)request.getAttribute("favorPics");
    if(pics==null&&request.getAttribute("message").equals("cannotVisited")){
      %>
    <h2>
      Sorry you are not allowed to
      visit <%= friend.getUsername()%> 's favorites!
      </h2>
    <%
    }else if(pics.size()==0){
    %>
    <h2><%= request.getParameter("friendId")==null?"You haven't":friend.getUsername()+" hasn't"%> favored any pictures!
        <br><%= request.getParameter("friendId")==null?"Please create sth!":""%></h2>
    <%
    }else{


      int num=5;
      int pageNow = request.getParameter("page")==null ? 1 : Integer.parseInt( request.getParameter("page")) ;
      Integer allCount=(Integer) request.getAttribute("allCount");
      int count=allCount/num+(allCount%num!=0? 1:0);
      //根据总页数求出偏移量
      int offset = (pageNow -1) * num; //起始位置
      //System.out.println(allCount);


      for(Picture picture: pics){



    %>

    <div class="favoreach">

      <a href="detail?imageId=<%= picture.getImageId()%>"><img class="favorpics" src="source/upfile/<%= picture.getPath() %>"/></a>

      <article class="pic_word">
        <h2><%= picture.getTitle()==null?"":picture.getTitle()%></h2>

        <p class="picword"> <%= picture.getDescription()==null?"":picture.getDescription()%> </p>
      </article>

      <% if(friendId==null){ %>
      <div class="con_word">
        <div class="size2">DON'T LIKE <a class="like" onclick="alert('取消收藏')" href="cancelFavor?referer=myfavor&imageId=<%= picture.getImageId()%>">
          <i class="fa fa-heart" aria-hidden="true"></i></a></div>
      </div>
      <% } %>

    </div>

    <%
        }
      %>


    <% if(friendId==null) {%>
    <div id="page"> <a href="myfavor?offset=<%= offset-5>=0? offset-5:0 %>&page=<%= pageNow-1>0 ? pageNow-1:1 %>" >&lt&lt&nbsp</a>

      <% }else{%>
      <div id="page"> <a href="visitFriendFavor?offset=<%= offset-5>=0? offset-5:0 %>&page=<%= pageNow-1>0 ? pageNow-1:1 %>&<%= request.getQueryString().startsWith("offset")?request.getQueryString().substring(request.getQueryString().indexOf("friendId")):request.getQueryString() %>" > &lt&lt&nbsp</a>


        <%
      }
      int i;
      if(pageNow-2>0&& pageNow+2<=count){
        for(i=pageNow-2;i<pageNow+3&&i<=count;i++) {
          if(i==pageNow){
            if(friendId==null)
              out.println("<a style=\"font-size:40px;color:#00CCCC;\" href=\"myfavor?offset=" + (i - 1) * num + "&page=" + i  +  "\" > &nbsp " + i + " &nbsp</a>");
            else
              out.println("<a style=\"font-size:40px;color:#00CCCC;\" href=\"visitFriendFavor?offset=" + (i - 1) * num + "&page=" + i  + "&" + (request.getQueryString().startsWith("offset") ? request.getQueryString().substring(request.getQueryString().indexOf("friendId")) : request.getQueryString()) + "\" > &nbsp " + i + " &nbsp</a>");
          }else{
            //out.println("<a href=\"myfavor?offset=" + (i - 1) * num + "&page=" + i + "\" > &nbsp " + i + " &nbsp</a>");
            if(friendId==null)
              out.println("<a href=\"myfavor?offset=" + (i - 1) * num + "&page=" + i  +  "\" > &nbsp " + i + " &nbsp</a>");
            else
              out.println("<a href=\"visitFriendFavor?offset=" + (i - 1) * num + "&page=" + i  + "&" + (request.getQueryString().startsWith("offset") ? request.getQueryString().substring(request.getQueryString().indexOf("friendId")) : request.getQueryString()) + "\" > &nbsp " + i + " &nbsp</a>");

          }
        }
      }else if(pageNow-2<=0){
        for(i=1;i<6&&i<=count;i++)
        {
          if(i==pageNow){
            //out.println("<a style=\"font-size:40px;color:#00CCCC;\" href=\"myfavor?offset=" + (i - 1) * num + "&page=" + i  +  "\" > &nbsp " + i + " &nbsp</a>");
            if(friendId==null)
              out.println("<a style=\"font-size:40px;color:#00CCCC;\" href=\"myfavor?offset=" + (i - 1) * num + "&page=" + i  +  "\" > &nbsp " + i + " &nbsp</a>");
            else
              out.println("<a style=\"font-size:40px;color:#00CCCC;\" href=\"visitFriendFavor?offset=" + (i - 1) * num + "&page=" + i  + "&" + (request.getQueryString().startsWith("offset") ? request.getQueryString().substring(request.getQueryString().indexOf("friendId")) : request.getQueryString()) + "\" > &nbsp " + i + " &nbsp</a>");

          }else {
            //out.println("<a href=\"myfavor?offset=" + (i - 1) * num + "&page=" + i + "\" > &nbsp " + i + " &nbsp</a>");
            if(friendId==null)
              out.println("<a href=\"myfavor?offset=" + (i - 1) * num + "&page=" + i  +  "\" > &nbsp " + i + " &nbsp</a>");
            else
              out.println("<a href=\"visitFriendFavor?offset=" + (i - 1) * num + "&page=" + i  + "&" + (request.getQueryString().startsWith("offset") ? request.getQueryString().substring(request.getQueryString().indexOf("friendId")) : request.getQueryString()) + "\" > &nbsp " + i + " &nbsp</a>");

          }
          }
      }else if(pageNow+2>count){
        for(i=(count-4>0?count-4:1);i<count+1;i++) {
          if (i == pageNow) {
            //out.println("<a style=\"font-size:40px;color:#00CCCC;\" href=\"myfavor?offset=" + (i - 1) * num + "&page=" + i  +  "\" > &nbsp " + i + " &nbsp</a>");
            if (friendId == null)
              out.println("<a style=\"font-size:40px;color:#00CCCC;\" href=\"myfavor?offset=" + (i - 1) * num + "&page=" + i + "\" > &nbsp " + i + " &nbsp</a>");
            else
              out.println("<a style=\"font-size:40px;color:#00CCCC;\" href=\"visitFriendFavor?offset=" + (i - 1) * num + "&page=" + i + "&" + (request.getQueryString().startsWith("offset") ? request.getQueryString().substring(request.getQueryString().indexOf("friendId")) : request.getQueryString()) + "\" > &nbsp " + i + " &nbsp</a>");

          } else{
            //out.println("<a href=\"myfavor?offset=" + (i - 1) * num + "&page=" + i + "\" > &nbsp " + i + " &nbsp</a>");
            if(friendId==null)
              out.println("<a href=\"myfavor?offset=" + (i - 1) * num + "&page=" + i  +  "\" > &nbsp " + i + " &nbsp</a>");
            else
              out.println("<a href=\"visitFriendFavor?offset=" + (i - 1) * num + "&page=" + i  + "&" + (request.getQueryString().startsWith("offset") ? request.getQueryString().substring(request.getQueryString().indexOf("friendId")) : request.getQueryString()) + "\" > &nbsp " + i + " &nbsp</a>");

          } }
      }
    %>

        <% if(friendId==null) {%>
        <a href="myfavor?offset=<%= ((pageNow+1>count ? count:pageNow+1)-1)*num %>&page=<%= pageNow+1>count ? count:pageNow+1 %>" > >> &nbsp</a>
        <% } else{%>
        <a href="visitFriendFavor?offset=<%= ((pageNow+1>count ? count:pageNow+1)-1)*num %>&page=<%= pageNow+1>count ? count:pageNow+1 %>&<%= request.getQueryString().startsWith("offset")?request.getQueryString().substring(request.getQueryString().indexOf("friendId")):request.getQueryString() %>"  > >> &nbsp</a>


<%
      }
    }
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

  let td=document.getElementsByTagName("td");
  let th=document.getElementsByTagName("th")[0];
  th.addEventListener("click",function(){
    for(let i=0;i<td.length;i++){
      if(td[i].style.display=="none")
      td[i].style.display="block";
      else
        td[i].style.display="none";
    }
  });

  //你第一次点击的时候是为a标签绑定了一个click事件，这个click要到第二次点击才生效。
  //如果是动态绑定事件，可以用jquery的on方法。
</script>
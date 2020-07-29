<%@ page import="domain.User" %>
<%@ page import="domain.Picture" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.net.CookieHandler" %>
<%@ page import="java.util.List" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.net.URLDecoder" %>
<%@ page import="domain.History" %>
<%@ page import="sun.net.www.http.HttpCaptureInputStream" %>
<%@ page import="domain.Comments" %>
<%@ page import="dao.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">





  <meta http-equiv="X-UA-Compatible" content="IE=edge">

  <meta name="viewport" content="width=device-width, initial-scale=1">

  <link rel="stylesheet" href="source/font-awesome-4.7.0/css/font-awesome.min.css"/>


  <link rel="stylesheet" type="text/css" media="screen" href="source/jqzoom/css/jquery.jqzoom.css" />

  <script src="source/jqzoom/js/jquery-1.5.js" type="text/javascript"></script>

  <script src="source/jqzoom/js/jquery.jqzoom-core.js" type="text/javascript"></script>



<%--  <script src="source/bootstrap/js/bootstrap.min.js"></script>--%>
  <link href="source/bootstrap/css/bootstrap.min.css" rel="stylesheet" />

<%--  <script src="source/bootstrapValidator/js/bootstrapValidator.min.js"></script>--%>
  <link href="source/bootstrapValidator/css/bootstrapValidator.min.css" rel="stylesheet" />



  <link rel="stylesheet" type="text/css" media="screen" href="source/css/detail.css" />
  <title>my_pj_图片详情</title>
</head>




<body>

<header>
  <div>

    <div id="title">Hello World</div>
<br>
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
    <li><a href="search.jsp">Search</a></li>
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
        <li id="log"><a href="logout"><i class="fa fa-sign-in" aria-hidden="true"></i> Log out</a></li>  <%-- 先注销session然后跳到登录页面？？--%>
      </ul>

      <% }else{ %>
      <a href="login.jsp">Log in</a>

      <% } %>
    </li>



  </ul>


</div>

<br>
<section>

  <div class="detail">

<% Picture picture=(Picture)request.getAttribute("pic"); %>
    <div class="til">DETAILS</div>

    <div class="size"> <%= picture.getTitle()==null?"":picture.getTitle() %> </div>


    <div class="size2"><i class="fa fa-camera" aria-hidden="true"></i>  taken by : <%=picture.getAuthor()==null?"":picture.getAuthor() %></div>

    <br>
    <div id="content">

      <div class="jqzoom">
        <a href="source/upfile/<%= picture.getPath() %>" class="jqzoom" >
        <img  id="con_pic" src="source/upfile/<%= picture.getPath() %>"  />
        </a>
      </div>


      <div id="column">
        <div class="con_word">



          <div class="size"><%= picture.getFavoredNum()%></div>

          <p>PEOPLE LIKE THIS <i id="likeit" class="fa fa-heart" aria-hidden="true"></i></p>

        </div>



        <div class="con_word">


          <p><i class="fa fa-camera-retro" aria-hidden="true"></i> IMAGE DETAILS</p>
          <table>
            <tr><td>Theme : <%= picture.getContent()==null?"":picture.getContent() %></td></tr>

            <tr><td>Country : <%= picture.getCountry()==null?"":picture.getCountry() %></td></tr>
            <tr><td>City : <%= picture.getCity()==null?"":picture.getCity() %></td></tr>
            <tr><td>UploadDate : <%
              String date= picture.getUploadDate().toString();
              date=date.substring(0,date.length()-2);
              out.println("<br>"+date);
            %></td></tr>

          </table>
        </div>


<%--        <div class="jqzoom">--%>
<%--        <a href="source/upfile/<%= picture.getPath() %>" class="jqzoom" title="MYTITLE">--%>
<%--          <img src="source/upfile/<%= picture.getPath() %>" title="IMAGE TITLE">--%>
<%--        </a>--%>
<%--        </div>--%>


        <div class="con_word">

          <%
            boolean valid=false;

            if(request.getSession().getAttribute("user")!=null) {
              User user = (User) request.getSession().getAttribute("user");
              int uid = user.getId();
              PictureDAO pictureDAO = new PictureDAO();
              String sql = "select favorid from travelimagefavor where uid=? and imageid=?";
              Integer favorId = 0; //主要因为getValue找不到记录则return null，因此int会出错，转为Integer
              favorId = pictureDAO.getValue(sql, uid, picture.getImageId());

              if (pictureDAO.getValue(sql, uid, picture.getImageId())==null) {
                valid = false;
              } else if (favorId.intValue()>0) {
                valid=true;
              }
            }else{
              valid=false;
            }
          %>
          <div class="size2">LIKE THIS <a id="like" href="<% if(valid) out.println("cancelFavor?imageId="+picture.getImageId());

          else if(request.getSession().getAttribute("user")!=null)
            out.println("setFavor?imageId="+picture.getImageId());
          else{ out.println("login.jsp");} %>"
                                          onclick="<% if(valid) out.println("alert('取消收藏')");
          else if(request.getSession().getAttribute("user")!=null)
            out.println("alert('收藏成功');");
          else{ out.println("alert('您还未登录，将跳转到登录界面，请登录后操作...')");} %>">
            <i <% if(valid) out.println("style=\"color:red\""); %> class="fa fa-heart" aria-hidden="true"></i></a></div>




        </div>

      </div>




    </div>

    <div id="description">
      <h3>DESCRIPTION : </h3>
      <p><%= picture.getDescription()==null?"":picture.getDescription() %></p>
    </div>

  </div>

    <%--
    设置足迹
    --%>
    <%
      //把picture的信息以Cookie的方式传递，若要删除一个Cookie
      //则先确定要被删除的Cookie
      //前提MY_FOOTPRINTS_开头的Cookie数量大于等于10

      User user=((User)(request.getSession().getAttribute("user")));

      if(user!=null) {
       // Cookie[] cookies = request.getCookies();
        //保存所有MY_FOOTPRINTS_username开头的Cookie

       // List<Cookie> pictureCookies = new ArrayList<Cookie>();
        HistoryDAO historyDAO=new HistoryDAO();
        String sql="select imageId from travelhistory where uid=?";
        List<History>pictureCookies = new ArrayList<History>();
        List<History> temppics=new ArrayList<History>();
        temppics=historyDAO.getForList(sql,user.getId());
        if(temppics!=null){
          pictureCookies=temppics;
        }



        //用来保存和myfavor.jsp传入的picture匹配的哪个Cookie
        //Cookie tempCookie = null;

        History tempCookie=null;

        //if (cookies != null && cookies.length > 0) {
        if (pictureCookies.size() > 0) {

          //for (Cookie c : cookies) {
          for (History c : pictureCookies) {
            //String cookieName = c.getName();
            //if (cookieName.startsWith("MY_FOOTPRINTS_" + user.getUsername())) {
            //pictureCookies.add(c);

            //pictureCookies.add(new History(c.getImageId()));

//            System.out.println("dododo");
//              System.out.println(c.getValue() + "  and   " + picture.getImageId());
//              System.out.println(c.getValue().equals(picture.getImageId().toString()));

            //if(URLDecoder.decode(c.getValue(),"UTF-8").equals(picture.getTitle())){ //picture's title 对比
            if (c.getImageId().equals(picture.getImageId().toString())) {  //picture's imageId 对比
              tempCookie = new History(c.getImageId());  //是点了最近十个足迹中的图片，图片之间转换顺序，锁定对应点的那张图片，加到最后
              // System.out.println("dododo");
            }
          }
        //}
        }

        if (pictureCookies.size() >= 10 && tempCookie == null) {
          tempCookie = pictureCookies.get(0); //点了最近十个足迹以外的图片，把第一个删掉
        }

        if (tempCookie != null) {
          sql="delete from travelhistory where uid=? and imageid=? ";
          historyDAO.update(sql,user.getId(),tempCookie.getImageId());  //保持数据库中同一个用户最多十个足迹
          //tempCookie.setMaxAge(0);

       //   response.addCookie(tempCookie);//是点了最近十个足迹中的图片，图片之间转换顺序，删掉对应点的那张图片
        }

        // Cookie cookie=new Cookie("MY_FOOTPRINTS_"+user.getUsername()+picture.getImageId().toString(), URLEncoder.encode(picture.getTitle(), "UTF-8")); //图片标题不可重复

       // Cookie cookie = new Cookie("MY_FOOTPRINTS_" + user.getUsername()+"_"+picture.getImageId(), picture.getImageId().toString()); //图片标题不可重复

        //response.addCookie(cookie);

        sql="INSERT INTO `travelhistory`(`imageid`, `uid`) VALUES (?,?)";
        historyDAO.update(sql,picture.getImageId().toString(),user.getId());


        //查找数据库中title是否重复的信息
        //select * from travelimage where title in (select Title from travelimage group by title having count(title) > 1

      }
    %>



  <div class="detail" style="min-height: 250px;">

    <div class="til">COMMENTS</div>

    <div class="form-group">
      <button type="button" id="createComments" name="createComments" class="btn btn-primary">Create Comments</button>
    </div>

      <div id="submitComments" style="display: none">

      <% if(user!=null) { %>




      <form action="createComment?imageId=<%= picture.getImageId() %>" method="post">

        <div class="form-group">
          <label>Username : <%= user.getUsername() %> </label>

        </div>

        <div class="form-group">
          <label>Comment to this picture:</label>
          <textarea class="form-control" id="comments" name="comments" cols="6" type="text" placeholder="Please input no more than 10000 characters ..." maxlength="10000"  required></textarea>

        </div>

        <div class="form-group">
          <button type="submit" id="comment_submit" name="comment_submit" class="btn btn-primary">Submit</button>
          <!--因为插件用的是jquery的submit 方法，不能用name="submit" 属性-->
        </div>
      </form>



      <% }else{%>
      <h2>Please login first and then to comment this picture! </h2>

      <% } %>
      </div>


    <div id="showComments">

      <div class="form-group" style="margin-top: 30px">
        <h2><i class="fa fa-comments-o" aria-hidden="true"></i> Hot Comments </h2>
        ( Only shows the top ten most recent comments )
      </div>

      <%
        String sql="SELECT `commentId`,`imageId`, `uid`, `comment`, `FavoredNum` favoredNum, `commentDate` FROM `travelimagecomments` WHERE imageId=? order by FavoredNum  desc ,commentDate DESC limit 0,10";
        CommentsDAO commentsDAO=new CommentsDAO();
        List<Comments> comments=null;
       comments= commentsDAO.getForList(sql,picture.getImageId());
       //System.out.println("comments size = "+comments.size());
       if(comments==null||comments.size()==0){
      %>

      <div class="comments">
        <div class="form-group">
          <h3>No comments on this picture yet! Go to create the first comment! </h3>
        </div>
      </div>
      <% } else {
         String sql1="select uid id,username from traveluser where uid=?";
        UserDAO userDAO=new UserDAO();
        User commenter=null;
        CommentsDAO thumbDAO=new CommentsDAO();
         for(Comments com:comments){
           commenter=userDAO.getInstance(sql1,com.getUid());
      %>

      <div class="comments">
        <div class="form-group">
          <h3><%= commenter.getUsername()%> :  <%String commentDate=com.getCommentDate().toString();   commentDate=commentDate.substring(0,commentDate.length()-2); out.println(commentDate);  %> </h3>

          <% if(user==null){%>
          <div class="thumbUp"><a href="login.jsp" onclick="alert('请登录后再点赞评论...')"><i class="fa fa-thumbs-up" aria-hidden="true" ></i></a> <%= com.getFavoredNum()%> </div>

          <%
            }else{
            valid=false;
            String sql2="select commentFavorId from travelimagecommentsfavor where uid=? and commentId=?";

            if(thumbDAO.getValue(sql2,user.getId(),com.getCommentId())!=null){
              valid=true;
            }else{
              valid=false;
            }
          %>


          <% if(!valid){ %>

          <div class="thumbUp"><a href="thumbUp?imageId=<%= picture.getImageId()%>&commentId=<%= com.getCommentId()%>&uid=<%= user.getId()%>">
            <i class="fa fa-thumbs-up" aria-hidden="true"></i></a> <%= com.getFavoredNum()%> </div>

          <% }else{ %>

          <div class="thumbUp"><a href="cancelThumbUp?imageId=<%= picture.getImageId()%>&commentId=<%= com.getCommentId()%>&uid=<%= user.getId()%>"><i class="fa fa-thumbs-up" aria-hidden="true" style="color: green"></i></a> <%= com.getFavoredNum()%> </div>

          <% }
          }
          %>

          <br>
          <label style="max-width: 800px">"<%= com.getComment() %>"</label>


        </div>
      </div>


      <% }
       } %>




      <div class="form-group"  style="margin-top: 100px" >
        <h2><i class="fa fa-commenting" aria-hidden="true"></i> My Comments</h2>
      </div>


      <%
        if(user==null){
      %>

      <div class="comments">
        <div class="form-group">
          <h3>You should login to see your comments on this picture! </h3>
        </div>
      </div>

      <%

        }else{

        sql="SELECT `commentId`,`imageId`, `uid`, `comment`, `FavoredNum` favoredNum, `commentDate` FROM `travelimagecomments` WHERE imageId=? and uid=?  order by FavoredNum  desc ,commentDate DESC";

        List<Comments> mycomments=null;
        mycomments= commentsDAO.getForList(sql,picture.getImageId(),user.getId());
        if(mycomments==null||mycomments.size()==0){
      %>

      <div class="comments">
        <div class="form-group">
          <h3>You haven't commented on this picture yet! Go to create your first comment! </h3>
        </div>
      </div>
      <% } else {
        String sql1="select uid id,username from traveluser where uid=?";
        UserDAO userDAO=new UserDAO();
        CommentsDAO thumbDAO=new CommentsDAO();
        User commenter=null;
        for(Comments com:mycomments){
          commenter=userDAO.getInstance(sql1,com.getUid());
      %>


      <div class="comments">
        <div class="form-group">
          <h3><%= commenter.getUsername()%> :  <%String comentDate=com.getCommentDate().toString();comentDate=comentDate.substring(0,comentDate.length()-2);out.print(comentDate);  %> </h3>
          <%
            valid=false;
            String sql2="select commentFavorId from travelimagecommentsfavor where uid=? and commentId=?";

            //System.out.println("my com : "+com.getCommentId());
            if(thumbDAO.getValue(sql2,user.getId(),com.getCommentId())!=null){
              valid=true;
            }else{
              valid=false;
            }
          %>


          <% if(!valid){ %>

          <div class="thumbUp"><a href="thumbUp?imageId=<%= picture.getImageId()%>&commentId=<%= com.getCommentId()%>&uid=<%= user.getId()%>">
            <i class="fa fa-thumbs-up" aria-hidden="true"></i></a> <%= com.getFavoredNum()%> </div>

          <% }else{ %>

          <div class="thumbUp"><a href="cancelThumbUp?imageId=<%= picture.getImageId()%>&commentId=<%= com.getCommentId()%>&uid=<%= user.getId()%>"><i class="fa fa-thumbs-up" aria-hidden="true" style="color: green"></i></a> <%= com.getFavoredNum()%> </div>

          <% }%>

          <br>
          <label style="max-width: 800px">"<%= com.getComment() %>"</label>


        </div>
      </div>




      <% }
      }
      }
      %>





    </div>



    </div>


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
<script src="source/js/setFavor.js"></script>
<script defer>
  let height=document.getElementById('con_pic').height;
  let width=document.getElementById('con_pic').width;
  //alert(document.getElementById('content').style.getPropertyValue('min-width'));

  $(function(){
    $('.jqzoom').jqzoom({
      //（默认值）standard / reverse,原图用半透明图层遮盖
      zoomType: 'reverse',
      //是否在原图上显示镜头
      lens:true,
      // 预先加载大图片
      preloadImages: false,
      //放大镜是否总是显示存在
      alwaysOn:false,
      //放大窗口的尺寸
      zoomWidth: 200,
      zoomHeight: 200,
      //放大窗口相对于原图的偏移量、位置
      xOffset:30,
      yOffset:0,
      position:'right',
      //默认值：true，是否显示加载提示Loading zoom
      showPreload:true,
      //默认 Loading zoom，自定义加载提示文本
      preloadText: '加载中……'
      //imageOpacity 默认值 0.2 透明度
      //title 是否在放大窗口中显示标题，值可以为a标记的title值，若无，则为原图的title值
    });
  });

  let createComments=document.getElementById("createComments");
  let submitComments=document.getElementById("submitComments");
  createComments.addEventListener("click",function(){
    if(submitComments.style.display=="none") {
      submitComments.style.display = "block";
      createComments.innerText="Cancel";
    }
    else {
      submitComments.style.display = "none";
      createComments.innerText="Create Comments";
      document.getElementById("comments").value="";
    }
  });


  if(document.getElementById('con_pic').width+380>1200){
    document.getElementById('content').style.setProperty('width',document.getElementById('con_pic').width+380+250+'px');
    document.getElementsByClassName('detail')[0].style.setProperty('width',document.getElementById('con_pic').width+380+250+'px');
    document.getElementsByClassName('detail')[1].style.setProperty('width',document.getElementById('con_pic').width+380+250+'px');

    document.getElementsByTagName('header')[0].style.setProperty('width',document.getElementById('con_pic').width+380+290+'px');
    document.getElementsByClassName('top')[0].style.setProperty('width',document.getElementById('con_pic').width+380+290+'px');
    document.getElementsByTagName('footer')[0].style.setProperty('width',document.getElementById('con_pic').width+380+290+'px');


  }

</script>

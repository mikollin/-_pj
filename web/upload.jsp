<%@ page import="domain.User" %>
<%@ page import="dao.PictureDAO" %>
<%@ page import="domain.Picture" %>
<%@ page import="java.util.List" %>
<%@ page import="sun.lwawt.macosx.CSystemTray" %>
<%@ page import="jdk.nashorn.internal.codegen.SpillObjectCreator" %><%--
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





  <meta http-equiv="content-type" content="text/html;charset=utf-8">

  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="source/font-awesome-4.7.0/css/font-awesome.min.css"/>
  <script src="source/jquery-1.10.2/jquery-1.10.2.js"></script>

  <script src="source/bootstrap/js/bootstrap.min.js"></script>
  <link href="source/bootstrap/css/bootstrap.min.css" rel="stylesheet" />

  <script src="source/bootstrapValidator/js/bootstrapValidator.min.js"></script>
  <link href="source/bootstrapValidator/css/bootstrapValidator.min.css" rel="stylesheet" />
  <link rel="stylesheet" type="text/css" media="screen" href="source/css/upload.css" />
  <title>my_pj_上传</title>







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

<%




  User user=((User)(request.getSession().getAttribute("user")));
  if(user==null) {
    response.setHeader("referer","localhost:8080/pj_war_exploded/upload.jsp");
    response.sendRedirect("login.jsp");
  }
  else
  {


    String imageId=request.getParameter("imageId");
    PictureDAO pictureDAO=new PictureDAO();
    String sql="SELECT imageId,path,title,description,content,country,city from travelimage where imageId=?";
    Picture pic=null;
    if(imageId!=null) {
      pic = pictureDAO.getInstance(sql, imageId);
    }
%>



<section>

  <div id="uploadcontent">


    <div class="up_til">UPLOAD</div>

    <form action="upload" method="POST" name="to_upload" enctype="multipart/form-data">
      <div id="up_pic">


        <div id="up_line"><i class="fa fa-picture-o" aria-hidden="true"></i> the picture hasn't been uploaded</div>

        <br>
        <img style="display:<%= pic==null?"none":"inline"%>" id="ready_to_up_pics" src="<% if(pic!=null) out.println("source/upfile/"+pic.getPath());%>" name="pics" alt=" hasn't been uploaded..." />
        <br>
        <!--<input id="up_trigger" type="button" value="Upload" onclick="show()" required>
        -->
        <!--<input id="up_button" name="upload_pics" accept="*/gif,*/jpeg,*/jpg,*/png"  type="file" onchange="previewFile()" >
        -->

        <div class="form-group">
          <input class="form-control" id="up_button" name="upload_pics" accept="*/gif,*/jpeg,*/jpg,*/png"  type="file" onchange="previewFile()" required>
        </div>



        <!--<script>
        function show(){
                document.getElementById("up_button").style.display="block";
               document.getElementById("up_line").style.display="none";

             }
        </script>-->


        <br>

        <script>
          function previewFile() {
            document.getElementById("up_line").style.display="none";

            var preview = document.getElementById('ready_to_up_pics');
            var file  = document.getElementById('up_button').files[0];
            var reader = new FileReader();
            if (file) {
              reader.readAsDataURL(file);
            }
            else {
              preview.src = "";
            }
            reader.onloadend = function () {
              preview.src = reader.result;
            }


            let uploadpic = document.getElementById("ready_to_up_pics");
            uploadpic.style.display = "inline";

          }
          //将文件内容读入内存，读取操作完成时，设置图片src为读取文件结果，如果文件成功获取用data:url的字符串形式表示来读取文件，否则不设置src
        </script>
      </div>


      <br>




      <div id="up_descp">


        <div class="form-group">
          <label>Picture's Title</label>
          <input class="form-control" name="upload_pic_title" type="text" value="<% if(pic!=null) out.println(pic.getTitle());%>"  required>
        </div>

        <div class="form-group">
          <label>Picture's Description</label>
          <textarea class="form-control" name="upload_pic_description" cols="6" type="text"  required><% if(pic!=null) out.println(pic.getDescription());%></textarea>
        </div>


        <div class="form-group">
          <label>Shooting Country</label>
          <!--<input class="form-control" name="upload_pic_country" type="text"  required> -->
          <select id="first" class="form-control" name="upload_pic_country" onChange="change()" required>
            <option selected="selected" value=""disabled selected hidden>COUNTRY</option>
            <%
              pictureDAO=new PictureDAO();
              sql="select geocountries.CountryName country,geocountries.ISO countryCode from geocountries order by countryName";
              List<Picture> countries=pictureDAO.getForList(sql);
              if(countries.size()!=0){

              for(Picture country:countries){
            %>
            <option><%= country.getCountry()%></option>

            <% }} %>

          </select>
        </div>

        <div class="form-group">
          <label>Shooting City</label>
          <!-- <input class="form-control" name="upload_pic_city" type="text"  required> -->
          <select id="second" class="form-control" name="upload_pic_city" required>
            <option selected="selected" value=""disabled selected hidden >CITY</option>
<%--            <%--%>

<%--              List<Picture>cities=(List<Picture>)request.getAttribute("cities");--%>
<%--              if(cities!=null&&cities.size()!=0){--%>
<%--                System.out.println("go cities"+cities.get(0).getCity());--%>
<%--                for(Picture city:cities){--%>
<%--                  out.print("<script>alert(\"this\");</script>");--%>
<%--                  System.out.println(city.getCity());--%>
<%--            %>--%>

<%--           <option><%= city.getCity()%></option>"--%>

<%--            <% }}--%>

<%--            %>--%>
          </select>
        </div>

        <script defer>

          function change(){

            let x = document.getElementById("first");

            let y = document.getElementById("second");

            y.options.length = 0; // 清除second下拉框的所有内容

            let i = 0;
            let count=x.options.length;


            /*
            jquery
            先获取大类选择框的值，并通过$.getJSON方法传递给后台，读取后台返回的JSON数据，
            并通过$.each方法遍历JSON数据，最后将option追加到小类里。
            * */

            $.getJSON("findRelatedCity",{first:$("#first").val()},function(json){

              let second = $("#second");


              $.each(json,function(index,array){
                //var option = "<option value='"+array['id']+"'>"+array['title']+"</option>";
                //alert(array);
                y.options.add(new Option(array, array));
              });
              });


            <%--alert("gogo");--%>
            <%--  <%--%>

            <%--  List<Picture>cities=(List<Picture>)request.getAttribute("cities");--%>
            <%--  if(cities!=null&&cities.size()!=0){--%>
            <%--    System.out.println("go cities"+cities.get(0).getCity());--%>
            <%-- for(Picture city:cities){--%>
            <%--   System.out.println(city.getCity());--%>
            <%--    %>--%>

            <%--y.innerHTML="<option><%= city.getCity()%></option>";--%>

            <%--alert("dododo");--%>
            <%--<% }}--%>

            <%--%>--%>

            <%--alert("eeend");--%>


          }


        </script>




        <div class="form-group">
          <label>Shooting Theme</label>
<%--          <input class="form-control"  id="upload_pic_theme" name="upload_pic_theme" type="text" placeholder="" required>--%>

            <select  class="form-control" name="upload_pic_theme" required>
            <option selected="selected" value=""disabled selected hidden>CONTENT</option>
            <option>Building</option>
            <option>Wonder</option>
            <option>Scenery</option>
            <option>City</option>
            <option>People</option>
            <option>Animal</option>
            <option>Other</option>
          </select>
        </div>


        <div class="form-group">
          <button type="submit" id="upload_submit" name="register_submit" class="btn btn-primary">Upload</button>
          <!--因为插件用的是jquery的submit 方法，不能用name="submit" 属性-->
        </div>



      </div>
    </form>

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



<script src="source/js/upload.js"></script>
<script src="source/js/modify.js"></script>


<script defer>
let submit=document.getElementById("upload_submit");
submit.addEventListener("click",function (e) {
  let r=confirm('确认信息是否无误');
  if(r==true)
  {

  }
  else if(r==false){
    e.preventDefault();
  }
});

  <% if(pic!=null)
    {
  %>


    let country = document.getElementById('first');
    let city = document.getElementById('second');
    let content=document.getElementsByName("upload_pic_theme")[0];

    for (let i = 0; i < content.options.length; i++) {
      if (content.options[i].value === "<%= pic.getContent()%>") {
        content.options[i].selected = true;
        break;
      }

    }


    for (let i = 0; i < country.options.length; i++) {
      if (country.options[i].value === "<%= pic.getCountry()%>") {
        country.options[i].selected = true;
        break;
      }

    }


    city.options.length = 0; // 清除second下拉框的所有内容

  $.getJSON("findRelatedCity",{first:$("#first").val()},function(json){

    let second = $("#second");


    $.each(json,function(index,array){
      //var option = "<option value='"+array['id']+"'>"+array['title']+"</option>";
      //alert(array);
      city.options.add(new Option(array, array));
    });


    for (let i = 0; i < city.options.length; i++) {
      if (city.options[i].value == "<%=pic.getCity() %>") {
        city.options[i].selected = true;
        break;
      }

    }


  });

  //
  // function getQueryVariable(variable)
  // {
  //   let query = window.location.search.substring(1);
  //   let vars = query.split("&");
  //   for (let i=0;i<vars.length;i++) {
  //     let pair = vars[i].split("=");
  //     if(pair[0] == variable){return pair[1];}
  //   }
  //   return(false);
  // }
  //
  //
  // let mimageId=getQueryVariable('imageId');
  //
  // let button=document.getElementById("upload_submit");
  // let form=document.getElementsByTagName('form')[0];
  // let file=document.getElementById("up_button");
  // let url='modify?imageId='+mimageId+'&picIsEmpty=';
  // button.onsubmit=function(){
  //
  //
  //   if(file.value==null || file.value=="")
  //     url=url+"true"
  //   else;
  //     url=url+"false";
  //
  //     form.setAttribute('action',url);
  //
  // };

  <%}%>



  if(document.getElementById('ready_to_up_pics').width+380>1200){
    document.getElementsByTagName('header')[0].style.setProperty('width',document.getElementById('ready_to_up_pics').width+130+'px');
    document.getElementsByClassName('top')[0].style.setProperty('width',document.getElementById('ready_to_up_pics').width+130+'px');
    document.getElementsByTagName('footer')[0].style.setProperty('width',document.getElementById('ready_to_up_pics').width+130+'px');


  }



</script>


<% } %>
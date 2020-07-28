<%@ page import="domain.User" %>
<%@ page import="java.util.List" %>
<%@ page import="domain.Invitation" %>
<%@ page import="dao.UserDAO" %>
<%@ page import="dao.InvitationDAO" %>
<%@ page import="dao.FriendshipDAO" %>
<%@ page import="domain.Friendship" %><%--
  Created by IntelliJ IDEA.
  User: yilingzhao
  Date: 2020/7/12
  Time: 上午9:08
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
    <script src="source/jquery-1.10.2/jquery-1.10.2.js"></script>
    <script src="source/js/jqfloatbox.js"></script>



    <link rel="stylesheet" type="text/css" media="screen" href="source/css/myfriends.css" />

    <title>my_pj_我的好友</title>
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

            <%
                if(request.getSession().getAttribute("user")==null)
                    response.sendRedirect("login.jsp");
                else{
            %>

<section>

    <div id="sidebar">

        <div id="sidesearch">
            <p><i class="fa fa-user-o" aria-hidden="true"></i> SEARCH FRIENDS BY USERNAME</p>
            <form action="searchFriends" method="GET" name="searchUsername">
                <!-- 两个均用name=“to_browse”来命名form -->
                <i class="fa fa-search" aria-hidden="true"></i> <input name="username" type="search" value="<%= request.getParameter("username")==null?"":request.getParameter("username") %>" >
                <input name="search" type="submit" value="search" onclick="message();">
                <!-- 解决放到github上之后的405not allowed 问题 -->

            </form>

            <script>

               function message(){
                  let search= document.getElementsByName("username")[0];
                  if(search.value=='')
                      alert("未输入任何信息，将显示所有非好友用户");
               }
            </script>

            <%
                User user=(User)request.getSession().getAttribute("user");
                boolean valid= (request.getAttribute("resultUsers")!=null);
                int size=0;
                if(valid)
                    size=((List<User>)request.getAttribute("resultUsers")).size();
                if(request.getAttribute("resultUsers")!=null){
            %>

            <table>
                <tr><th>Username</th><th>Email</th><th>DateJoined</th><th>Add</th></tr>
                <%
                    List<User> resultUsers=(List<User>)request.getAttribute("resultUsers");
                    InvitationDAO invitationDAO=new InvitationDAO();
                    String sql="select friendshipId from travelfriendship where uid=? and friendId=?";

                    int onlyAgreed=0;

                    for(User result:resultUsers){

                        if( !result.getUsername().equals(user.getUsername()) ){
                            //可以多次发送请求
                            if(invitationDAO.getValue(sql,user.getId(),result.getId())==null){
                %>

                <tr><td><%= result.getUsername()%></td><td><%= result.getEmail()%></td>
                    <td><%String time= result.getDate().toString();time=time.substring(0,time.length()-2); out.print(time);%></td>
                    <td><a href="sendInvitation?senderId=<%= user.getId()%>&receiverId=<%= result.getId()%>"><i class="fa fa-user-plus" aria-hidden="true"></i></a></td></tr>

                <%}else if(invitationDAO.getValue(sql,user.getId(),result.getId())!=null)
                    onlyAgreed++;
                        }
                    }
                    %>
            </table>
            <%
            if(resultUsers.size()==onlyAgreed){
            %>
            <p>No results</p>
            <script> let restable=document.getElementById("sidesearch").firstElementChild.nextElementSibling.nextElementSibling.nextElementSibling; restable.style.display="none"; </script>
            <%
                }
            %>
                <%}
                else if(request.getParameter("username")!=null){
                %>
           <p>No results</p>
                <%
                    }
                %>




        </div>



        <div class="myInvitations">

            <table>
                <tr><th colspan = "5"><i class="fa fa-envelope" aria-hidden="true"></i>  Received Invitations</th></tr>
                <%

                    InvitationDAO invitationDAO=new InvitationDAO();
                    String sql= "SELECT `invitationId`, `senderId`, `receiverId`, `invitationState`,sendDate FROM `travelinvitation` WHERE receiverid=? order by sendDate desc";

                    //每次访问都先去查一下收到的好友邀请

                    List<Invitation> receivedInvitations=invitationDAO.getForList(sql, user.getId());
                        if(receivedInvitations.size()==0){

                %>
                <tr><td>You haven't received any invitations</tr><td>
                <script> let rtable=document.getElementsByClassName("myInvitations")[0].firstElementChild;rtable.style.marginLeft="120px";</script>

                <% } else{
                            size+=receivedInvitations.size();
                    UserDAO userDAO=new UserDAO();
                    sql="select username from traveluser where uid=?";
                    String sender=null;
                            for(Invitation invitation:receivedInvitations){
                                sender=userDAO.getValue(sql,invitation.getSenderId());

                                if(invitation.getInvitationState().equals("ToBeConfirmed")){
                %>
                <tr>
                    <td>To Be Confirmed: </td>
                    <td><% String sendtime= invitation.getSendDate().toString(); sendtime=sendtime.substring(0,sendtime.length()-2);out.println("Invitation Sent At : "+sendtime); %></td>
                    <td> "<%= sender  %>" wants to be friends with you...</td>
                    <td style="font-size: 20px;padding-right: 10px">&nbsp <a href="handleInvitation?method=agree&senderId=<%= invitation.getSenderId()%>&receiverId=<%= invitation.getReceiverId()%>&invitationId=<%= invitation.getInvitationId()%>" onclick="alert('同意后默认向好友开放我的收藏');">Agree</a> &nbsp </td>
                    <td style="font-size: 20px"> &nbsp <a href="handleInvitation?method=reject&senderId=<%= invitation.getSenderId()%>&receiverId=<%= invitation.getReceiverId()%>&invitationId=<%= invitation.getInvitationId()%>" >Reject</a> &nbsp</td>
                </tr>
                <% }}
                    for(Invitation invitation:receivedInvitations){
                        sender=userDAO.getValue(sql,invitation.getSenderId());

                        if(invitation.getInvitationState().equals("Rejected")){ %>
                <tr> <td>Already Rejected: </td>
                    <td><% String sendtime= invitation.getSendDate().toString(); sendtime=sendtime.substring(0,sendtime.length()-2);out.println("Invitation Sent At : "+sendtime); %></td>


                    <td colspan="3"> You have rejected "<%=  sender %>" 's friend invitation... </td>

                </tr>


                <% }
                }
                    for(Invitation invitation:receivedInvitations){
                        sender=userDAO.getValue(sql,invitation.getSenderId());

                        if(invitation.getInvitationState().equals("Agreed")){ %>

                <tr> <td>Already Agreed: </td>
                    <td><% String sendtime= invitation.getSendDate().toString(); sendtime=sendtime.substring(0,sendtime.length()-2);out.println("Invitation Sent At : "+sendtime); %></td>
                    <td colspan="3"> You have agreed "<%= sender %>" 's friend invitation... </td>

                </tr>

                <% }} } %>
            </table>
        </div>



        <div class="myInvitations">

            <table>
                <tr><th colspan = "3"><i class="fa fa-envelope" aria-hidden="true"></i>  Sended Invitations</th></tr>
                <%


                    sql= "SELECT `invitationId`, `senderId`, `receiverId`, `invitationState`,sendDate FROM `travelinvitation` WHERE senderid=? order by sendDate desc";
                    List<Invitation> invitationList=null;

                    //每次访问都先去查一下收到的好友邀请

                        List<Invitation> sendedInvitations=invitationDAO.getForList(sql, user.getId());
                        if(sendedInvitations.size()==0){
                %>
                <tr><td>You haven't sent any invitations</td></tr>
                <script> let table=document.getElementsByClassName("myInvitations")[1].firstElementChild;table.style.marginLeft="120px";</script>

                <% } else{
                    size+=sendedInvitations.size();
                    UserDAO userDAO=new UserDAO();
                    sql="select username from traveluser where uid=?";
                    String receiver=null;
                    for(Invitation invitation:sendedInvitations){
                        receiver=userDAO.getValue(sql,invitation.getReceiverId());

                        if(invitation.getInvitationState().equals("ToBeConfirmed")){
                %>
                <tr> <td>To Be Confirmed:</td>
                    <td><% String sendtime= invitation.getSendDate().toString(); sendtime=sendtime.substring(0,sendtime.length()-2);out.println("Invitation Sent At : "+sendtime); %></td>

                    <td> "<%= receiver  %>" hasn't sent any response back...</td>

                </tr>
                <% }}
                    for(Invitation invitation:sendedInvitations){
                        receiver=userDAO.getValue(sql,invitation.getReceiverId());

                        if(invitation.getInvitationState().equals("Rejected")){ %>
                <tr> <td>Already Rejected : </td>
                    <td><% String sendtime= invitation.getSendDate().toString(); sendtime=sendtime.substring(0,sendtime.length()-2);out.println("Invitation Sent At : "+sendtime); %></td>

                    <td > Your friend invitation has been rejected by "<%=  receiver %>" ... </td>

                </tr>


                <% }
                }
                    for(Invitation invitation:sendedInvitations){
                        receiver=userDAO.getValue(sql,invitation.getReceiverId());

                        if(invitation.getInvitationState().equals("Agreed")){ %>

                <tr><td>Already Agreed : </td>
                    <td><% String sendtime= invitation.getSendDate().toString(); sendtime=sendtime.substring(0,sendtime.length()-2);out.println("Invitation Sent At : "+sendtime); %></td>

                    <td> Your friend invitation has been agreed by "<%=  receiver %>" ... </td>

                </tr>

                <% }} } %>
            </table>
        </div>




    </div>


       <div id="myfriendscontent" <% if(valid&&size!=0) out.print("style=\"min-height:"+(450+size*35)+"px\"");else  out.print("style=\"min-height:"+(450+size*35)+"px\""); %>>


        <div class="myfriends_til">MY FRIENDS</div>
           <%
               FriendshipDAO friendshipDAO=new FriendshipDAO();
               List<Friendship> friends=null;
               sql="select friendId,isOpened from travelfriendship where uid=?";
               friends=friendshipDAO.getForList(sql,user.getId());
               if(friends.size()==0){
           %>
           <h2>No friends in the friend-list! <br> Go to make friends!</h2>
           <% } else{
                   sql="select username,email,dateJoined date from traveluser where uid=?";
                   String sql2="select isOpened from travelfriendship where uid=?";
                   UserDAO userDAO=new UserDAO();
                   String friendIsOpened=null;
                   User friend=new User();
                   for(Friendship friendship:friends){
                       friend=userDAO.getInstance(sql,friendship.getFriendId());
                       friendIsOpened=friendshipDAO.getValue(sql2,friendship.getFriendId());
           %>

           <div class="friend">
           <table class="friendeach" cellpadding="10">
               <tr >
                   <td rowspan="4"><i style="font-size: 68px" class="fa fa-user-circle-o" aria-hidden="true"></i></td>
                   <td><a href="visitFriendFavor?visitorId=<%= user.getId()%>&friendId=<%= friendship.getFriendId()%>">Username : <%= friend.getUsername()%></a>

<%--                       &nbsp  &nbsp &nbsp &nbsp &nbsp--%>
<%--                       <a class="my-link <%= "friendId:"+friendship.getFriendId()%>" style="text-decoration-line: underline">CHAT</a>--%>
<%--                   --%>
                   </td>
               </tr>
               <tr>
                   <td><a href="visitFriendFavor?visitorId=<%= user.getId()%>&friendId=<%= friendship.getFriendId()%>">Email : <%= friend.getEmail()%></a></td>
               </tr>
               <tr><td>DateJoined : <%String date= friend.getDate().toString();date=date.substring(0,date.length()-2);out.print(date); %></td></tr>
<%--               <tr><td style="font-weight:bolder;text-decoration:underline;font-size:20px "><%= friend.getUsername()+" 's favored pics are "+(friendIsOpened.equals("y")?"opened":"closed" )+" to you..." %></td></tr>--%>

               <tr><td><a style="text-decoration-line: underline"  href="deleteFriend?uid=<%= user.getId()%>&friendId=<%= friendship.getFriendId()%>">DELETE THIS FRIEND</a></td></tr>

           </table>
           <div class="con_word">
               <div class="size2">
                   Your Favorites are <%= friendship.getIsOpened().equals("y")?"OPENED":"CLOSED"  %> to <%= friend.getUsername()%>
                   <br>
                   <a href="toggleFavorIsOpened?method=<%= friendship.getIsOpened().equals("y")?"close":"open"  %>&uid=<%= user.getId()%>&friendId=<%= friendship.getFriendId()%>">Click To <%= friendship.getIsOpened().equals("y")?"Close":"Open"   %> My Favorites</a>
               </div>
           </div>


           </div>

           <% }
               } %>


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


    /*

    $("a.my-link").click(function () {
        alert( this.getAttribute("class").substr(17));

        $.floatbox({
            ajax:  {
               // url: "getMessages?senderId=<%= user.getId()%>&receiverId="+this.getAttribute("class").substr(17), // request url
               url:"websocket",
                // params:  "name=ieda&age=23", //post parameters
                before:  "Loading content", //loading message while the request is being processed
                delay: 500, //每隔5s刷新
                finish: function () {
                    //callback function
                }
            },
            fade: true,
            content:
                "<div id=\"chatroom\"><h2>Chatting</h2>" +
                "<div id=\"chattingmessages\">" +
                    "<div class=\"others\">AAA : <br><div class=\"messContent\">你好</div>" +
                    "</div>" +
                    "<div class=\"mine\">BBB : <br><div class=\"messMyContent\">你好</div>" +
                " </div>"+
                "<div class=\"others\">AAA : <br><div class=\"messContent\">你好</div>" +
                "</div>" +
                "<div class=\"mine\">BBB : <br><div class=\"messMyContent\">你好</div>" +
                " </div>"+
                "<div class=\"others\">AAA : <br><div class=\"messContent\">你好</div>" +
                "</div>" +
                "<div class=\"mine\">BBB : <br><div class=\"messMyContent\">你好</div>" +
                " </div>"+
                "<div class=\"others\">AAA : <br><div class=\"messContent\">你真的真的真的很不错</div>" +
                "</div>" +
                "<div class=\"mine\">BBB : <br><div class=\"messMyContent\">你也真的真的真的很好</div>" +
                " </div>"+
                "</div>" +

                "<form action=\"\" method=\"post\">" +
                "          <textarea style='width: 550px;height:90px' class=\"form-control\" id=\"comments\" name=\"comments\" cols=\"6\" type=\"text\" placeholder=\"Please input no more than 30 characters ...\" maxlength=\"30\"  required></textarea>" +
                "          <br><button style='float:right;margin-right:50px;' type=\"submit\" id=\"comment_submit\" name=\"comment_submit\" class=\"btn btn-primary\">Send</button>" +
                "      </form>"
            +"</div>"

    });
        //固定开始看到的在最底部
        document.getElementById("chattingmessages").scrollTo(0, document.getElementById("chattingmessages").scrollHeight);
    });


    $(function() {
        var url = "websocket";
        var ws = "";
        var message ={"id":"","msg":"","form":"","to":""};
        function connection() {
            ws = new WebSocket(url);
            console.log("connection.......");
            ws.onmessage = function (e){
                var json = eval('(' +  e.data.toString() + ')');
                showMessage(json.from +":"+ json.msg);
            }
            ws.onclose = function() {
                showMessage("close");
            }
            ws.onerror = function (e){
                showMessage("error");
            }
            ws.onopen = function() {
                showMessage("链接成功")
                message.id = $(".identity").val();
                message.msg = "newUser";
                console.log(JSON.stringify(message));
                ws.send(JSON.stringify(message));
                message.msg = "";

            }
        }




        $(".start-conn-btn").click(function() {
            connection();
        });
        $(".send-btn").click(function() {//send message
            message.to = $(".to-user").val();
            message.msg = $(".msg-context").val();
            $(".msg-context").val("");
            ws.send(JSON.stringify(message));
            showMessage( "我:" + message.msg );
            message.msg = "";

        });

        function showMessage(msg) {
            $("#chattingmessages").append( msg + "<br/>");

        }


    });

*/

</script>


<% } %>
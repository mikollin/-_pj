package controller;

import dao.InvitationDAO;
import domain.Invitation;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

@WebServlet(name = "controller.SendInvitationServlet", value = "/sendInvitation")
public class SendInvitationServlet extends HttpServlet {
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        doGet(request,response);
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        response.setCharacterEncoding("UTF-8");

        String senderId=request.getParameter("senderId");
        String receiverId=request.getParameter("receiverId");
        Timestamp date=new Timestamp(new Date().getTime());
        System.out.println(date.toString());

        String sql=null;
        InvitationDAO invitationDAO=new InvitationDAO();
        sql="select invitationId from travelinvitation where senderId=? and receiverId=? and invitationState='ToBeConfirmed'";
        boolean isSent=false;
        if(invitationDAO.getValue(sql,senderId,receiverId)!=null)
            isSent=true;

        Timestamp now=new Timestamp(new Date().getTime());
        if(isSent){
            sql="UPDATE `travelinvitation` SET `sendDate`=? WHERE senderId=? and receiverId=? ";
            invitationDAO.update(sql,now,senderId,receiverId);
        }

        //如果同一个人多次发送请求，只保留一份且时间切换为最新时间
        if(!isSent) {
            sql = "INSERT INTO `travelinvitation`( `senderId`, `receiverId`,`sendDate`) VALUES (?,?,?)";
            invitationDAO.update(sql, senderId, receiverId, date);
        }

        sql="select invitationId from travelinvitation where senderId=? and receiverId=? and invitationState='ToBeConfirmed'";
        boolean isReceiverSent=false;
        if(invitationDAO.getValue(sql,receiverId,senderId)!=null)
            isReceiverSent=true;

        //如果双方均发送了好友邀请，那么自动成为好友
        if(isReceiverSent){
            sql = "UPDATE `travelinvitation` SET `invitationState`='Agreed' WHERE senderId=? and receiverId=? and invitationState='ToBeConfirmed' ";
            invitationDAO.update(sql, senderId, receiverId);
            invitationDAO.update(sql, receiverId, senderId);

            sql = "INSERT INTO `travelfriendship`( `uid`, `friendId`) VALUES (?,?)";
            invitationDAO.update(sql, senderId, receiverId);
            invitationDAO.update(sql, receiverId, senderId);
        }

//        sql="SELECT `invitationId`, `senderId`, `receiverId`, `invitationState`,sendDate FROM `travelinvitation` WHERE senderId=?";
//        List<Invitation> invitationList=invitationDAO.getForList(sql,senderId);
//
//        request.getSession().setAttribute("sendedInvitations",invitationList);

        response.sendRedirect("myfriends.jsp");

    }
}

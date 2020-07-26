package controller;

import dao.FriendshipDAO;
import dao.InvitationDAO;
import domain.Invitation;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "controller.HandleInvitationServlet", value = "/handleInvitation")
public class HandleInvitationServlet extends HttpServlet {
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        doGet(request,response);
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        response.setCharacterEncoding("UTF-8");

        String method=request.getParameter("method");
        switch (method){
            case "agree": agreeInvitation(request,response);break;
            case "reject": rejectInvitation(request,response);break;
        }



    }

    public void agreeInvitation(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String receiverId=request.getParameter("receiverId");
        String senderId=request.getParameter("senderId");
        String invitationId=request.getParameter("invitationId");
        String sql="UPDATE `travelinvitation` SET `invitationState`='Agreed' WHERE invitationId=?";
        InvitationDAO invitationDAO=new InvitationDAO();
        invitationDAO.update(sql,invitationId);

        sql="select friendshipId from travelfriendship where uid=? and friendid=?";
        FriendshipDAO friendshipDAO=new FriendshipDAO();

        if(friendshipDAO.getValue(sql,senderId,receiverId)==null) {
            sql = "INSERT INTO `travelfriendship`( `uid`, `friendId`) VALUES (?,?)";
            invitationDAO.update(sql, senderId, receiverId);
            invitationDAO.update(sql, receiverId, senderId);
        }

        //发送多个请求（包括互相请求且均未确认）一个同意全设为统一
        sql="UPDATE `travelinvitation` SET `invitationState`='Agreed' WHERE senderId=? and receiverId=? and invitationState='ToBeConfirmed' ";
        invitationDAO.update(sql,senderId,receiverId);
        invitationDAO.update(sql, receiverId, senderId);

        response.sendRedirect("myfriends.jsp");


    }



    public void rejectInvitation(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String receiverId=request.getParameter("receiverId");
        String senderId=request.getParameter("senderId");
        String invitationId=request.getParameter("invitationId");
        String sql="UPDATE `travelinvitation` SET `invitationState`='Rejected' WHERE invitationId=?";
        InvitationDAO invitationDAO=new InvitationDAO();
        invitationDAO.update(sql,invitationId);

        response.sendRedirect("myfriends.jsp");
    }



    }

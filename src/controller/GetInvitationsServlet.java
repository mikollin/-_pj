package controller;

import dao.InvitationDAO;
import domain.Invitation;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "controller.GetInvitationsServlet",value = "/getInvitations")
public class GetInvitationsServlet extends HttpServlet {
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String receiverId=request.getParameter("receiverId");
        String senderId=request.getParameter("senderId");
        InvitationDAO invitationDAO=new InvitationDAO();
        String sql=null;
        if(receiverId!=null)
        sql="SELECT `invitationId`, `senderId`, `receiverId`, `invitationState`,sendDate FROM `travelinvitation` WHERE receiverid=?";
       else
           sql="SELECT `invitationId`, `senderId`, `receiverId`, `invitationState`,sendDate FROM `travelinvitation` WHERE senderid=?";
        List<Invitation> invitationList=null;


        if(receiverId!=null) {
            invitationList = invitationDAO.getForList(sql, receiverId);
            request.getSession().setAttribute("myInvitations",invitationList);
        }
        else if(senderId!=null) {
            invitationList = invitationDAO.getForList(sql, receiverId);
            request.getSession().setAttribute("sendedInvitations",invitationList);

        }

        response.sendRedirect("myfriends.jsp");
    }
}

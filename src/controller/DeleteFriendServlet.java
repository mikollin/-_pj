package controller;

import dao.FriendshipDAO;
import dao.InvitationDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.Date;

@WebServlet(name = "controller.DeleteFriendServlet", value = "/deleteFriend")
public class DeleteFriendServlet extends HttpServlet {
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        doGet(request,response);
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        response.setCharacterEncoding("UTF-8");

        String uid=request.getParameter("uid");
        String friendId=request.getParameter("friendId");
        String sql="DELETE FROM `travelfriendship` WHERE uid=? and friendId=?";
        FriendshipDAO friendshipDAO=new FriendshipDAO();
        friendshipDAO.update(sql,uid,friendId);
        friendshipDAO.update(sql,friendId,uid);



        response.sendRedirect("myfriends.jsp");

    }
}

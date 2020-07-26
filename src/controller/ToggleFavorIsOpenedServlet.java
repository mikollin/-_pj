package controller;

import dao.FriendshipDAO;
import domain.Friendship;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "ToggleFavorIsOpenedServlet", value = "/toggleFavorIsOpened")
public class ToggleFavorIsOpenedServlet extends HttpServlet {
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        doGet(request,response);
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String method=request.getParameter("method");
        switch (method){
            case "close":close(request,response);break;
            case "open":open(request,response);break;
        }



    }

    public void close(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String uid=request.getParameter("uid");
        String friendId=request.getParameter("friendId");
        FriendshipDAO friendshipDAO=new FriendshipDAO();
        String sql="UPDATE `travelfriendship` SET `IsOpened`=? WHERE uid=? and friendId=?";
        friendshipDAO.update(sql,"n",uid,friendId);

        response.sendRedirect("myfriends.jsp");

    }


    public void open(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String uid=request.getParameter("uid");
        String friendId=request.getParameter("friendId");
        FriendshipDAO friendshipDAO=new FriendshipDAO();
        String sql="UPDATE `travelfriendship` SET `IsOpened`=? WHERE uid=? and friendId=?";
        friendshipDAO.update(sql,"y",uid,friendId);

        response.sendRedirect("myfriends.jsp");
    }


    }

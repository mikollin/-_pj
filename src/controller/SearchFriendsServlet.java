package controller;

import com.alibaba.fastjson.JSON;
import dao.PictureDAO;
import dao.UserDAO;
import domain.Picture;
import domain.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

@WebServlet(name = "controller.SearchFriendsServlet", value = "/searchFriends")
public class SearchFriendsServlet extends HttpServlet {


    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request,response);
    }
    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        String username=request.getParameter("username");
        username="%"+username+"%";
        System.out.println(username);
         UserDAO userDAO=new UserDAO();
         String sql="select uid id,username,email,DateJoined date from traveluser where username like ? order by username desc";
         List<User> users=new ArrayList<>();
         users=userDAO.getForList(sql,username);
         System.out.println(users);
         request.setAttribute("resultUsers",users);
         request.getRequestDispatcher("myfriends.jsp").forward(request,response);
    }




}

package controller;

import dao.FriendshipDAO;
import dao.PictureDAO;
import dao.UserDAO;
import domain.Friendship;
import domain.Picture;
import domain.User;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

// value的值指定在浏览器中的访问路径
@WebServlet(name = "controller.VisitFriendFavorServlet", value = "/visitFriendFavor")
public class VisitFriendFavorServlet extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        User login = (User) session.getAttribute("user");

        if (login == null) {
           // response.setHeader("referer", "myfavor");
            response.sendRedirect("index.jsp"); //若直接跳到login.jsp就相当于直接访问login.jsp一样 之前点击的页面为null
        } else {

            String visitorId=request.getParameter("visitorId");
            String friendId=request.getParameter("friendId");

            FriendshipDAO friendshipDAO=new FriendshipDAO();
            boolean canVisited=false;
            String sql="select isOpened from travelfriendship where uid=? and friendId=?";
            String isOpened=friendshipDAO.getValue(sql,friendId,visitorId); //查看friend对当前用户开放吗
            System.out.println(isOpened);
            if(isOpened.equals("y"))
                canVisited=true;

            if(canVisited) {


                String uid = friendId;


                sql = "SELECT imageId from travelimagefavor where uid=?";


                List<Picture> pics = new ArrayList<>();

                PictureDAO daoPicture = new PictureDAO();
                List<Picture> imageIds = daoPicture.getForList(sql, uid);
                request.setAttribute("allCount", imageIds.size());

                String offset = null;

                if (request.getParameter("offset") == null) {
                    sql = sql + " limit 0,5";
                } else {

                    offset = (String) request.getParameter("offset");
                    System.out.println(offset);
                    sql = sql + " limit " + offset + ",5";

                }
                pics = new ArrayList<>();

                imageIds = daoPicture.getForList(sql, uid);


                for (Picture image : imageIds) {
                    sql = "SELECT imageId,path,title,description,content,username author,uid authorId from travelimage where imageid=?";
                    Picture pic = daoPicture.getInstance(sql, image.getImageId());
                    pics.add(pic);
                }
                request.setAttribute("favorPics", pics);
                request.setAttribute("message","canVisited");


            }else {
                request.setAttribute("message","cannotVisited");
            }


            RequestDispatcher dispatcher = request.getRequestDispatcher("myfavor.jsp?friendId="+friendId+"&visitorId="+visitorId);
            dispatcher.forward(request, response);

        }
    }

    }


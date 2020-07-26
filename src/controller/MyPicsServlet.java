package controller;

import dao.PictureDAO;
import dao.UserDAO;
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
@WebServlet(name = "controller.MyPicsServlet", value = "/mypics")
public class MyPicsServlet extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
           // response.setHeader("referer", "myfavor");
            response.sendRedirect("index.jsp"); //若直接跳到login.jsp就相当于直接访问login.jsp一样 之前点击的页面为null
        } else {

            String sql = "SELECT imageId,path,title,description,content,username author,uid authorId from travelimage where uid=?";


            List<Picture> pics = new ArrayList<>();

            PictureDAO daoPicture = new PictureDAO();
            List<Picture> imageIds = daoPicture.getForList(sql, user.getId());
            request.setAttribute("allCount",imageIds.size());

            String offset=null;

            if(request.getParameter("offset")==null) {
                sql=sql+" limit 0,5";
            }
            else{

                offset=(String) request.getParameter("offset");
                System.out.println(offset);
                sql=sql+" limit "+offset+",5";

            }

            pics = daoPicture.getForList(sql, user.getId());


            request.setAttribute("myPics", pics);

            RequestDispatcher dispatcher = request.getRequestDispatcher("mypics.jsp");
            dispatcher.forward(request, response);


        }
    }

    }


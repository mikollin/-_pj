package controller;

import dao.PictureDAO;
import domain.Picture;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "controller.HomeServlet", value = "/index")
public class HomeServlet extends HttpServlet {


    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        PictureDAO pictureDAO=new PictureDAO();
        String sql="select title,path,imageId from travelimage order by favorednum desc limit 0,3";
        List<Picture> pictureList=new ArrayList<Picture>();
        pictureList=pictureDAO.getForList(sql);
        request.setAttribute("hotpics",pictureList);

        sql="select title,imageId,path,uid authorId,content,uploadDate from travelimage order by uploaddate desc limit 0,8";
        pictureList= pictureList=pictureDAO.getForList(sql);


        request.setAttribute("newestpics",pictureList);

        request.getRequestDispatcher("index.jsp").forward(request,response);


    }




}

package controller;

import dao.PictureDAO;
import dao.UserDAO;
import domain.Picture;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Timestamp;

// value的值指定在浏览器中的访问路径
@WebServlet(name = "controller.DetailServlet", value = "/detail")
public class DetailServlet extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        String imageId=request.getParameter("imageId");


        String sql = "SELECT imageId,path,title,description,favoredNum,content,uid authorId,cityCode,countrycodeiso countryCode from travelimage where imageid=?";

        PictureDAO daoPicture=new PictureDAO();
        Picture picture=daoPicture.getInstance(sql,imageId);
        int uid=picture.getAuthorId();
        sql="select username from traveluser where uid=?";
        UserDAO userDAO=new UserDAO();

        picture.setAuthor(userDAO.getValue(sql,uid));
        sql="select countryname from geocountries where iso=?";
        String countryname=daoPicture.getValue(sql,picture.getCountryCode());
        picture.setCountry(countryname);

        sql="select asciiname from geocities where geonameid=?";
        String city=daoPicture.getValue(sql,picture.getCityCode());
        picture.setCity(city);

        sql="select uploaddate from travelimage where imageid=?";
        Timestamp uploadDate=daoPicture.getValue(sql,imageId);
        picture.setUploadDate(uploadDate);

        request.setAttribute("pic",picture);

        RequestDispatcher dispatcher=request.getRequestDispatcher("detail.jsp");
        dispatcher.forward(request,response);


    }


    }


package controller;

import dao.PictureDAO;
import dao.UserDAO;
import domain.Picture;
import domain.User;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.List;

// value的值指定在浏览器中的访问路径
@WebServlet(name = "controller.SearchServlet", value = "/search")
public class SearchServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        response.setCharacterEncoding("UTF-8");


        String type=request.getParameter("type");
        String sortType=request.getParameter("sort");
        String filter_value=request.getParameter("filter_value");
        filter_value="%"+filter_value+"%"; //模糊搜索
        String sql=null;
        String offset;


            if (type.equals("Title") && sortType.equals("FavoredNum")) {
                sql = "select imageId,title,path,description from travelimage where title like ? order by favorednum desc ";

            } else if (type.equals("Title") && sortType.equals("UploadDate")) {
                sql = "select imageId,title,path,description from travelimage where title like ? order by UploadDate desc ";

            } else if (type.equals("Content") && sortType.equals("FavoredNum")) {
                sql = "select imageId,title,path,description from travelimage where content like ? order by FavoredNum desc ";

            } else if (type.equals("Content") && sortType.equals("UploadDate")) {
                sql = "select imageId,title,path,description from travelimage where Content like ? order by UploadDate desc ";

            }

        PictureDAO pictureDAO=new PictureDAO();
        List<Picture> results=new ArrayList<Picture>();

        results=pictureDAO.getForList(sql,filter_value);
        System.out.println("size"+results.size());
        request.setAttribute("allCount",results.size());




        if(request.getParameter("offset")==null) {
            sql=sql+"limit 0,5";
        }
        else{

            offset=(String) request.getParameter("offset");
            System.out.println(offset);
            sql=sql+"limit "+offset+",5";

        }



        System.out.println(sql);


        results= pictureDAO.getForList(sql,filter_value);
        request.setAttribute("results",results);
        //System.out.println(results);

        request.getRequestDispatcher("search.jsp").forward(request,response);






    }







}
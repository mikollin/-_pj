package controller;

import dao.PictureDAO;
import dao.UserDAO;
import domain.Picture;
import domain.User;
import service.SearchingUtil;

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

        String filter_value1="%"+filter_value+"%";
        filter_value="%"+filter_value+"%"; //模糊搜索

        String sql=null;
        int offset;


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
        List<Picture> resultsall=new ArrayList<Picture>();
        List<Picture> results;
        List<Picture> addedres;

        resultsall=pictureDAO.getForList(sql,filter_value);
        System.out.println("result :"+resultsall);

        //filter_value= SearchingUtil.specialStr(filter_value);
        filter_value=SearchingUtil.specialStrKeyword(filter_value);
        System.out.println(filter_value);

        results=resultsall;
        addedres=pictureDAO.getForList(sql,filter_value);
        for(Picture add :addedres ){
            if(!resultsall.contains(add)){
                results.add(add);
            }
        }

        System.out.println("added :"+results);

        System.out.println("size"+results.size());
        request.setAttribute("allCount",results.size());


        List<Picture> res=new ArrayList<Picture>();


        if(request.getParameter("offset")==null) {
            sql=sql+"limit 0,5";

            for(int i=0;i<5&&i<results.size();i++)
                res.add(results.get(i));

        }
        else{

            offset=Integer.parseInt((String) request.getParameter("offset"));
            System.out.println(offset);
            sql=sql+"limit "+offset+",5";


            for(int i=offset;i<5+offset&&i<results.size();i++)
                res.add(results.get(i));

        }



        System.out.println(sql);


        /*

        results= pictureDAO.getForList(sql,filter_value1);
//
//        filter_value= SearchingUtil.specialStr(filter_value);
//        filter_value=SearchingUtil.specialStrKeyword(filter_value);
        System.out.println("results :"+results);
        addedres=pictureDAO.getForList(sql,filter_value);
        for(Picture add :addedres ){
            if(!resultsall.contains(add)&&results.size()<5){
                results.add(add);
            }
        }

        System.out.println("added :"+results);


        request.setAttribute("results",results);

         */

        request.setAttribute("results",res);
        //System.out.println(results);

        request.getRequestDispatcher("search.jsp").forward(request,response);






    }







}
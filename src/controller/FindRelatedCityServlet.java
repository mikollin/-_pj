package controller;

import com.alibaba.fastjson.JSON;
import dao.PictureDAO;
import domain.Picture;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.*;

@WebServlet(name = "controller.FindRelatedCityServlet", value = "/findRelatedCity")
public class FindRelatedCityServlet extends HttpServlet {


    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request,response);
    }
    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/json; charset=utf-8");    // 设置response的编码及格式
        PrintWriter out = response.getWriter();

        String country=(String)request.getParameter("first");

        System.out.println("country : "+country);



        PictureDAO pictureDAO=new PictureDAO();
        String sql="select geocountries.CountryName country,geocities.AsciiName city from geocities inner join geocountries on geocities.CountryCodeISO= geocountries.ISO where geocountries.CountryName=? order by geocities.AsciiName";
        List<Picture> cities=new ArrayList<Picture>();
        cities=pictureDAO.getForList(sql,country);
       // request.setAttribute("cities",cities);
       // request.getRequestDispatcher("upload.jsp").forward(request,response);


        Map<String,String> resMap = new TreeMap<>();
        for(Picture city:cities){

            //System.out.println(city.getCity());
            resMap.put(city.getCity(),city.getCity());

        }
        String resJSON = JSON.toJSONString(resMap);     // 转换为json

        //System.out.println(resJSON);
        out.print(resJSON); // 输出

    }




}

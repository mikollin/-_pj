package controller;

import dao.PictureDAO;
import dao.PictureDAO;
import domain.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

// value的值指定在浏览器中的访问路径
@WebServlet(name = "controller.SetFavorServlet", value = "/setFavor")
public class SetFavorServlet extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        User user=(User)request.getSession().getAttribute("user");
        String imageId=request.getParameter("imageId");
        int uid=user.getId();
        String sql="INSERT INTO `travelimagefavor`(`UID`, `ImageID`) VALUES (?,?)";
        PictureDAO pictureDAO=new PictureDAO();
        pictureDAO.update(sql,uid,imageId);
        Integer favoredNum=0;
        sql="select favoredNum from travelimage where imageid=?";
        favoredNum=pictureDAO.getValue(sql,imageId);
        favoredNum=favoredNum+1;
        sql="UPDATE `travelimage` SET `favorednum`=? WHERE imageid=?";
        pictureDAO.update(sql,favoredNum,imageId);

        response.sendRedirect("detail?imageId="+imageId);



//
//        RequestDispatcher dispatcher=request.getRequestDispatcher("detail.jsp");
//        dispatcher.forward(request,response);


    }


    }


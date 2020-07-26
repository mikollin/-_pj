package controller;

import dao.CommentsDAO;
import dao.PictureDAO;
import domain.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.Date;

// value的值指定在浏览器中的访问路径
@WebServlet(name = "controller.CreateCommentServlet", value = "/createComment")
public class CreateCommentServlet extends HttpServlet {
    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        String imageId=request.getParameter("imageId");

        System.out.println("comment: "+imageId);
        User user=(User)request.getSession().getAttribute("user");
        String comment=request.getParameter("comments");
        Timestamp commentDate=new Timestamp(new Date().getTime());

        CommentsDAO commentsDAO=new CommentsDAO();
        String sql="INSERT INTO `travelimagecomments`( `imageId`, `uid`, `comment`,`commentDate`) VALUES (?,?,?,?)";
        commentsDAO.update(sql,imageId,user.getId(),comment,commentDate);

        response.sendRedirect("detail?imageId="+imageId);



    }


    }


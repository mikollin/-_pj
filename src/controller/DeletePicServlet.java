package controller;

import dao.CommentsDAO;
import dao.PictureDAO;
import domain.Comments;
import domain.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

// value的值指定在浏览器中的访问路径
@WebServlet(name = "controller.DeletePicServlet", value = "/delete")
public class DeletePicServlet extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        String imageId=request.getParameter("imageId");

        System.out.println("delete: "+imageId);
        User user=(User)request.getSession().getAttribute("user");

        int uid=user.getId();
        String sql="DELETE FROM `travelimage` WHERE uid=? and imageid=?";
        PictureDAO pictureDAO=new PictureDAO();
        pictureDAO.update(sql,uid,imageId);

        sql="DELETE FROM `travelimagefavor` WHERE imageid=?";
        pictureDAO.update(sql,imageId);

        sql="DELETE FROM `travelhistory` WHERE imageid=?";
        pictureDAO.update(sql,imageId);

        //删除这张图片的评论
        CommentsDAO commentsDAO=new CommentsDAO();
        List<Comments> comments=null;
        sql="select commentId FROM `travelimagecomments` WHERE imageid=?";
        comments=commentsDAO.getForList(sql,imageId);
        String sql2;

        for(Comments com:comments){
            sql2="delete from travelimagecommentsfavor where commentId=?";
            commentsDAO.update(sql2,com.getCommentId());
        }

        sql="delete FROM `travelimagecomments` WHERE imageid=?";
        commentsDAO.update(sql,imageId);

        response.sendRedirect("mypics");



    }


    }


package controller;

import dao.CommentsDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

// value的值指定在浏览器中的访问路径
@WebServlet(name = "controller.CancelThumbUp", value = "/cancelThumbUp")
public class CancelThumbUpServlet extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String imageId=request.getParameter("imageId");
        String commentId=request.getParameter("commentId");
        String uid=request.getParameter("uid");

        String sql="delete from `travelimagecommentsfavor` where commentId=? and uid=?";
        CommentsDAO commentsDAO=new CommentsDAO();
        commentsDAO.update(sql,commentId,uid);
        Integer favoredNum=0;
        sql="select favoredNum from travelimagecomments where commentid=?";
        favoredNum=commentsDAO.getValue(sql,commentId);
        favoredNum=favoredNum-1;
        sql="UPDATE `travelimagecomments` SET `favorednum`=? WHERE commentid=?";
        commentsDAO.update(sql,favoredNum,commentId);

        response.sendRedirect("detail?imageId="+imageId);


    }


    }


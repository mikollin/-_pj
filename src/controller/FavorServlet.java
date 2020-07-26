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
@WebServlet(name = "controller.FavorServlet", value = "/myfavor")
public class FavorServlet extends HttpServlet {
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

            response.setContentType("application/json");
            PrintWriter out = response.getWriter();
//
//        out.println("<html><body>");
//        out.print("<h2>register</h2>");

//        JdbcUtil util = new JdbcUtil();
//        Connection conn = util.getConnection();
            //       String sql = "use Pj2";
            UserDAO daoUser = new UserDAO();
//        PreparedStatement pst = null;
//        ResultSet rs = null;

            //       try {
//                pst = conn.prepareStatement(sql);
////                rs = pst.executeQuery();
            String sql = "SELECT uid from traveluser where username=?";
//                pst= conn.prepareStatement(sql);
//                pst.setString(1,user.getUsername());
//                rs=pst.executeQuery();
//                rs.next();

            //int uid=rs.getInt(1);
            Integer uid = daoUser.getValue(sql, user.getUsername());

            user.setId(uid);

            sql = "SELECT imageId from travelimagefavor where uid=?";
//                pst = conn.prepareStatement(sql);
//                pst.setInt(1,uid);
//                rs=pst.executeQuery();




            List<Picture> pics = new ArrayList<>();

            PictureDAO daoPicture = new PictureDAO();
            List<Picture> imageIds = daoPicture.getForList(sql, uid);
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


//
             pics = new ArrayList<>();

            imageIds = daoPicture.getForList(sql, uid);

            // int imageId;

//                while(rs.next()) {
//                    imageId=rs.getInt(1);  //columnLabel：数据表中列名称或别名。
//
//                    sql = "SELECT path,title,description from travelimage where imageid=?";
//                    pst = conn.prepareStatement(sql);
//
//                    pst.setInt(1, imageId);
//                    rs = pst.executeQuery();
//                    Picture pic = new Picture();
//                    rs.next();
//                    pic.setPath(rs.getString(1));
//                    pic.setTitle(rs.getString(2));
//                    pic.setDescription(rs.getString(3));
//                    pics.add(pic);
//
//                    System.out.println(pic);
//
//                }

            for (Picture image : imageIds) {
                sql = "SELECT imageId,path,title,description,content,username author,uid authorId from travelimage where imageid=?";
                Picture pic = daoPicture.getInstance(sql, image.getImageId());
                pics.add(pic);
            }
            request.setAttribute("favorPics", pics);

            RequestDispatcher dispatcher = request.getRequestDispatcher("myfavor.jsp");
            dispatcher.forward(request, response);


//        } catch (SQLException e) {
//            e.printStackTrace();
//        } finally {
//            util.close(rs, pst, conn);
//        }
        }
    }

    }


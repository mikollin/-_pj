package controller;

import dao.UserDAO;
import domain.User;
import service.CodingUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.security.NoSuchAlgorithmException;
import java.sql.*;

// value的值指定在浏览器中的访问路径
@WebServlet(name = "controller.RegisterServlet", value = "/register")
public class RegisterServlet extends HttpServlet {
    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String username = request.getParameter("id");
        String email = request.getParameter("email");
        String password = request.getParameter("password1");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("application/json");
        PrintWriter out=response.getWriter();
//
//        out.println("<html><body>");
//        out.print("<h2>register</h2>");

//        JdbcUtil util = new JdbcUtil();
//        Connection conn = util.getConnection();
//        String sql = "use Pj2";
//        PreparedStatement pst = null;
//        ResultSet rs = null;

//        try {
//                pst = conn.prepareStatement(sql);
//                rs = pst.executeQuery();
//
//                sql = "INSERT INTO `traveluser`(`username`, `email`,`pass`,`DateJoined`) VALUES (?,?,?,?)";
//
//                pst = conn.prepareStatement(sql);
//                pst.setString(1,username);
//                pst.setString(2,email);
//                pst.setString(3,password);
                Timestamp date=new Timestamp(new java.util.Date().getTime());
//                pst.setDate(4,date);
//                pst.executeUpdate();
//
//                User user=new User(username,email,password,date);
//
        User user=null;
        UserDAO userDAO=new UserDAO();
        //防止复写
        request.getSession().removeAttribute("validateCode");

        //密码加密
        //password= CodingUtil.encodeStringToBase64String(password);
        try {
            password=CodingUtil.EncoderByMd5(password);
            System.out.println("password"+password);
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }

        user=userDAO.addUser(username,email,password,date);
                System.out.println(date.toString());
                System.out.println(user);

                request.getSession().setAttribute("user",user);

            HttpSession session=request.getSession();
            String path=(String)session.getAttribute("referer");
            session.removeAttribute("referer");
            //out.print("<script>alert(\"登录成功\")</script>");
            response.sendRedirect(path);

//        } catch (SQLException e) {
//            e.printStackTrace();
//        } finally {
//            util.close(rs, pst, conn);
//        }
    }


    }


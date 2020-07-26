package controller;

import dao.JdbcUtil;
import dao.UserDAO;
import domain.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

// value的值指定在浏览器中的访问路径
@WebServlet(name = "controller.CheckServlet", value = "/checkServlet")
public class CheckServlet extends HttpServlet {


    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request,response);
        System.out.println("get");

    }
    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String method = request.getParameter("method");
        System.out.println("post "+method);

        switch (method) {
            case "usernameRegistered":
                try {
                    usernameRegistered(request, response);
                } catch (Exception e) {
                    e.printStackTrace();
                }finally {
                    break;
                }

            case "emailRegistered":
                try {
                    emailRegistered(request, response);
                } catch (Exception e) {
                    e.printStackTrace();
                }finally {
                    break;
                }

            case "verificationCodeCheck" :
                try {
                    verificationCodeCheck(request, response);
                } catch (Exception e) {
                    e.printStackTrace();
                }finally {
                    break;
                }
            case "passwordCheck" :
                try {
                    passwordCheck(request, response);
                } catch (Exception e) {
                    e.printStackTrace();
                }finally {
                    break;
                }

        }
    }


    public void usernameRegistered(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException{


        String username = request.getParameter("id");
        // String email = request.getParameter("email");
        //String password = request.getParameter("password1");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
//
//        out.println("<html><body>");
//        out.print("<h2>register</h2>");

//        JdbcUtil util = new JdbcUtil();
//        Connection conn = util.getConnection();
//        String sql = "use Pj2";
//        PreparedStatement pst = null;
//        ResultSet rs = null;
//        //Map map = new HashMap<>();
//
//        try {
//            pst = conn.prepareStatement(sql);
//            rs = pst.executeQuery();
            String sql = "select uid id,username username,email email,pass password,DateJoined date from traveluser where username= ? ";

//            pst = conn.prepareStatement(sql);
//            pst.setString(1, username);
//            rs = pst.executeQuery();
        User user=null;
        UserDAO userDAO=new UserDAO();
        user=userDAO.getInstance(sql,username);

        // if(rs.next()) {
        if(user!=null){
            //if (rs.next()) {
                //map.put("valid", false);
                out.print("{\"valid\":false}");
                System.out.println("false");
            } else {
                //map.put("valid", true);
                //out.print(map);
                out.print("{\"valid\":true}");
                System.out.println("true");
            }
//        } catch (SQLException e) {
//            e.printStackTrace();
//        } finally {
//            util.close(rs, pst, conn);
//        }

    }

    public void emailRegistered(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException{


        //String username=request.getParameter("id");
         String email = request.getParameter("email");

        response.setCharacterEncoding("UTF-8");
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        String sql = "select uid id,username username from traveluser where email= ? ";


        User user=null;
        UserDAO userDAO=new UserDAO();
        user=userDAO.getInstance(sql,email);


        if(user!=null){

            out.print("{\"valid\":false}");
            System.out.println("false");
        } else {

            out.print("{\"valid\":true}");
            System.out.println("true");
        }


    }

    public void verificationCodeCheck(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException{




         response.setCharacterEncoding("UTF-8");
         response.setContentType("application/json");
         PrintWriter out = response.getWriter();

         String code=(String)request.getSession().getAttribute("validateCode");
         String verificationCode=request.getParameter("verificationCode");


         if(code.equals(verificationCode)){

                 out.print("{\"valid\":true}");

                 System.out.println(" verificationCode true");
             } else {
                 //map.put("valid", true);

                 out.print("{\"valid\":false}");
                 System.out.println("verificationCode false");
             }
//         } catch (SQLException e) {
//             e.printStackTrace();
//         } finally {
//             util.close(rs, pst, conn);
//         }


     }


    public void passwordCheck(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException{

        request.setCharacterEncoding("UTF-8");
        String username = request.getParameter("id");
        String password = request.getParameter("password");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("application/json");
        PrintWriter out=response.getWriter();


//        JdbcUtil util = new JdbcUtil();
//        Connection conn = util.getConnection();
//        String sql = "use Pj2";
//        PreparedStatement pst = null;
//        ResultSet rs = null;
//        try {
//            pst = conn.prepareStatement(sql);
//            rs = pst.executeQuery();
//
//            sql = "select * from traveluser where username=? and pass=?";
//
//            pst = conn.prepareStatement(sql);
//            pst.setString(1,username);
//            pst.setString(2,password);
//            rs = pst.executeQuery();
//            if(rs.next()) {
        User user=null;
        UserDAO userDAO=new UserDAO();
        user=userDAO.get(username,password);
        // if(rs.next()) {
        if(user!=null){
                out.print("{\"valid\":true}");
            }
            else{
                out.print("{\"valid\":false}");
            }
//        } catch (SQLException e) {
//            e.printStackTrace();
//        } finally {
//            util.close(rs, pst, conn);
//        }
    }



}


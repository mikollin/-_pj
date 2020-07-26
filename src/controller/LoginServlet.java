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

// value的值指定在浏览器中的访问路径
@WebServlet(name = "controller.LoginServlet", value = "/login")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String username = request.getParameter("id");
        String password = request.getParameter("password");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
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
        User user=null;
        UserDAO userDAO=new UserDAO();

        //防止复写
        request.getSession().removeAttribute("validateCode");

        //密码加密比对
        //CodingUtil encodingUtil=new CodingUtil();
        //password= CodingUtil.encodeStringToBase64String(password);
        try {
            password=CodingUtil.EncoderByMd5(password);
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }

        user=userDAO.get(username,password);

        String sql="select uid id,username username,email email,pass password,DateJoined date from traveluser where email=? and pass=?";
        if(user==null){
            System.out.println("yyyy");
            user=userDAO.getInstance(sql,username,password);
        }

        //System.out.println(user);
           // if(rs.next()) {
        if(user!=null){
                //User user=new User(rs.getString("username"),rs.getString("email"),rs.getString("pass"),rs.getDate("DateJoined"));
                request.getSession().setAttribute("user",user);
                HttpSession session=request.getSession();
//                String path=(String)session.getAttribute("referer");
//                session.removeAttribute("referer");
                //out.print("<script>alert(\"登录成功\")</script>");
                request.setAttribute("message","登录成功");
                request.getRequestDispatcher("login.jsp").forward(request,response);
//                response.sendRedirect(path);
                //之后要重定向到点击login的哪个页面

            }
            else{
                request.setAttribute("message","用户名和密码错误");
                request.getRequestDispatcher("login.jsp").forward(request,response);
            }
//        } catch (SQLException e) {
//            e.printStackTrace();
//        } finally {
//            util.close(rs, pst, conn);
//        }
    }







}
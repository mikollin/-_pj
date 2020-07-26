package controller;

import domain.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "controller.LogoutServlet", value = "/logout")
public class LogoutServlet extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {


//        Cookie[] cookies=request.getCookies();
//        for(Cookie c:cookies) {
//            if(c!=null && c.getName()!=null && request.getSession().getAttribute("user")!=null) {
//                if (c.getName().startsWith("MY_FOOTPRINTS_" + ((User) request.getSession().getAttribute("user")).getUsername())) {
//                    System.out.println("clean" + c.getName());
//                    c.setMaxAge(0); //把足迹清空
//                    response.addCookie(c);
//                }
//            }
//        }

        request.getSession().invalidate();
        response.sendRedirect("index.jsp");

    }

}


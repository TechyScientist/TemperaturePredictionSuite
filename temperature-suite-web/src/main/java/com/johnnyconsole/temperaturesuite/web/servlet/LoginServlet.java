package com.johnnyconsole.temperaturesuite.web.servlet;

import com.johnnyconsole.temperaturesuite.ejb.interfaces.TemperatureStatefulLocal;
import com.johnnyconsole.temperaturesuite.persistence.User;
import com.johnnyconsole.temperaturesuite.persistence.interfaces.UserDaoLocal;

import javax.ejb.EJB;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    @EJB
    UserDaoLocal userDao;

    @EJB
    TemperatureStatefulLocal stateful;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws IOException {
        try {
            if(request.getParameter("login-submit") != null) {
                String username = request.getParameter("username").toLowerCase(),
                        password = request.getParameter("password");
                if (userDao.verifyUser(username, password)) {
                    User user = userDao.getUser(username);
                    stateful.logIn(user.getUsername(), user.getName(), user.getAccessLevel());

                    HttpSession session = request.getSession();
                    session.setAttribute("session", stateful);
                    response.sendRedirect("dashboard.jsp");
                }
            } else {
                response.sendRedirect("/temperature-suite");
            }
        }
        catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("/temperature-suite?error=login");
        }
    }
}

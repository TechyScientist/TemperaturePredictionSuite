package com.johnnyconsole.temperaturesuite.web.servlet;

import at.favre.lib.crypto.bcrypt.BCrypt;
import com.johnnyconsole.temperaturesuite.persistence.User;
import com.johnnyconsole.temperaturesuite.persistence.interfaces.UserDaoLocal;
import com.johnnyconsole.temperaturesuite.web.util.ApplicationSession;

import javax.ejb.EJB;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    @EJB
    UserDaoLocal userDao;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws IOException {
        try {
            if(request.getParameter("login-submit") != null) {
                String username = request.getParameter("username").toLowerCase(),
                        password = request.getParameter("password");
                if (userDao.verifyUser(username, password)) {
                    User user = userDao.getUser(username);
                    ApplicationSession.set(username, user.getName(), user.getAccessLevel());
                    response.sendRedirect("/temperature-suite/dashboard.jsp");
                }
            } else {
                response.sendRedirect("/temperature-suite");
            }
        }
        catch (Exception e) {
            response.sendRedirect("/temperature-suite?error=login");
        }
    }
}

package com.johnnyconsole.temperaturesuite.web.servlet;

import at.favre.lib.crypto.bcrypt.BCrypt;
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

@WebServlet("/AddUserServlet")
public class AddUserServlet extends HttpServlet {

    @EJB
    UserDaoLocal userDao;

    TemperatureStatefulLocal stateful;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws IOException {
        try {
            HttpSession session = request.getSession();
            stateful = (TemperatureStatefulLocal) session.getAttribute("session");
            if(stateful != null && stateful.loggedInAccessLevel() == 1) {
                if (request.getParameter("add-user-submit") != null) {
                    String username = request.getParameter("username").toLowerCase(),
                            name = request.getParameter("name"),
                            password = request.getParameter("password"),
                            confirmPassword = request.getParameter("confirm-password");
                    int accessLevel = Integer.parseInt(request.getParameter("access-level"));
                    if (!userDao.userExists(username)) {
                        if (password.equals(confirmPassword)) {
                            password = BCrypt.withDefaults().hashToString(12, password.toCharArray());
                            User user = new User(username, name, password, accessLevel);
                            if (userDao.addUser(user))
                                response.sendRedirect("/temperature-suite/add-user.jsp?user=added");
                            else response.sendRedirect("/temperature-suite/add-user.jsp?error=user-add");
                        }
                    } else {
                        response.sendRedirect("/temperature-suite/add-user.jsp?error=user-exists");
                    }
                } else {
                    response.sendRedirect("/temperature-suite?error=unauthorized");
                }
            } else {
                response.sendRedirect("/temperature-suite?error=unauthorized");
            }
        }
        catch (Exception e) {
            response.sendRedirect("/temperature-suite/add-user.jsp?error=user-add");
        }
    }
}

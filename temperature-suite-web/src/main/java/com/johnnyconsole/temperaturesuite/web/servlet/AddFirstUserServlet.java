package com.johnnyconsole.temperaturesuite.web.servlet;

import at.favre.lib.crypto.bcrypt.BCrypt;
import com.johnnyconsole.temperaturesuite.persistence.User;
import com.johnnyconsole.temperaturesuite.persistence.interfaces.UserDaoLocal;

import javax.ejb.EJB;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/AddFirstUserServlet")
public class AddFirstUserServlet extends HttpServlet {

    @EJB
    UserDaoLocal userDao;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws IOException {
        try {
            if(request.getParameter("first-user-add") != null) {
                String username = request.getParameter("username").toLowerCase(),
                        name = request.getParameter("name"),
                        password = request.getParameter("password"),
                        confirmPassword = request.getParameter("confirm-password");
                if (password.equals(confirmPassword)) {
                    password = BCrypt.withDefaults().hashToString(12, password.toCharArray());
                    User user = new User(username, name, password, 1);
                    if (userDao.addUser(user)) response.sendRedirect("/temperature-suite?first-user=added");
                    else response.sendRedirect("/temperature-suite?error=user-add");
                }
            } else {
                response.sendRedirect("/temperature-suite");
            }
        }
        catch (Exception e) {
            response.sendRedirect("/temperature-suite?error=user-add");
        }
    }
}

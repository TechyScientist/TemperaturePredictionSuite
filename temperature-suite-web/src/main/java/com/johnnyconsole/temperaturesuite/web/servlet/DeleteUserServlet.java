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

@WebServlet("/DeleteUserServlet")
public class DeleteUserServlet extends HttpServlet {

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
                if (request.getParameter("delete-user-submit") != null) {
                    String username = request.getParameter("username").toLowerCase();
                    if(username.isEmpty())
                        response.sendRedirect("/temperature-suite/delete-user.jsp");
                    User user = userDao.getUser(username);
                    userDao.removeUser(user, stateful.loggedInUsername());
                    session.setAttribute("deletable-users", userDao.getUsersExcept(stateful.loggedInUsername()));
                    response.sendRedirect("delete-user.jsp");
                    response.sendRedirect("/temperature-suite/delete-user.jsp?user=deleted");
                } else {
                    response.sendRedirect("/temperature-suite?error=unauthorized");
                }
            } else {
                response.sendRedirect("/temperature-suite?error=unauthorized");
            }
        }
        catch (Exception e) {
            response.sendRedirect("/temperature-suite/delete-user.jsp?error=user-delete");
        }
    }
}

package com.johnnyconsole.temperaturesuite.web.servlet;

import com.johnnyconsole.temperaturesuite.ejb.interfaces.TemperatureStatefulLocal;
import com.johnnyconsole.temperaturesuite.persistence.interfaces.UserDaoLocal;

import javax.ejb.EJB;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/GetDeletableUsersServlet")
public class GetDeletableUsersServlet extends HttpServlet {

    @EJB
    private UserDaoLocal userDao;

    private TemperatureStatefulLocal stateful;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            HttpSession session = request.getSession();
            stateful = (TemperatureStatefulLocal) session.getAttribute("session");
            if (stateful.isLoggedIn() && stateful.loggedInAccessLevel() == 1) {
                session.setAttribute("deletable-users", userDao.getUsersExcept(stateful.loggedInUsername()));
                response.sendRedirect("delete-user.jsp");
            } else {
                response.sendRedirect("/temperature-suite?error=unauthorized");
            }
        } catch (Exception e) {
                response.sendRedirect("/temperature-suite?error=unauthorized");
        }
    }
}

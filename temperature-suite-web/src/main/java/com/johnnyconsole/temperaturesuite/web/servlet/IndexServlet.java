package com.johnnyconsole.temperaturesuite.web.servlet;

import com.johnnyconsole.temperaturesuite.persistence.interfaces.UserDaoLocal;

import javax.ejb.EJB;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/")
public class IndexServlet extends HttpServlet {

    @EJB
    private UserDaoLocal userDao;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        if(userDao.userCount() == 0) {
            response.sendRedirect("add-first-user.jsp");
        }
        else {
            response.sendRedirect("login.jsp");
        }
    }
}

package com.johnnyconsole.temperaturesuite.web.servlet;

import com.johnnyconsole.temperaturesuite.ejb.interfaces.TemperatureStatefulLocal;
import com.johnnyconsole.temperaturesuite.web.util.ApplicationSession;

import javax.ejb.EJB;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/LogoutServlet")
public class LogoutServlet extends HttpServlet {

    @EJB
    TemperatureStatefulLocal stateful;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws IOException {
        try {
            stateful.logOut();
            //ApplicationSession.unset();
            response.sendRedirect("/temperature-suite/?logout=success");
        }
        catch (Exception e) {
            response.sendRedirect("/temperature-suite?error=login");
        }
    }
}

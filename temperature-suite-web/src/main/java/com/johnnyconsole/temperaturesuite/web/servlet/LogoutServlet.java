package com.johnnyconsole.temperaturesuite.web.servlet;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/LogoutServlet")
public class LogoutServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws IOException {
        try {
            request.getSession().invalidate();
            response.sendRedirect("/temperature-suite/?logout=success");
        }
        catch (Exception e) {
            response.sendRedirect("/temperature-suite?error=login");
        }
    }
}

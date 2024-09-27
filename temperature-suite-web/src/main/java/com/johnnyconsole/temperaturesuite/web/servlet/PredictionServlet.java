package com.johnnyconsole.temperaturesuite.web.servlet;

import com.johnnyconsole.temperaturesuite.ejb.interfaces.TemperatureStatefulLocal;
import com.johnnyconsole.temperaturesuite.ejb.interfaces.TemperatureStatelessLocal;

import javax.ejb.EJB;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/PredictionServlet")
public class PredictionServlet extends HttpServlet {

    @EJB
    TemperatureStatelessLocal stateless;

    TemperatureStatefulLocal stateful;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws IOException {
        try {
            HttpSession session = request.getSession();
            stateful = (TemperatureStatefulLocal) session.getAttribute("session");
            if(stateful != null) {
                if (stateful.isLoggedIn()) {
                    String model = request.getParameter("model");
                    if (model.isEmpty()) response.sendRedirect("");

                    String modelName = model.substring(0, model.indexOf(" ")).toLowerCase(),
                            className = model.substring(model.indexOf("(") + 1, model.indexOf(")"));
                    int year = Integer.parseInt(request.getParameter("year")),
                            month = Integer.parseInt(request.getParameter("month")),
                            day = Integer.parseInt(request.getParameter("day"));
                    double prediction = stateless.predict(modelName, className, year, month, day);
                    if (prediction == Double.MIN_VALUE) throw new Exception("Missing Model");
                    response.sendRedirect("/temperature-suite/make-prediction.jsp?model=" + model + "&date=" + day + getMonthName(month) + year + "&prediction=" + prediction);
                } else response.sendRedirect("/temperature-suite/?error=unauthorized");
            }
            else {
                response.sendRedirect("/temperature-suite/?error=unauthorized");
            }
        } catch(Exception e) {
            response.sendRedirect("/temperature-suite/make-prediction.jsp?error=prediction");
        }

    }

    private String getMonthName(int month) {
        switch(month) {
            case 1: return " January ";
            case 2: return " February ";
            case 3: return " March ";
            case 4: return " April ";
            case 5: return " May ";
            case 6: return " June ";
            case 7: return " July ";
            case 8: return " August ";
            case 9: return " September ";
            case 10: return " October ";
            case 11: return " November ";
            default: return " December ";
        }
    }
}

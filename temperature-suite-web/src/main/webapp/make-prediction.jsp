<%@ page import="static com.johnnyconsole.temperaturesuite.web.util.ApplicationSession.*" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="com.johnnyconsole.temperaturesuite.web.util.Database" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<!DOCTYPE HTML>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Temperature Suite Web App</title>

    <style>
        :root {
            --color-primary: #1DA1F2;
            --color-background: #CFEBFC;
        }

        * {
            margin: 0;
            padding: 0;
            font-family: "Calibri Light", sans-serif;
        }

        body {
            margin: 20px 200px;
            background: var(--color-background)
        }

        div#body {
            margin: 30px;
        }

        h2 {
            margin-bottom: 10px;
        }

        h3 {
            font-size: 20px;
            margin-bottom: 10px;
        }

        form:not(div#intro-header form) {
            margin-left: 30px;
            margin-bottom: 25px;
        }

        label {
            margin-right: 10px;
        }

        input, select {
            padding: 5px
        }

        input[type="text"], select {
            margin-right: 10px;
        }

        div#header {
            background: var(--color-primary);
            padding: 20px;
            color: white;
            border-radius: 16px;
        }

        div#intro-header h2, div#intro-header form {
            display: inline-block;
        }

        div#intro-header form {
            margin-left: 30px;
        }

        hr {
            height: 20px;
            background-color: var(--color-primary);
            border-radius: 16px;
        }

        p {
            margin-bottom: 10px;
        }

        p#error {
            background-color: darkred;
            color: white;
            text-align: center;
            width: 100%;
            padding: 10px;
        }

        p#success {
            background-color: darkgreen;
            color: white;
            text-align: center;
            width: 100%;
            padding: 10px;
        }

        p:not(#error, #success) {
            margin-left: 20px;
        }

        ul {
            margin-left: 60px;
        }
    </style>
</head>

<body>
<%
    if(username != null) {
%>
<div id="header">
    <h1>Temperature Suite Web App</h1>
</div>
<div id="body">
    <% if(request.getParameter("error") != null) {
        if(request.getParameter("error").equals("prediction")) { %>
    <p id="error">There was an error making the prediction.</p>

    <%  }
    }
    else if(request.getParameter("prediction") != null) {
        String model = request.getParameter("model"),
                modelName = model.substring(0, model.indexOf(" ")),
                className = model.substring(model.indexOf("(") + 1, model.indexOf(")")),
                date = request.getParameter("date"),
                prediction = request.getParameter("prediction"); %>
    <p id="success"><b><%=className%></b> Model <b><%=modelName%></b> predicts the temperature on <b><%= date %></b> as: <b><%=prediction%>&deg;C</b>.</p>
    <% } %>
    <div id="intro-header">
        <h2>Make a Prediction</h2>
        <form action="dashboard.jsp" method="post">
            <input type="submit" value="Return to Dashboard">
        </form>
    </div>
    <p>Select a model from the list and choose a date to make a prediction.</p>
    <form action="PredictionServlet" method="post">
        <table style="border-spacing: 5px;">
            <tr>
                <th><label for="model">Model:</label></th>
                <td colspan="3">
                    <select name="model" id="model">
                        <%
                            try(Connection conn = Database.connect()) {
                                PreparedStatement stmt = conn.prepareStatement("SELECT * FROM temperature_suite_models;");
                                stmt.execute();
                                ResultSet set = stmt.getResultSet();
                                int count = 0;
                                while(set.next()) {
                                    count++;
                                    String modelClass = set.getString("className");
                                    modelClass = modelClass.substring(modelClass.lastIndexOf(".") + 1);
                                    String value = set.getString("name") + " (" + modelClass + ")"; %>
                                    <option value='<%= value %>'><%=value%></option>
                        <%      }
                                if(count == 0) { %>
                                    <option value="">No Models Found</option>
                             <% }
                            } catch(SQLException e) { %>
                                <p id="error">Error</p>
                        <%
                            }
                            %>
                    </select>
                </td>
            </tr>
            <tr>
                <th rowspan="2">Date:</th>
                <td><label for="day">Day:</label></td>
                <td><label for="month">Month:</label></td>
                <td><label for="year">Year:</label></td>
            </tr>
            <tr>
                <td>
                    <select name="day" id="day">
                        <% for(int i = 1; i <= 31; i++) {%>
                        <option value="<%= i %>"><%= i %></option>
                        <% } %>
                    </select>
                </td>
                <td>
                    <select name="month" id="month">
                        <option value="1">January</option>
                        <option value="2">February</option>
                        <option value="3">March</option>
                        <option value="4">April</option>
                        <option value="5">May</option>
                        <option value="6">June</option>
                        <option value="7">July</option>
                        <option value="8">August</option>
                        <option value="9">September</option>
                        <option value="10">October</option>
                        <option value="11">November</option>
                        <option value="12">December</option>
                    </select>
                </td>
                <td><input type="number" name="year" id="year" placeholder="Enter Year" required/></td>
            </tr>
            <tr>
                <td rowspan="4"><center><input type="submit" name="predict-submit" value="Make Prediction"/></center></td>
            </tr>
        </table>
    </form>
</div>

<hr/>
<% } else response.sendRedirect("/temperature-suite?error=unauthorized"); %>
</body>
</html>
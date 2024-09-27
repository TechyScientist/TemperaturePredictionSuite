<%@ page import="com.johnnyconsole.temperaturesuite.ejb.interfaces.TemperatureStatefulLocal" %>
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
TemperatureStatefulLocal stateful = (TemperatureStatefulLocal) session.getAttribute("session");
    if(stateful != null && stateful.isLoggedIn() && stateful.loggedInAccessLevel() == 1) {
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
        <h2>User Management: Add a User</h2>
        <form action="dashboard.jsp" method="post">
            <input type="submit" value="Return to Dashboard">
        </form>
    </div>
    <p>Fill in the information below to add a new user. All fields are required.</p>
    <form action="AddUserServlet" method="post">

    </form>
</div>

<hr/>
<% } else response.sendRedirect("/temperature-suite?error=unauthorized"); %>
</body>
</html>
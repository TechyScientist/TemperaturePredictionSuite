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

        a {
            color: black;
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


        p:not(#error) {
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

    if(stateful != null && stateful.isLoggedIn()) {
%>
<div id="header">
    <h1>Temperature Suite Web App</h1>
</div>
<div id="body">
    <div id="intro-header">
        <% String name = stateful.loggedInName(); %>
        <h2>Welcome, <%= name != null ? (name.contains(" ") ? name.substring(0, name.indexOf(" ")) : name) : "" %>!</h2>
        <form action="LogoutServlet" method="post">
            <input type="submit" value="Log Out">
        </form>
    </div>
    <% if(request.getParameter("error") != null && request.getParameter("error").equals("delete-user")) { %>
        <p id="error">There was an error getting the user list for deleting.</p>
    <% } %>
    <h2>Available Tools</h2>
    <p>You are currently authorized to access the following tools:</p>
    <ul>
        <li><a href="make-prediction.jsp">Make Prediction</a></li>
        <li>My Profile</li>
        <% if(stateful.loggedInAccessLevel() == 1) { %>
            <li>User Management:
                <ul>
                    <li><a href="add-user.jsp">Add a User</a></li>
                    <li>Modify a User's Profile</li>
                    <li><a href="delete-user.jsp">Delete a User</a></li>
                </ul>
            </li>
            <li>Model Management:
                    <ul>
                        <li>Create a New Model</li>
                        <li>Delete an Existing Model</li>
                    </ul>
            </li>
        <% } %>
    </ul>
</div>

<hr/>
<% } else response.sendRedirect("/temperature-suite?error=unauthorized"); %>
</body>
</html>
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
        <% String username = stateful.loggedInUsername(),
                name = stateful.loggedInName(),
                accessLevel = stateful.loggedInAccessLevel() == 0 ? "Standard User" : "Administrative User";
            if(username.equals("guest")) {
                response.sendRedirect("dashboard.jsp");
            }
        %>
        <h2>My Profile</h2>
        <form action="dashboard.jsp" method="post">
            <input type="submit" value="Return to Dashboard">
        </form>
    </div>
    <p>Your details are listed below. Modify the text fields to change values. Note: you are unable to change your username or access level.</p>
    <form action="ProfileServlet" method="post">
        <label for="username">Username:</label>
        <input type="text" name="username" id="username" disabled value="<%= username %>"/><br/><br/>
        <label for="name">Full Name:</label>
        <input type="text" name="name" id="name" value="<%= name %>" required/><br/><br/>
        <label for="password">Change Password:</label>
        <input type="password" name="password" id="password" placeholder="New Password"/><br/><br/>
        <label for="confirm-password">Confirm Password:</label>
        <input type="password" name="confirm-password" id="confirm-password" placeholder="Confirm New Password"/><br/><br/>
        <label for="access-level-dont-use">Access Level:</label>
        <input type="text" id="access-level-dont-use" disabled value="<%= accessLevel %>"/>
    </form>
<hr/>
<% } else response.sendRedirect("/temperature-suite?error=unauthorized"); %>
</body>
</html>
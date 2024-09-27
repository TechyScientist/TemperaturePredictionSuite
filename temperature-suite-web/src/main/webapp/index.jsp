<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="com.johnnyconsole.temperaturesuite.web.util.Database" %>
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

        form {
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

        hr {
            height: 20px;
            background-color: var(--color-primary);
            border-radius: 16px;
        }

        p#error {
            background-color: darkred;
            color: white;
            text-align: center;
            width: 100%;
            padding: 10px;
            margin-bottom: 10px;
        }

        p#success {
            background-color: darkgreen;
            color: white;
            text-align: center;
            width: 100%;
            padding: 10px;
            margin-bottom: 10px;
        }
    </style>
</head>

<body>
<%
    try (Connection conn = Database.connect()){
        PreparedStatement stmt = conn.prepareStatement("SELECT COUNT(username) FROM temperature_suite_users WHERE accessLevel = 1;");
        stmt.execute();
        ResultSet set = stmt.getResultSet();
        if(set.next()) {
            if(set.getInt(1) == 0) {
                response.sendRedirect("add-first-user.jsp");
            }
        }
    } catch(SQLException e) {
        response.sendRedirect("add-first-user.jsp");
    }
%>
<div id="header">
    <h1>Temperature Suite Web App</h1>
</div>
<div id="body">
    <%
        if(request.getParameter("first-user") != null) { %>
            <p id="success">The first user account was added successfully. Please log in with the information you provided.</p>
    <% }
       else if(request.getParameter("logout") != null) {%>
            <p id="success">You have successfully been logged out.</p>
    <% }
        else if(request.getParameter("error") != null) {
            if(request.getParameter("error").equals("unauthorized")) { %>
                <p id="error">You must be signed in to access that page.</p>
    <%      }
            else if(request.getParameter("error").equals("credentials")) { %>
                <p id="error">The username or password you entered is incorrect.</p>
        <% }
        }%>
    <h2>Log In</h2>
    <form action="LoginServlet" method="post">
        <label for="username">Username:</label>
        <input type="text" name="username" id="username" placeholder="Enter Username" required/><br/><br/>
        <label for="password">Password:</label>
        <input type="password" name="password" id="password" placeholder="Enter Password" required/><br/><br/>
        <input type="submit" name="login-submit" id="login-submit" value="Log In"/>
    </form>
</div>

<hr/>

</body>
</html>
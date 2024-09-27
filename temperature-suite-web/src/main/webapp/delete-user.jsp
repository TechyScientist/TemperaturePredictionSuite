<%@ page import="com.johnnyconsole.temperaturesuite.ejb.interfaces.TemperatureStatefulLocal" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="com.johnnyconsole.temperaturesuite.web.util.Database" %>
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
TemperatureStatefulLocal stateful = (TemperatureStatefulLocal) session.getAttribute("session");
    if(stateful != null && stateful.isLoggedIn() && stateful.loggedInAccessLevel() == 1) {
%>
<div id="header">
    <h1>Temperature Suite Web App</h1>
</div>
<div id="body">
    <% if(request.getParameter("error") != null) {
        if(request.getParameter("error").equals("user-delete")) { %>
    <p id="error">There was an error deleting the user.</p>
    <%  }
    }
    else if(request.getParameter("user") != null && request.getParameter("user").equals("deleted")) { %>
        <p id="success">The user has been deleted successfully.</p>
    <% } %>
    <div id="intro-header">
        <h2>User Management: Delete a User</h2>
        <form action="dashboard.jsp" method="post">
            <input type="submit" value="Return to Dashboard">
        </form>
    </div>
    <p>Select the user to delete from the options below. You cannot delete your own profile.</p>
    <form action="DeleteUserServlet" method="post">
        <label for="username">User to Delete:</label>
        <select name="username" id="username" required>
            <%
                try(Connection conn = Database.connect()) {
                    PreparedStatement stmt = conn.prepareStatement("SELECT username, name, accessLevel FROM temperature_suite_users WHERE username != ?;");
                    stmt.setString(1, stateful.loggedInUsername());
                    ResultSet set = stmt.executeQuery();
                    int i = 0;
                    while(set.next()) {
                        i++;
                        String username = set.getString("username"),
                                name = set.getString("name"),
                                type = set.getInt("accessLevel") == 0 ? "Standard User" : "Administrative User"; %>
                        <option value="<%= username %>"><%= username %>: <%= name %> (<%= type %>)</option>
                 <% }
                    if(i == 0) { %>
                        <option value="">No Users Found</option>
                    <% }
                } catch(Exception e) {
                    response.sendRedirect("/dashboard.jsp?error=delete-user");
                }
            %>
        </select>
        <input type="submit" name="delete-user-submit" id="delete-user-submit" value="Delete User"/>
    </form>
</div>

<hr/>
<% } else response.sendRedirect("/temperature-suite?error=unauthorized"); %>
</body>
</html>
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

        input:not(input[type="checkbox"]), select {
            padding: 5px
        }

        input[type="text"], select {
            margin-right: 10px;
        }

        input[type="checkbox"] {
            width: 20px;
            height: 20px;
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
        <label for="change-password">Change Password</label>
        <input type="checkbox" name="change-password" id="change-password" /><br/><br/>
        <div id="div-password" style="display: none;">
            <label for="password">New Password:</label>
            <input type="password" name="password" id="password" placeholder="New Password" disabled/><br/><br/>
            <label for="confirm-password">Confirm New Password:</label>
            <input type="password" name="confirm-password" id="confirm-password" placeholder="Confirm New Password" disabled/><br/><br/>
        </div>
        <label for="access-level-dont-use">Access Level:</label>
        <input type="text" id="access-level-dont-use" disabled value="<%= accessLevel %>"/><br/><br/>
        <input type="submit" name="change-profile-submit" id="change-profile-submit" value="Save Changes"/>
    </form>
    <script defer>
        div_password = document.getElementById("div-password");
        password = document.getElementById("password");
        confirm_password = document.getElementById("confirm-password");
        change_password = document.getElementById("change-password");

        change_password.addEventListener("change", (event) => {
            if(event.currentTarget.checked) {
                div_password.style.display = "block";
                password.disabled = confirm_password.disabled = false;
                password.required = confirm_password.required = true;
            }
            else {
                div_password.style.display = "none";
                password.disabled = confirm_password.disabled = true;
                password.required = confirm_password.required = false;
            }
        });
    </script>
<hr/>
<% } else response.sendRedirect("/temperature-suite?error=unauthorized"); %>

</body>
</html>
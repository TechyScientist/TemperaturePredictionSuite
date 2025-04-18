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
        if(request.getParameter("error").equals("create-model")) { %>
    <p id="error">There was an error creating the model.</p>
    <%  }
        else if(request.getParameter("error").equals("model-exists")) { %>
            <p id="error">The model name you entered already exists. Please choose a different name and try again.</p>
    <% }
    }
    else if(request.getParameter("model") != null && request.getParameter("created").equals("added")) { %>
        <p id="success">The model has been created successfully.</p>
    <% } %>
    <div id="intro-header">
        <h2>Model Management: Create a Model</h2>
        <form action="dashboard.jsp" method="post">
            <input type="submit" value="Return to Dashboard">
        </form>
    </div>
    <p>Fill in the information below to create a new model. All fields are required.</p>
    <form action="CreateModelServlet" method="post">
        <label for="name">Model Name:</label>
        <input type="text" name="name" id="name" placeholder="Model Name" required/><br/><br/>
        <label for="class">Model Class:</label>
        <select name="class" id="class">
            <option value="REPTree">REPTree Classifier</option>
        </select><br/><br/>
        <label for="data">Training Data (*.csv):</label>
        <input type="file" name="data" id="data" accept="text/csv" placeholder="Training Data (*.csv)" required/><br/><br/>
        <input type="submit" name="add-user-submit" id="create-model-submit" value="Create Model"/>
    </form>
</div>

<hr/>
<% } else response.sendRedirect("/temperature-suite?error=unauthorized"); %>
</body>
</html>
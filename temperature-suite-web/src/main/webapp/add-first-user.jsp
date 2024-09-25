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

        h2, p {
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

        input[type="text"] {
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
    </style>
</head>

<body>
<div id="header">
    <h1>Temperature Suite Web App</h1>
</div>
<div id="body">
    <h2>User Management: Add a User</h2>
    <p>Hi there! Before you can use the temperature suite, you need to define your first administrative user.<br/>
        Please fill in the information below and your user profile will be created for you.</p>
    <form action="/temperature-suite/AddFirstUserServlet" method="post">
        <label for="username">Username:</label>
        <input type="text" name="username" id="username" placeholder="Enter a Username" required/><br/><br/>
        <label for="name">Name:</label>
        <input type="text" name="name" id="name" placeholder="Enter your Name" required/><br/><br/>
        <label for="password">Password:</label>
        <input type="password" name="password" id="password" placeholder="Enter a Password" required/><br/><br/>
        <label for="confirm-password">Confirm Password:</label>
        <input type="password" name="confirm-password" id="confirm-password" placeholder="Confirm Password" required/><br/><br/>
        <input type="submit" name="first-user-add" value="Add User"/>
    </form>
</div>

<hr/>

</body>
</html>
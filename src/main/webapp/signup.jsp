<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Signup</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f9f9f9;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .signup-container {
            width: 400px;
            background-color: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        h2 {
            text-align: center;
            margin-bottom: 20px;
        }

        form input[type="text"], form input[type="email"], form input[type="password"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }

        button {
            width: 100%;
            padding: 10px;
            background-color: #e97c32;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        button:hover {
            background-color: #c86b2a;
        }
        
        .error-message {
            display: flex;
            align-items: center;
            background-color: #F8D7DA;
            border: 1px solid #F5C2C7;
            color: #842029;
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 5px;
            font-size: 0.9rem;
        }

        .error-message i {
            font-size: 1.2rem;
            margin-right: 10px;
        }

        .error-message a {
            color: #842029;
            text-decoration: underline;
            margin-left: 5px;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <div class="signup-container">
        <h2>S'inscrire</h2>
        <% if (request.getAttribute("error") != null) { %>
	        <div class="error-message">
	            <i class="fas fa-exclamation-circle"></i>
	            <span><%= request.getAttribute("error") %></span>
	        </div>
        <% } %>
        <form action="SignupServlet" method="post">
            <input type="text" name="name" placeholder="Nom" required>
            <input type="email" name="email" placeholder="Email" required>
            <input type="password" name="password" placeholder="Mot de passe" required>
            <input type="password" name="confirmPassword" placeholder="Confirmer le mot de passe" required>
            <button type="submit">S'inscrire</button>
        </form>
    </div>
</body>
</html>
